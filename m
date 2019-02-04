From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/11] ALSA: drivers: Clean up with new procfs
	helpers
Date: Mon,  4 Feb 2019 16:20:30 +0100
Message-ID: <20190204152036.14102-6-tiwai@suse.de>
References: <20190204152036.14102-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DD49526755C
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 16:20:40 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 6062DAEDC
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 15:20:39 +0000 (UTC)
In-Reply-To: <20190204152036.14102-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Simplify the proc fs creation code with new helper functions,
snd_card_ro_proc_new() and snd_card_rw_proc_new().
Just a code refactoring and no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/aloop.c      | 10 ++--------
 sound/drivers/dummy.c      | 10 ++--------
 sound/drivers/vx/vx_core.c |  5 +----
 3 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 65c903b639c2..8c3fbe1276be 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -1133,16 +1133,10 @@ static void print_cable_info(struct snd_info_entry *entry,
 static int loopback_proc_new(struct loopback *loopback, int cidx)
 {
 	char name[32];
-	struct snd_info_entry *entry;
-	int err;
 
 	snprintf(name, sizeof(name), "cable#%d", cidx);
-	err = snd_card_proc_new(loopback->card, name, &entry);
-	if (err < 0)
-		return err;
-
-	snd_info_set_text_ops(entry, loopback, print_cable_info);
-	return 0;
+	return snd_card_ro_proc_new(loopback->card, name, loopback,
+				    print_cable_info);
 }
 
 static int loopback_probe(struct platform_device *devptr)
diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index c8d31550e9a1..2672c2e13334 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -1037,14 +1037,8 @@ static void dummy_proc_write(struct snd_info_entry *entry,
 
 static void dummy_proc_init(struct snd_dummy *chip)
 {
-	struct snd_info_entry *entry;
-
-	if (!snd_card_proc_new(chip->card, "dummy_pcm", &entry)) {
-		snd_info_set_text_ops(entry, chip, dummy_proc_read);
-		entry->c.text.write = dummy_proc_write;
-		entry->mode |= 0200;
-		entry->private_data = chip;
-	}
+	snd_card_rw_proc_new(chip->card, "dummy_pcm", chip,
+			     dummy_proc_read, dummy_proc_write);
 }
 #else
 #define dummy_proc_init(x)
diff --git a/sound/drivers/vx/vx_core.c b/sound/drivers/vx/vx_core.c
index 19496fa486aa..543945643a76 100644
--- a/sound/drivers/vx/vx_core.c
+++ b/sound/drivers/vx/vx_core.c
@@ -643,10 +643,7 @@ static void vx_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *b
 
 static void vx_proc_init(struct vx_core *chip)
 {
-	struct snd_info_entry *entry;
-
-	if (! snd_card_proc_new(chip->card, "vx-status", &entry))
-		snd_info_set_text_ops(entry, chip, vx_proc_read);
+	snd_card_ro_proc_new(chip->card, "vx-status", chip, vx_proc_read);
 }
 
 
-- 
2.16.4
