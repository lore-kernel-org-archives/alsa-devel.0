From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 5/5] ASoC: Remove ASoC level IO tracing
Date: Tue, 22 Apr 2014 12:02:24 +0200
Message-ID: <1398160944-6661-6-git-send-email-lars@metafoo.de>
References: <1398160944-6661-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-072.synserver.de (smtp-out-075.synserver.de
 [212.40.185.75])
 by alsa0.perex.cz (Postfix) with ESMTP id BFE7A261AC1
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 12:02:35 +0200 (CEST)
In-Reply-To: <1398160944-6661-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The ASoC framework is in the process of migrating all IO operations to regmap.
regmap has its own more sophisticated tracing infrastructure for IO operations,
which means that the ASoC level IO tracing becomes redundant, hence this patch
removes them. There are still a handful of ASoC drivers left that do not use
regmap yet, but hopefully the removal of the ASoC IO tracing will be an
additional incentive to switch to regmap.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
New in v2
---
 include/trace/events/asoc.h | 92 ---------------------------------------------
 sound/soc/soc-io.c          | 11 ------
 2 files changed, 103 deletions(-)

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 03996b2..c75c795 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -11,102 +11,10 @@
 
 struct snd_soc_jack;
 struct snd_soc_codec;
-struct snd_soc_platform;
 struct snd_soc_card;
 struct snd_soc_dapm_widget;
 struct snd_soc_dapm_path;
 
-/*
- * Log register events
- */
-DECLARE_EVENT_CLASS(snd_soc_reg,
-
-	TP_PROTO(struct snd_soc_codec *codec, unsigned int reg,
-		 unsigned int val),
-
-	TP_ARGS(codec, reg, val),
-
-	TP_STRUCT__entry(
-		__string(	name,		codec->name	)
-		__field(	int,		id		)
-		__field(	unsigned int,	reg		)
-		__field(	unsigned int,	val		)
-	),
-
-	TP_fast_assign(
-		__assign_str(name, codec->name);
-		__entry->id = codec->id;
-		__entry->reg = reg;
-		__entry->val = val;
-	),
-
-	TP_printk("codec=%s.%d reg=%x val=%x", __get_str(name),
-		  (int)__entry->id, (unsigned int)__entry->reg,
-		  (unsigned int)__entry->val)
-);
-
-DEFINE_EVENT(snd_soc_reg, snd_soc_reg_write,
-
-	TP_PROTO(struct snd_soc_codec *codec, unsigned int reg,
-		 unsigned int val),
-
-	TP_ARGS(codec, reg, val)
-
-);
-
-DEFINE_EVENT(snd_soc_reg, snd_soc_reg_read,
-
-	TP_PROTO(struct snd_soc_codec *codec, unsigned int reg,
-		 unsigned int val),
-
-	TP_ARGS(codec, reg, val)
-
-);
-
-DECLARE_EVENT_CLASS(snd_soc_preg,
-
-	TP_PROTO(struct snd_soc_platform *platform, unsigned int reg,
-		 unsigned int val),
-
-	TP_ARGS(platform, reg, val),
-
-	TP_STRUCT__entry(
-		__string(	name,		platform->name	)
-		__field(	int,		id		)
-		__field(	unsigned int,	reg		)
-		__field(	unsigned int,	val		)
-	),
-
-	TP_fast_assign(
-		__assign_str(name, platform->name);
-		__entry->id = platform->id;
-		__entry->reg = reg;
-		__entry->val = val;
-	),
-
-	TP_printk("platform=%s.%d reg=%x val=%x", __get_str(name),
-		  (int)__entry->id, (unsigned int)__entry->reg,
-		  (unsigned int)__entry->val)
-);
-
-DEFINE_EVENT(snd_soc_preg, snd_soc_preg_write,
-
-	TP_PROTO(struct snd_soc_platform *platform, unsigned int reg,
-		 unsigned int val),
-
-	TP_ARGS(platform, reg, val)
-
-);
-
-DEFINE_EVENT(snd_soc_preg, snd_soc_preg_read,
-
-	TP_PROTO(struct snd_soc_platform *platform, unsigned int reg,
-		 unsigned int val),
-
-	TP_ARGS(platform, reg, val)
-
-);
-
 DECLARE_EVENT_CLASS(snd_soc_card,
 
 	TP_PROTO(struct snd_soc_card *card, int val),
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index 2ead9ed..7767fbd 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -17,8 +17,6 @@
 #include <linux/export.h>
 #include <sound/soc.h>
 
-#include <trace/events/asoc.h>
-
 /**
  * snd_soc_component_read() - Read register value
  * @component: Component to read from
@@ -39,8 +37,6 @@ int snd_soc_component_read(struct snd_soc_component *component,
 	else
 		ret = -EIO;
 
-	dev_dbg(component->dev, "read %x => %x\n", reg, *val);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_component_read);
@@ -56,8 +52,6 @@ EXPORT_SYMBOL_GPL(snd_soc_component_read);
 int snd_soc_component_write(struct snd_soc_component *component,
 	unsigned int reg, unsigned int val)
 {
-	dev_dbg(component->dev, "write %x = %x\n", reg, val);
-
 	if (component->regmap)
 		return regmap_write(component->regmap, reg, val);
 	else if (component->write)
@@ -207,7 +201,6 @@ unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg)
 	ret = snd_soc_component_read(&codec->component, reg, &val);
 	if (ret < 0)
 		return -1;
-	trace_snd_soc_reg_read(codec, reg, val);
 
 	return val;
 }
@@ -216,7 +209,6 @@ EXPORT_SYMBOL_GPL(snd_soc_read);
 int snd_soc_write(struct snd_soc_codec *codec, unsigned int reg,
 	unsigned int val)
 {
-	trace_snd_soc_reg_write(codec, reg, val);
 	return snd_soc_component_write(&codec->component, reg, val);
 }
 EXPORT_SYMBOL_GPL(snd_soc_write);
@@ -269,8 +261,6 @@ int snd_soc_platform_read(struct snd_soc_platform *platform,
 	if (ret < 0)
 		return -1;
 
-	trace_snd_soc_preg_read(platform, reg, val);
-
 	return val;
 }
 EXPORT_SYMBOL_GPL(snd_soc_platform_read);
@@ -278,7 +268,6 @@ EXPORT_SYMBOL_GPL(snd_soc_platform_read);
 int snd_soc_platform_write(struct snd_soc_platform *platform,
 					 unsigned int reg, unsigned int val)
 {
-	trace_snd_soc_preg_write(platform, reg, val);
 	return snd_soc_component_write(&platform->component, reg, val);
 }
 EXPORT_SYMBOL_GPL(snd_soc_platform_write);
-- 
1.8.0
