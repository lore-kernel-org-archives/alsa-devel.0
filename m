From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 2/2] ASoC: twl6040: Request core to inline
	the DAPM sequence
Date: Fri, 14 Oct 2011 14:43:34 +0300
Message-ID: <1318592614-13110-3-git-send-email-peter.ujfalusi@ti.com>
References: <1318592614-13110-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76])
	by alsa0.perex.cz (Postfix) with ESMTP id AB05C103890
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 13:43:40 +0200 (CEST)
Received: by yxk38 with SMTP id 38so928266yxk.4
	for <alsa-devel@alsa-project.org>; Fri, 14 Oct 2011 04:43:38 -0700 (PDT)
In-Reply-To: <1318592614-13110-1-git-send-email-peter.ujfalusi@ti.com>
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

We need to have as less time between McPDM shutdown,
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
 sound/soc/codecs/twl6040.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 6c573c3..73e11f0 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1504,6 +1504,7 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 
 	priv->codec = codec;
 	codec->control_data = dev_get_drvdata(codec->dev->parent);
+	codec->ignore_pmdown_time = 1;
 
 	if (pdata && pdata->hs_left_step && pdata->hs_right_step) {
 		priv->hs_left_step = pdata->hs_left_step;
-- 
1.7.7
