From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: doc: ReSTize codec_to_codec.txt
Date: Fri, 11 Nov 2016 17:11:06 +0100
Message-ID: <20161111161106.4286-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9228126741B
 for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2016 17:11:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Yet another simple conversion from a plain text file.
Renamed to codec-to-codec.rst to align with others.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Mark, this is the rest one in your branch, which I pulled now.
It's already in topic/restize-docs branch, so I can merge to for-next
as is if it's OK.

 .../codec_to_codec.txt => soc/codec-to-codec.rst}  | 79 ++++++++++++----------
 Documentation/sound/soc/index.rst                  |  1 +
 2 files changed, 43 insertions(+), 37 deletions(-)
 rename Documentation/sound/{alsa/soc/codec_to_codec.txt => soc/codec-to-codec.rst} (68%)

diff --git a/Documentation/sound/alsa/soc/codec_to_codec.txt b/Documentation/sound/soc/codec-to-codec.rst
similarity index 68%
rename from Documentation/sound/alsa/soc/codec_to_codec.txt
rename to Documentation/sound/soc/codec-to-codec.rst
index 704a6483652c..810109d7500d 100644
--- a/Documentation/sound/alsa/soc/codec_to_codec.txt
+++ b/Documentation/sound/soc/codec-to-codec.rst
@@ -1,37 +1,41 @@
+==============================================
 Creating codec to codec dai link for ALSA dapm
-===================================================
+==============================================
 
 Mostly the flow of audio is always from CPU to codec so your system
 will look as below:
+::
 
- ---------          ---------
-|         |  dai   |         |
-    CPU    ------->    codec
-|         |        |         |
- ---------          ---------
+   ---------          ---------
+  |         |  dai   |         |
+      CPU    ------->    codec
+  |         |        |         |
+   ---------          ---------
 
 In case your system looks as below:
-                     ---------
-                    |         |
-                      codec-2
-                    |         |
-                     ---------
-                         |
-                       dai-2
-                         |
- ----------          ---------
-|          |  dai-1 |         |
-    CPU     ------->  codec-1
-|          |        |         |
- ----------          ---------
-                         |
-                       dai-3
-                         |
-                     ---------
-                    |         |
-                      codec-3
-                    |         |
-                     ---------
+::
+
+                       ---------
+                      |         |
+                        codec-2
+                      |         |
+                      ---------
+                           |
+                         dai-2
+                           |
+   ----------          ---------
+  |          |  dai-1 |         |
+      CPU     ------->  codec-1
+  |          |        |         |
+   ----------          ---------
+                           |
+                         dai-3
+                           |
+                       ---------
+                      |         |
+                        codec-3
+                      |         |
+                       ---------
 
 Suppose codec-2 is a bluetooth chip and codec-3 is connected to
 a speaker and you have a below scenario:
@@ -42,20 +46,21 @@ connection should be used.
 
 Your dai_link should appear as below in your machine
 file:
+::
 
-/*
- * this pcm stream only supports 24 bit, 2 channel and
- * 48k sampling rate.
- */
-static const struct snd_soc_pcm_stream dsp_codec_params = {
+ /*
+  * this pcm stream only supports 24 bit, 2 channel and
+  * 48k sampling rate.
+  */
+ static const struct snd_soc_pcm_stream dsp_codec_params = {
         .formats = SNDRV_PCM_FMTBIT_S24_LE,
         .rate_min = 48000,
         .rate_max = 48000,
         .channels_min = 2,
         .channels_max = 2,
-};
+ };
 
-{
+ {
     .name = "CPU-DSP",
     .stream_name = "CPU-DSP",
     .cpu_dai_name = "samsung-i2s.0",
@@ -66,8 +71,8 @@ static const struct snd_soc_pcm_stream dsp_codec_params = {
             | SND_SOC_DAIFMT_CBM_CFM,
     .ignore_suspend = 1,
     .params = &dsp_codec_params,
-},
-{
+ },
+ {
     .name = "DSP-CODEC",
     .stream_name = "DSP-CODEC",
     .cpu_dai_name = "wm0010-sdi2",
@@ -77,7 +82,7 @@ static const struct snd_soc_pcm_stream dsp_codec_params = {
             | SND_SOC_DAIFMT_CBM_CFM,
     .ignore_suspend = 1,
     .params = &dsp_codec_params,
-},
+ },
 
 Above code snippet is motivated from sound/soc/samsung/speyside.c.
 
diff --git a/Documentation/sound/soc/index.rst b/Documentation/sound/soc/index.rst
index e142a0f25c5b..e57df2dab2fd 100644
--- a/Documentation/sound/soc/index.rst
+++ b/Documentation/sound/soc/index.rst
@@ -17,3 +17,4 @@ The documentation is spilt into the following sections:-
    clocking
    jack
    dpcm
+   codec-to-codec
-- 
2.10.2
