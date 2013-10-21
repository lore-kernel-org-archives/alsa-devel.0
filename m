From: =?ISO-8859-1?Q?st=E9phane_cerveau?= <scerveau@gmail.com>
Subject: Re: mxc-spdif delay: miss 1-2s at the beginning of the
	song
Date: Mon, 21 Oct 2013 13:50:26 +0200
Message-ID: <52651502.7000608@gmail.com>
References: <525D4F5B.6050105@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070101010009010305090103"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id D16A42602AD
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2013 13:50:28 +0200 (CEST)
Received: by mail-wi0-f173.google.com with SMTP id ey11so3781184wid.12
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2013 04:50:28 -0700 (PDT)
Received: from [172.24.63.13] ([94.103.137.126])
 by mx.google.com with ESMTPSA id ft19sm31499488wic.5.2013.10.21.04.50.27
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 21 Oct 2013 04:50:27 -0700 (PDT)
In-Reply-To: <525D4F5B.6050105@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070101010009010305090103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Dear all,

I had some progress concerning spdif various issues (alsactl store lock,=20
rx to tx support).
Here is in attachment the patch.

Concerning the music startup i still have some issues with sync. If=20
there is someone who can help me out with this, i will be pleased to=20
work on this issue. IMX documentation is not really clear enough to me.=20
Especially for the config SPDIF_SCR/TxFifo_ctrl.
For now i put a delay in playback start but this is not clearly fixing=20
the issue and this is not a solution for me.

Best regards.

St=E9phane


On 10/15/2013 04:21 PM, st=E9phane cerveau wrote:
> Dear all,
>
> I'm facing a delay during startup missing 1-2s of the song when i'm=20
> using mxc spdif with aplay.
> I guess its a problem with spdif synchronization. If i put a=20
> msleep(1000) at the end of the function=20
> mxc-spdif.c:mxc_spdif_playback_start, the playback is ok.
>
> Is there anyone who already faced this issue?
> BR.
>
> St=E9phane


--------------070101010009010305090103
Content-Type: text/x-patch;
 name="006_spdif_fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="006_spdif_fixes.patch"

Index: git/sound/soc/codecs/mxc_spdif.c
===================================================================
--- git.orig/sound/soc/codecs/mxc_spdif.c	2013-10-18 17:00:32.704690599 +0200
+++ git/sound/soc/codecs/mxc_spdif.c	2013-10-18 17:03:20.547153022 +0200
@@ -12,7 +12,6 @@
  * http://www.opensource.org/licenses/gpl-license.html
  * http://www.gnu.org/copyleft/gpl.html
  */
-
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -38,6 +37,12 @@
 
 #define MXC_SPDIF_DEBUG 0
 
+enum spdif_rx2tx_modes {
+	SPDIF_RX2TX_OFF = 0,
+	SPDIF_RX2TX_ON,
+	SPDIF_RX2TX_LAST_MODE,
+};
+
 static unsigned int gainsel_multi[GAINSEL_MULTI_MAX] = {
 	24 * 1024, 16 * 1024, 12 * 1024,
 	8 * 1024, 6 * 1024, 4 * 1024,
@@ -74,6 +79,7 @@
 	atomic_t dpll_locked;	/* DPLL locked status */
 	bool tx_active;
 	bool rx_active;
+	enum spdif_rx2tx_modes rx2tx_en;
 };
 
 struct spdif_mixer_control mxc_spdif_control;
@@ -522,6 +528,99 @@
 	.mask = 0,
 };
 
