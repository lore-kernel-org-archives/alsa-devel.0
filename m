From: Gen <madeallup.gen@gmail.com>
Subject: [PATCH - Preliminary Xonar Xense support 1/1] Added
	support for Xonar Xense. Only speaker out and mic in working.
Date: Sun, 28 Jul 2013 02:45:48 +0100
Message-ID: <1374975948-9895-1-git-send-email-madeallup.gen@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Gen <madeallup.gen@gmail.com>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Gen <madeallup.gen@gmail.com>

diff --git a/sound/pci/oxygen/virtuoso.c b/sound/pci/oxygen/virtuoso.c
index 64b9fda..df99ec9 100644
--- a/sound/pci/oxygen/virtuoso.c
+++ b/sound/pci/oxygen/virtuoso.c
@@ -52,6 +52,7 @@ static DEFINE_PCI_DEVICE_TABLE(xonar_ids) = {
 	{ OXYGEN_PCI_SUBID(0x1043, 0x835d) },
 	{ OXYGEN_PCI_SUBID(0x1043, 0x835e) },
 	{ OXYGEN_PCI_SUBID(0x1043, 0x838e) },
+	{ OXYGEN_PCI_SUBID(0x1043, 0x8428) },
 	{ OXYGEN_PCI_SUBID(0x1043, 0x8522) },
 	{ OXYGEN_PCI_SUBID_BROKEN_EEPROM },
 	{ }
diff --git a/sound/pci/oxygen/xonar_pcm179x.c b/sound/pci/oxygen/xonar_pcm179x.c
index c8c7f2c..2567810 100644
--- a/sound/pci/oxygen/xonar_pcm179x.c
+++ b/sound/pci/oxygen/xonar_pcm179x.c
@@ -499,6 +499,17 @@ static void xonar_stx_init(struct oxygen *chip)
 	xonar_st_init_common(chip);
 }
 
+static void xonar_xense_init(struct oxygen *chip)
+{
+	struct xonar_pcm179x *data = chip->model_data;
+
+	data->generic.ext_power_reg = OXYGEN_GPI_DATA;
+	data->generic.ext_power_int_reg = OXYGEN_GPI_INTERRUPT_MASK;
+	data->generic.ext_power_bit = GPI_EXT_POWER;
+	xonar_init_ext_power(chip);
+	xonar_st_init(chip);
+}
+
 static void xonar_d2_cleanup(struct oxygen *chip)
 {
 	xonar_disable_output(chip);
@@ -1138,6 +1149,14 @@ int get_xonar_pcm179x_model(struct oxygen *chip,
 		chip->model.resume = xonar_stx_resume;
 		chip->model.set_dac_params = set_pcm1796_params;
 		break;
+	case 0x8428:
+		chip->model = model_xonar_st;
+		chip->model.shortname = "Xonar Xense";
+		chip->model.chip = "AV100";
+		chip->model.init = xonar_xense_init;
+		chip->model.dac_channels_pcm = 8;
+		chip->model.dac_channels_mixer = 8;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
1.8.1.2
