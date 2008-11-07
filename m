From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 3/3] enable Intel G35 SDVO HDMI audio output
Date: Fri, 07 Nov 2008 14:23:41 +0800
Message-ID: <20081107062413.275249223@linux.intel.com>
References: <20081107062338.158523355@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xorg-bounces@lists.freedesktop.org>
Content-Disposition: inline; filename=a
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
To: Wang Zhenyu <zhenyu.z.wang@intel.com>
Cc: Ma Ling <ling.ma@intel.com>, alsa-devel@alsa-project.org, linux-gfx@linux.intel.com, xorg@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

From: Ma Ling <ling.ma@intel.com>

Set the SDVO_AUDIO_ENABLE bit to enable SDVO HDMI audio output of the
Intel G35 chipset.                                                                                                     

Signed-off-by: Ma Ling <ling.ma@intel.com>
Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 src/i830_sdvo.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- xf86-video-intel.orig/src/i830_sdvo.c
+++ xf86-video-intel/src/i830_sdvo.c
@@ -1019,7 +1019,7 @@ i830_sdvo_mode_set(xf86OutputPtr output,
     struct i830_sdvo_priv   *dev_priv = intel_output->dev_priv;
     xf86CrtcPtr	    crtc = output->crtc;
     I830CrtcPrivatePtr	    intel_crtc = crtc->driver_private;
-    uint32_t sdvox;
+    uint32_t sdvox = 0;
     int sdvo_pixel_multiply;
     struct i830_sdvo_in_out_map in_out;
     struct i830_sdvo_dtd input_dtd;
@@ -1041,8 +1041,10 @@ i830_sdvo_mode_set(xf86OutputPtr output,
 			&in_out, sizeof(in_out));
     status = i830_sdvo_read_response(output, NULL, 0);
 
-    if (dev_priv->is_hdmi)
+    if (dev_priv->is_hdmi) {
 	i830_sdvo_set_avi_infoframe(output, mode);
+	sdvox |= SDVO_AUDIO_ENABLE;
+    }
 
     i830_sdvo_get_dtd_from_mode(&input_dtd, mode);
 
@@ -1090,11 +1092,11 @@ i830_sdvo_mode_set(xf86OutputPtr output,
 
     /* Set the SDVO control regs. */
     if (IS_I965G(pI830)) {
-	sdvox = SDVO_BORDER_ENABLE |
+	sdvox |= SDVO_BORDER_ENABLE |
 		SDVO_VSYNC_ACTIVE_HIGH |
 		SDVO_HSYNC_ACTIVE_HIGH;
     } else {
-	sdvox = INREG(dev_priv->output_device);
+	sdvox |= INREG(dev_priv->output_device);
 	switch (dev_priv->output_device) {
 	case SDVOB:
 	    sdvox &= SDVOB_PRESERVE_MASK;

-- 
