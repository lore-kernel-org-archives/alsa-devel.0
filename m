From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 7/9] ASoC: tas2552: Remove unneeded semicolon
Date: Mon, 8 Jun 2015 15:19:54 +0300
Message-ID: <1433765996-28930-8-git-send-email-peter.ujfalusi@ti.com>
References: <1433765996-28930-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 90D4E260415
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 14:20:16 +0200 (CEST)
In-Reply-To: <1433765996-28930-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Double semicolon was added by the following commit:
ea178d1456dc ASoC: tas2552: Make the enable-gpio really optional

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 7e65294f5244..534b57bff03d 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -708,7 +708,7 @@ static int tas2552_probe(struct i2c_client *client,
 		if (PTR_ERR(data->enable_gpio) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 
-		data->enable_gpio = NULL;;
+		data->enable_gpio = NULL;
 	}
 
 	data->tas2552_client = client;
-- 
2.4.2
