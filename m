From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: opl3: remove redundant pointer opl3
Date: Mon, 16 Jul 2018 09:34:51 +0100
Message-ID: <20180716083451.15290-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Variable opl3 is being assigned but is never used hence it is
redundant and can be removed.

Cleans up several clang warnings:
warning: variable 'opl3' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/drivers/opl3/opl3_midi.c | 12 ------------
 sound/drivers/opl3/opl3_oss.c  |  6 ------
 2 files changed, 18 deletions(-)

diff --git a/sound/drivers/opl3/opl3_midi.c b/sound/drivers/opl3/opl3_midi.c
index bb3f3a5a6951..71cd5a2fbe82 100644
--- a/sound/drivers/opl3/opl3_midi.c
+++ b/sound/drivers/opl3/opl3_midi.c
@@ -721,9 +721,6 @@ void snd_opl3_note_off(void *p, int note, int vel,
  */
 void snd_opl3_key_press(void *p, int note, int vel, struct snd_midi_channel *chan)
 {
-  	struct snd_opl3 *opl3;
-
-	opl3 = p;
 #ifdef DEBUG_MIDI
 	snd_printk(KERN_DEBUG "Key pressure, ch#: %i, inst#: %i\n",
 		   chan->number, chan->midi_program);
@@ -735,9 +732,6 @@ void snd_opl3_key_press(void *p, int note, int vel, struct snd_midi_channel *cha
  */
 void snd_opl3_terminate_note(void *p, int note, struct snd_midi_channel *chan)
 {
-  	struct snd_opl3 *opl3;
-
-	opl3 = p;
 #ifdef DEBUG_MIDI
 	snd_printk(KERN_DEBUG "Terminate note, ch#: %i, inst#: %i\n",
 		   chan->number, chan->midi_program);
@@ -861,9 +855,6 @@ void snd_opl3_control(void *p, int type, struct snd_midi_channel *chan)
 void snd_opl3_nrpn(void *p, struct snd_midi_channel *chan,
 		   struct snd_midi_channel_set *chset)
 {
-  	struct snd_opl3 *opl3;
-
-	opl3 = p;
 #ifdef DEBUG_MIDI
 	snd_printk(KERN_DEBUG "NRPN, ch#: %i, inst#: %i\n",
 		   chan->number, chan->midi_program);
@@ -876,9 +867,6 @@ void snd_opl3_nrpn(void *p, struct snd_midi_channel *chan,
 void snd_opl3_sysex(void *p, unsigned char *buf, int len,
 		    int parsed, struct snd_midi_channel_set *chset)
 {
-  	struct snd_opl3 *opl3;
-
-	opl3 = p;
 #ifdef DEBUG_MIDI
 	snd_printk(KERN_DEBUG "SYSEX\n");
 #endif
diff --git a/sound/drivers/opl3/opl3_oss.c b/sound/drivers/opl3/opl3_oss.c
index 22c3e4bca220..8a0ce3f43f42 100644
--- a/sound/drivers/opl3/opl3_oss.c
+++ b/sound/drivers/opl3/opl3_oss.c
@@ -233,11 +233,8 @@ static int snd_opl3_load_patch_seq_oss(struct snd_seq_oss_arg *arg, int format,
 static int snd_opl3_ioctl_seq_oss(struct snd_seq_oss_arg *arg, unsigned int cmd,
 				  unsigned long ioarg)
 {
-	struct snd_opl3 *opl3;
-
 	if (snd_BUG_ON(!arg))
 		return -ENXIO;
-	opl3 = arg->private_data;
 	switch (cmd) {
 		case SNDCTL_FM_LOAD_INSTR:
 			snd_printk(KERN_ERR "OPL3: "
@@ -261,11 +258,8 @@ static int snd_opl3_ioctl_seq_oss(struct snd_seq_oss_arg *arg, unsigned int cmd,
 /* reset device */
 static int snd_opl3_reset_seq_oss(struct snd_seq_oss_arg *arg)
 {
-	struct snd_opl3 *opl3;
-
 	if (snd_BUG_ON(!arg))
 		return -ENXIO;
-	opl3 = arg->private_data;
 
 	return 0;
 }
-- 
2.17.1
