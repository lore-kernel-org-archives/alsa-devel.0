From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: core - Add platform IO tracing
Date: Mon, 4 Jul 2011 22:10:50 +0100
Message-ID: <1309813853-7142-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 92F9F1038AA
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 23:10:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Trace platform IO just like CODEC IO.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/trace/events/asoc.h |   45 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-core.c        |    2 +
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index ae973d2..603f5a0 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -9,6 +9,7 @@
 
 struct snd_soc_jack;
 struct snd_soc_codec;
+struct snd_soc_platform;
 struct snd_soc_card;
 struct snd_soc_dapm_widget;
 
@@ -59,6 +60,50 @@ DEFINE_EVENT(snd_soc_reg, snd_soc_reg_read,
 
 );
 
+DECLARE_EVENT_CLASS(snd_soc_preg,
+
+	TP_PROTO(struct snd_soc_platform *platform, unsigned int reg,
+		 unsigned int val),
+
+	TP_ARGS(platform, reg, val),
+
+	TP_STRUCT__entry(
+		__string(	name,		platform->name	)
+		__field(	int,		id		)
+		__field(	unsigned int,	reg		)
+		__field(	unsigned int,	val		)
+	),
+
+	TP_fast_assign(
+		__assign_str(name, platform->name);
+		__entry->id = platform->id;
+		__entry->reg = reg;
+		__entry->val = val;
+	),
+
+	TP_printk("platform=%s.%d reg=%x val=%x", __get_str(name),
+		  (int)__entry->id, (unsigned int)__entry->reg,
+		  (unsigned int)__entry->val)
+);
+
+DEFINE_EVENT(snd_soc_preg, snd_soc_preg_write,
+
+	TP_PROTO(struct snd_soc_platform *platform, unsigned int reg,
+		 unsigned int val),
+
+	TP_ARGS(platform, reg, val)
+
+);
+
+DEFINE_EVENT(snd_soc_preg, snd_soc_preg_read,
+
+	TP_PROTO(struct snd_soc_platform *platform, unsigned int reg,
+		 unsigned int val),
+
+	TP_ARGS(platform, reg, val)
+
+);
+
 DECLARE_EVENT_CLASS(snd_soc_card,
 
 	TP_PROTO(struct snd_soc_card *card, int val),
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d08abf4..06c9b14 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1652,6 +1652,7 @@ int snd_soc_platform_read(struct snd_soc_platform *platform,
 
 	ret = platform->driver->read(platform, reg);
 	dev_dbg(platform->dev, "read %x => %x\n", reg, ret);
+	trace_snd_soc_preg_read(platform, reg, ret);
 
 	return ret;
 }
@@ -1666,6 +1667,7 @@ int snd_soc_platform_write(struct snd_soc_platform *platform,
 	}
 
 	dev_dbg(platform->dev, "write %x = %x\n", reg, val);
+	trace_snd_soc_preg_write(platform, reg, val);
 	return platform->driver->write(platform, reg, val);
 }
 EXPORT_SYMBOL_GPL(snd_soc_platform_write);
-- 
1.7.4.1
