From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/2] ASoC: mxs-sgtl5000: Configure the
	dai_links as unidirectional
Date: Thu, 29 Aug 2013 10:32:14 -0300
Message-ID: <1377783134-23528-2-git-send-email-fabio.estevam@freescale.com>
References: <1377783134-23528-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E24D2654F6
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 15:32:37 +0200 (CEST)
In-Reply-To: <1377783134-23528-1-git-send-email-fabio.estevam@freescale.com>
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
 sound/soc/mxs/mxs-sgtl5000.c | 2 ++
 1 file changed, 2 insertions(+)

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
 
-- 
1.8.1.2
