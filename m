From: Christine Spang <christine.spang@oracle.com>
Subject: [PATCH] Make snd_BUG_ON() always evaluate and return
	the conditional expression.
Date: Mon,  4 Mar 2013 17:02:59 -0500
Message-ID: <1362434579-7733-1-git-send-email-christine.spang@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id B3322265167
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2013 23:03:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Sasha Levin <sasha.levin@oracle.com>, alsa-devel@alsa-project.org, Jamie Iles <jamie.iles@oracle.com>, Christine Spang <christine.spang@oracle.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Having snd_BUG_ON() only evaluate its conditional when CONFIG_SND_DEBUG
is set leads to frequent bugs, since other similar macros in the kernel
have different behavior. Let's make snd_BUG_ON() act like those macros
so it will stop being accidentally misused.

Signed-off-by: Christine Spang <christine.spang@oracle.com>
---
 Documentation/DocBook/writing-an-alsa-driver.tmpl | 12 +++++-------
 include/sound/core.h                              | 24 ++++++++---------------
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/Documentation/DocBook/writing-an-alsa-driver.tmpl b/Documentation/DocBook/writing-an-alsa-driver.tmpl
index bd6fee2..06741e9 100644
--- a/Documentation/DocBook/writing-an-alsa-driver.tmpl
+++ b/Documentation/DocBook/writing-an-alsa-driver.tmpl
@@ -6164,14 +6164,12 @@ struct _snd_pcm_runtime {
 
       <para>
         The macro takes an conditional expression to evaluate.
-	When <constant>CONFIG_SND_DEBUG</constant>, is set, the
-	expression is actually evaluated. If it's non-zero, it shows
-	the warning message such as
+	When <constant>CONFIG_SND_DEBUG</constant>, is set, if the
+	expression is non-zero, it shows the warning message such as
 	<computeroutput>BUG? (xxx)</computeroutput>
-	normally followed by stack trace.  It returns the evaluated
-	value.
-	When no <constant>CONFIG_SND_DEBUG</constant> is set, this
-	macro always returns zero.
+	normally followed by stack trace.
+
+	In both cases it returns the evaluated value.
       </para>
 
     </section>
diff --git a/include/sound/core.h b/include/sound/core.h
index 7cede2d..a63680b 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -379,18 +379,10 @@ void __snd_printk(unsigned int level, const char *file, int line,
  * snd_BUG_ON - debugging check macro
  * @cond: condition to evaluate
  *
- * When CONFIG_SND_DEBUG is set, this macro evaluates the given condition,
- * and call WARN() and returns the value if it's non-zero.
- * 
- * When CONFIG_SND_DEBUG is not set, this just returns zero, and the given
- * condition is ignored.
- *
- * NOTE: the argument won't be evaluated at all when CONFIG_SND_DEBUG=n.
- * Thus, don't put any statement that influences on the code behavior,
- * such as pre/post increment, to the argument of this macro.
- * If you want to evaluate and give a warning, use standard WARN_ON().
+ * Has the same behavior as WARN_ON when CONFIG_SND_DEBUG is set,
+ * otherwise just evaluates the conditional and returns the value.
  */
-#define snd_BUG_ON(cond)	WARN((cond), "BUG? (%s)\n", __stringify(cond))
+#define snd_BUG_ON(cond)	WARN_ON((cond))
 
 #else /* !CONFIG_SND_DEBUG */
 
@@ -400,11 +392,11 @@ __printf(2, 3)
 static inline void _snd_printd(int level, const char *format, ...) {}
 
 #define snd_BUG()			do { } while (0)
-static inline int __snd_bug_on(int cond)
-{
-	return 0;
-}
-#define snd_BUG_ON(cond)	__snd_bug_on(0 && (cond))  /* always false */
+
+#define snd_BUG_ON(condition) ({ \
+	int __ret_warn_on = !!(condition); \
+	unlikely(__ret_warn_on); \
+})
 
 #endif /* CONFIG_SND_DEBUG */
 
-- 
1.8.2.rc0
