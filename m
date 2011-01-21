From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH v2] ASoC: soc-cache: Add trace event for
	snd_soc_cache_sync()
Date: Fri, 21 Jan 2011 15:29:02 +0000
Message-ID: <1295623742-7988-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B88D024602
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 16:29:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This patch makes it easy to see when the syncing process begins and
ends.  You can also enable the snd_soc_reg_write tracepoint to see
which registers are being synced.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 include/trace/events/asoc.h |   25 +++++++++++++++++++++++++
 sound/soc/soc-cache.c       |   10 ++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 186e84d..ae973d2 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -229,6 +229,31 @@ TRACE_EVENT(snd_soc_jack_notify,
 	TP_printk("jack=%s %x", __get_str(name), (int)__entry->val)
 );
 
+TRACE_EVENT(snd_soc_cache_sync,
+
+	TP_PROTO(struct snd_soc_codec *codec, const char *type,
+		 const char *status),
+
+	TP_ARGS(codec, type, status),
+
+	TP_STRUCT__entry(
+		__string(	name,		codec->name	)
+		__string(	status,		status		)
+		__string(	type,		type		)
+		__field(	int,		id		)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, codec->name);
+		__assign_str(status, status);
+		__assign_str(type, type);
+		__entry->id = codec->id;
+	),
+
+	TP_printk("codec=%s.%d type=%s status=%s", __get_str(name),
+		  (int)__entry->id, __get_str(type), __get_str(status))
+);
+
 #endif /* _TRACE_ASOC_H */
 
 /* This part must be outside protection */
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index f834839..db66dc4 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -18,6 +18,8 @@
 #include <linux/bitmap.h>
 #include <linux/rbtree.h>
 
+#include <trace/events/asoc.h>
+
 static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
@@ -1601,18 +1603,26 @@ EXPORT_SYMBOL_GPL(snd_soc_cache_write);
 int snd_soc_cache_sync(struct snd_soc_codec *codec)
 {
 	int ret;
+	const char *name;
 
 	if (!codec->cache_sync) {
 		return 0;
 	}
 
+	if (codec->cache_ops->name)
+		name = codec->cache_ops->name;
+	else
+		name = "unknown";
+
 	if (codec->cache_ops && codec->cache_ops->sync) {
 		if (codec->cache_ops->name)
 			dev_dbg(codec->dev, "Syncing %s cache for %s codec\n",
 				codec->cache_ops->name, codec->name);
+		trace_snd_soc_cache_sync(codec, name, "start");
 		ret = codec->cache_ops->sync(codec);
 		if (!ret)
 			codec->cache_sync = 0;
+		trace_snd_soc_cache_sync(codec, name, "end");
 		return ret;
 	}
 
-- 
1.7.3.5
