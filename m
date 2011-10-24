From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: wm8996: Avoid a redundant
 i2c_get_clientdata call in wm8996_i2c_remove
Date: Mon, 24 Oct 2011 11:31:12 +0800
Message-ID: <1319427072.5773.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BAB37244AC
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Oct 2011 05:31:23 +0200 (CEST)
Received: by gyg8 with SMTP id 8so5655341gyg.38
	for <alsa-devel@alsa-project.org>; Sun, 23 Oct 2011 20:31:22 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8996.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 645c980..32324c9 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -3144,7 +3144,7 @@ static __devexit int wm8996_i2c_remove(struct i2c_client *client)
 	snd_soc_unregister_codec(&client->dev);
 	if (wm8996->pdata.ldo_ena > 0)
 		gpio_free(wm8996->pdata.ldo_ena);
-	kfree(i2c_get_clientdata(client));
+	kfree(wm8996);
 	return 0;
 }
 
-- 
1.7.5.4
