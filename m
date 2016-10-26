From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Codec to codec dai link description" to
	the asoc tree
Date: Wed, 26 Oct 2016 11:46:16 +0100
Message-ID: <E1bzLiq-0005QH-CP@debutante>
References: <CABCoZhB6F9J0677swtrHdp=Yg_v6b=C9Ph5KhWqaDN=3UjwqkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BB95B266875
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 12:46:25 +0200 (CEST)
In-Reply-To: <CABCoZhB6F9J0677swtrHdp=Yg_v6b=C9Ph5KhWqaDN=3UjwqkA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "broonie@kernel.org" <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Codec to codec dai link description

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

>From 452a256898e7ca88115aa02d3851e67994ce3e19 Mon Sep 17 00:00:00 2001
From: anish kumar <yesanishhere@gmail.com>
Date: Sun, 23 Oct 2016 21:03:53 -0700
Subject: [PATCH] ASoC: Codec to codec dai link description

Signed-off-by: anish kumar <yesanishhere@gmail.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/sound/alsa/soc/codec_to_codec.txt | 103 ++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/sound/alsa/soc/codec_to_codec.txt

diff --git a/Documentation/sound/alsa/soc/codec_to_codec.txt b/Documentation/sound/alsa/soc/codec_to_codec.txt
new file mode 100644
index 000000000000..704a6483652c
--- /dev/null
+++ b/Documentation/sound/alsa/soc/codec_to_codec.txt
@@ -0,0 +1,103 @@
+Creating codec to codec dai link for ALSA dapm
+===================================================
+
+Mostly the flow of audio is always from CPU to codec so your system
+will look as below:
+
+ ---------          ---------
+|         |  dai   |         |
+    CPU    ------->    codec
+|         |        |         |
+ ---------          ---------
+
+In case your system looks as below:
+                     ---------
+                    |         |
+                      codec-2
+                    |         |
+                     ---------
+                         |
+                       dai-2
+                         |
+ ----------          ---------
+|          |  dai-1 |         |
+    CPU     ------->  codec-1
+|          |        |         |
+ ----------          ---------
+                         |
+                       dai-3
+                         |
+                     ---------
+                    |         |
+                      codec-3
+                    |         |
+                     ---------
+
+Suppose codec-2 is a bluetooth chip and codec-3 is connected to
+a speaker and you have a below scenario:
+codec-2 will receive the audio data and the user wants to play that
+audio through codec-3 without involving the CPU.This
+aforementioned case is the ideal case when codec to codec
+connection should be used.
+
+Your dai_link should appear as below in your machine
+file:
+
+/*
+ * this pcm stream only supports 24 bit, 2 channel and
+ * 48k sampling rate.
+ */
+static const struct snd_soc_pcm_stream dsp_codec_params = {
+        .formats = SNDRV_PCM_FMTBIT_S24_LE,
+        .rate_min = 48000,
+        .rate_max = 48000,
+        .channels_min = 2,
+        .channels_max = 2,
+};
+
+{
+    .name = "CPU-DSP",
+    .stream_name = "CPU-DSP",
+    .cpu_dai_name = "samsung-i2s.0",
+    .codec_name = "codec-2,
+    .codec_dai_name = "codec-2-dai_name",
+    .platform_name = "samsung-i2s.0",
+    .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+            | SND_SOC_DAIFMT_CBM_CFM,
+    .ignore_suspend = 1,
+    .params = &dsp_codec_params,
+},
+{
+    .name = "DSP-CODEC",
+    .stream_name = "DSP-CODEC",
+    .cpu_dai_name = "wm0010-sdi2",
+    .codec_name = "codec-3,
+    .codec_dai_name = "codec-3-dai_name",
+    .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+            | SND_SOC_DAIFMT_CBM_CFM,
+    .ignore_suspend = 1,
+    .params = &dsp_codec_params,
+},
+
+Above code snippet is motivated from sound/soc/samsung/speyside.c.
+
+Note the "params" callback which lets the dapm know that this
+dai_link is a codec to codec connection.
+
+In dapm core a route is created between cpu_dai playback widget
+and codec_dai capture widget for playback path and vice-versa is
+true for capture path. In order for this aforementioned route to get
+triggered, DAPM needs to find a valid endpoint which could be either
+a sink or source widget corresponding to playback and capture path
+respectively.
+
+In order to trigger this dai_link widget, a thin codec driver for
+the speaker amp can be created as demonstrated in wm8727.c file, it
+sets appropriate constraints for the device even if it needs no control.
+
+Make sure to name your corresponding cpu and codec playback and capture
+dai names ending with "Playback" and "Capture" respectively as dapm core
+will link and power those dais based on the name.
+
+Note that in current device tree there is no way to mark a dai_link
+as codec to codec. However, it may change in future.
-- 
2.8.1
