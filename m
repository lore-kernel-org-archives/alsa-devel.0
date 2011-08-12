From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: [PATCH v2 3/5] ASoC: ad193x: fix system clock
Date: Fri, 12 Aug 2011 18:04:12 -0400
Message-ID: <1313186654-22520-3-git-send-email-scott.jiang.linux@gmail.com>
References: <1313186654-22520-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D5CD1039B9
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 10:58:02 +0200 (CEST)
In-Reply-To: <1313186654-22520-1-git-send-email-scott.jiang.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Scott Jiang <scott.jiang.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

system clock is 24.576MHz instead of 12.288MHz

Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>
---
 sound/soc/blackfin/bf5xx-ad193x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ad193x.c b/sound/soc/blackfin/bf5xx-ad193x.c
index d6651c0..a118a0f 100644
--- a/sound/soc/blackfin/bf5xx-ad193x.c
+++ b/sound/soc/blackfin/bf5xx-ad193x.c
@@ -56,7 +56,7 @@ static int bf5xx_ad193x_hw_params(struct snd_pcm_substream *substream,
 
 	switch (params_rate(params)) {
 	case 48000:
-		clk = 12288000;
+		clk = 24576000;
 		break;
 	}
 
-- 
1.7.0.4
