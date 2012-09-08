From: sgiurgiu11@gmail.com
Subject: [PATCH - ALSA: snd-virtuoso 1/1] Xonar DSX support
Date: Sat,  8 Sep 2012 15:09:59 -0400
Message-ID: <504b9831.aac4320a.1f39.ffff8a9f@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Sergiu Giurgiu <sgiurgiu11@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Sergiu Giurgiu <sgiurgiu11@gmail.com>


Signed-off-by: Sergiu Giurgiu <sgiurgiu11@gmail.com>

diff --git a/mirror/sound/pci/oxygen/virtuoso.c b/mirror/sound/pci/oxygen/virtuoso.c
index 3d71423..8104eab 100644
--- a/mirror/sound/pci/oxygen/virtuoso.c
+++ b/mirror/sound/pci/oxygen/virtuoso.c
@@ -52,6 +52,7 @@ static DEFINE_PCI_DEVICE_TABLE(xonar_ids) = {
 	{ OXYGEN_PCI_SUBID(0x1043, 0x835d) },
 	{ OXYGEN_PCI_SUBID(0x1043, 0x835e) },
 	{ OXYGEN_PCI_SUBID(0x1043, 0x838e) },
+	{ OXYGEN_PCI_SUBID(0x1043, 0x8522) },
 	{ OXYGEN_PCI_SUBID_BROKEN_EEPROM },
 	{ }
 };
diff --git a/mirror/sound/pci/oxygen/xonar_wm87x6.c b/mirror/sound/pci/oxygen/xonar_wm87x6.c
index 63cff90..af91016 100644
--- a/mirror/sound/pci/oxygen/xonar_wm87x6.c
+++ b/mirror/sound/pci/oxygen/xonar_wm87x6.c
@@ -1321,6 +1321,40 @@ static const struct oxygen_model model_xonar_hdav_slim = {
 	.adc_i2s_format = OXYGEN_I2S_FORMAT_LJUST,
 };
 
+static const struct oxygen_model model_xonar_dsx = {
+	.shortname = "Xonar DSX",
+	.longname = "Asus Virtuoso 66",
+	.chip = "AV200",
+	.init = xonar_ds_init,
+	.mixer_init = xonar_ds_mixer_init,
+	.cleanup = xonar_ds_cleanup,
+	.suspend = xonar_ds_suspend,
+	.resume = xonar_ds_resume,
+	.pcm_hardware_filter = wm8776_adc_hardware_filter,
+	.set_dac_params = set_wm87x6_dac_params,
+	.set_adc_params = set_wm8776_adc_params,
+	.update_dac_volume = update_wm87x6_volume,
+	.update_dac_mute = update_wm87x6_mute,
+	.update_center_lfe_mix = update_wm8766_center_lfe_mix,
+	.gpio_changed = xonar_ds_gpio_changed,
+	.dump_registers = dump_wm87x6_registers,
+	.dac_tlv = wm87x6_dac_db_scale,
+	.model_data_size = sizeof(struct xonar_wm87x6),
+	.device_config = PLAYBACK_0_TO_I2S |
+			 PLAYBACK_1_TO_SPDIF |
+			 CAPTURE_0_FROM_I2S_1 |
+			 CAPTURE_1_FROM_SPDIF,
+	.dac_channels_pcm = 8,
+	.dac_channels_mixer = 8,
+	.dac_volume_min = 255 - 2*60,
+	.dac_volume_max = 255,
+	.function_flags = OXYGEN_FUNCTION_SPI,
+	.dac_mclks = OXYGEN_MCLKS(256, 256, 128),
+	.adc_mclks = OXYGEN_MCLKS(256, 256, 128),
+	.dac_i2s_format = OXYGEN_I2S_FORMAT_LJUST,
+	.adc_i2s_format = OXYGEN_I2S_FORMAT_LJUST,
+};
+
 int __devinit get_xonar_wm87x6_model(struct oxygen *chip,
 				     const struct pci_device_id *id)
 {
@@ -1331,6 +1365,9 @@ int __devinit get_xonar_wm87x6_model(struct oxygen *chip,
 	case 0x835e:
 		chip->model = model_xonar_hdav_slim;
 		break;
+	case 0x8522:
+		chip->model = model_xonar_dsx;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
1.7.10.4
