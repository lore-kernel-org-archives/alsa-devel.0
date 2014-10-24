From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/3] ASoC: sgtl5000: Use the preferred form for
	passing a size of a struct
Date: Fri, 24 Oct 2014 13:01:25 -0200
Message-ID: <1414162887-14279-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f41.google.com (mail-yh0-f41.google.com
 [209.85.213.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 916C82604AA
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 17:03:09 +0200 (CEST)
Received: by mail-yh0-f41.google.com with SMTP id i57so863008yha.14
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 08:03:08 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

According to Documentation/CodingStyle - Chapter 14:

"The preferred form for passing a size of a struct is the following:

	p = kmalloc(sizeof(*p), ...); 

The alternative form where struct name is spelled out hurts readability and
introduces an opportunity for a bug when the pointer variable type is changed
but the corresponding sizeof that is passed to a memory allocator is not."

So do it as recommeded.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 6bb77d7..3f8c05b 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1419,8 +1419,7 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	int ret, reg, rev;
 	unsigned int mclk;
 
-	sgtl5000 = devm_kzalloc(&client->dev, sizeof(struct sgtl5000_priv),
-								GFP_KERNEL);
+	sgtl5000 = devm_kzalloc(&client->dev, sizeof(*sgtl5000), GFP_KERNEL);
 	if (!sgtl5000)
 		return -ENOMEM;
 
-- 
1.9.1
