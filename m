From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 1/3] introduce i830_hdmi_priv.has_hdmi_sink
Date: Fri, 07 Nov 2008 14:23:39 +0800
Message-ID: <20081107062410.013520150@linux.intel.com>
References: <20081107062338.158523355@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xorg-bounces@lists.freedesktop.org>
Content-Disposition: inline; filename=has-hdmi-sink.patch
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
Cc: alsa-devel@alsa-project.org, linux-gfx@linux.intel.com, xorg@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

HDMI is compatible with DVI, and we've seen many boards that
use HDMI port for DVI output.

So Zhenyu proposed this flag: i830_hdmi_priv.has_hdmi_sink
to indicate the presence of HDMI capable monitors.

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 src/i830_hdmi.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- xf86-video-intel.orig/src/i830_hdmi.c
+++ xf86-video-intel/src/i830_hdmi.c
@@ -38,6 +38,8 @@ struct i830_hdmi_priv {
     uint32_t output_reg;
 
     uint32_t save_SDVO;
+
+    Bool has_hdmi_sink;
 };
 
 static int
@@ -142,6 +144,8 @@ i830_hdmi_detect(xf86OutputPtr output)
     xf86OutputStatus status;
     xf86MonPtr edid_mon;
 
+    dev_priv->has_hdmi_sink = FALSE;
+
     /* For G4X desktop chip, PEG_BAND_GAP_DATA 3:0 must first be written 0xd.
      * Failure to do so will result in spurious interrupts being
      * generated on the port when a cable is not attached.
@@ -180,6 +184,16 @@ i830_hdmi_detect(xf86OutputPtr output)
     edid_mon = xf86OutputGetEDID (output, intel_output->pDDCBus);
     if (!edid_mon || !DIGITAL(edid_mon->features.input_type))
 	status = XF86OutputStatusDisconnected;
+
+    if (xf86MonitorIsHDMI(edid_mon))
+	dev_priv->has_hdmi_sink = TRUE;
+
+    if (pI830->debug_modes)
+	xf86DrvMsg(pScrn->scrnIndex, X_INFO,
+			"%s monitor detected on HDMI-%d\n",
+			dev_priv->has_hdmi_sink ? "HDMI" : "DVI",
+			(dev_priv->output_reg == SDVOB) ? 1 : 2);
+
     xfree(edid_mon);
     return status;
 }
@@ -232,6 +246,7 @@ i830_hdmi_init(ScrnInfoPtr pScrn, int ou
 
     dev_priv = (struct i830_hdmi_priv *)(intel_output + 1);
     dev_priv->output_reg = output_reg;
+    dev_priv->has_hdmi_sink = FALSE;
 
     intel_output->dev_priv = dev_priv;
     intel_output->type = I830_OUTPUT_HDMI;

-- 
