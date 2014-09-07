From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 5/5] ALSA: virtuoso: add Xonar Essence STX II
	daughterboard	support
Date: Sun, 07 Sep 2014 21:47:33 +0200
Message-ID: <540CB655.7020103@ladisch.de>
References: <540CB520.50909@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 415B2260859
 for <alsa-devel@alsa-project.org>; Sun,  7 Sep 2014 21:46:43 +0200 (CEST)
In-Reply-To: <540CB520.50909@ladisch.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Detect and handle the H6 daughterboard; it works the same as with the
ST, except that there is no conflict with the CS2000 chip.

Tested-by: Andreas Allacher <andreas.allacher@gmx.at>
Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/pci/oxygen/xonar_pcm179x.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/pci/oxygen/xonar_pcm179x.c b/sound/pci/oxygen/xonar_pcm179x.c
index 3c0a679..0d6a805 100644
--- a/sound/pci/oxygen/xonar_pcm179x.c
+++ b/sound/pci/oxygen/xonar_pcm179x.c
@@ -419,6 +419,7 @@ static void xonar_st_init_common(struct oxygen *chip)

 	data->generic.output_enable_bit = GPIO_ST_OUTPUT_ENABLE;
 	data->dacs = chip->model.dac_channels_mixer / 2;
+	data->h6 = chip->model.dac_channels_mixer > 2;
 	data->hp_gain_offset = 2*-18;

 	pcm1796_init(chip);
@@ -1142,8 +1143,18 @@ int get_xonar_pcm179x_model(struct oxygen *chip,
 		break;
 	case 0x85f4:
 		chip->model = model_xonar_st;
-		/* TODO: daughterboard support */
-		chip->model.shortname = "Xonar STX II";
+		oxygen_clear_bits16(chip, OXYGEN_GPIO_CONTROL, GPIO_DB_MASK);
+		switch (oxygen_read16(chip, OXYGEN_GPIO_DATA) & GPIO_DB_MASK) {
+		default:
+			chip->model.shortname = "Xonar STX II";
+			break;
+		case GPIO_DB_H6:
+			chip->model.shortname = "Xonar STX II+H6";
+			chip->model.dac_channels_pcm = 8;
+			chip->model.dac_channels_mixer = 8;
+			chip->model.dac_mclks = OXYGEN_MCLKS(256, 128, 128);
+			break;
+		}
 		chip->model.init = xonar_stx_init;
 		chip->model.resume = xonar_stx_resume;
 		chip->model.set_dac_params = set_pcm1796_params;
