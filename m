From: anish kumar <yesanishhere@gmail.com>
Subject: [PATCH] Codec to codec dai link description
Date: Wed, 19 Oct 2016 23:00:37 -0700
Message-ID: <CABCoZhDiBxGHbZopLqkkMALozAt9eO2ANNT9puRy12Ez_oZstQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f68.google.com (mail-vk0-f68.google.com
 [209.85.213.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 25BB1267018
 for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2016 08:00:38 +0200 (CEST)
Received: by mail-vk0-f68.google.com with SMTP id 2so2334094vkb.1
 for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2016 23:00:38 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, "broonie@kernel.org" <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 Documentation/sound/alsa/soc/codec_to_codec.txt | 114 ++++++++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/sound/alsa/soc/codec_to_codec.txt

diff --git a/Documentation/sound/alsa/soc/codec_to_codec.txt
b/Documentation/sound/alsa/soc/codec_to_codec.txt
new file mode 100644
index 0000000..b0f221d
--- /dev/null
+++ b/Documentation/sound/alsa/soc/codec_to_codec.txt
@@ -0,0 +1,114 @@
+Creating codec to codec dai link for ALSA dapm
+===================================================
+
+Mostly the flow of audio is always from CPU to codec so your system
+will look as below:
+
+ ----------         ---------
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
+static const struct snd_soc_pcm_stream dummy_params = {
+        .formats = SNDRV_PCM_FMTBIT_S24_LE,
+        .rate_min = 48000,
+        .rate_max = 48000,
+        .channels_min = 2,
+        .channels_max = 2,
+};
+
+{
+    .name = "your_name",
+    .stream_name = "your_stream_name",
+    .cpu_dai_name = "snd-soc-dummy-dai",
+    .codec_name = "codec-2,
+    .codec_dai_name = "codec-2-dai_name",
+    .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+                    | SND_SOC_DAIFMT_CBM_CFM,
+    .ignore_suspend = 1,
+    .params = &dummy_params,
+},
+{
+    .name = "your_name",
+    .stream_name = "your_stream_name",
+    .cpu_dai_name = "snd-soc-dummy-dai",
+    .codec_name = "codec-3,
+    .codec_dai_name = "codec-3-dai_name",
+    .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+                    | SND_SOC_DAIFMT_CBM_CFM,
+    .ignore_suspend = 1,
+    .params = &dummy_params,
+},
+
+Note the "params" callback which lets the dapm know that this
+dai_link is a codec to codec connection.
+Also, in above code cpu_dai should be replaced with your actual
+cpu dai but in case you don't have a actual cpu dai then dummy will
+do.
+
+You can browse the speyside.c for an actual example code in mainline.
+
+Note that in current device tree there is no way to mark a dai_link
+as codec to codec. However, it may change in future.
+
+In dapm core a route is created between cpu_dai playback widget
+and codec_dai capture widget for playback path and vice-versa is
+true for capture path. In order for this aforementioned route to get
+triggered, DAPM needs to find a valid endpoint which could be either
+a sink or source widget corresponding to playback and capture path
+respectively.
+
+Below is what you can use it to trigger the widgets provided you have
+stream name ending with "Playback" and "Capture" for cpu and
+codec dai's.
+
+static const struct snd_soc_dapm_widget aif_dapm_widgets[] = {
+        SND_SOC_DAPM_SPK("dummyspk", NULL),
+        SND_SOC_DAPM_MIC("dummymic", NULL),
+};
+
+static const struct snd_soc_dapm_route audio_i2s_map[] = {
+        {"dummyspk", NULL, "Playback"},
+        {"Capture", NULL, "dummymic"},
+};
+
+Above code is good for quick testing but in order to mainline it
+you are expected to create a thin codec driver for the speaker
+amp rather than doing this sort of thing, as that at least
+sets appropriate constraints for the device even if it needs
+no control. For an example of such a driver you can see:
+sound/soc/codecs/wm8727.c
-- 
2.8.4 (Apple Git-73)
