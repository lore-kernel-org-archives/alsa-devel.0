From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: trace: Remove trailing new-lines in
	trace messages
Date: Wed, 24 Sep 2014 11:17:14 -0700
Message-ID: <1411582634-40122-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f73.google.com (mail-oi0-f73.google.com
 [209.85.218.73])
 by alsa0.perex.cz (Postfix) with ESMTP id C37C6261B25
 for <alsa-devel@alsa-project.org>; Wed, 24 Sep 2014 20:17:26 +0200 (CEST)
Received: by mail-oi0-f73.google.com with SMTP id u20so1930174oif.4
 for <alsa-devel@alsa-project.org>; Wed, 24 Sep 2014 11:17:25 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

These new-lines add empty lines to trace output

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 include/trace/events/asoc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 0194a64..b04ee7e 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -175,7 +175,7 @@ TRACE_EVENT(snd_soc_dapm_output_path,
 		__entry->path_sink = (long)path->sink;
 	),
 
-	TP_printk("%c%s -> %s -> %s\n",
+	TP_printk("%c%s -> %s -> %s",
 		(int) __entry->path_sink &&
 		(int) __entry->path_connect ? '*' : ' ',
 		__get_str(wname), __get_str(pname), __get_str(psname))
@@ -204,7 +204,7 @@ TRACE_EVENT(snd_soc_dapm_input_path,
 		__entry->path_source = (long)path->source;
 	),
 
-	TP_printk("%c%s <- %s <- %s\n",
+	TP_printk("%c%s <- %s <- %s",
 		(int) __entry->path_source &&
 		(int) __entry->path_connect ? '*' : ' ',
 		__get_str(wname), __get_str(pname), __get_str(psname))
@@ -226,7 +226,7 @@ TRACE_EVENT(snd_soc_dapm_connected,
 		__entry->stream = stream;
 	),
 
-	TP_printk("%s: found %d paths\n",
+	TP_printk("%s: found %d paths",
 		__entry->stream ? "capture" : "playback", __entry->paths)
 );
 
-- 
2.1.0.rc2.206.gedb03e5
