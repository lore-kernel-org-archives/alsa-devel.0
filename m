From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: ASoC: fix PXA SSP port resume
Date: Thu, 28 Jan 2010 18:34:18 +0800
Message-ID: <1264674858-27461-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A9AE103827
	for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2010 08:06:55 +0100 (CET)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Invalidate the cached hardware format on resume for PXA SSP ports.
Otherwise hw_params() will bail out early at the next stream start,
leaving the registers in a bogus state.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Philipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/pxa/pxa-ssp.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 3bd7712..ebde673 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -146,6 +146,9 @@ static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
 {
 	struct ssp_priv *priv = cpu_dai->private_data;
 
+	/* the cached format information is invalid now */
+	priv->dai_fmt = (unsigned int) -1;
+
 	if (!cpu_dai->active)
 		return 0;
 
-- 
1.6.3.3
