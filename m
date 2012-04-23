From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: dapm: Fix x86_64 build warning.
Date: Mon, 23 Apr 2012 10:31:15 +0100
Message-ID: <1335173475-5536-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog128.obsmtp.com (na3sys009aog128.obsmtp.com
	[74.125.149.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C596244DA
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2012 11:34:23 +0200 (CEST)
Received: by werj55 with SMTP id j55so8065829wer.28
	for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2012 02:34:21 -0700 (PDT)
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

Fixes the following build warning on x86_64.

In file included from include/trace/ftrace.h:567:0,
                 from include/trace/define_trace.h:86,
                 from include/trace/events/asoc.h:410,
                 from sound/soc/soc-core.c:45:
include/trace/events/asoc.h: In function 'ftrace_raw_event_snd_soc_dapm_output_path':
include/trace/events/asoc.h:246:1: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
include/trace/events/asoc.h: In function 'ftrace_raw_event_snd_soc_dapm_input_path':
include/trace/events/asoc.h:275:1: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/trace/events/asoc.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 6d8efb1..5fc2dcd 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -263,7 +263,7 @@ TRACE_EVENT(snd_soc_dapm_output_path,
 		__assign_str(pname, path->name ? path->name : DAPM_DIRECT);
 		__assign_str(psname, path->sink->name);
 		__entry->path_connect = path->connect;
-		__entry->path_sink = (int)path->sink;
+		__entry->path_sink = (long)path->sink;
 	),
 
 	TP_printk("%c%s -> %s -> %s\n",
@@ -292,7 +292,7 @@ TRACE_EVENT(snd_soc_dapm_input_path,
 		__assign_str(pname, path->name ? path->name : DAPM_DIRECT);
 		__assign_str(psname, path->source->name);
 		__entry->path_connect = path->connect;
-		__entry->path_source = (int)path->source;
+		__entry->path_source = (long)path->source;
 	),
 
 	TP_printk("%c%s <- %s <- %s\n",
-- 
1.7.5.4
