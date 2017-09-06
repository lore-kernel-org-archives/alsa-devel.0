From: Li Xu <li.xu@cirrus.com>
Subject: [PATCH] ASoC: cs43130: Add break keyword to switch case
Date: Tue, 5 Sep 2017 20:33:04 -0500
Message-ID: <cdb2768e-7853-4ada-b1e3-dd48d09d0d15@EX4.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 24D3D26734C
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 03:33:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, brian.austin@cirrus.com, tiwai@suse.com, robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, Paul.Handrigan@cirrus.com, Li Xu <li.xu@cirrus.com>
List-Id: alsa-devel@alsa-project.org

Add break keyword to all switch case unless the case is returning.
Also remove gpio check for consistency.

Signed-off-by: Li Xu <li.xu@cirrus.com>
---
This patch addresses stylistic issues in driver.

 sound/soc/codecs/cs43130.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 643e37f..5ba0edc 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -909,6 +909,7 @@ static int cs43130_hw_params(struct snd_pcm_substream *substream,
 		regmap_update_bits(cs43130->regmap, CS43130_DSD_PATH_CTL_2,
 				   CS43130_DSD_SRC_MASK, CS43130_DSD_SRC_XSP <<
 				   CS43130_DSD_SRC_SHIFT);
+		break;
 	}
 
 	if (!sclk && cs43130->dais[dai->id].dai_mode == SND_SOC_DAIFMT_CBM_CFM)
@@ -1039,6 +1040,7 @@ static int cs43130_pcm_ch_put(struct snd_kcontrol *kcontrol,
 		else
 			regmap_multi_reg_write(cs43130->regmap, pcm_ch_dis_seq,
 					       ARRAY_SIZE(pcm_ch_dis_seq));
+		break;
 	}
 
 	return snd_soc_put_enum_double(kcontrol, ucontrol);
@@ -1152,6 +1154,7 @@ static int cs43130_dsd_event(struct snd_soc_dapm_widget *w,
 		case CS4399_CHIP_ID:
 			regmap_multi_reg_write(cs43130->regmap, dsd_seq,
 					       ARRAY_SIZE(dsd_seq));
+			break;
 		}
 		break;
 	case SND_SOC_DAPM_POST_PMU:
@@ -1162,6 +1165,7 @@ static int cs43130_dsd_event(struct snd_soc_dapm_widget *w,
 		case CS4399_CHIP_ID:
 			regmap_multi_reg_write(cs43130->regmap, unmute_seq,
 					       ARRAY_SIZE(unmute_seq));
+			break;
 		}
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
@@ -1184,6 +1188,7 @@ static int cs43130_dsd_event(struct snd_soc_dapm_widget *w,
 			regmap_update_bits(cs43130->regmap,
 					   CS43130_DSD_PATH_CTL_1,
 					   CS43130_MUTE_MASK, CS43130_MUTE_EN);
+			break;
 		}
 		break;
 	default:
@@ -1206,6 +1211,7 @@ static int cs43130_pcm_event(struct snd_soc_dapm_widget *w,
 		case CS4399_CHIP_ID:
 			regmap_multi_reg_write(cs43130->regmap, pcm_seq,
 					       ARRAY_SIZE(pcm_seq));
+			break;
 		}
 		break;
 	case SND_SOC_DAPM_POST_PMU:
@@ -1216,6 +1222,7 @@ static int cs43130_pcm_event(struct snd_soc_dapm_widget *w,
 		case CS4399_CHIP_ID:
 			regmap_multi_reg_write(cs43130->regmap, unmute_seq,
 					       ARRAY_SIZE(unmute_seq));
+			break;
 		}
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
@@ -1238,6 +1245,7 @@ static int cs43130_pcm_event(struct snd_soc_dapm_widget *w,
 			regmap_update_bits(cs43130->regmap,
 					   CS43130_PCM_PATH_CTL_1,
 					   CS43130_MUTE_MASK, CS43130_MUTE_EN);
+			break;
 		}
 		break;
 	default:
@@ -1277,6 +1285,7 @@ static int cs43130_dac_event(struct snd_soc_dapm_widget *w,
 		case CS43198_CHIP_ID:
 			regmap_multi_reg_write(cs43130->regmap, pop_free_seq2,
 					       ARRAY_SIZE(pop_free_seq2));
+			break;
 		}
 		break;
 	case SND_SOC_DAPM_POST_PMU:
@@ -1301,6 +1310,7 @@ static int cs43130_dac_event(struct snd_soc_dapm_widget *w,
 		case CS43198_CHIP_ID:
 			usleep_range(12000, 12010);
 			regmap_write(cs43130->regmap, CS43130_DXD13, 0);
+			break;
 		}
 
 		regmap_write(cs43130->regmap, CS43130_DXD1, 0);
@@ -1311,6 +1321,7 @@ static int cs43130_dac_event(struct snd_soc_dapm_widget *w,
 		case CS4399_CHIP_ID:
 			regmap_multi_reg_write(cs43130->regmap, dac_postpmd_seq,
 					       ARRAY_SIZE(dac_postpmd_seq));
+			break;
 		}
 		break;
 	default:
@@ -2133,6 +2144,7 @@ static void cs43130_imp_meas(struct work_struct *wk)
 		cs43130_hpload_proc(cs43130, hp_dis_cal_seq2,
 				    ARRAY_SIZE(hp_dis_cal_seq2),
 				    CS43130_HPLOAD_OFF_INT, ac_idx);
+		break;
 	}
 
 	regmap_multi_reg_write(cs43130->regmap, hp_cln_seq,
@@ -2543,6 +2555,7 @@ static int cs43130_i2c_probe(struct i2c_client *client,
 			digital_hp_routes;
 		soc_codec_dev_cs43130.component_driver.num_dapm_routes =
 			ARRAY_SIZE(digital_hp_routes);
+		break;
 	}
 
 	ret = snd_soc_register_codec(&client->dev, &soc_codec_dev_cs43130,
@@ -2586,8 +2599,7 @@ static int cs43130_i2c_remove(struct i2c_client *client)
 		device_remove_file(&client->dev, &dev_attr_hpload_ac_r);
 	}
 
-	if (cs43130->reset_gpio)
-		gpiod_set_value_cansleep(cs43130->reset_gpio, 0);
+	gpiod_set_value_cansleep(cs43130->reset_gpio, 0);
 
 	pm_runtime_disable(&client->dev);
 	regulator_bulk_disable(CS43130_NUM_SUPPLIES, cs43130->supplies);
-- 
1.9.1
