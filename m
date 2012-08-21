From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 4/5] hda-emu: Add playback/capture test to test
	suite
Date: Tue, 21 Aug 2012 10:54:02 +0200
Message-ID: <1345539243-8147-5-git-send-email-david.henningsson@canonical.com>
References: <1345539243-8147-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id BAE9B265EE9
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 10:54:11 +0200 (CEST)
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

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 tester/runner.py |   25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tester/runner.py b/tester/runner.py
index dc9f6fd..b585ad3 100644
--- a/tester/runner.py
+++ b/tester/runner.py
@@ -18,6 +18,7 @@
 
 import subprocess
 import os
+import re
 
 class ControlInfo():
     def __init__(self, runner, list_info):
@@ -27,7 +28,6 @@ class ControlInfo():
         self.name = carr[2]
 
     def add_info(self, get_info):
-        import re
         minmax_regex = re.compile("MIN/MAX: (\d+)/(\d+),\s+VAL:(( \\[\d+\\])+)")
         val_regex = re.compile(" \\[(\d+)\\]")
 
@@ -189,7 +189,6 @@ class HdaEmuRunner():
         dump = self.run_command("dump")
         pins = []
 
-        import re
         pinregex = re.compile("^Node (0x\w\w+) \\[Pin Complex\\].*")
         jackregex = re.compile("Pin Default.*\\[Jack\\]")
         for s in dump:
@@ -217,7 +216,6 @@ class HdaEmuRunner():
                 self.add_error("Tried to set " + c.name + " to " + str([int(x) for x in values]) + ", but got " + str(c.values) + " instead", "Error")
 
     def run_kcontrol_test(self):
-        import re
         minmax_regex = re.compile("MIN/MAX: (\d+)/(\d+),\s+VAL:(( \\[\d+\\])+)")
         val_regex = re.compile(" \\[(\d+)\\]")
 
@@ -234,11 +232,32 @@ class HdaEmuRunner():
                 self.run_set_kcontrol_test(c, [minval, minval])
                 self.run_set_kcontrol_test(c, [maxval, maxval])
 
+    def run_pcm_test(self):
+        pcm_regex = re.compile("Info: (\d+):.*play=(\d+), capt=(\d+)")
+        pcm_lines = self.run_command("PCM")
+        playback_test = False
+        for pcm_line in pcm_lines:
+            r = pcm_regex.match(pcm_line)
+            if r is None:
+                self.add_error("Invalid pcm response: " + pcm_line, "Error");
+                continue
+            pcm_devid = r.group(1)
+            play_count = r.group(2)
+            rec_count = r.group(3)
+            if play_count > 0:
+                playback_test = True
+                self.run_command("PCM " + pcm_devid + " playback")
+            if rec_count > 0:
+                self.run_command("PCM " + pcm_devid + " capture")
+        if not playback_test:
+            self.add_error("No playback PCM devices", "Error")
+
     def run_standard(self):
         self.start_process()
         self.run_command() # Initial parsing
         self.run_command("pm") # S3 test
         self.run_jack_plug_test()
         self.run_kcontrol_test()
+        self.run_pcm_test()
         self.stop_process()
 
-- 
1.7.9.5
