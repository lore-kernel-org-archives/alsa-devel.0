From: "Wu, Fengguang" <fengguang.wu@intel.com>
Subject: Re: Intel G45 8-Channel LPCM over HDMI
Date: Wed, 5 Nov 2008 12:46:25 +0800
Message-ID: <1225860387.293695.26980@de>
References: <8D978A35-5424-4BB5-980A-8F74EE529876@lambda-audiosystems.de>
	<s5hfxm9wap9.wl%tiwai@suse.de> <1225792266.708657.30943@de>
	<C804A129-7BFB-4F0B-BE64-CCAE549FB895@lambda-audiosystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 202492437A
	for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2008 05:46:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <C804A129-7BFB-4F0B-BE64-CCAE549FB895@lambda-audiosystems.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander Werner <alexander.werner@lambda-audiosystems.de>
Cc: "Ma, Ling" <ling.ma@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 04, 2008 at 10:36:35PM +0800, Alexander Werner wrote:
> > It's ready now!
> >
> > We did a lot of code refactor, testing and bug fixes in the last ten
> > days, and now it's ready for release :-)
> >
> > Note that X.org intel video patches are also necessary for HDMI  
> > sound output.
> >
> > However our 3 HDMI monitors have only 2-channel audio support, so
> > 8-channel LPCM audio may not work for now.
> >
> > Thank you,
> > Fengguang
> >
> That's great news! I'll test the patch as soon as my replacement board  
> arrives.

Thank you. The G45 HDMI audio can be enabled by the submitted ALSA
kernel patch together with this X.org intel driver patch:

Cheers,
Fengguang
---

[PATCH] enable HDMI audio output

Set the SDVO_AUDIO_ENABLE bit to enable audio output for
        - integrated HDMI (e.g. G45)
        - SDVO HDMI (e.g. G35)

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
Signed-off-by: Ma Ling <ling.ma@intel.com>
---
 src/i810_reg.h  |    1 +
 src/i830_hdmi.c |    1 +
 src/i830_sdvo.c |   10 ++++++----
 3 files changed, 8 insertions(+), 4 deletions(-)

--- xf86-video-intel.orig/src/i810_reg.h
+++ xf86-video-intel/src/i810_reg.h
@@ -1281,6 +1281,7 @@ SOFTWARE OR THE USE OR OTHER DEALINGS IN
 /** Requird for HDMI operation */
 #define SDVO_NULL_PACKETS_DURING_VSYNC		(1 << 9)
 #define SDVO_BORDER_ENABLE			(1 << 7)
+#define SDVO_AUDIO_ENABLE			(1 << 6)
 /** New with 965, default is to be set */
 #define SDVO_VSYNC_ACTIVE_HIGH			(1 << 4)
 /** New with 965, default is to be set */
--- xf86-video-intel.orig/src/i830_hdmi.c
+++ xf86-video-intel/src/i830_hdmi.c
@@ -75,6 +75,7 @@ i830_hdmi_mode_set(xf86OutputPtr output,
     uint32_t sdvox;
 
     sdvox = SDVO_ENCODING_HDMI |
+	SDVO_AUDIO_ENABLE |
 	SDVO_BORDER_ENABLE |
 	SDVO_VSYNC_ACTIVE_HIGH |
 	SDVO_HSYNC_ACTIVE_HIGH;
--- xf86-video-intel.orig/src/i830_sdvo.c
+++ xf86-video-intel/src/i830_sdvo.c
@@ -1017,7 +1017,7 @@ i830_sdvo_mode_set(xf86OutputPtr output,
     struct i830_sdvo_priv   *dev_priv = intel_output->dev_priv;
     xf86CrtcPtr	    crtc = output->crtc;
     I830CrtcPrivatePtr	    intel_crtc = crtc->driver_private;
-    uint32_t sdvox;
+    uint32_t sdvox = 0;
     int sdvo_pixel_multiply;
     struct i830_sdvo_in_out_map in_out;
     struct i830_sdvo_dtd input_dtd;
@@ -1039,8 +1039,10 @@ i830_sdvo_mode_set(xf86OutputPtr output,
 			&in_out, sizeof(in_out));
     status = i830_sdvo_read_response(output, NULL, 0);
 
-    if (dev_priv->is_hdmi)
+    if (dev_priv->is_hdmi){
 	i830_sdvo_set_avi_infoframe(output, mode);
+	sdvox |= SDVO_AUDIO_ENABLE;
+    }
 
     i830_sdvo_get_dtd_from_mode(&input_dtd, mode);
 
@@ -1088,11 +1090,11 @@ i830_sdvo_mode_set(xf86OutputPtr output,
 
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
