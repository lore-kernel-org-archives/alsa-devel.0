From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Relax restrictions on WM8962 BCLK
	configuration
Date: Thu, 30 Sep 2010 14:26:40 -0700
Message-ID: <1285882000-17669-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C29C8103978
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 01:52:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The restrictions on configuring BCLK are overly cautious, other constraints
in the system should ensure that reconfiguration is not possible when the
device is sufficiently active to be unable to support reclocking.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index be34146..38cbf85 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -911,12 +911,6 @@ static void wm8962_configure_bclk(struct snd_soc_codec *codec)
 	int clocking2 = 0;
 	int aif2 = 0;
 
-	/* If the CODEC is powered on we can configure BCLK */
-	if (codec->bias_level != SND_SOC_BIAS_OFF) {
-		dev_dbg(codec->dev, "Bias is off, can't configure BCLK\n");
-		return;
-	}
-
 	if (!wm8962->bclk) {
 		dev_dbg(codec->dev, "No BCLK rate configured\n");
 		return;
-- 
1.7.1
