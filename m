From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/5] ASoC: ak4104: Remove uninformative print
	on probe()
Date: Fri, 17 Feb 2012 12:23:08 -0800
Message-ID: <1329510192-4442-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20120217202240.GA2784@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 53BF2103FDE
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 21:23:19 +0100 (CET)
In-Reply-To: <20120217202240.GA2784@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/ak4104.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index d27b5e4..6f93892 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -224,7 +224,6 @@ static int ak4104_probe(struct snd_soc_codec *codec)
 	if (ret < 0)
 		return ret;
 
-	dev_info(codec->dev, "SPI device initialized\n");
 	return 0;
 }
 
-- 
1.7.9
