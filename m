From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Add sanity check of vmaster
	slave dB steps
Date: Mon,  4 Nov 2013 17:08:30 +0100
Message-ID: <1383581310-9947-2-git-send-email-tiwai@suse.de>
References: <1383581310-9947-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (unknown [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 822E5264E9D
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2013 17:08:50 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4E21FA60D0
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2013 17:08:30 +0100 (CET)
In-Reply-To: <1383581310-9947-1-git-send-email-tiwai@suse.de>
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

Check whether all vmaster slaves have the same dB steps.  Otherwise
the behavior would become inconsistent.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 33c01d551aa4..dd5403d40830 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2661,7 +2661,7 @@ static int check_slave_present(void *data, struct snd_kcontrol *sctl)
 }
 
 /* guess the value corresponding to 0dB */
-static int get_kctl_0dB_offset(struct snd_kcontrol *kctl)
+static int get_kctl_0dB_offset(struct snd_kcontrol *kctl, int *step_to_check)
 {
 	int _tlv[4];
 	const int *tlv = NULL;
@@ -2681,6 +2681,12 @@ static int get_kctl_0dB_offset(struct snd_kcontrol *kctl)
 		step &= ~TLV_DB_SCALE_MUTE;
 		if (!step)
 			return -1;
+		if (*step_to_check && *step_to_check != step) {
+			snd_printk(KERN_ERR "hda_codec: Mismatching dB step for vmaster slave (%d!=%d)\n",
+				   *step_to_check, step);
+			return -1;
+		}
+		*step_to_check = step;
 		val = -tlv[2] / step;
 	}
 	return val;
@@ -2703,7 +2709,7 @@ static int put_kctl_with_value(struct snd_kcontrol *kctl, int val)
 /* initialize the slave volume with 0dB */
 static int init_slave_0dB(void *data, struct snd_kcontrol *slave)
 {
-	int offset = get_kctl_0dB_offset(slave);
+	int offset = get_kctl_0dB_offset(slave, data);
 	if (offset > 0)
 		put_kctl_with_value(slave, offset);
 	return 0;
@@ -2764,9 +2770,11 @@ int __snd_hda_add_vmaster(struct hda_codec *codec, char *name,
 
 	/* init with master mute & zero volume */
 	put_kctl_with_value(kctl, 0);
-	if (init_slave_vol)
+	if (init_slave_vol) {
+		int step = 0;
 		map_slaves(codec, slaves, suffix,
-			   tlv ? init_slave_0dB : init_slave_unmute, kctl);
+			   tlv ? init_slave_0dB : init_slave_unmute, &step);
+	}
 
 	if (ctl_ret)
 		*ctl_ret = kctl;
-- 
1.8.4.2
