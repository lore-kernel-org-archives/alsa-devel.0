From: Emmanuel Gil Peyrot <linkmauve@jabberfr.org>
Subject: [PATCH - hwmixvolume 5/9] hwmixvolume: replace
	deprecated Gtk.HScale with Gtk.Scale
Date: Wed,  8 Aug 2018 17:56:33 +0200
Message-ID: <20180808155637.5592-6-linkmauve@jabberfr.org>
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
index e82f32d..af0c1e0 100755
--- a/hwmixvolume/hwmixvolume
+++ b/hwmixvolume/hwmixvolume
@@ -69,7 +69,7 @@ class Stream:
                     step_incr=1,
                     page_incr=(info.max-info.min+1)/8)
             adj.connect('value-changed', self.update_ctl_from_scale, i)
-            scale = Gtk.HScale(adj)
+            scale = Gtk.Scale(orientation=Gtk.Orientation.HORIZONTAL, adjustment=adj)
             scale.set_draw_value(False)
             self.parent.scales_vbox.add(scale)
             self.scales.append(scale)
@@ -207,7 +207,7 @@ class MixerWindow(Gtk.Window):
         label.set_single_line_mode(True)
         line_height = label.size_request().height
         label.destroy()
-        scale = Gtk.HScale()
+        scale = Gtk.Scale(orientation=Gtk.Orientation.HORIZONTAL)
         scale.set_draw_value(False)
         line_height += scale.size_request().height
         scale.destroy()
-- 
2.18.0