+static int spdif_get_rx2tx(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct mxc_spdif_priv *spdif_priv = snd_soc_codec_get_drvdata(codec);
+	ucontrol->value.integer.value[0] = spdif_priv->rx2tx_en;
+
+	return 0;
+}
+
+static void enable_rx2tx(struct mxc_spdif_priv *priv)
+{
+	u32 regval;
+	if (!priv->tx_active && !priv->rx_active)
+		clk_enable(priv->plat_data->spdif_core_clk);
+
+	regval = __raw_readl(spdif_base_addr + SPDIF_REG_SCR);
+	regval &= ~SCR_LOW_POWER;
+	if (priv->rx2tx_en) {
+		regval &=  ~SCR_TXSEL_NORMAL;
+		regval |=  SCR_TXSEL_RX;
+	}
+	else {
+		regval &=  ~SCR_TXSEL_RX;
+		regval |=  SCR_TXSEL_NORMAL;
+	}
+
+	__raw_writel(regval, SPDIF_REG_SCR + spdif_base_addr);
+
+	if (!priv->tx_active && !priv->rx_active)
+		clk_disable(priv->plat_data->spdif_core_clk);
+}
+
+static int spdif_set_rx2tx(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct mxc_spdif_priv *spdif_priv = snd_soc_codec_get_drvdata(codec);
+	int ret = 0;
+
+	/* Do not allow changes while stream is running*/
+	if (codec->active)
+		return -EPERM;
+
+	if (ucontrol->value.integer.value[0] < 0 ||
+	    ucontrol->value.integer.value[0] >= SPDIF_RX2TX_LAST_MODE)
+		ret = -EINVAL;
+	else
+		spdif_priv->rx2tx_en = ucontrol->value.integer.value[0];
+
+	enable_rx2tx(spdif_priv);
+
+	return ret;
+}
+
+/*
+ * DAPM controls.
+ */
+static const struct snd_soc_dapm_widget spdif_dapm_widgets[] = {
+SND_SOC_DAPM_DAC("SPDIF", "HiFi Playback", SND_SOC_NOPM, 0, 0),
+SND_SOC_DAPM_OUTPUT("VOUT"),
+};
+
+static const struct snd_soc_dapm_route spdif_intercon[] = {
+	{"VOUT", NULL, "SPDIF"},
+};
+
+static int spdif_add_widgets(struct snd_soc_codec *codec)
+{
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
+	snd_soc_dapm_new_controls(dapm, spdif_dapm_widgets,
+				  ARRAY_SIZE(spdif_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, spdif_intercon, ARRAY_SIZE(spdif_intercon));
+
+	return 0;
+}
+
+/* Codec operation modes */
+static const char *spdif_rx2tx_mode[] = {
+	"Off", "On"
+};
+
+static const struct soc_enum spdif_rx2tx_mode_enum =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(spdif_rx2tx_mode),
+			    spdif_rx2tx_mode);
+
+
+static const struct snd_kcontrol_new spdif_rx2tx_mode_snd_controls[] = {
+	SOC_ENUM_EXT("RX2TX_PassThrough", spdif_rx2tx_mode_enum,
+		 spdif_get_rx2tx, spdif_set_rx2tx),
+};
+
 static int mxc_spdif_playback_startup(struct snd_pcm_substream *substream,
 					       struct snd_soc_dai *dai)
 {
@@ -601,6 +700,9 @@
 	regval |= SCR_DMA_TX_EN;
 	__raw_writel(regval, SPDIF_REG_SCR + spdif_base_addr);
 
+	// TODO Get a better way to get synchro
+	// Wait synchro.
+	mdelay(2500);
 	dumpregs(spdif_priv);
 	return 0;
 }
@@ -677,6 +779,11 @@
 	struct mxc_spdif_platform_data *plat_data = spdif_priv->plat_data;
 	int err = 0;
 
+	if (spdif_priv->rx2tx_en) {
+		pr_info("rx2tx is enabled");
+		return -EINVAL;
+	}
+
 	if (!plat_data->spdif_rx)
 		return -EINVAL;
 
@@ -708,6 +815,7 @@
 	return err;
 }
 
