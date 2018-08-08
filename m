From: Emmanuel Gil Peyrot <linkmauve@jabberfr.org>
Subject: [PATCH - hwmixvolume 4/9] hwmixvolume: use a with
	context to open files
Date: Wed,  8 Aug 2018 17:56:32 +0200
Message-ID: <20180808155637.5592-5-linkmauve@jabberfr.org>
References: <20180808155637.5592-1-linkmauve@jabberfr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180808155637.5592-1-linkmauve@jabberfr.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Emmanuel Gil Peyrot <linkmauve@jabberfr.org>, Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>

diff --git a/hwmixvolume/hwmixvolume b/hwmixvolume/hwmixvolume
index 267228c..e82f32d 100755
--- a/hwmixvolume/hwmixvolume
+++ b/hwmixvolume/hwmixvolume
@@ -138,26 +138,20 @@ class Stream:
             subdevice = info.index
         filename = "/proc/asound/card%d/pcm%dp/sub%d/status" % (card, device, subdevice)
         try:
-            f = open(filename, "r")
+            with open(filename, "r") as f:
+                for line in f.readlines():
+                    if line[:9] == "owner_pid":
+                        return int(line.split(':')[1].strip())
         except IOError:
             return None
-        try:
-            for line in f.readlines():
-                if line[:9] == "owner_pid":
-                    return int(line.split(':')[1].strip())
-        finally:
-            f.close()
         return None
 
     def get_pid_cmdline(self, pid):
         try:
-            f = open("/proc/%d/cmdline" % pid, "r")
+            with open("/proc/%d/cmdline" % pid, "r") as f:
+                cmdline = f.read()
         except IOError:
             return None
-        try:
-            cmdline = f.read()
-        finally:
-            f.close()
         return cmdline.replace('\x00', ' ').strip()
 
 class MixerWindow(Gtk.Window):
-- 
2.18.0
