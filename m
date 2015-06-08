From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 6/9] ASoC: tas2552: Call pm_runtime_disable
	when the module is removed
Date: Mon, 8 Jun 2015 15:19:53 +0300
Message-ID: <1433765996-28930-7-git-send-email-peter.ujfalusi@ti.com>
References: <1433765996-28930-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B1BA260429
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 14:20:13 +0200 (CEST)
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

The module can not be loaded again after it has been removed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tas2552.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 5e6490c19b7e..7e65294f5244 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -751,6 +751,7 @@ static int tas2552_probe(struct i2c_client *client,
 static int tas2552_i2c_remove(struct i2c_client *client)
 {
 	snd_soc_unregister_codec(&client->dev);
+	pm_runtime_disable(&client->dev);
 	return 0;
 }
 
-- 
2.4.2
