From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 4/5] hda-emu/tester: Add codec index parameter
	to hda-emu-tester
Date: Thu,  4 Sep 2014 14:21:06 +0200
Message-ID: <1409833267-9778-5-git-send-email-david.henningsson@canonical.com>
References: <1409833267-9778-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CA102658A6
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

Also improve runner's error handling a little.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 tester/hda-emu-tester.py |  2 ++
 tester/runner.py         | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tester/hda-emu-tester.py b/tester/hda-emu-tester.py
index 4782a97..3b994ab 100755
--- a/tester/hda-emu-tester.py
+++ b/tester/hda-emu-tester.py
@@ -22,6 +22,7 @@ def handle_argv():
     import argparse
     parser = argparse.ArgumentParser(description='Hda-emu automated test wrapper.')
     parser.add_argument('--file', dest='file', required=True, help='alsa-info filename')
+    parser.add_argument('--codec-index', dest='codecindex', default=0, help='what codec to test')
     parser.add_argument('--print-errors', dest='print_errors', action="store_true", 
         default=False, help='print errors, and the command that caused it')
     parser.add_argument('--comm-log', dest='comm_log', action="store_true", 
@@ -34,6 +35,7 @@ def run_test(argv):
     result.set_print_errors(argv.print_errors)
     result.set_comm_log_enabled(argv.comm_log)
     result.set_alsa_info_file(argv.file)
+    result.set_codec_index(argv.codecindex)
     result.run_standard()
     return result
 
diff --git a/tester/runner.py b/tester/runner.py
index 1e7ecf9..964da1a 100644
--- a/tester/runner.py
+++ b/tester/runner.py
@@ -20,6 +20,9 @@ import subprocess
 import os
 import re
 
+class HdaEmuFatalError(Exception):
+    pass
+
 class ControlInfo():
     def __init__(self, runner, list_info):
         self.runner = runner
@@ -48,15 +51,20 @@ class HdaEmuRunner():
     def __init__(self):
         import os.path
         hda_emu_path = os.path.join(os.path.dirname(os.path.realpath(__file__)),"../hda-emu")
-        self.child_args = '"' + hda_emu_path + '" -M -F'
+        self.child_args = '"' + hda_emu_path + '" -M -F -i'
         self.alsa_info = "/proc/asound/card0/codec#0"
         self.errors = 0
         self.warnings = 0
         self.fatals = 0
+        self.codec_index = 0
         self.print_errors = False
+        self.error_list = []
         self.comm_log_enabled = False
         self.last_command = None
 
+    def set_codec_index(self, codec_index):
+        self.codec_index = codec_index
+
     def set_alsa_info_file(self, filename):
         self.alsa_info = filename
 
@@ -71,6 +79,7 @@ class HdaEmuRunner():
         from subprocess import PIPE, STDOUT
 
         args = shlex.split(self.child_args)
+        args.append(str(self.codec_index))
         args.append(self.alsa_info)
         self.child = subprocess.Popen(args, bufsize=0, stdin=PIPE, stdout=PIPE, stderr=PIPE)
 
@@ -82,6 +91,7 @@ class HdaEmuRunner():
         self.child = None
 
     def add_error(self, message, severity):
+        self.error_list.append(message)
         if severity == "Warning":
             self.warnings += 1
         else:
@@ -97,7 +107,7 @@ class HdaEmuRunner():
                 self.last_command_printed = True
             print "  ", message
         if self.fatals > 0:
-            raise Exception(message)
+            raise HdaEmuFatalError(message)
 
     def check_stdout(self):
         s = os.read(self.child.stdout.fileno(), 65536)
-- 
1.9.1