+
 static int mxc_spdif_capture_start(struct snd_pcm_substream *substream,
 					 struct snd_soc_dai *dai)
 {
@@ -882,10 +990,15 @@
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	unsigned int cstatus;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct mxc_spdif_priv *spdif_priv = snd_soc_codec_get_drvdata(codec);
 
-	if (!(__raw_readl(spdif_base_addr + SPDIF_REG_SIS) & INT_CNEW))
-		return -EAGAIN;
 
+	if (!spdif_priv->tx_active && !spdif_priv->rx_active)
+		clk_enable(spdif_priv->plat_data->spdif_core_clk);
+
+	if (!(__raw_readl(spdif_base_addr + SPDIF_REG_SIS) & INT_CNEW))
+		return 0;
 	cstatus = __raw_readl(spdif_base_addr + SPDIF_REG_SRCSLH);
 	ucontrol->value.iec958.status[0] = (cstatus >> 16) & 0xFF;
 	ucontrol->value.iec958.status[1] = (cstatus >> 8) & 0xFF;
@@ -898,6 +1011,9 @@
 	/* clear intr */
 	__raw_writel(INT_CNEW, spdif_base_addr + SPDIF_REG_SIC);
 
+	if (!spdif_priv->tx_active && !spdif_priv->rx_active)
+		clk_disable(spdif_priv->plat_data->spdif_core_clk);
+
 	return 0;
 }
 
@@ -917,11 +1033,8 @@
 		       &mxc_spdif_control.subcode[(mxc_spdif_control.ready_buf -
 						   1) * SPDIF_UBITS_SIZE],
 		       SPDIF_UBITS_SIZE);
-	} else {
-		ret = -EAGAIN;
 	}
 	spin_unlock_irqrestore(&mxc_spdif_control.ctl_lock, flags);
-
 	return ret;
 }
 
@@ -953,8 +1066,6 @@
 		       &mxc_spdif_control.qsub[(mxc_spdif_control.ready_buf -
 						1) * SPDIF_QSUB_SIZE],
 		       SPDIF_QSUB_SIZE);
-	} else {
-		ret = -EAGAIN;
 	}
 	spin_unlock_irqrestore(&mxc_spdif_control.ctl_lock, flags);
 
@@ -981,11 +1092,17 @@
 			      struct snd_ctl_elem_value *ucontrol)
 {
 	unsigned int int_val;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct mxc_spdif_priv *spdif_priv = snd_soc_codec_get_drvdata(codec);
+	if (!spdif_priv->tx_active && !spdif_priv->rx_active)
+		clk_enable(spdif_priv->plat_data->spdif_core_clk);
 
 	int_val = __raw_readl(spdif_base_addr + SPDIF_REG_SIS);
 	ucontrol->value.integer.value[0] = (int_val & INT_VAL_NOGOOD) != 0;
 	__raw_writel(INT_VAL_NOGOOD, spdif_base_addr + SPDIF_REG_SIC);
 
+	if (!spdif_priv->tx_active && !spdif_priv->rx_active)
+		clk_disable(spdif_priv->plat_data->spdif_core_clk);
 	return 0;
 }
 
@@ -1047,8 +1164,17 @@
 			       struct snd_ctl_elem_value *ucontrol)
 {
 	unsigned int int_val;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct mxc_spdif_priv *spdif_priv = snd_soc_codec_get_drvdata(codec);
+
+	if (!spdif_priv->tx_active && !spdif_priv->rx_active)
+		clk_enable(spdif_priv->plat_data->spdif_core_clk);
+
 	int_val = __raw_readl(spdif_base_addr + SPDIF_REG_SRCD);
 	ucontrol->value.integer.value[0] = (int_val & SRCD_CD_USER) != 0;
+
+	if (!spdif_priv->tx_active && !spdif_priv->rx_active)
+		clk_disable(spdif_priv->plat_data->spdif_core_clk);
 	return 0;
 }
 
