From: Paulo Zanoni <przanoni@gmail.com>
Subject: [PATCH] drm/i915: switch disable_power_well default
	value to 1
Date: Wed,  3 Jul 2013 17:12:13 -0300
Message-ID: <1372882333-4011-1-git-send-email-przanoni@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: intel-gfx@lists.freedesktop.org
Cc: alsa-devel@alsa-project.org, Paulo Zanoni <paulo.r.zanoni@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Paulo Zanoni <paulo.r.zanoni@intel.com>

Now that the audio driver is using our power well API, everything
should be working correctly, so let's give it a try.

Signed-off-by: Paulo Zanoni <paulo.r.zanoni@intel.com>
---
 drivers/gpu/drm/i915/i915_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 33cb973..e6dc81c 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -123,10 +123,10 @@ module_param_named(preliminary_hw_support, i915_preliminary_hw_support, int, 060
 MODULE_PARM_DESC(preliminary_hw_support,
 		"Enable preliminary hardware support. (default: false)");
 
-int i915_disable_power_well __read_mostly = 0;
+int i915_disable_power_well __read_mostly = 1;
 module_param_named(disable_power_well, i915_disable_power_well, int, 0600);
 MODULE_PARM_DESC(disable_power_well,
-		 "Disable the power well when possible (default: false)");
+		 "Disable the power well when possible (default: true)");
 
 int i915_enable_ips __read_mostly = 1;
 module_param_named(enable_ips, i915_enable_ips, int, 0600);
-- 
1.8.1.2
