From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 2/3] enable Intel G45 integrated HDMI audio
	output
Date: Fri, 07 Nov 2008 14:23:40 +0800
Message-ID: <20081107062411.695866509@linux.intel.com>
References: <20081107062338.158523355@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmsmga102.fm.intel.com (mga10.intel.com [192.55.52.92])
	by alsa0.perex.cz (Postfix) with ESMTP id EB3CC103894
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2008 07:24:13 +0100 (CET)
Content-Disposition: inline; filename=audio-enable.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wang Zhenyu <zhenyu.z.wang@intel.com>
Cc: alsa-devel@alsa-project.org, linux-gfx@linux.intel.com, xorg@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Enable audio output for the integrated HDMI of Intel G45 chipset
by introducing the SDVO_AUDIO_ENABLE bit.

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 src/i810_reg.h  |    1 +
 src/i830_hdmi.c |    4 ++++
 2 files changed, 5 insertions(+)

--- xf86-video-intel.orig/src/i810_reg.h
+++ xf86-video-intel/src/i810_reg.h
@@ -1296,6 +1296,7 @@ SOFTWARE OR THE USE OR OTHER DEALINGS IN
 /** Requird for HDMI operation */
 #define SDVO_NULL_PACKETS_DURING_VSYNC		(1 << 9)
 #define SDVO_BORDER_ENABLE			(1 << 7)
+#define SDVO_AUDIO_ENABLE			(1 << 6)
 /** New with 965, default is to be set */
 #define SDVO_VSYNC_ACTIVE_HIGH			(1 << 4)
 /** New with 965, default is to be set */
--- xf86-video-intel.orig/src/i830_hdmi.c
+++ xf86-video-intel/src/i830_hdmi.c
@@ -80,6 +80,10 @@ i830_hdmi_mode_set(xf86OutputPtr output,
 	SDVO_BORDER_ENABLE |
 	SDVO_VSYNC_ACTIVE_HIGH |
 	SDVO_HSYNC_ACTIVE_HIGH;
+
+    if (dev_priv->has_hdmi_sink)
+	    sdvox |= SDVO_AUDIO_ENABLE;
+
     if (intel_crtc->pipe == 1)
 	sdvox |= SDVO_PIPE_B_SELECT;
 

-- 
