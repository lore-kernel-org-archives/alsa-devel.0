From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: virtuoso: add Xonar Essence STX
	II	support
Date: Fri, 29 Aug 2014 09:49:41 +0200
Message-ID: <54003095.200@ladisch.de>
References: <53FC4901.6070908@allacher.com> <53FC49A8.1010108@gmx.at>
 <53FC4D56.5020808@ladisch.de> <53FC6532.2080903@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 3818726684D
 for <alsa-devel@alsa-project.org>; Fri, 29 Aug 2014 09:49:52 +0200 (CEST)
In-Reply-To: <53FC6532.2080903@gmx.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Allacher <andreas.allacher@gmx.at>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In theory, this patch should work:

--- a/sound/pci/oxygen/xonar_pcm179x.c
+++ b/sound/pci/oxygen/xonar_pcm179x.c
@@ -419,6 +419,7 @@

 	data->generic.output_enable_bit = GPIO_ST_OUTPUT_ENABLE;
 	data->dacs = chip->model.dac_channels_mixer / 2;
+	data->h6 = chip->model.dac_channels_mixer > 2;
 	data->hp_gain_offset = 2*-18;

 	pcm1796_init(chip);
@@ -1140,8 +1141,18 @@
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
