From: Emmanuel Gil Peyrot <linkmauve@jabberfr.org>
Subject: =?utf-8?q?=5BPATCH_-_hwmixvolume_v2_3/7=5D_hwmixvolu?=
	=?utf-8?q?me=3A_switch_to_GTK+=C2=A03=2E0_and_GLib=C2=A02=2E0?=
Date: Tue, 18 Sep 2018 15:42:33 +0200
Message-ID: <20180918134237.8489-4-linkmauve@jabberfr.org>
References: <20180918134237.8489-1-linkmauve@jabberfr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180918134237.8489-1-linkmauve@jabberfr.org>
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
Cc: linkmauve@linkmauve.fr, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>

This replaces VBox and HBox with Grid (using Gtk.Orientation), HScale
with Scale, creates labels with mnemonics, set hexpand and vexpand
properly, use the correct enum container classes, use the correct getter
for size request, and finally update to the correct GLib watch function.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>

diff --git a/hwmixvolume/hwmixvolume b/hwmixvolume/hwmixvolume
index 64d232c..8e0b6b8 100755
--- a/hwmixvolume/hwmixvolume
+++ b/hwmixvolume/hwmixvolume
@@ -60,18 +60,18 @@ class Stream:
         value = alsahcontrol.Value(self.element)
         value.read()
         values = value.get_tuple(TYPE_INTEGER, info.count)
-        self.label = Gtk.Label(self.get_label(info))
+        self.label = Gtk.Label.new(self.get_label(info))
         self.label.set_single_line_mode(True)
-        self.parent.scales_vbox.pack_start(self.label, expand=False)
+        self.parent.scales_vbox.add(self.label)
         for i in range(info.count):
             adj = Gtk.Adjustment(value=values[i],
                     lower=info.min, upper=info.max,
                     step_incr=1,
                     page_incr=(info.max-info.min+1)/8)
             adj.connect('value-changed', self.update_ctl_from_scale, i)
-            scale = Gtk.HScale(adj)
+            scale = Gtk.Scale(orientation=Gtk.Orientation.HORIZONTAL, adjustment=adj)
             scale.set_draw_value(False)
-            self.parent.scales_vbox.pack_start(scale, expand=False)
+            self.parent.scales_vbox.add(scale)
             self.scales.append(scale)
             self.adjustments.append(adj)
         self.parent.scales_vbox.show_all()
@@ -174,45 +174,48 @@ class MixerWindow(Gtk.Window):
         self.connect('destroy', lambda w: Gtk.main_quit())
         self.set_title("Hardware Mixer Volumes")
 
-        vbox = Gtk.VBox()
+        vbox = Gtk.Grid()
+        vbox.set_orientation(Gtk.Orientation.VERTICAL)
         self.add(vbox)
 
-        hbox = Gtk.HBox()
-        vbox.pack_start(hbox, expand=False)
+        hbox = Gtk.Grid()
+        vbox.add(hbox)
 
-        label = Gtk.Label("_Sound Card: ")
-        label.set_use_underline(True)
-        hbox.pack_start(label, expand=False)
+        label = Gtk.Label.new_with_mnemonic("_Sound Card: ")
+        hbox.add(label)
 
-        combo = Gtk.combo_box_new_text()
+        combo = Gtk.ComboBoxText()
+        combo.set_hexpand(True)
         for i in self.card_numbers:
             str = "%d: %s" % (i, alsacard.card_get_name(i))
             combo.append_text(str)
         if len(self.card_numbers) > 0:
             combo.set_active(0)
         combo.connect('changed', lambda c: self.change_card(self.card_numbers[combo.get_active()]))
-        hbox.pack_start(combo)
+        hbox.add(combo)
         label.set_mnemonic_widget(combo)
 
-        self.lock_check = Gtk.CheckButton(label="_Lock Channels")
+        self.lock_check = Gtk.CheckButton.new_with_mnemonic(label="_Lock Channels")
         self.lock_check.set_active(True)
-        vbox.pack_start(self.lock_check, expand=False)
+        vbox.add(self.lock_check)
 
         scrollwin = Gtk.ScrolledWindow()
-        scrollwin.set_policy(hscrollbar_policy=Gtk.POLICY_NEVER, vscrollbar_policy=Gtk.POLICY_AUTOMATIC)
-        scrollwin.set_shadow_type(Gtk.SHADOW_NONE)
-        vbox.pack_start(scrollwin)
+        scrollwin.set_policy(hscrollbar_policy=Gtk.PolicyType.NEVER, vscrollbar_policy=Gtk.PolicyType.AUTOMATIC)
+        scrollwin.set_shadow_type(Gtk.ShadowType.NONE)
+        scrollwin.set_vexpand(True)
+        vbox.add(scrollwin)
 
-        self.scales_vbox = Gtk.VBox()
-        scrollwin.add_with_viewport(self.scales_vbox)
+        self.scales_vbox = Gtk.Grid()
+        self.scales_vbox.set_orientation(Gtk.Orientation.VERTICAL)
+        scrollwin.add(self.scales_vbox)
 
         label = Gtk.Label()
         label.set_single_line_mode(True)
-        line_height = label.size_request()[1]
+        line_height = max(label.get_size_request().height, 0)
         label.destroy()
-        scale = Gtk.HScale()
+        scale = Gtk.Scale(orientation=Gtk.Orientation.HORIZONTAL)
         scale.set_draw_value(False)
-        line_height += scale.size_request()[1]
+        line_height += max(scale.get_size_request().height, 0)
         scale.destroy()
         # always have space for at least four sliders
         scrollwin.set_size_request(width=-1, height=line_height*4+4)
@@ -252,7 +255,7 @@ class MixerWindow(Gtk.Window):
             self.streams.append(stream)
 
         for fd,condition in self.hcontrol.poll_fds:
-            self.hctl_sources.append(GLib.io_add_watch(fd, condition, self.hctl_io_callback))
+            self.hctl_sources.append(GLib.io_add_watch(fd, 0, GLib.IOCondition(condition), self.hctl_io_callback))
 
         self.update_msg_label()
 
@@ -270,8 +273,9 @@ class MixerWindow(Gtk.Window):
             else:
                 msg = "This card does not have stream controls."
             if not has_msg:
-                self.msg_label = Gtk.Label(msg)
-                self.scales_vbox.pack_start(self.msg_label)
+                self.msg_label = Gtk.Label.new(msg)
+                self.msg_label.set_vexpand(True)
+                self.scales_vbox.add(self.msg_label)
                 self.scales_vbox.show_all()
             elif self.msg_label.get_text() != msg:
                 self.msg_label.set_text(msg)
@@ -284,8 +288,8 @@ class MixerWindow(Gtk.Window):
         except:
             # TODO: alsa error msg
             dlg = Gtk.MessageDialog(self,
-                    Gtk.DIALOG_MODAL | Gtk.DIALOG_DESTROY_WITH_PARENT,
-                    Gtk.MESSAGE_ERROR, Gtk.BUTTONS_OK,
+                    Gtk.DialogFlags.MODAL | Gtk.DialogFlags.DESTROY_WITH_PARENT,
+                    Gtk.MessageType.ERROR, Gtk.ButtonsType.OK,
                     "Cannot open sound card control device.")
             dlg.run()
             dlg.destroy()
-- 
2.19.0
