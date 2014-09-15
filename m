From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: Update document about PCM nonatomic ops
Date: Mon, 15 Sep 2014 15:24:56 +0200
Message-ID: <1410787496-20573-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DB470260320
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 15:24:57 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AA87075013
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 13:24:57 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/DocBook/writing-an-alsa-driver.tmpl | 28 +++++++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/DocBook/writing-an-alsa-driver.tmpl b/Documentation/DocBook/writing-an-alsa-driver.tmpl
index 6f639d9530b5..784793df81ed 100644
--- a/Documentation/DocBook/writing-an-alsa-driver.tmpl
+++ b/Documentation/DocBook/writing-an-alsa-driver.tmpl
@@ -2742,7 +2742,9 @@ struct _snd_pcm_runtime {
 
         <para>
           Another note is that this callback is non-atomic
-        (schedulable). This is important, because the
+        (schedulable) as default, i.e. when no
+	<structfield>nonatomic</structfield> flag set.
+	This is important, because the
         <structfield>trigger</structfield> callback 
         is atomic (non-schedulable). That is, mutexes or any
         schedule-related functions are not available in
@@ -2900,8 +2902,9 @@ struct _snd_pcm_runtime {
         </para>
 
         <para>
-          As mentioned, this callback is atomic.  You cannot call
-	  functions which may sleep.
+          As mentioned, this callback is atomic as default unless
+	  <structfield>nonatomic</structfield> flag set, and
+	  you cannot call functions which may sleep.
 	  The trigger callback should be as minimal as possible,
 	  just really triggering the DMA.  The other stuff should be
 	  initialized hw_params and prepare callbacks properly
@@ -2936,7 +2939,7 @@ struct _snd_pcm_runtime {
         </para>
 
         <para>
-          This callback is also atomic.
+          This callback is also atomic as default.
         </para>
       </section>
 
@@ -2972,7 +2975,7 @@ struct _snd_pcm_runtime {
 	is useful only for such a purpose.
 	</para>
 	<para>
-	  This callback is atomic.
+	  This callback is atomic as default.
 	</para>
       </section>
 
@@ -3175,6 +3178,21 @@ struct _snd_pcm_runtime {
       called with local interrupts disabled.
       </para>
 
+      <para>
+      The recent changes in PCM core code, however, allow all PCM
+      operations to be non-atomic.  This assumes that the all caller
+      sides are in non-atomic contexts.  For example, the function
+      <function>snd_pcm_period_elapsed()</function> is called
+      typically from the interrupt handler.  But, if you set up the
+      driver to use a threaded interrupt handler, this call can be in
+      non-atomic context, too.  In such a case, you can set
+      <structfield>nonatomic</structfield> filed of
+      <structname>snd_pcm</structname> object after creating it.
+      When this flag is set, mutex and rwsem are used internally in
+      the PCM core instead of spin and rwlocks, so that you can call
+      all PCM functions safely in a non-atomic context.
+      </para>
+
     </section>
     <section id="pcm-interface-constraints">
       <title>Constraints</title>
-- 
2.1.0