@@ -1061,9 +1187,15 @@
 				   struct snd_ctl_elem_value *ucontrol)
 {
 	unsigned int int_val;
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct mxc_spdif_priv *spdif_priv = snd_soc_codec_get_drvdata(codec);
+	if (!spdif_priv->tx_active && !spdif_priv->rx_active)
+		clk_enable(spdif_priv->plat_data->spdif_core_clk);
 
 	int_val = ucontrol->value.integer.value[0] << SRCD_CD_USER_OFFSET;
 	__raw_writel(int_val, spdif_base_addr + SPDIF_REG_SRCD);
+	if (!spdif_priv->tx_active && !spdif_priv->rx_active)
+		clk_disable(spdif_priv->plat_data->spdif_core_clk);
 	return 0;
 }
 
@@ -1140,6 +1272,10 @@
 	struct mxc_spdif_platform_data *plat_data = spdif_priv->plat_data;
 	int ret = 0;
 
+	if (spdif_priv->rx2tx_en) {
+		pr_info("rx2tx is enabled");
+		return -EINVAL;
+	}
 	/* enable spdif_xtal_clk */
 	ret = clk_enable(plat_data->spdif_core_clk);
 	if (ret < 0)
@@ -1198,7 +1334,10 @@
 static int mxc_spdif_soc_probe(struct snd_soc_codec *codec)
 {
 	snd_soc_add_controls(codec, mxc_spdif_ctrls,
-			     ARRAY_SIZE(mxc_spdif_ctrls));
+					ARRAY_SIZE(mxc_spdif_ctrls));
+	snd_soc_add_controls(codec, spdif_rx2tx_mode_snd_controls,
+					ARRAY_SIZE(spdif_rx2tx_mode_snd_controls));
+     spdif_add_widgets(codec);
 	return 0;
 }
 
@@ -1260,6 +1399,7 @@
 
 	spdif_priv->tx_active = false;
 	spdif_priv->rx_active = false;
+	spdif_priv->rx2tx_en = SPDIF_RX2TX_OFF;
 	platform_set_drvdata(pdev, spdif_priv);
 
 	spdif_priv->reg_phys_base = res->start;
@@ -1307,6 +1447,7 @@
 		goto card_err;
 	}
 
+
 	dumpregs(spdif_priv);
 
 	return 0;
Index: git/sound/soc/imx/imx-spdif.c
===================================================================
--- git.orig/sound/soc/imx/imx-spdif.c	2013-10-18 17:00:32.704690599 +0200
+++ git/sound/soc/imx/imx-spdif.c	2013-10-18 17:01:25.505465029 +0200
@@ -33,6 +33,35 @@
 #include "imx-ssi.h"
 #include "../codecs/mxc_spdif.h"
 
+/* imx_3stack card dapm widgets */
+static const struct snd_soc_dapm_widget imx_3stack_dapm_widgets[] = {
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+};
+
+/* imx_3stack machine connections to the codec pins */
+static const struct snd_soc_dapm_route audio_map[] = {
+	/* LINE_OUT --> Ext Speaker */
+	{"Ext Spk", NULL, "VOUT"},
+};
+
+
+static int imx_3stack_spdif_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	int ret;
+
+		/* Add imx_3stack specific widgets */
+	snd_soc_dapm_new_controls(&codec->dapm, imx_3stack_dapm_widgets,
+				  ARRAY_SIZE(imx_3stack_dapm_widgets));
+
+	/* Set up imx_3stack specific audio path audio_map */
+	snd_soc_dapm_add_routes(&codec->dapm, audio_map, ARRAY_SIZE(audio_map));
+
+	snd_soc_dapm_sync(&codec->dapm);
+
+	return 0;
+}
+
 /* imx digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link imx_spdif_dai_link = {
 	.name = "IMX SPDIF",
@@ -41,6 +70,7 @@
 	.codec_name = "mxc_spdif.0",
 	.cpu_dai_name = "imx-spdif-dai.0",
 	.platform_name = "imx-pcm-audio.2", /* imx-pcm-dma-mx2 */
+	.init = imx_3stack_spdif_init
 };
 
 static struct snd_soc_card snd_soc_card_imx_spdif = {

--------------070101010009010305090103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070101010009010305090103--
