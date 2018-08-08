From: Emmanuel Gil Peyrot <linkmauve@jabberfr.org>
Subject: [PATCH - hwmixvolume 6/9] hwmixvolume: fix deprecation
	warnings given by G_ENABLE_DIAGNOSTIC=1
Date: Wed,  8 Aug 2018 17:56:34 +0200
Message-ID: <20180808155637.5592-7-linkmauve@jabberfr.org>
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
index af0c1e0..ec2d05d 100755
--- a/hwmixvolume/hwmixvolume
+++ b/hwmixvolume/hwmixvolume
@@ -60,7 +60,7 @@ class Stream:
         value = alsahcontrol.Value(self.element)
         value.read()
         values = value.get_tuple(TYPE_INTEGER, info.count)
-        self.label = Gtk.Label(self.get_label(info))
+        self.label = Gtk.Label.new(self.get_label(info))
         self.label.set_single_line_mode(True)
         self.parent.scales_vbox.add(self.label)
         for i in range(info.count):
@@ -201,15 +201,15 @@ class MixerWindow(Gtk.Window):
 
         self.scales_vbox = Gtk.Grid()
         self.scales_vbox.set_orientation(Gtk.Orientation.VERTICAL)
-        scrollwin.add_with_viewport(self.scales_vbox)
+        scrollwin.add(self.scales_vbox)
 
         label = Gtk.Label()
         label.set_single_line_mode(True)
-        line_height = label.size_request().height
+        line_height = max(label.get_size_request().height, 0)
         label.destroy()
         scale = Gtk.Scale(orientation=Gtk.Orientation.HORIZONTAL)
         scale.set_draw_value(False)
-        line_height += scale.size_request().height
+        line_height += max(scale.get_size_request().height, 0)
         scale.destroy()
         # always have space for at least four sliders
         scrollwin.set_size_request(width=-1, height=line_height*4+4)
@@ -267,7 +267,7 @@ class MixerWindow(Gtk.Window):
             else:
                 msg = "This card does not have stream controls."
             if not has_msg:
-                self.msg_label = Gtk.Label(msg)
+                self.msg_label = Gtk.Label.new(msg)
                 self.msg_label.set_vexpand(True)
                 self.scales_vbox.add(self.msg_label)
                 self.scales_vbox.show_all()
-- 
2.18.0
