From: Dan Carpenter <error27@gmail.com>
Subject: [patch] ALSA: soc-cache: dereferencing before checking
Date: Mon, 7 Feb 2011 22:01:41 +0300
Message-ID: <20110207190141.GJ4384@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id ED270244EF
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 20:02:00 +0100 (CET)
Received: by ewy19 with SMTP id 19so2340689ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 07 Feb 2011 11:02:00 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch c358e640a66 "ASoC: soc-cache: Add trace event for
snd_soc_cache_sync()" introduced a dereference of "codec->cache_ops"
before we had checked it for NULL.

I pulled the check forward, and then pulled everything in an indent
level.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index db66dc4..5d76da4 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -1609,24 +1609,23 @@ int snd_soc_cache_sync(struct snd_soc_codec *codec)
 		return 0;
 	}
 
+	if (!codec->cache_ops || !codec->cache_ops->sync)
+		return -EINVAL;
+
 	if (codec->cache_ops->name)
 		name = codec->cache_ops->name;
 	else
 		name = "unknown";
 
-	if (codec->cache_ops && codec->cache_ops->sync) {
-		if (codec->cache_ops->name)
-			dev_dbg(codec->dev, "Syncing %s cache for %s codec\n",
-				codec->cache_ops->name, codec->name);
-		trace_snd_soc_cache_sync(codec, name, "start");
-		ret = codec->cache_ops->sync(codec);
-		if (!ret)
-			codec->cache_sync = 0;
-		trace_snd_soc_cache_sync(codec, name, "end");
-		return ret;
-	}
-
-	return -EINVAL;
+	if (codec->cache_ops->name)
+		dev_dbg(codec->dev, "Syncing %s cache for %s codec\n",
+			codec->cache_ops->name, codec->name);
+	trace_snd_soc_cache_sync(codec, name, "start");
+	ret = codec->cache_ops->sync(codec);
+	if (!ret)
+		codec->cache_sync = 0;
+	trace_snd_soc_cache_sync(codec, name, "end");
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_cache_sync);
