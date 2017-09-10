From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: cs43130: Add break keyword to switch case" to the asoc tree
Date: Sun, 10 Sep 2017 05:58:49 +0100
Message-ID: <E1dquKX-0005RS-EQ@debutante>
References: <cdb2768e-7853-4ada-b1e3-dd48d09d0d15@EX4.ad.cirrus.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cdb2768e-7853-4ada-b1e3-dd48d09d0d15-k7YZYYsDncjfk+Ne4bZl5AC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.orgbroonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.orgalsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs43130: Add break keyword to switch case

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 574ff444b9fcc2554e381054f5052cb9c0e91de7 Mon Sep 17 00:00:00 2001
From: Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Date: Tue, 5 Sep 2017 20:33:04 -0500
Subject: [PATCH] ASoC: cs43130: Add break keyword to switch case

Add break keyword to all switch case unless the case is returning.
Also remove gpio check for consistency.

Signed-off-by: Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 sound/soc/codecs/cs43130.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 643e37fc218e..5ba0edc19df4 100644
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
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
