From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] ALSA: introduce snd_card_make_id_unique()
	(was: ALSA:	snd_usb_caiaq: give better shortname)
Date: Tue, 2 Jun 2009 12:10:59 +0200
Message-ID: <20090602101059.GE26160@buzzloop.caiaq.de>
References: <s5h8wkbc2ro.wl%tiwai@suse.de>
	<1243884987-20256-1-git-send-email-daniel@caiaq.de>
	<1243884987-20256-2-git-send-email-daniel@caiaq.de>
	<alpine.LNX.2.00.0906012306460.4067@eeebox2.perex-int.cz>
	<s5hmy8rms9j.wl%tiwai@suse.de>
	<20090602072948.GO26148@buzzloop.caiaq.de>
	<s5hfxejrs6k.wl%tiwai@suse.de>
	<20090602093104.GC26160@buzzloop.caiaq.de>
	<s5htz2zt15j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 039B510380E
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 12:11:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5htz2zt15j.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 02, 2009 at 11:50:32AM +0200, Takashi Iwai wrote:
> > What about that patch below? Works well in my tests here.
> 
> Looks almost good, but we need to check
> snd_info_check_reserved_words() too.

A new version to fix just that issue is below.

Thanks,
Daniel


>From f8925c51b08b15d95d060148e2ce639987374b87 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@caiaq.de>
Date: Tue, 2 Jun 2009 11:23:41 +0200
Subject: [PATCH] ALSA: introduce snd_card_make_id_unique()

Sound card drivers may choose their own way to provide a nice sound card
ID, especially when the default behaviour taken by choose_default_name()
is not appropriate. ALSA's IDs must be unique, so there is need for some
core logic to ensure that.

This patch adds the function snd_card_make_id_unique() to the ALSA core
which lowlevel drivers can call to make sure the computed string isn't
already taken.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>
---
 include/sound/core.h |    1 +
 sound/core/init.c    |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 3dea798..01ea816 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -319,6 +319,7 @@ int snd_card_info_done(void);
 int snd_component_add(struct snd_card *card, const char *component);
 int snd_card_file_add(struct snd_card *card, struct file *file);
 int snd_card_file_remove(struct snd_card *card, struct file *file);
+void snd_card_make_id_unique(struct snd_card *card);
 
 #ifndef snd_card_set_dev
 #define snd_card_set_dev(card, devptr) ((card)->dev = (devptr))
diff --git a/sound/core/init.c b/sound/core/init.c
index fd56afe..bce2982 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -547,6 +547,59 @@ static void choose_default_id(struct snd_card *card)
 	}
 }
 
+static int
+card_id_is_ambiguous(struct snd_card *card, const char *id)
+{
+	int i;
+
+	for (i = 0; i < snd_ecards_limit; i++) {
+		/* only run for exisiting cards but not for the
+		 * one in question */
+		if (i == card->number || !snd_cards[i])
+			continue;
+
+		if (strcmp(snd_cards[i]->id, id) == 0)
+			return 1;
+	}
+
+	return 0;
+}
+
+void
+snd_card_make_id_unique(struct snd_card *card)
+{
+	int count = 1;
+	char id[sizeof(card->id)];
+
+	if (*card->id == '\0')
+		return;
+
+	/* if there's a reserved word in the card's chosen id, reset it
+	 * to empty. choose_default_id() will then take care to generate
+	 * an id for the card at a later point */
+	if (!snd_info_check_reserved_words(card->id)) {
+		*card->id = '\0';
+		return;
+	}
+
+	strlcpy(id, card->id, sizeof(id));
+
+	while (card_id_is_ambiguous(card, id)) {
+		/* As we need to add some characters to the id, make
+		 * sure there's enough room for it */
+		int maxlen = sizeof(card->id) - (2 + (count / 10));
+
+		if (strlen(card->id) > maxlen)
+			card->id[maxlen] = '\0';
+
+		snprintf(id, sizeof(id), "%s_%d", card->id, count);
+		count++;
+	}
+
+	strlcpy(card->id, id, sizeof(id));
+}
+EXPORT_SYMBOL_GPL(snd_card_make_id_unique);
+
 #ifndef CONFIG_SYSFS_DEPRECATED
 static ssize_t
 card_id_show_attr(struct device *dev,
-- 
1.6.3.1
