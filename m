From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: hda ca0132 - remove unused error
	handling code
Date: Tue, 7 Feb 2012 10:19:32 +0300
Message-ID: <20120207071932.GA21047@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from acsinet15.oracle.com (acsinet15.oracle.com [141.146.126.227])
	by alsa0.perex.cz (Postfix) with ESMTP id E513B103F45
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2012 08:19:48 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Paul Gortmaker <paul.gortmaker@windriver.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

We never save the return value from chipio_write() so "err" is always
zero here, not less than zero.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
The other option would be to save the return value.  I don't have the
hardware and I worried that there was a reason we don't save it.  The
current code is misleading because it looks like it's checked until
you notice that the "err = " bit is missing.

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 35abe3c..92f1f0c 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -733,8 +733,6 @@ static int ca0132_hp_switch_put(struct snd_kcontrol *kcontrol,
 	/* *valp 0 is mute, 1 is unmute */
 	data = (data & 0x7f) | (*valp ? 0 : 0x80);
 	chipio_write(codec, REG_CODEC_MUTE, data);
-	if (err < 0)
-		return err;
 
 	spec->curr_hp_switch = *valp;
 
@@ -775,8 +773,6 @@ static int ca0132_speaker_switch_put(struct snd_kcontrol *kcontrol,
 	/* *valp 0 is mute, 1 is unmute */
 	data = (data & 0xef) | (*valp ? 0 : 0x10);
 	chipio_write(codec, REG_CODEC_MUTE, data);
-	if (err < 0)
-		return err;
 
 	spec->curr_speaker_switch = *valp;
 
@@ -824,14 +820,10 @@ static int ca0132_hp_volume_put(struct snd_kcontrol *kcontrol,
 	val = 31 - left_vol;
 	data = (data & 0xe0) | val;
 	chipio_write(codec, REG_CODEC_HP_VOL_L, data);
-	if (err < 0)
-		return err;
 
 	val = 31 - right_vol;
 	data = (data & 0xe0) | val;
 	chipio_write(codec, REG_CODEC_HP_VOL_R, data);
-	if (err < 0)
-		return err;
 
 	spec->curr_hp_volume[0] = left_vol;
 	spec->curr_hp_volume[1] = right_vol;
