From: Ben Dooks <ben-alsa@fluff.org>
Subject: [patch 7/9] ASoC: Ensure codec check hw_write error at
	probe
Date: Wed, 04 Mar 2009 00:49:32 +0000
Message-ID: <20090304005139.164366737@fluff.org.uk>
References: <20090304004925.530566010@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from teyla.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 515DD24408
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 01:54:00 +0100 (CET)
Content-Disposition: inline; filename=audio/fix-i2c-error-returns.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Add checks to see if wmXXXX_reset() failed and notify
the user of the problem. This is generally due to a
problem on the i2c bus such as an un-powered or 
non-connected codec.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

Index: linux-2.6.29-rc6-quilt1/sound/soc/codecs/wm8731.c
===================================================================
--- linux-2.6.29-rc6-quilt1.orig/sound/soc/codecs/wm8731.c	2009-02-25 11:14:15.000000000 +0000
+++ linux-2.6.29-rc6-quilt1/sound/soc/codecs/wm8731.c	2009-02-25 11:14:37.000000000 +0000
@@ -521,7 +521,11 @@ static int wm8731_init(struct snd_soc_de
 	if (codec->reg_cache == NULL)
 		return -ENOMEM;
 
-	wm8731_reset(codec);
+	ret = wm8731_reset(codec);
+	if (ret < 0) {
+		printk(KERN_ERR "wm8731: failed to send reset\n");
+		return -EIO;
+	}
 
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
Index: linux-2.6.29-rc6-quilt1/sound/soc/codecs/wm8753.c
===================================================================
--- linux-2.6.29-rc6-quilt1.orig/sound/soc/codecs/wm8753.c	2009-02-25 11:14:15.000000000 +0000
+++ linux-2.6.29-rc6-quilt1/sound/soc/codecs/wm8753.c	2009-02-25 11:14:37.000000000 +0000
@@ -1573,7 +1573,11 @@ static int wm8753_init(struct snd_soc_de
 
 	wm8753_set_dai_mode(codec, 0);
 
-	wm8753_reset(codec);
+	ret = wm8753_reset(codec);
+	if (ret < 0) {
+		printk(KERN_ERR "wm8753: failed reset, not present?\n");
+		return -EIO;
+	}
 
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
