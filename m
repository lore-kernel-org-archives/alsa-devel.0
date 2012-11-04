From: Daniel J Blueman <daniel@quora.org>
Subject: [PATCH 1/2] HDA: Fix digital microphone on CS420x
Date: Sun,  4 Nov 2012 13:19:03 +0800
Message-ID: <1352006344-3378-1-git-send-email-daniel@quora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 33F2B261676
 for <alsa-devel@alsa-project.org>; Sun,  4 Nov 2012 06:20:22 +0100 (CET)
Received: by mail-da0-f51.google.com with SMTP id t11so2017799daj.38
 for <alsa-devel@alsa-project.org>; Sat, 03 Nov 2012 22:20:21 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Daniel J Blueman <daniel@quora.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: alsa-devel@alsa-project.org

Correctly enable the digital microphones with the right bits in the right coeffecient
registers on Cirrus CS4206/7 codecs. It also prevents misconfiguring ADC1/2.

This fixes the digital mic on the Macbook Pro 10,1/Retina.

Based-on-patch-by: Alexander Stein <alexander.stein@systec-electronic.com>
Signed-off-by: Daniel J Blueman <daniel@quora.org>
---
 sound/pci/hda/patch_cirrus.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 61a7113..859a119 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -101,8 +101,8 @@ enum {
 #define CS420X_VENDOR_NID	0x11
 #define CS_DIG_OUT1_PIN_NID	0x10
 #define CS_DIG_OUT2_PIN_NID	0x15
-#define CS_DMIC1_PIN_NID	0x12
-#define CS_DMIC2_PIN_NID	0x0e
+#define CS_DMIC1_PIN_NID	0x0e
+#define CS_DMIC2_PIN_NID	0x12
 
 /* coef indices */
 #define IDX_SPDIF_STAT		0x0000
@@ -1079,14 +1079,18 @@ static void init_input(struct hda_codec *codec)
 			cs_automic(codec, NULL);
 
 		coef = 0x000a; /* ADC1/2 - Digital and Analog Soft Ramp */
+		cs_vendor_coef_set(codec, IDX_ADC_CFG, coef);
+
+		coef = cs_vendor_coef_get(codec, IDX_BEEP_CFG);
 		if (is_active_pin(codec, CS_DMIC2_PIN_NID))
-			coef |= 0x0500; /* DMIC2 2 chan on, GPIO1 off */
+			coef |= 1 << 4; /* DMIC2 2 chan on, GPIO1 off */
 		if (is_active_pin(codec, CS_DMIC1_PIN_NID))
-			coef |= 0x1800; /* DMIC1 2 chan on, GPIO0 off
+			coef |= 1 << 3; /* DMIC1 2 chan on, GPIO0 off
 					 * No effect if SPDIF_OUT2 is
 					 * selected in IDX_SPDIF_CTL.
 					*/
-		cs_vendor_coef_set(codec, IDX_ADC_CFG, coef);
+
+		cs_vendor_coef_set(codec, IDX_BEEP_CFG, coef);
 	} else {
 		if (spec->mic_detect)
 			cs_automic(codec, NULL);
-- 
1.7.10.4
