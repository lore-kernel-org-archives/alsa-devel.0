From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] ASoC: Fix check for symmetric rate enforcement
Date: Wed, 17 Aug 2011 08:27:53 +0200
Message-ID: <20110817062753.GB31404@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id AD7F51038A5
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Aug 2011 08:27:54 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Lambrecht =?iso-8859-15?Q?J=FCrgen?= <J.Lambrecht@TELEVIC.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


The ASoC core tries to not enforce symmetric rates when
two streams open simultaneously. It does so by checking
rtd->rate being zero. This works exactly once after booting
because it is not set to zero again when the streams close.
Fix this by clearing rtd->rate when no active stream is left.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/soc-core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d75043e..c25649a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -746,6 +746,9 @@ static int soc_codec_close(struct snd_pcm_substream *substream)
 	codec_dai->active--;
 	codec->active--;
 
+	if (!cpu_dai->active && !codec_dai->active)
+		rtd->rate = 0;
+
 	/* Muting the DAC suppresses artifacts caused during digital
 	 * shutdown, for example from stopping clocks.
 	 */
-- 
1.7.5.4

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
