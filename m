From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ASoC: pxa-ssp: allow setting of dai format 0
Date: Wed, 15 Apr 2009 20:24:45 +0200
Message-ID: <1239819885-25964-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D7A3A1037F8
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 20:25:03 +0200 (CEST)
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
Cc: pHilipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

pxa_ssp_set_dai_fmt() currently has an early exit if the desired format
equals the current configuration. This is correct behaviour unless this
function is called with a zero value parameter for the first time.
Zero is a valid value for this function, but the early exit is bogus in
this case.

Hence, set priv->dai_fmt to -1 in the beginning so we can configure the
port.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Mark Brown <broonie@sirena.org.uk>
Cc: pHilipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/pxa/pxa-ssp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 308a657..de22544 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -806,6 +806,7 @@ static int pxa_ssp_probe(struct platform_device *pdev,
 		goto err_priv;
 	}
 
+	priv->dai_fmt = (unsigned int) -1;
 	dai->private_data = priv;
 
 	return 0;
-- 
1.6.2.1
