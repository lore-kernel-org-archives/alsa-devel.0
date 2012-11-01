From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 2/2] hda: Cirrus: Fix wrong ADC config
Date: Thu,  1 Nov 2012 13:42:38 +0100
Message-ID: <1351773758-1010-3-git-send-email-alexander.stein@systec-electronic.com>
References: <1351773758-1010-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webbox1416.server-home.net (webbox1416.server-home.net
 [77.236.96.61]) by alsa0.perex.cz (Postfix) with ESMTP id 73A3E2617A4
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 13:42:48 +0100 (CET)
In-Reply-To: <1351773758-1010-1-git-send-email-alexander.stein@systec-electronic.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: alsa-devel@alsa-project.org

Both ADCs were configured wrongly due to the DMIC setting bits written
to the wrong index. Fix it according to CS4207-F4 datasheet.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 sound/pci/hda/patch_cirrus.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 3b7d67a..e18117c 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -1079,14 +1079,17 @@ static void init_input(struct hda_codec *codec)
 			cs_automic(codec, NULL);
 
 		coef = 0x000a; /* ADC1/2 - Digital and Analog Soft Ramp */
+		cs_vendor_coef_set(codec, IDX_ADC_CFG, coef);
+
+		coef = cs_vendor_coef_get(codec, IDX_BEEP_CFG);
 		if (is_active_pin(codec, CS_DMIC2_PIN_NID))
-			coef |= 0x0500; /* DMIC2 2 chan on, GPIO1 off */
+			coef |= 0x1000; /* DMIC2 2 chan on, GPIO1 off */
 		if (is_active_pin(codec, CS_DMIC1_PIN_NID))
-			coef |= 0x1800; /* DMIC1 2 chan on, GPIO0 off
+			coef |= 0x0800; /* DMIC1 2 chan on, GPIO0 off
 					 * No effect if SPDIF_OUT2 is
 					 * selected in IDX_SPDIF_CTL.
 					*/
-		cs_vendor_coef_set(codec, IDX_ADC_CFG, coef);
+		cs_vendor_coef_set(codec, IDX_BEEP_CFG, coef);
 	} else {
 		if (spec->mic_detect)
 			cs_automic(codec, NULL);
-- 
1.7.8.6
