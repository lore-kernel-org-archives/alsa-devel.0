From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/2] hda-emu: Add more functionality to test
	suite
Date: Tue, 14 Aug 2012 11:55:44 +0200
Message-ID: <1344938144-22240-2-git-send-email-david.henningsson@canonical.com>
References: <1344938144-22240-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 70C84265E1E
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2012 11:26:04 +0200 (CEST)
In-Reply-To: <1344938144-22240-1-git-send-email-david.henningsson@canonical.com>
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

Now also test jack plug/unplug, and get/set of some controls.
Add option to log communication, and make it work regardless of whether
hda-emu was compiled with readline or not.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 tester/hda-emu-tester.py |    6 ++
 tester/runner.py         |  185 +++++++++++++++++++++++++++++++++++++++-------
 tester/summary.py        |   52 +++++++++++++
 3 files changed, 218 insertions(+), 25 deletions(-)
 create mode 100755 tester/summary.py

diff --git a/tester/hda-emu-tester.py b/tester/hda-emu-tester.py
index a931651..4782a97 100755
--- a/tester/hda-emu-tester.py
+++ b/tester/hda-emu-tester.py
@@ -22,11 +22,17 @@ def handle_argv():
     import argparse
     parser = argparse.ArgumentParser(description='Hda-emu automated test wrapper.')
     parser.add_argument('--file', dest='file', required=True, help='alsa-info filename')
+    parser.add_argument('--print-errors', dest='print_errors', action="store_true", 
+        default=False, help='print errors, and the command that caused it')
+    parser.add_argument('--comm-log', dest='comm_log', action="store_true", 
+        default=False, help='print communication with hda-emu')
     return parser.parse_args()
 
 def run_test(argv):
     import runner
     result = runner.HdaEmuRunner()
+    result.set_print_errors(argv.print_errors)
+    result.set_comm_log_enabled(argv.comm_log)
     result.set_alsa_info_file(argv.file)
     result.run_standard()
     return result
diff --git a/tester/runner.py b/tester/runner.py
index 28953be..dc9f6fd 100644
--- a/tester/runner.py
+++ b/tester/runner.py
@@ -19,6 +19,28 @@
 import subprocess
 import os
 
+class ControlInfo():
+    def __init__(self, runner, list_info):
+        self.runner = runner
+        carr = list_info.split(":")
+        self.numid = carr[1]
+        self.name = carr[2]
+
+    def add_info(self, get_info):
+        import re
+        minmax_regex = re.compile("MIN/MAX: (\d+)/(\d+),\s+VAL:(( \\[\d+\\])+)")
+        val_regex = re.compile(" \\[(\d+)\\]")
+
+        if self.name.endswith("Volume") or self.name.endswith("Switch"):
+            match = minmax_regex.search("".join(get_info))
+            if match is None:
+                self.runner.add_error("Could not find MIN/MAX values for '" + self.name + "' (" + "".join(get_info) + ")", "Error")
+                return
+            self.minval = match.group(1)
+            self.maxval = match.group(2)
+            cval = val_regex.split(match.group(3))
+            self.values = [int(v) for v in cval if v != ""]
+
 class HdaEmuRunner():
 
     def __init__(self):
@@ -26,10 +48,19 @@ class HdaEmuRunner():
         self.alsa_info = "/proc/asound/card0/codec#0"
         self.errors = 0
         self.warnings = 0
+        self.print_errors = False
+        self.comm_log_enabled = False
+        self.last_command = None
 
     def set_alsa_info_file(self, filename):
         self.alsa_info = filename
 
+    def set_print_errors(self, print_errors):
+        self.print_errors = print_errors
+
+    def set_comm_log_enabled(self, value):
+        self.comm_log_enabled = value
+
     def start_process(self):
         import shlex
         from subprocess import PIPE, STDOUT
@@ -45,65 +76,169 @@ class HdaEmuRunner():
         self.child.wait()
         self.child = None
 
