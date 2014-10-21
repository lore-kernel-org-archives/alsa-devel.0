From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/43] ALSA: doc: Recommend the use of
	snd_ctl_elem_info()
Date: Tue, 21 Oct 2014 12:10:37 +0200
Message-ID: <1413886279-18704-2-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BB70266635
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:24 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0A83CAAF3
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 10:11:23 +0000 (UTC)
In-Reply-To: <1413886279-18704-1-git-send-email-tiwai@suse.de>
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

Instead of the open code for the info call back of enum elements,
recommend the use of snd_ctl_elem_info(), which will reduce lots of
codes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/DocBook/writing-an-alsa-driver.tmpl | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/DocBook/writing-an-alsa-driver.tmpl b/Documentation/DocBook/writing-an-alsa-driver.tmpl
index 784793df81ed..84ef6a90131c 100644
--- a/Documentation/DocBook/writing-an-alsa-driver.tmpl
+++ b/Documentation/DocBook/writing-an-alsa-driver.tmpl
@@ -3658,6 +3658,29 @@ struct _snd_pcm_runtime {
         </para>
 
         <para>
+	  The above callback can be simplified with a helper function,
+	  <function>snd_ctl_enum_info</function>.  The final code
+	  looks like below.
+	  (You can pass ARRAY_SIZE(texts) instead of 4 in the third
+	   argument; it's a matter of taste.)
+
+          <informalexample>
+            <programlisting>
+<![CDATA[
+  static int snd_myctl_enum_info(struct snd_kcontrol *kcontrol,
+                          struct snd_ctl_elem_info *uinfo)
+  {
+          static char *texts[4] = {
+                  "First", "Second", "Third", "Fourth"
+          };
+          return snd_ctl_enum_info(uinfo, 1, 4, texts);
+  }
+]]>
+            </programlisting>
+          </informalexample>
+        </para>
+
+        <para>
 	  Some common info callbacks are available for your convenience:
 	<function>snd_ctl_boolean_mono_info()</function> and
 	<function>snd_ctl_boolean_stereo_info()</function>.
-- 
2.1.2
