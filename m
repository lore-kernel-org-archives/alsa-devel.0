From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 2/2] ASoC: sdp4430: Request core to inline the
	DAPM sequence
Date: Thu, 13 Oct 2011 16:23:35 +0300
Message-ID: <1318512215-2331-3-git-send-email-peter.ujfalusi@ti.com>
References: <1318512215-2331-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog126.obsmtp.com (na3sys009aog126.obsmtp.com
	[74.125.149.155])
	by alsa0.perex.cz (Postfix) with ESMTP id DA5AB103854
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 15:30:00 +0200 (CEST)
Received: by mail-bw0-f43.google.com with SMTP id s6so1692152bka.30
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2011 06:29:51 -0700 (PDT)
In-Reply-To: <1318512215-2331-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

We need to have as less time between OMAP McPDM shutdown,
and power down of the DAC on the twl6040 codec as possible.
Request core to ignore the pmdown_time for the playback
stream.
Backround: with the McPDM protocol we are sendning not only
the pure audio stream, but OMAP McPDM also transmits
additional information (for example offset cancellation).
If McPDM is stopped prior to the DAC this information will
be not sent to the codec, which can result noise rendered
by the twl6040 codec.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/sdp4430.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index cc3d792..e2f93e8 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -155,6 +155,7 @@ static struct snd_soc_dai_link sdp4430_dai = {
 	.codec_dai_name = "twl6040-legacy",
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "twl6040-codec",
+	.ignore_pmdown_time = 1,
 	.init = sdp4430_twl6040_init,
 	.ops = &sdp4430_ops,
 };
-- 
1.7.7