+    def add_error(self, message, severity):
+        if severity == "Warning":
+            self.warnings += 1
+        else:
+            self.errors += 1
+        if self.print_errors:
+            if not self.last_command_printed:
+                if self.last_command:
+                    print "Encountered while running '" + self.last_command + "':"
+                else:
+                    print "Encountered during initial parsing:"
+                self.last_command_printed = True
+            print "  ", message
 
     def check_stdout(self):
         s = os.read(self.child.stdout.fileno(), 65536)
-        # print "Stdout received (", len(s), ")"
+
+        if self.comm_log_enabled:
+            if len(s) < 150:
+                print "Stdout received (", len(s), ")", s
+            else:
+                print "Stdout received (", len(s), ")", s[:70], " ... ", s[-70:]
+
         if s == "":
-            print "Unexpected EOF of stdout (hda-emu crashed?)"
-            self.errors += 1
+            self.add_error("Unexpected EOF of stdout (hda-emu crashed?)", "Fatal")
             return
         self.stdout_total += s
 
         q, _, self.stdout_total = self.stdout_total.rpartition('\n')
-        for s in q.splitlines():
+        l = q.splitlines()
+        self.stdout_lines += l
+        for s in l:
             if s.startswith("Error:"):
-                self.errors += 1
-                # print s
+                self.add_error(s, "Error")
             if s.startswith("Warning:"):
-                self.warnings += 1
-                # print s
+                self.add_error(s, "Warning")
 
     def check_stderr(self):
         s = os.read(self.child.stderr.fileno(), 65536)
-        # print "Stderr received (", len(s), ")"
+
+        if self.comm_log_enabled:
+            print "Stderr received (", len(s), ")", s
+
         if s == "":
-            print "Unexpected EOF of stderr (hda-emu crashed?)"
-            self.errors += 1
+            self.add_error("Unexpected EOF of stderr (hda-emu crashed?)", "Fatal")
             return False
-        if s == "> ":
-            return True
-        print "Unexpected stderr output: '" + prompt + "'"
-        self.errors += 1
-        return False
+        # consume readline echo
+        while len(s) > 0 and self.readline_echo.startswith(s[0]):
+            self.readline_echo = self.readline_echo[1:]
+            s = s[1:]
+
+        # detect prompts and half prompts
+        fullprompt = False
+        if self.has_partial_stderr_prompt:
+             if s.startswith(" "):
+                  fullprompt = True
+                  s = s[1:]
+             else:
+                  s = ">" + s
+             self.has_partial_stderr_prompt = False
+        if s.endswith("> "):
+            fullprompt = True
+            s = s[:-2]
+        elif s.endswith(">"):
+            self.has_partial_stderr_prompt = True
+            s = s[:-1]
+
+        if s != "":
+            self.add_error("Unexpected stderr output: '" + s + "'", "Error")
+        return fullprompt
+
 
     def run_command(self, command=None):
+        self.last_command_printed = False
+        self.has_partial_stderr_prompt = False
+
         if command:
+            self.readline_echo = command + '\n'
+            self.last_command = command
+            if self.comm_log_enabled:
+                print "Sending command: ", command
             self.child.stdin.write(command + '\n')
             self.child.stdin.flush()
+        else:
+            self.readline_echo = ""
 
         import select
         self.stdout_total = ""
+        self.stderr_total = ""
+        self.stdout_lines = []
         pipelist = [self.child.stdout, self.child.stderr]
+        timeout = 3
         while True:
-            readable, _, broken = select.select(pipelist, [], pipelist, 3)
+            readable, _, broken = select.select(pipelist, [], pipelist, timeout)
             for q in broken:
-                print "Broken pipe (hda-emu crashed?)"
-                self.errors += 1
-                return
-            if readable == []:
-                print "Timeout waiting for hda-emu"
-                self.errors += 1
-                return
+                self.add_error("Broken pipe (hda-emu crashed?)", "Fatal")
+                return None
             if self.child.stdout in readable:
                 self.check_stdout()
             if self.child.stderr in readable:
                 if self.check_stderr():
