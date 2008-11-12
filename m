From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: RFC: add possibility to change text identification
 string
Date: Wed, 12 Nov 2008 16:29:22 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0811121623330.13649@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0811111657261.13649@tm8103.perex-int.cz>
	<s5h63mujk7t.wl%tiwai@suse.de> <s5h63mtj8i6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 2107E24495
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 16:29:23 +0100 (CET)
In-Reply-To: <s5h63mtj8i6.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 12 Nov 2008, Takashi Iwai wrote:

> At Tue, 11 Nov 2008 17:33:42 +0100,
> I wrote:
> > 
> > At Tue, 11 Nov 2008 17:00:41 +0100 (CET),
> > Jaroslav Kysela wrote:
> > > 
> > > Hi all,
> > > 
> > > 	based on discussion today, I prepared a patch to handle udev-style 
> > > card renaming. Comments are welcome.
> > 
> > Looks good to me.  The sanity check of the id string should be used
> > for the assignment from the module option, too.
> 
> One remaining problem I found is a symlink of id in /proc/asound.
> This won't be changed even if you change the id string via sysfs.
> A minor issue, though.

Thanks for this note. The patch bellow should fix this issue. Also, I'm 
going to remove card->id from hdsp.c and hdspm.c where this string is 
used for rawmidi device name - it might be confusing when changed, too.

						Jaroslav

diff --git a/include/sound/info.h b/include/sound/info.h
index 8ae72e7..baf09d8 100644
--- a/include/sound/info.h
+++ b/include/sound/info.h
@@ -126,6 +126,7 @@ int snd_info_card_create(struct snd_card * card);
 int snd_info_card_register(struct snd_card * card);
 int snd_info_card_free(struct snd_card * card);
 void snd_info_card_disconnect(struct snd_card * card);
+void snd_info_card_id_change(struct snd_card * card);
 int snd_info_register(struct snd_info_entry * entry);
 
 /* for card drivers */
diff --git a/sound/core/info.c b/sound/core/info.c
index 527b207..e91da07 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -653,6 +653,21 @@ int snd_info_card_register(struct snd_card *card)
 }
 
 /*
+ * called on card->id change
+ */
+void snd_info_card_id_change(struct snd_card *card)
+{
+	mutex_lock(&info_mutex);
+	if (card->proc_root_link) {
+		snd_remove_proc_entry(snd_proc_root, card->proc_root_link);
+		card->proc_root_link = NULL;
+	}
+	if (strcmp(card->id, card->proc_root->name))
+		card->proc_root_link = proc_symlink(card->id, snd_proc_root, card->proc_root->name);
+	mutex_unlock(&info_mutex);
+}
+
+/*
  * de-register the card proc file
  * called from init.c
  */
diff --git a/sound/core/init.c b/sound/core/init.c
index 5ff297d..af1e407 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -571,6 +571,7 @@ card_id_store_attr(struct device *dev, struct device_attribute *attr,
 			goto __exist;
 	}
 	strcpy(card->id, buf1);
+	snd_info_card_id_change(card);
 	mutex_unlock(&snd_card_mutex);
 
 	return count;

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
