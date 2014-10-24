From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/3] ASoC: wm8962: Use the preferred form for
	passing a size of a struct
Date: Fri, 24 Oct 2014 13:01:26 -0200
Message-ID: <1414162887-14279-2-git-send-email-festevam@gmail.com>
References: <1414162887-14279-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f45.google.com (mail-yh0-f45.google.com
 [209.85.213.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 13A022604AF
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 17:03:10 +0200 (CEST)
Received: by mail-yh0-f45.google.com with SMTP id f73so861757yha.32
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 08:03:09 -0700 (PDT)
In-Reply-To: <1414162887-14279-1-git-send-email-festevam@gmail.com>
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
 sound/soc/codecs/wm8962.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 9077411..cfd3891 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3552,8 +3552,7 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
 	unsigned int reg;
 	int ret, i, irq_pol, trigger;
 
-	wm8962 = devm_kzalloc(&i2c->dev, sizeof(struct wm8962_priv),
-			      GFP_KERNEL);
+	wm8962 = devm_kzalloc(&i2c->dev, sizeof(*wm8962), GFP_KERNEL);
 	if (wm8962 == NULL)
 		return -ENOMEM;
 
-- 
1.9.1