-                    return
+                    timeout = 0 # One more check round to help against races between stderr and stdout
+
+            if readable == [] and timeout > 0:
+                self.add_error("Timeout waiting for hda-emu", "Fatal")
+                return None
+            elif readable == [] and timeout == 0:
+                return self.stdout_lines
+
+    def find_jack_pins(self):
+        dump = self.run_command("dump")
+        pins = []
+
+        import re
+        pinregex = re.compile("^Node (0x\w\w+) \\[Pin Complex\\].*")
+        jackregex = re.compile("Pin Default.*\\[Jack\\]")
+        for s in dump:
+            g = pinregex.match(s)
+            if g:
+                currentpin = g.group(1)
+            elif jackregex.search(s):
+                pins.append(currentpin)
+        return pins
+
+    def run_jack_plug_test(self):
+        pins = self.find_jack_pins()
+        for pin in pins:
+            self.run_command("jack " + pin + " 1")
+        for pin in pins:
+            self.run_command("jack " + pin + " 0")
+
+    def run_set_kcontrol_test(self, c, values):
+        if len(c.values) < len(values):
+            values = values[:len(c.values)]
+        self.run_command("set " + c.numid + " " + " ".join(values))
+        c.add_info(self.run_command("get " + c.numid))
+        for a, b in zip(values, c.values):
+            if (int(a) != int(b)):
+                self.add_error("Tried to set " + c.name + " to " + str([int(x) for x in values]) + ", but got " + str(c.values) + " instead", "Error")
+
+    def run_kcontrol_test(self):
+        import re
+        minmax_regex = re.compile("MIN/MAX: (\d+)/(\d+),\s+VAL:(( \\[\d+\\])+)")
+        val_regex = re.compile(" \\[(\d+)\\]")
+
+        controls = self.run_command("list")
+        for control in controls:
+            c = ControlInfo(self, control)
+            c.add_info(self.run_command("get " + c.numid))
+            if "minval" in c.__dict__:
+                minval = c.minval
+                maxval = c.maxval
+                # Set to: 1) min, max 2) max, min 3) min, min 4) max, max
+                self.run_set_kcontrol_test(c, [minval, maxval])
+                self.run_set_kcontrol_test(c, [maxval, minval])
+                self.run_set_kcontrol_test(c, [minval, minval])
+                self.run_set_kcontrol_test(c, [maxval, maxval])
 
     def run_standard(self):
         self.start_process()
         self.run_command() # Initial parsing
         self.run_command("pm") # S3 test
+        self.run_jack_plug_test()
+        self.run_kcontrol_test()
         self.stop_process()
 
diff --git a/tester/summary.py b/tester/summary.py
new file mode 100755
index 0000000..cd66df7
--- /dev/null
+++ b/tester/summary.py
@@ -0,0 +1,52 @@
+#!/usr/bin/env python
+
+# hda-emu-tester - a test framework around hda-emu
+#
+# Written by David Henningsson <david.henningsson@canonical.com>
+#
+#    Copyright 2012 Canonical Ltd.
+#
+#    This program is free software: you can redistribute it and/or modify it 
+#    under the terms of the GNU General Public License version 3, as published 
+#    by the Free Software Foundation.
+#
+#    This program is distributed in the hope that it will be useful, but 
+#    WITHOUT ANY WARRANTY; without even the implied warranties of 
+#    MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR 
+#    PURPOSE.  See the GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along 
+#    with this program.  If not, see <http://www.gnu.org/licenses/>.
+
+def main():
+    import os
+    import os.path
+    import runner
+
+    os.chdir(os.path.dirname(os.path.realpath(__file__)))
+    directory = "../codecs/canonical/"
+    files = os.listdir(directory)
+
+    successes = 0
+    fails = 0
+    warnings = 0
+    errors = 0
+    for f in files:
+        try:
+            r = runner.HdaEmuRunner()
+            r.set_alsa_info_file(os.path.join(directory, f))
+            r.run_standard()
+            if r.errors > 0 or r.warnings > 0:
+                fails += 1
+                errors += r.errors
+                warnings += r.warnings
+            else:
+                successes += 1
+        except:
+            errors += 1
+            fails += 1
+
+    print "Test run of %d machines: %d failing with %d errors and %d warnings." % (successes + fails, fails, errors, warnings)
+
+if __name__ == "__main__":
+    main()
-- 
1.7.9.5
