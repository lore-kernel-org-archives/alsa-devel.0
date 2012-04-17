From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH -next] soc: fix printk format in soc-dapm.c
Date: Mon, 16 Apr 2012 18:01:29 -0700
Message-ID: <4F8CC0E9.3010407@xenotime.net>
References: <20120416161121.261ba4e7e38989173accfb16@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy7-pub.bluehost.com (oproxy7-pub.bluehost.com
	[67.222.55.9]) by alsa0.perex.cz (Postfix) with SMTP id B2546104259
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 00:01:26 +0200 (CEST)
In-Reply-To: <20120416161121.261ba4e7e38989173accfb16@canb.auug.org.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warning for 'formats':

sound/soc/soc-dapm.c:2913:5: warning: format '%lx' expects type 'long unsigned int', but argument 3 has type 'u64'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Cc:	Liam Girdwood <lrg@ti.com>
Cc:	Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:	alsa-devel@alsa-project.org
---
 sound/soc/soc-dapm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20120416.orig/sound/soc/soc-dapm.c
+++ linux-next-20120416/sound/soc/soc-dapm.c
@@ -2909,7 +2909,7 @@ static int snd_soc_dai_link_event(struct
 	if (config->formats) {
 		fmt = ffs(config->formats) - 1;
 	} else {
-		dev_warn(w->dapm->dev, "Invalid format %lx specified\n",
+		dev_warn(w->dapm->dev, "Invalid format %llx specified\n",
 			 config->formats);
 		fmt = 0;
 	}
