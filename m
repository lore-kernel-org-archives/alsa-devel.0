From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-analyzer: Make parsing code more robust
	against future proc file changes
Date: Thu,  7 Feb 2013 14:47:33 +0100
Message-ID: <1360244853-22301-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 4604F2652AB
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2013 14:47:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Historically, new additions to the codec proc file has crashed hda-analyzer.
With this patch, new additions will instead be ignored.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-analyzer/hda_proc.py |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hda-analyzer/hda_proc.py b/hda-analyzer/hda_proc.py
index 3d544c8..10aa662 100644
--- a/hda-analyzer/hda_proc.py
+++ b/hda-analyzer/hda_proc.py
@@ -644,9 +644,8 @@ class HDACodecProc(HDACodec, HDABaseProc):
     if line == 'Invalid AFG subtree':
       print "Invalid AFG subtree for codec %s?" % self.proc_codec_id
       return
-    while line.startswith('Power-Map: ') or \
-          line.startswith('Analog Loopback: '):
-      print 'Sigmatel specific "%s" verb ignored for the moment' % line
+    while not line.startswith('Node '):
+      print 'Vendor specific "%s" verb ignored at the moment' % line
       idx += 1
       line = lines[idx].strip()
     node = None
@@ -728,7 +727,7 @@ class HDACodecProc(HDACodec, HDABaseProc):
         elif line.startswith('  Volume-Knob: '):
           node.add_volknob(line[15:])
         else:
-          self.wrongfile(line)
+          print 'Node line "%s" ignored at the moment' % line
         idx += 1
         if idx < len(lines):
           line = lines[idx]
-- 
1.7.9.5
