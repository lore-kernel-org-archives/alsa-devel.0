From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] ASoC: wm8962: Fit error message into a
	single line
Date: Mon, 28 Mar 2016 08:31:19 -0300
Message-ID: <1459164679-17961-2-git-send-email-festevam@gmail.com>
References: <1459164679-17961-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f44.google.com (mail-qg0-f44.google.com
 [209.85.192.44])
 by alsa0.perex.cz (Postfix) with ESMTP id D767726655F
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2016 13:31:45 +0200 (CEST)
Received: by mail-qg0-f44.google.com with SMTP id j35so106047663qge.0
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2016 04:31:45 -0700 (PDT)
In-Reply-To: <1459164679-17961-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, ckeepax@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The error message fits well into a single line.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/codecs/wm8962.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index f3f71ba..93f75dc 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3798,8 +3798,7 @@ static int wm8962_runtime_resume(struct device *dev)
 	ret = regulator_bulk_enable(ARRAY_SIZE(wm8962->supplies),
 				    wm8962->supplies);
 	if (ret != 0) {
-		dev_err(dev,
-			"Failed to enable supplies: %d\n", ret);
+		dev_err(dev, "Failed to enable supplies: %d\n", ret);
 		goto disable_clock;
 	}
 
-- 
1.9.1
