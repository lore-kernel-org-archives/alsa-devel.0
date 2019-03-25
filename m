From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: [v2] ASoC: AMD: Configure wclk and bclk of master codec
Date: Mon, 25 Mar 2019 06:38:27 +0000
Message-ID: <20190325063759.28300-1-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Cc: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Adam.Thomson.Opensource@diasemi.com" <Adam.Thomson.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Wei Yongjun <weiyongjun1@huawei.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

With CCF support in da7219, we can now set the correct rate of
wclk and bclk.
Setting bclk at lower rate at 1.53Mhz from its earlier default
rate of 3Mhz, also fixes noise issue observed on some dmics.

v2: Removed clk set rate and enable/disable from da7219 ops as
da7219 codec takes care of them internally. Clock configuration
kept for those codecs where da7219 acts as master of clock.
As suggested by Adam Thomson.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 45 +++++++++++++++++-----------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da721=
9-max98357a.c
index 8e2ce369a295..7737c6dc026a 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -46,7 +46,8 @@
 #define DUAL_CHANNEL		2
=20
 static struct snd_soc_jack cz_jack;
-static struct clk *da7219_dai_clk;
+static struct clk *da7219_dai_wclk;
+static struct clk *da7219_dai_bclk;
 extern int bt_uart_enable;
=20
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
@@ -72,7 +73,8 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd=
)
 		return ret;
 	}
=20
-	da7219_dai_clk =3D clk_get(component->dev, "da7219-dai-bclk");
+	da7219_dai_wclk =3D clk_get(component->dev, "da7219-dai-wclk");
+	da7219_dai_bclk =3D clk_get(component->dev, "da7219-dai-bclk");
=20
 	ret =3D snd_soc_card_jack_new(card, "Headset Jack",
 				SND_JACK_HEADSET | SND_JACK_LINEOUT |
@@ -94,12 +96,15 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *r=
td)
 	return 0;
 }
=20
-static int da7219_clk_enable(struct snd_pcm_substream *substream)
+static int da7219_clk_enable(struct snd_pcm_substream *substream,
+			     int wclk_rate, int bclk_rate)
 {
 	int ret =3D 0;
 	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
=20
-	ret =3D clk_prepare_enable(da7219_dai_clk);
+	clk_set_rate(da7219_dai_wclk, wclk_rate);
+	clk_set_rate(da7219_dai_bclk, bclk_rate);
+	ret =3D clk_prepare_enable(da7219_dai_bclk);
 	if (ret < 0) {
 		dev_err(rtd->dev, "can't enable master clock %d\n", ret);
 		return ret;
@@ -110,7 +115,7 @@ static int da7219_clk_enable(struct snd_pcm_substream *=
substream)
=20
 static void da7219_clk_disable(void)
 {
-	clk_disable_unprepare(da7219_dai_clk);
+	clk_disable_unprepare(da7219_dai_bclk);
 }
=20
 static const unsigned int channels[] =3D {
@@ -151,7 +156,7 @@ static int cz_da7219_play_startup(struct snd_pcm_substr=
eam *substream)
 				   &constraints_rates);
=20
 	machine->play_i2s_instance =3D I2S_SP_INSTANCE;
-	return da7219_clk_enable(substream);
+	return 0;
 }
=20
 static int cz_da7219_cap_startup(struct snd_pcm_substream *substream)
@@ -173,12 +178,7 @@ static int cz_da7219_cap_startup(struct snd_pcm_substr=
eam *substream)
=20
 	machine->cap_i2s_instance =3D I2S_SP_INSTANCE;
 	machine->capture_channel =3D CAP_CHANNEL1;
-	return da7219_clk_enable(substream);
-}
-
-static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
-{
-	da7219_clk_disable();
+	return 0;
 }
=20
 static int cz_max_startup(struct snd_pcm_substream *substream)
@@ -199,7 +199,7 @@ static int cz_max_startup(struct snd_pcm_substream *sub=
stream)
 				   &constraints_rates);
=20
 	machine->play_i2s_instance =3D I2S_BT_INSTANCE;
-	return da7219_clk_enable(substream);
+	return 0;
 }
=20
 static void cz_max_shutdown(struct snd_pcm_substream *substream)
@@ -225,7 +225,7 @@ static int cz_dmic0_startup(struct snd_pcm_substream *s=
ubstream)
 				   &constraints_rates);
=20
 	machine->cap_i2s_instance =3D I2S_BT_INSTANCE;
-	return da7219_clk_enable(substream);
+	return 0;
 }
=20
 static int cz_dmic1_startup(struct snd_pcm_substream *substream)
@@ -247,7 +247,7 @@ static int cz_dmic1_startup(struct snd_pcm_substream *s=
ubstream)
=20
 	machine->cap_i2s_instance =3D I2S_SP_INSTANCE;
 	machine->capture_channel =3D CAP_CHANNEL0;
-	return da7219_clk_enable(substream);
+	return 0;
 }
=20
 static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
@@ -255,29 +255,40 @@ static void cz_dmic_shutdown(struct snd_pcm_substream=
 *substream)
 	da7219_clk_disable();
 }
=20
+static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
+				      struct snd_pcm_hw_params *params)
+{
+	int wclk, bclk;
+
+	wclk =3D params_rate(params);
+	bclk =3D wclk * params_channels(params) *
+		snd_pcm_format_width(params_format(params));
+	return da7219_clk_enable(substream, wclk, bclk);
+}
 static const struct snd_soc_ops cz_da7219_play_ops =3D {
 	.startup =3D cz_da7219_play_startup,
-	.shutdown =3D cz_da7219_shutdown,
 };
=20
 static const struct snd_soc_ops cz_da7219_cap_ops =3D {
 	.startup =3D cz_da7219_cap_startup,
-	.shutdown =3D cz_da7219_shutdown,
 };
=20
 static const struct snd_soc_ops cz_max_play_ops =3D {
 	.startup =3D cz_max_startup,
 	.shutdown =3D cz_max_shutdown,
+	.hw_params =3D cz_da7219_hw_params,
 };
=20
 static const struct snd_soc_ops cz_dmic0_cap_ops =3D {
 	.startup =3D cz_dmic0_startup,
 	.shutdown =3D cz_dmic_shutdown,
+	.hw_params =3D cz_da7219_hw_params,
 };
=20
 static const struct snd_soc_ops cz_dmic1_cap_ops =3D {
 	.startup =3D cz_dmic1_startup,
 	.shutdown =3D cz_dmic_shutdown,
+	.hw_params =3D cz_da7219_hw_params,
 };
=20
 static struct snd_soc_dai_link cz_dai_7219_98357[] =3D {
--=20
2.17.1
