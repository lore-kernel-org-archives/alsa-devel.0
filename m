From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: UDA134X Codec: Fix mute/unmute code
 mistake and add ADC/DAC power control support
Date: Mon, 17 Aug 2009 12:27:57 +0100
Message-ID: <20090817112756.GA19898@rakim.wolfsonmicro.main>
References: <1250498216.2764.1.camel@shinel>
	<20090817103248.GA4464@sirena.org.uk>
	<1250508154.1932.37.camel@shinel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 574C11037F7
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 13:27:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1250508154.1932.37.camel@shinel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shine Liu <shinel@foxmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 17, 2009 at 07:22:34PM +0800, Shine Liu wrote:

> When I play a wav file using aplay, I found there's no sound. After some
> debug work, I noticed that the DAC power control bit keeps zero since
> the system started up.

Please try the patch below.

commit 6294523841a61cd1ad24f220daf6e73e9cc83184
Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date:   Mon Aug 17 11:55:38 2009 +0100

    ASoC: Fix handling of bias levels for non-DAPM codecs
    
    If the system doesn't have any DAPM widgets then we can't use their
    state to check if the bias level for the codec should be up.
    
    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c68c204..4a21a5e 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -966,6 +966,22 @@ static int dapm_power_widgets(struct snd_soc_codec *codec, int event)
 		}
 	}
 
+	/* If there are no DAPM widgets then try to figure out power from the
+	 * event type.
+	 */
+	if (list_empty(&codec->dapm_widgets)) {
+		switch (event) {
+		case SND_SOC_DAPM_STREAM_START:
+		case SND_SOC_DAPM_STREAM_RESUME:
+			sys_power = 1;
+			break;
+		case SND_SOC_DAPM_STREAM_NOP:
+			sys_power == codec->bias_level != SND_SOC_BIAS_STANDBY;
+		default:
+			break;
+		}
+	}
+
 	/* If we're changing to all on or all off then prepare */
 	if ((sys_power && codec->bias_level == SND_SOC_BIAS_STANDBY) ||
 	    (!sys_power && codec->bias_level == SND_SOC_BIAS_ON)) {
