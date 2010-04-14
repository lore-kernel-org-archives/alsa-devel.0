From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] ALSA: Update the documentation for changes
	of proc files
Date: Wed, 14 Apr 2010 10:18:03 +0200
Message-ID: <1271233083-16310-6-git-send-email-tiwai@suse.de>
References: <1271233083-16310-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 9794424481
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 10:18:41 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 76F3E8980B
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 10:18:41 +0200 (CEST)
In-Reply-To: <1271233083-16310-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/DocBook/writing-an-alsa-driver.tmpl |   27 +++++++++++++-------
 1 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/Documentation/DocBook/writing-an-alsa-driver.tmpl b/Documentation/DocBook/writing-an-alsa-driver.tmpl
index 0d0f7b4..0ba149d 100644
--- a/Documentation/DocBook/writing-an-alsa-driver.tmpl
+++ b/Documentation/DocBook/writing-an-alsa-driver.tmpl
@@ -5518,34 +5518,41 @@ struct _snd_pcm_runtime {
 ]]>
         </programlisting>
       </informalexample>
+
+      For the raw data, <structfield>size</structfield> field must be
+      set properly.  This specifies the maximum size of the proc file access.
     </para>
 
     <para>
-      The callback is much more complicated than the text-file
-      version. You need to use a low-level I/O functions such as
+      The read/write callbacks of raw mode are more direct than the text mode.
+      You need to use a low-level I/O functions such as
       <function>copy_from/to_user()</function> to transfer the
       data.
 
       <informalexample>
         <programlisting>
 <![CDATA[
-  static long my_file_io_read(struct snd_info_entry *entry,
+  static ssize_t my_file_io_read(struct snd_info_entry *entry,
                               void *file_private_data,
                               struct file *file,
                               char *buf,
-                              unsigned long count,
-                              unsigned long pos)
+                              size_t count,
+                              loff_t pos)
   {
-          long size = count;
-          if (pos + size > local_max_size)
-                  size = local_max_size - pos;
-          if (copy_to_user(buf, local_data + pos, size))
+          if (copy_to_user(buf, local_data + pos, count))
                   return -EFAULT;
-          return size;
+          return count;
   }
 ]]>
         </programlisting>
       </informalexample>
+
+      If the size of the info entry has been set up properly,
+      <structfield>count</structfield> and <structfield>pos</structfield> are
+      guaranteed to fit within 0 and the given size.
+      You don't have to check the range in the callbacks unless any
+      other condition is required.
+
     </para>
 
   </chapter>
-- 
1.7.0.4
