From: Fabio Estevam <festevam@gmail.com>
Subject: [RFC] ASoC: soc-pcm: Add support for unidirectional
	dai links
Date: Thu, 29 Aug 2013 01:54:59 -0300
Message-ID: <1377752099-21373-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f170.google.com (mail-gh0-f170.google.com
 [209.85.160.170])
 by alsa0.perex.cz (Postfix) with ESMTP id C4A082615FA
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 06:55:14 +0200 (CEST)
Received: by mail-gh0-f170.google.com with SMTP id z10so1840497ghb.1
 for <alsa-devel@alsa-project.org>; Wed, 28 Aug 2013 21:55:14 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

On a mx28 board, running "aplay -l" and "arecord -l" results in the following:

$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: mxssgtl5000 [mxs_sgtl5000], device 0: Playback sgtl5000-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: mxssgtl5000 [mxs_sgtl5000], device 1: Capture sgtl5000-1 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

$ arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: mxssgtl5000 [mxs_sgtl5000], device 0: Playback sgtl5000-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: mxssgtl5000 [mxs_sgtl5000], device 1: Capture sgtl5000-1 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

,which is not correct because we got a capture device listed in aplay and a 
playback device listed in arecord.

On mx28 there are two serial audio interface ports (SAIF0 and SAIF1) and each
one of them are unidirectional.

Allow to specify a dai link as 'playback_only' or 'capture_only', which suits
well for this case.

After this change we can correctly report the capabilities as follows:

$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: mxssgtl5000 [mxs_sgtl5000], device 0: HiFi Playback sgtl5000-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

$ arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: mxssgtl5000 [mxs_sgtl5000], device 1: HiFi Capture sgtl5000-1 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

Also tested playback and capture on the mx28evk board.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---

After I get some feedback, I can split the patch in two parts (one for soc-pcm
and another one for mxs-sgtl5000).

 include/sound/soc.h          |  4 ++++
 sound/soc/mxs/mxs-sgtl5000.c |  2 ++
 sound/soc/soc-pcm.c          | 10 ++++++++++
 3 files changed, 16 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8e2ad52..774d3be 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -934,6 +934,10 @@ struct snd_soc_dai_link {
 	/* machine stream operations */
 	const struct snd_soc_ops *ops;
 	const struct snd_soc_compr_ops *compr_ops;
+
+	/* For unidirectional dai links */
+	bool playback_only;
+	bool capture_only;
 };
 
 struct snd_soc_codec_conf {
diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index ce084eb..4bb2737 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -105,11 +105,13 @@ static struct snd_soc_dai_link mxs_sgtl5000_dai[] = {
 		.stream_name	= "HiFi Playback",
 		.codec_dai_name	= "sgtl5000",
 		.ops		= &mxs_sgtl5000_hifi_ops,
+		.playback_only	= true,
 	}, {
 		.name		= "HiFi Rx",
 		.stream_name	= "HiFi Capture",
 		.codec_dai_name	= "sgtl5000",
 		.ops		= &mxs_sgtl5000_hifi_ops,
+		.capture_only	= true,
 	},
 };
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index fb70fbe..5e44863 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2020,6 +2020,16 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 			capture = 1;
 	}
 
+	if (rtd->dai_link->playback_only) {
+		playback = 1;
+		capture = 0;
+	}
+
+	if (rtd->dai_link->capture_only) {
+		playback = 0;
+		capture = 1;
+	}
+
 	/* create the PCM */
 	if (rtd->dai_link->no_pcm) {
 		snprintf(new_name, sizeof(new_name), "(%s)",
-- 
1.8.1.2
