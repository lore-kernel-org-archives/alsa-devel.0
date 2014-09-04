From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 5/5] hda-emu/tester: Test all codecs,
	not just one
Date: Thu,  4 Sep 2014 14:21:07 +0200
Message-ID: <1409833267-9778-6-git-send-email-david.henningsson@canonical.com>
References: <1409833267-9778-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id CD91A2658A8
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 14:21:07 +0200 (CEST)
In-Reply-To: <1409833267-9778-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This way we get a more complete test over the codecs.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 tester/summary.py | 62 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 13 deletions(-)

diff --git a/tester/summary.py b/tester/summary.py
index 0f9fbf3..640d1c1 100755
--- a/tester/summary.py
+++ b/tester/summary.py
@@ -18,15 +18,33 @@
 #    You should have received a copy of the GNU General Public License along 
 #    with this program.  If not, see <http://www.gnu.org/licenses/>.
 
+import runner
+
+
 def defaultpath(s):
     import os.path
     q = os.path.dirname(os.path.realpath(__file__))
     return os.path.join(q, s)
 
+def count_codecs(filename):
+    r = runner.HdaEmuRunner()
+    r.set_alsa_info_file(filename)
+    r.set_codec_index(99999)
+    r.start_process()
+    try:
+        r.run_command()
+    except runner.HdaEmuFatalError:
+        import re
+        m = re.compile("Codec index (\d+) requested, but found only (\d+) codecs")
+        for line in r.error_list:
+            match = m.search(line)
+            if match:
+                return int(match.group(2))
+    return -1
+
 def main():
     import os
     import os.path
-    import runner
 
     import argparse
     parser = argparse.ArgumentParser(description='Hda-emu automated test wrapper.')
@@ -53,19 +71,37 @@ def main():
         index += 1
         if verbose > 2:
             print '[{0}/{1}]: Testing {2}'.format(index, len(files), f)
+
         try:
-            r = runner.HdaEmuRunner()
-            r.set_alsa_info_file(os.path.join(directory, f))
-            r.set_print_errors(verbose > 1)
-            r.run_standard()
-            if r.errors > 0 or r.warnings > 0:
-                fails += 1
-                errors += r.errors
-                warnings += r.warnings
-                if verbose > 0:
-                    print '{0} errors, {1} warnings. ({2})'.format(r.errors, r.warnings, f)
-            else:
-                successes += 1
+            codecs = count_codecs(os.path.join(directory, f))
+
+            fail_this = False
+            skip_this = codecs < 0
+            for codec_index in range(codecs):
+                r = runner.HdaEmuRunner()
+                r.set_alsa_info_file(os.path.join(directory, f))
+                r.set_codec_index(codec_index)
+                r.set_print_errors(verbose > 1)
+
+                try:
+                    r.run_standard()
+                except runner.HdaEmuFatalError:
+                    for line in r.error_list:
+                        if line.find("is a modem codec, aborting"):
+                            skip_this = True
+
+                if (not skip_this) and (r.errors > 0 or r.warnings > 0):
+                    fail_this = True
+                    errors += r.errors
+                    warnings += r.warnings
+                    if verbose > 0:
+                        print '{0} errors, {1} warnings for {2}, codec {3}/{4}.'.format(r.errors, r.warnings, f, codec_index+1, codecs)
+
+            if not skip_this:
+                if fail_this:
+                    fails += 1
+                else:
+                    successes += 1
         except KeyboardInterrupt:
             import sys
             sys.exit(1)
-- 
1.9.1
