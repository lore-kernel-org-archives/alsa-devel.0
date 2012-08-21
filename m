From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 5/5] hda-emu: improve test suite summary script
Date: Tue, 21 Aug 2012 10:54:03 +0200
Message-ID: <1345539243-8147-6-git-send-email-david.henningsson@canonical.com>
References: <1345539243-8147-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 150CB265EEF
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 10:54:12 +0200 (CEST)
In-Reply-To: <1345539243-8147-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Now you can call summary with -v or -vv to get the same functionality
as you could with the runall.sh script.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 tester/runall.sh  |    3 ---
 tester/summary.py |    9 +++++++++
 2 files changed, 9 insertions(+), 3 deletions(-)
 delete mode 100755 tester/runall.sh

diff --git a/tester/runall.sh b/tester/runall.sh
deleted file mode 100755
index d078f35..0000000
--- a/tester/runall.sh
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/sh
-find ../codecs/canonical/ -type f | sort | xargs -n1 ./hda-emu-tester.py --file
-
diff --git a/tester/summary.py b/tester/summary.py
index cd66df7..6e94c9b 100755
--- a/tester/summary.py
+++ b/tester/summary.py
@@ -23,6 +23,12 @@ def main():
     import os.path
     import runner
 
+    import argparse
+    parser = argparse.ArgumentParser(description='Hda-emu automated test wrapper.')
+    parser.add_argument('--verbose', '-v', action='count')
+    parser_dict = parser.parse_args()
+    verbose = parser_dict.verbose
+
     os.chdir(os.path.dirname(os.path.realpath(__file__)))
     directory = "../codecs/canonical/"
     files = os.listdir(directory)
@@ -35,11 +41,14 @@ def main():
         try:
             r = runner.HdaEmuRunner()
             r.set_alsa_info_file(os.path.join(directory, f))
+            r.set_print_errors(verbose > 1)
             r.run_standard()
             if r.errors > 0 or r.warnings > 0:
                 fails += 1
                 errors += r.errors
                 warnings += r.warnings
+                if verbose > 0:
+                    print '{0} errors, {1} warnings. ({2})'.format(r.errors, r.warnings, f)
             else:
                 successes += 1
         except:
-- 
1.7.9.5
