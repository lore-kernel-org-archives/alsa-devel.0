From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 2/6]
	Documentation/DocBook/writing-an-alsa-driver.tmpl: fix some thinkos
Date: Mon, 28 Jan 2013 23:42:28 +0100
Message-ID: <1359412952-1680-3-git-send-email-ospite@studenti.unina.it>
References: <1359412952-1680-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp207.alice.it (smtp207.alice.it [82.57.200.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 14228265B47
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 23:43:56 +0100 (CET)
In-Reply-To: <1359412952-1680-1-git-send-email-ospite@studenti.unina.it>
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
Cc: Takashi Iwai <tiwai@suse.de>, Michael Trimarchi <michael@amarulasolutions.com>, Antonio Ospite <ao2@amarulasolutions.com>, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Antonio Ospite <ao2@amarulasolutions.com>

Signed-off-by: Antonio Ospite <ao2@amarulasolutions.com>
---
 Documentation/DocBook/writing-an-alsa-driver.tmpl |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/DocBook/writing-an-alsa-driver.tmpl b/Documentation/DocBook/writing-an-alsa-driver.tmpl
index fb32aea..da2f443 100644
--- a/Documentation/DocBook/writing-an-alsa-driver.tmpl
+++ b/Documentation/DocBook/writing-an-alsa-driver.tmpl
@@ -871,9 +871,8 @@
       <para>
       This function itself doesn't allocate the data space. The data
       must be allocated manually beforehand, and its pointer is passed
-      as the argument. This pointer is used as the
-      (<parameter>chip</parameter> identifier in the above example)
-      for the instance. 
+      as the argument. This pointer (<parameter>chip</parameter> in the
+      above example) is used as the identifier for the instance.
       </para>
 
       <para>
@@ -2304,7 +2303,7 @@ struct _snd_pcm_runtime {
         <constant>SNDRV_PCM_INFO_XXX</constant>. Here, at least, you
         have to specify whether the mmap is supported and which
         interleaved format is supported.
-        When the is supported, add the
+        When the hardware supports mmap, add the
         <constant>SNDRV_PCM_INFO_MMAP</constant> flag here. When the
         hardware supports the interleaved or the non-interleaved
         formats, <constant>SNDRV_PCM_INFO_INTERLEAVED</constant> or
-- 
1.7.10.4
