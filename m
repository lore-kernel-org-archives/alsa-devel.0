From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH -next] soc: fix wm0010.c printk format warning
Date: Wed, 05 Sep 2012 16:24:57 -0700
Message-ID: <5047DF49.6070502@xenotime.net>
References: <20120905161230.3bab1de6d4c8c8e466c3b0df@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy12-pub.bluehost.com (oproxy12-pub.bluehost.com
 [50.87.16.10]) by alsa0.perex.cz (Postfix) with SMTP id 50B7E264EF4
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 01:25:19 +0200 (CEST)
In-Reply-To: <20120905161230.3bab1de6d4c8c8e466c3b0df@canb.auug.org.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: alsa-devel@alsa-project.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warning:

sound/soc/codecs/wm0010.c:411:2: warning: format '%d' expects type 'int', but argument 4 has type 'size_t'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/codecs/wm0010.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20120905.orig/sound/soc/codecs/wm0010.c
+++ linux-next-20120905/sound/soc/codecs/wm0010.c
@@ -408,7 +408,7 @@ static int wm0010_boot(struct snd_soc_co
 	wm0010->state = WM0010_BOOTROM;
 	spin_unlock_irqrestore(&wm0010->irq_lock, flags);
 
-	dev_dbg(codec->dev, "Downloading %d byte stage 2 loader\n", fw->size);
+	dev_dbg(codec->dev, "Downloading %zu byte stage 2 loader\n", fw->size);
 
 	/* Copy to local buffer first as vmalloc causes problems for dma */
 	img = kzalloc(fw->size, GFP_KERNEL);
