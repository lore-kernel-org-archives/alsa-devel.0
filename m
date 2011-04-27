From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/5] ASoC: Don't specify the DMA driver for
	Speyside baseband link
Date: Wed, 27 Apr 2011 18:27:35 +0100
Message-ID: <1303925257-26920-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1303925257-26920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D67A024395
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 19:29:43 +0200 (CEST)
In-Reply-To: <1303925257-26920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Jassi Brar <jassisinghbrar@gmail.com>, Lars-Peter Clausen <lars@m>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/speyside.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 337855a..360a333 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -183,7 +183,6 @@ static struct snd_soc_dai_link speyside_dai[] = {
 		.cpu_dai_name = "wm8915-aif2",
 		.codec_dai_name = "wm1250-ev1",
 		.codec_name = "wm1250-ev1.1-0027",
-		.platform_name = "samsung-audio",
 		.ops = &speyside_ops,
 		.ignore_suspend = 1,
 	},
-- 
1.7.4.1
