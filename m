From: Wang YanQing <udknight@gmail.com>
Subject: [PATCH] ALSA: hda: Fix regression of hdmi eld control
 created based on invalid pcm
Date: Sun, 3 Sep 2017 21:18:49 +0800
Message-ID: <20170903131849.GA2278@udknight>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id A7AF3266CE1
 for <alsa-devel@alsa-project.org>; Sun,  3 Sep 2017 15:24:17 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id 83so2915393pgb.3
 for <alsa-devel@alsa-project.org>; Sun, 03 Sep 2017 06:24:17 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, libin.yang@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Commit fb087eaaef72 ("ALSA: hda - hdmi eld control created based on pcm")
forget to filter out invalid pcm numbers, if there is only one invalid pcm
number, then this issue causes we create eld control for invalid pcm silently,
but when there are more than one invalid pcm numbers, then this issue bring
probe error looks like below dmesg:
"
kernel: [    1.647283] snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops 0xc2967540)
kernel: [    1.651192] snd_hda_intel 0000:00:03.0: Too many HDMI devices
kernel: [    1.651195] snd_hda_intel 0000:00:03.0: Consider building the kernel with CONFIG_SND_DYNAMIC_MINORS=y
kernel: [    1.651197] snd_hda_intel 0000:00:03.0: Too many HDMI devices
kernel: [    1.651199] snd_hda_intel 0000:00:03.0: Consider building the kernel with CONFIG_SND_DYNAMIC_MINORS=y
kernel: [    1.651201] snd_hda_intel 0000:00:03.0: Too many HDMI devices
kernel: [    1.651203] snd_hda_intel 0000:00:03.0: Consider building the kernel with CONFIG_SND_DYNAMIC_MINORS=y
kernel: [    1.651676] snd_hda_intel 0000:00:03.0: control 3:0:0:ELD:0 is already present
kernel: [    1.651787] snd_hda_codec_hdmi: probe of hdaudioC0D0 failed with error -16
"

This patch add invalid pcm number filter before calling hdmi_create_eld_ctl.

Fixes: fb087eaaef72 ("ALSA: hda - hdmi eld control created based on pcm")
Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 sound/pci/hda/hda_codec.c  |  4 +++-
 sound/pci/hda/hda_codec.h  |  1 +
 sound/pci/hda/patch_hdmi.c | 14 ++++++++------
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 821aad3..3db26c4 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3213,8 +3213,10 @@ int snd_hda_codec_build_pcms(struct hda_codec *codec)
 			continue; /* no substreams assigned */
 
 		dev = get_empty_pcm_device(bus, cpcm->pcm_type);
-		if (dev < 0)
+		if (dev < 0) {
+			cpcm->device = SNDRV_PCM_INVALID_DEVICE;
 			continue; /* no fatal error */
+		}
 		cpcm->device = dev;
 		err =  snd_hda_attach_pcm_stream(bus, codec, cpcm);
 		if (err < 0) {
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 60ce1cf..681c360 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -164,6 +164,7 @@ enum {
 	HDA_PCM_NTYPES
 };
 
+#define SNDRV_PCM_INVALID_DEVICE	(-1)
 /* for PCM creation */
 struct hda_pcm {
 	char *name;
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 53f9311..2b64fab 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2126,7 +2126,7 @@ static int generic_hdmi_build_jack(struct hda_codec *codec, int pcm_idx)
 static int generic_hdmi_build_controls(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec = codec->spec;
-	int err;
+	int dev, err;
 	int pin_idx, pcm_idx;
 
 
@@ -2154,11 +2154,13 @@ static int generic_hdmi_build_controls(struct hda_codec *codec)
 			return err;
 		snd_hda_spdif_ctls_unassign(codec, pcm_idx);
 
-		/* add control for ELD Bytes */
-		err = hdmi_create_eld_ctl(codec, pcm_idx,
-					get_pcm_rec(spec, pcm_idx)->device);
-		if (err < 0)
-			return err;
+		dev = get_pcm_rec(spec, pcm_idx)->device;
+		if (dev != SNDRV_PCM_INVALID_DEVICE) {
+			/* add control for ELD Bytes */
+			err = hdmi_create_eld_ctl(codec, pcm_idx, dev);
+			if (err < 0)
+				return err;
+		}
 	}
 
 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
-- 
1.8.5.6.2.g3d8a54e.dirty
