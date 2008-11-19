From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: [alsa-devel] [RFC][PATCH] ELD routines and proc interface
Date: Wed, 19 Nov 2008 17:39:40 +0800
Message-ID: <20081119093940.GA17245@localhost>
References: <1226542918.126598.6912@de> <20081119071135.GA17733@csy.ca>
	<20081119071757.GA32376@localhost> <20081119075545.GA19833@csy.ca>
	<20081119080800.GA522@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Return-path: <xorg-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20081119080800.GA522@localhost>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
To: Shane W <shane-alsa@csy.ca>
Cc: "Ma, Ling" <ling.ma@intel.com>, "Fu, Michael" <michael.fu@intel.com>, alsa-devel <alsa-devel@alsa-project.org>, intel-gfx@lists.freedesktop.org, xorg@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2008 at 04:08:00PM +0800, Wu Fengguang wrote:
> On Tue, Nov 18, 2008 at 11:55:45PM -0800, Shane W wrote:
> > On Wed, Nov 19, 2008 at 03:17:57PM +0800, Wu Fengguang wrote:
> > > On Tue, Nov 18, 2008 at 11:11:35PM -0800, Shane W wrote:
> > > > On Thu, Nov 13, 2008 at 10:21:53AM +0800, Wu Fengguang wrote:
> > > > > Create hda_eld.c for ELD routines and proc interface.
> > > 
> > > > Just testing this and your multichannel HDMI code over here
> > > > but it doesn't seem to get ELD data for my setup.  Intel
> > > > g45-id board with an Yamaha RX-v1800 receiver which is HDMI
> > > > 1.3 capable.
> > > 
> > > Do you run the latest xorg intel driver?  Also dmesg should tell us
> > > something if anything goes wrong with ELD retrieving/parsing.
> > 
> > Yes though Xorg wasn't running when I was doing the audio
> > tests.  Pure console at that point but I fired up Xorg
> > which is latest git as of today but still no ELD
> 
> Yeah sorry I missed one note. The xorg git tree only contains the
> audio output enabling patches, but not yet ELD transferring patches.
> (the ELD data flow is monitor => video driver => audio driver)
> I called for the Xorg ELD enabling patches from Ma Ling just after
> replying to your email. He should send the patches soon.

Hi Shane,

I managed to update the last working Xorg ELD patches to the latest
git tree, and they compile flawlessly. The attached 2 patches are for 
xf86-video-intel/ and xserver/ respectively.

Thanks,
Fengguang

--ikeVEW9yuYc//A+q
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="xorg-eld-intel.patch"

---
 src/i810_reg.h   |   13 ++-
 src/i830.h       |    3 
 src/i830_hdmi.c  |   64 +++++++++++++++
 src/i830_modes.c |  189 +++++++++++++++++++++++++++++++++++++++++++++
 src/i830_sdvo.c  |   49 ++++++++++-
 src/i830_sdvo.h  |    2 
 6 files changed, 313 insertions(+), 7 deletions(-)

--- xf86-video-intel.orig/src/i810_reg.h
+++ xf86-video-intel/src/i810_reg.h
@@ -1240,6 +1240,7 @@ SOFTWARE OR THE USE OR OTHER DEALINGS IN
 # define HDMID_HOTPLUG_INT_EN			(1 << 27)
 # define SDVOB_HOTPLUG_INT_EN			(1 << 26)
 # define SDVOC_HOTPLUG_INT_EN			(1 << 25)
+# define AUDIO_HOTPLUG_INT_EN			(1 << 24)
 # define TV_HOTPLUG_INT_EN			(1 << 18)
 # define CRT_HOTPLUG_INT_EN			(1 << 9)
 # define CRT_HOTPLUG_ACTIVATION_PERIOD_32	(0 << 8)
@@ -1271,7 +1272,17 @@ SOFTWARE OR THE USE OR OTHER DEALINGS IN
 # define CRT_HOTPLUG_MONITOR_NONE		(0 << 8)
 # define SDVOC_HOTPLUG_INT_STATUS		(1 << 7)
 # define SDVOB_HOTPLUG_INT_STATUS		(1 << 6)
-
+#define AUDIO_VENDOR_DEVICE_ID  0x62020
+#define INTEL_AUDIO_DEVCL        0x808629FB
+#define INTEL_AUDIO_DEVBLC       0x80862801
+#define INTEL_AUDIO_DEVCTG       0x80862802
+
+#define AUDIO_CNTL_STATUS       0x620B4
+#define AUDIO_ELD_VALID_DEVCL_DEVBLC    (1 << 13)
+#define AUDIO_ELD_VALID_DEVCTG  (1 << 14)
+#define AUDIO_ELD_ADDR          (0xf << 5)
+#define AUDIO_ELD_ACK           (1 << 4)
+#define AUDIO_HDMIW_HDMIEDID    0x6210C
 #define SDVOB			0x61140
 #define SDVOC			0x61160
 #define SDVO_ENABLE				(1 << 31)
--- xf86-video-intel.orig/src/i830.h
+++ xf86-video-intel/src/i830.h
@@ -887,7 +887,8 @@ Bool I830UnbindAGPMemory(ScrnInfoPtr pSc
 
 /* i830_modes.c */
 DisplayModePtr i830_ddc_get_modes(xf86OutputPtr output);
-
+int i830_handle_cea_like_data(xf86OutputPtr output,Uchar **buf);
+unsigned long i830_extract_max_tmds_clock(xf86OutputPtr output);
 /* i830_tv.c */
 void i830_tv_init(ScrnInfoPtr pScrn);
 
--- xf86-video-intel.orig/src/i830_hdmi.c
+++ xf86-video-intel/src/i830_hdmi.c
@@ -45,12 +45,17 @@ struct i830_hdmi_priv {
 static int
 i830_hdmi_mode_valid(xf86OutputPtr output, DisplayModePtr mode)
 {
+    unsigned long tmds_max_clock = i830_extract_max_tmds_clock(output);
+
     if (mode->Clock > 165000)
 	return MODE_CLOCK_HIGH;
 
     if (mode->Clock < 20000)
 	return MODE_CLOCK_LOW;
 
+    if( 0 < tmds_max_clock && tmds_max_clock < mode->Clock) 
+	return MODE_CLOCK_HIGH;
+
     return MODE_OK;
 }
 
@@ -64,6 +69,60 @@ i830_hdmi_mode_fixup(xf86OutputPtr outpu
     return TRUE;
 }
 
+static uint32_t i830_hdmi_get_eld_flag(I830Ptr pI830 )
+{ 
+    uint32_t ar ;
+
+    ar = INREG(AUDIO_VENDOR_DEVICE_ID);
+
+    if (INTEL_AUDIO_DEVBLC == ar || INTEL_AUDIO_DEVCL == ar) {
+        ar = AUDIO_ELD_VALID_DEVCL_DEVBLC;
+    } else {
+	ar =  AUDIO_ELD_VALID_DEVCTG;
+    }
+
+    return ar;
+
+}
+
+static void i830_hdmi_set_edid_like_data(xf86OutputPtr output)
+{
+    I830Ptr pI830 = I830PTR(output->scrn);
+    uint32_t *eld;
+    int eld_len;
+    uint32_t ar;
+    uint32_t flag;
+    int i;
+
+
+    eld = NULL;
+    eld_len = i830_extract_cea_like_data(output, (Uchar **)&eld);
+    eld_len = eld_len / sizeof(uint32_t);
+
+    if (NULL == eld) {
+        xf86DrvMsg(output->scrn->scrnIndex, X_ERROR,
+	       "HDMI failed to get ELD \n");
+        goto end;
+    } 
+
+    flag = i830_hdmi_get_eld_flag(pI830);
+
+    ar = INREG(AUDIO_CNTL_STATUS);
+    ar &= ~(flag | AUDIO_ELD_ADDR);
+    OUTREG(AUDIO_CNTL_STATUS, ar);
+
+    for (i = 0; i < eld_len; i = i + 1)
+        OUTREG(AUDIO_HDMIW_HDMIEDID, eld[i]);
+
+    ar = INREG(AUDIO_CNTL_STATUS);
+    ar |= flag ;
+    OUTREG(AUDIO_CNTL_STATUS, ar);
+
+end:
+    if (NULL != eld )
+        xfree(eld);
+}
+
 static void
 i830_hdmi_mode_set(xf86OutputPtr output, DisplayModePtr mode,
 		   DisplayModePtr adjusted_mode)
@@ -76,6 +135,8 @@ i830_hdmi_mode_set(xf86OutputPtr output,
     I830CrtcPrivatePtr intel_crtc = crtc->driver_private;
     uint32_t sdvox;
 
+    i830_hdmi_set_edid_like_data(output);
+
     sdvox = SDVO_ENCODING_HDMI |
 	SDVO_BORDER_ENABLE |
 	SDVO_VSYNC_ACTIVE_HIGH |
@@ -165,7 +226,8 @@ i830_hdmi_detect(xf86OutputPtr output)
 	   temp |
 	   HDMIB_HOTPLUG_INT_EN |
 	   HDMIC_HOTPLUG_INT_EN |
-	   HDMID_HOTPLUG_INT_EN);
+	   HDMID_HOTPLUG_INT_EN |
+	   AUDIO_HOTPLUG_INT_EN);
 
     POSTING_READ(PORT_HOTPLUG_EN);
 
--- xf86-video-intel.orig/src/i830_modes.c
+++ xf86-video-intel/src/i830_modes.c
@@ -54,6 +54,195 @@
 #include "xf86Modes.h"
 #include <randrstr.h>
 
+#define CEA_LIKE_DATA_MAX_LEN  48
+struct  eld_header{
+	Uchar rsv_0		:3;
+	Uchar ELD_ver		:5;
+	Uchar rsv_1;
+	Uchar baseline_ELD_len;
+	Uchar rsv_3;
+}__attribute__ ((packed));
+
+struct eld_data_fixed_fields {
+	struct eld_header header;
+
+	/* byte 1 */
+	Uchar MNL		:5;
+	Uchar CEA_EDID_ver	:3;
+
+	/* byte 2 */
+	Uchar HDCP		:1;
+	Uchar S_AI		:1;
+	Uchar Conn_Type		:2;
+	Uchar SAD_Count		:4;
+
+	/* byte 3 */
+	Uchar Aud_Synch_Delay;
+
+	/* byte 4 */
+	Uchar FLR		:1;
+	Uchar LFE		:1;
+	Uchar FC 		:1;
+	Uchar RLR		:1;
+	Uchar RC 		:1;
+	Uchar FLRC		:1;
+	Uchar RLRC		:1;
+	Uchar rsv_7		:1;
+
+	/* byte 5-12 */
+	Uchar Port_ID[8]; /* little endian */
+
+	/* byte 13-14 */
+	Uchar Manufacture_Name[2];
+	/* byte 15-16 */
+	Uchar Product_Code[2];
+
+	/* byte 17 len MNL */
+	char Monitor_Name[0];
+} __attribute__ ((packed));
+
+unsigned long i830_extract_max_tmds_clock(xf86OutputPtr output)
+{
+    struct cea_data_blk *blk ;
+    struct extension_type type;
+
+    unsigned long ret  = 0;
+    
+    if (0 == (EDID_CEA_EXTENSION_FLG & output->MonInfo->flags)) {
+        goto end;
+    }
+
+    type.body_type = CEA_EXT;
+    type.data_type = CEA_VENDOR_BLK;
+    blk = (struct cea_data_blk *)xf86DDCGetCEA( output->MonInfo,&type);
+
+    if (NULL != blk) {
+        if (VENDOR_OFFSET(struct cea_vendor_blk, hdmi.Max_TMDS_Clock) <= 
+	    blk->len) {
+		ret = blk->u.vendor.hdmi.Max_TMDS_Clock * HDMI_MAX_TMDS_UNIT; 
+        }
+    }
+end:
+    return ret;
+}
+
+int i830_extract_cea_like_data(xf86OutputPtr output, Uchar **buf)
+{
+    struct eld_data_fixed_fields *eld;
+    struct cea_data_blk *blk ;
+    struct cea_audio_blk *audio;
+    struct extension_type type;
+    Uchar  *name ;
+    int i;
+    int eld_len;
+    int SAD_Count;
+
+
+    if (0 == (EDID_CEA_EXTENSION_FLG & output->MonInfo->flags)) {
+        eld = NULL;
+	eld_len = 0;
+        goto end;
+    }
+   
+    name = NULL;  
+    audio = NULL;
+
+    eld_len = sizeof(struct eld_data_fixed_fields);    
+
+    type.body_type = CEA_EXT;
+    type.data_type = CEA_AUDIO_BLK;
+    blk = (struct cea_data_blk *)xf86DDCGetCEA(output->MonInfo, &type);
+  
+    SAD_Count = 0;
+    if (NULL != blk) {
+        audio = (struct cea_audio_blk *)&blk->u.audio;
+        eld_len = eld_len + blk->len;
+        SAD_Count = blk->len/3;  // SAD_Count is multiple of 3 bytes
+    }
+
+    for (i=0; i<output->MonInfo->det_mon_num; i++) {
+	if (0xfc == output->MonInfo->det_mon[i].type){
+            eld_len = eld_len + EDID_DET_NAME_LEN ; 
+            name = output->MonInfo->det_mon[i].section.name;
+            break;
+        } 
+    }
+    /* The item need to be multiple of 8 because  sdvo write 8 bytes one time */ 
+    eld_len = (eld_len + 7)/8;
+    eld_len = eld_len * 8;  
+    eld = (struct eld_data_fixed_fields *)xcalloc(1, eld_len);
+
+    if (NULL == eld) {
+        eld_len = 0;
+        goto end;
+    }
+
+    memset((Uchar *)eld, 0, eld_len);
+    /* The item need to be multiple of 4 */ 
+    eld->header.baseline_ELD_len =  (eld_len - sizeof(struct eld_header))/4;
+    eld->header.ELD_ver = CEA_EXT;
+    eld->HDCP = 0;
+    eld->CEA_EDID_ver = output->MonInfo->ver.version;
+    if (NULL != name) {
+        eld->MNL = EDID_DET_NAME_LEN; 
+    }
+    eld->SAD_Count = SAD_Count;
+    type.body_type = CEA_EXT;
+    type.data_type = CEA_VENDOR_BLK;
+    blk = (struct cea_data_blk *)xf86DDCGetCEA( output->MonInfo,&type);
+
+    eld->Conn_Type = 0; 
+    /* Currently do not consider about Interlaced mode.
+     * Because the member hdmi of vendor data block is extension part, 
+     * it's length is flexible, we need to guarantee the boundary 
+     * prior to fetching data.
+     */
+
+    if (NULL != blk) {
+        if (VENDOR_OFFSET(struct cea_vendor_blk, hdmi.Support_flags) <= 
+	    blk->len)
+            eld->S_AI = VENDOR_SUPPORT_AI(blk->u.vendor.hdmi.Support_flags);
+
+        if (VENDOR_OFFSET(struct cea_vendor_blk, hdmi.Audio_Latency) <= 
+	    blk->len) {
+            if (VENDOR_LATENCY_PRESENT(blk->u.vendor.hdmi.Latency_Present)) {
+                if(blk->u.vendor.hdmi.Audio_Latency)
+                    eld->Aud_Synch_Delay = blk->u.vendor.hdmi.Audio_Latency - 1;
+	    }
+        }
+    }
+
+    type.body_type = CEA_EXT;
+    type.data_type = CEA_SPEAKER_ALLOC_BLK;
+    blk = (struct cea_data_blk *)xf86DDCGetCEA(output->MonInfo,&type);
+    if (NULL != blk) {
+        eld->FLR = blk->u.speaker.FLR;
+        eld->LFE = blk->u.speaker.LFE;
+        eld->FC = blk->u.speaker.FC;
+        eld->RLR = blk->u.speaker.RLR;
+        eld->RC = blk->u.speaker.RC;
+        eld->FLRC = blk->u.speaker.FLRC;
+        eld->RLRC = blk->u.speaker.RLRC;
+    }
+        
+    //eld->Port_ID /*TBD XXX*/
+    eld->Manufacture_Name[0] = output->MonInfo->vendor.name[0];
+    eld->Manufacture_Name[1] = output->MonInfo->vendor.name[1];
+    eld->Product_Code[0] = output->MonInfo->vendor.prod_id & 0xff;
+    eld->Product_Code[1] = output->MonInfo->vendor.prod_id >> 8;
+
+    if (NULL != name) {
+        memcpy(eld->Monitor_Name, name, EDID_DET_NAME_LEN);
+    }
+    if (NULL != audio) {
+        memcpy(eld->Monitor_Name + EDID_DET_NAME_LEN, audio,SAD_Count * 3);
+    }
+
+end:
+    *buf = eld;
+    return eld_len <= CEA_LIKE_DATA_MAX_LEN ? eld_len:CEA_LIKE_DATA_MAX_LEN ;
+}
+
 DisplayModePtr
 i830_ddc_get_modes (xf86OutputPtr output)
 {
--- xf86-video-intel.orig/src/i830_sdvo.c
+++ xf86-video-intel/src/i830_sdvo.c
@@ -36,6 +36,7 @@ USE OR OTHER DEALINGS IN THE SOFTWARE.
  * this code doesn't deal with either ganged mode or more than one SDVO output.
  */
 
+
 #ifdef HAVE_CONFIG_H
 #include "config.h"
 #endif
@@ -889,10 +890,13 @@ struct dip_infoframe {
     union {
 	struct {
 	    /* Packet Byte #1 */
-	    uint8_t S:2;
-	    uint8_t B:2;
+	    uint8_t S0: 1;
+	    uint8_t S1:1;
+	    uint8_t B0:1;
+	    uint8_t B1:1;
 	    uint8_t A:1;
-	    uint8_t Y:2;
+	    uint8_t Y0:1;
+	    uint8_t Y1:1;
 	    uint8_t rsvd1:1;
 	    /* Packet Byte #2 */
 	    uint8_t R:4;
@@ -954,6 +958,36 @@ static void i830_sdvo_set_avi_infoframe(
 			SDVO_HBUF_TX_VSYNC);
 }
 
+static void i830_sdvo_set_edid_like_data(xf86OutputPtr output)
+{
+    Uchar *eld;
+    int eld_len;
+    Uchar av_split;
+    Uchar eld_pre;
+
+    eld = NULL;
+    eld_len = i830_extract_cea_like_data(output, &eld);
+    if (NULL == eld)
+        goto end;
+
+    av_split = 7;
+
+    i830_sdvo_write_cmd(output, SDVO_CMD_SET_HBUF_AV_SPLIT,
+			    &av_split, sizeof(Uchar));
+    av_split = 0;
+    i830_sdvo_set_hdmi_buf(output, av_split, eld, eld_len,
+		               SDVO_HBUF_TX_DISABLED);
+
+    eld_pre = SDVO_ELD_PRESENT | SDVO_ELD_VALID;
+
+    i830_sdvo_write_cmd(output, SDVO_CMD_SET_AUDIO_STAT,
+                            &eld_pre, sizeof(Uchar));
+end:
+    if (NULL != eld)
+        xfree(eld);
+
+}
+
 static Bool
 i830_sdvo_mode_fixup(xf86OutputPtr output, DisplayModePtr mode,
 		     DisplayModePtr adjusted_mode)
@@ -1025,6 +1059,8 @@ i830_sdvo_mode_set(xf86OutputPtr output,
     struct i830_sdvo_dtd input_dtd;
     uint8_t status;
 
+    sdvox = 0;
+
     if (!mode)
 	return;
 
@@ -1043,6 +1079,7 @@ i830_sdvo_mode_set(xf86OutputPtr output,
 
     if (dev_priv->is_hdmi) {
 	i830_sdvo_set_avi_infoframe(output, mode);
+	i830_sdvo_set_edid_like_data(output);
 	sdvox |= SDVO_AUDIO_ENABLE;
     }
 
@@ -1118,7 +1155,7 @@ i830_sdvo_mode_set(xf86OutputPtr output,
     } else {
 	sdvox |= (sdvo_pixel_multiply - 1) << SDVO_PORT_MULTIPLY_SHIFT;
     }
-
+    sdvox = sdvox ;
     i830_sdvo_write_sdvox(output, sdvox);
 }
 
@@ -1264,6 +1301,7 @@ i830_sdvo_mode_valid(xf86OutputPtr outpu
 {
     I830OutputPrivatePtr    intel_output = output->driver_private;
     struct i830_sdvo_priv   *dev_priv = intel_output->dev_priv;
+    unsigned long tmds_max_clock =  i830_extract_max_tmds_clock(output);
 
     if (pMode->Flags & V_DBLSCAN)
 	return MODE_NO_DBLESCAN;
@@ -1274,6 +1312,9 @@ i830_sdvo_mode_valid(xf86OutputPtr outpu
     if (dev_priv->pixel_clock_max < pMode->Clock)
 	return MODE_CLOCK_HIGH;
 
+    if(0 != dev_priv->is_hdmi && 0 < tmds_max_clock && tmds_max_clock < pMode->Clock) 
+	return MODE_CLOCK_HIGH;
+
     return MODE_OK;
 }
 
--- xf86-video-intel.orig/src/i830_sdvo.h
+++ xf86-video-intel/src/i830_sdvo.h
@@ -24,6 +24,8 @@
  *    Eric Anholt <eric@anholt.net>
  *
  */
+#define SDVO_ELD_PRESENT (1 << 0)
+#define SDVO_ELD_VALID (1 << 1)
 
 Bool
 i830_sdvo_init(ScrnInfoPtr pScrn, int output_device);

--ikeVEW9yuYc//A+q
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="xorg-eld-xserver.patch"

---
 hw/xfree86/ddc/edid.h            |  101 ++++++++++++++++++++++++-
 hw/xfree86/ddc/interpret_edid.c  |  102 ++++++++++++++++++++++++-
 hw/xfree86/ddc/print_edid.c      |    9 +-
 hw/xfree86/ddc/xf86DDC.c         |   41 +++++++---
 hw/xfree86/ddc/xf86DDC.h         |    4 +
 hw/xfree86/modes/xf86Crtc.c      |    2 
 hw/xfree86/modes/xf86EdidModes.c |  114 +++++++++++++++++++++++++++--
 7 files changed, 342 insertions(+), 31 deletions(-)

--- xserver.orig/hw/xfree86/ddc/edid.h
+++ xserver/hw/xfree86/ddc/edid.h
@@ -20,7 +20,7 @@
 
 #define STD_TIMINGS 8
 #define DET_TIMINGS 4
-
+#define EDID_DET_NAME_LEN 13
 #ifdef _PARSE_EDID_
 
 /* header: 0x00 0xFF 0xFF 0xFF 0xFF 0xFF 0xFF 0x00  */
@@ -519,9 +519,9 @@ struct detailed_monitor_section {
   int type;
   union {
     struct detailed_timings d_timings;	/* 56 */
-    Uchar serial[13];
-    Uchar ascii_data[13];
-    Uchar name[13];
+    Uchar serial[EDID_DET_NAME_LEN];
+    Uchar ascii_data[EDID_DET_NAME_LEN];
+    Uchar name[EDID_DET_NAME_LEN];
     struct monitor_ranges ranges;	/* 56 */
     struct std_timings std_t[5];	/* 80 */
     struct whitePoints wp[2];		/* 32 */
@@ -533,6 +533,96 @@ struct detailed_monitor_section {
 
 /* flags */
 #define EDID_COMPLETE_RAWDATA	0x1
+#define EDID_CEA_EXTENSION_FLG		0x2
+
+#define CEA_EXT  2
+#define CEA_EXT_MIN_DATA_OFFSET 4
+#define CEA_EXT_MAX_DATA_OFFSET 127
+
+#define IEEE_ID_HDMI    0x000C03
+#define CEA_AUDIO_BLK   1
+#define CEA_VIDEO_BLK   2
+#define CEA_VENDOR_BLK  3
+#define CEA_SPEAKER_ALLOC_BLK 4
+#define CEA_VESA_DTC_BLK 5
+
+#define VENDOR_OFFSET(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
+
+#define VENDOR_SUPPORT_AI(x) (x >> 7)
+#define VENDOR_SUPPORT_DC_48bit(x) ( ( x >> 6) & 0x01)
+#define VENDOR_SUPPORT_DC_36bit(x) ( ( x >> 5) & 0x01)
+#define VENDOR_SUPPORT_DC_30bit(x) ( ( x >> 4) & 0x01)
+#define VENDOR_SUPPORT_DC_Y444(x)  ( ( x >> 3) & 0x01)
+#define VENDOR_LATENCY_PRESENT(x)  ( ( x >> 7) )
+#define VENDOR_LATENCY_PRESENT_I(x)  ( ( x >> 6) & 0x01)
+#define HDMI_MAX_TMDS_UNIT   (5000)
+struct cea_video_blk {
+  Uchar video_code; /* point to raw EDID data block */
+}__attribute__ ((packed));
+
+
+struct cea_audio_blk {
+    Uchar descs[3];
+}__attribute__ ((packed));
+struct hdmi {
+  Uchar  Support_flags;
+  Uchar  Max_TMDS_Clock;
+  Uchar  Latency_Present;
+  Uchar  Video_Latency;
+  Uchar  Audio_Latency;
+  Uchar  Interlaced_Video_Latency;
+  Uchar  Interlaced_Audio_Latency;
+
+}__attribute__ ((packed));
+struct cea_vendor_blk {
+  unsigned char ieee_id[3];
+  Uchar  Port_Addr[2];
+  struct hdmi hdmi;
+}__attribute__ ((packed));
+
+struct cea_speaker_blk 
+{
+  Uchar FLR:1;
+  Uchar LFE:1;
+  Uchar FC:1;
+  Uchar RLR:1;
+  Uchar RC:1;
+  Uchar FLRC:1;
+  Uchar RLRC:1;
+  Uchar FLRW:1;
+  Uchar FLRH:1;
+  Uchar TC:1;
+  Uchar FCH:1;
+  Uchar Resv:5;
+  Uchar Resv_Byte;
+}__attribute__ ((packed));
+
+struct cea_data_blk {
+  Uchar len:5;
+  Uchar tag:3;
+union{
+    struct cea_video_blk video;
+    struct cea_audio_blk audio;
+    struct cea_vendor_blk vendor;
+    struct cea_speaker_blk speaker;
+  }u;
+}__attribute__ ((packed));
+struct cea_ext {
+  Uchar tag;
+  Uchar rev;
+  Uchar dt_offset;
+  Uchar flags;
+  struct cea_data_blk data_collection;
+}__attribute__ ((packed));
+struct extension_block {
+  union{
+        struct cea_ext cea;
+  }u;
+}__attribute__ ((packed));
+struct extension_type {
+        int body_type;
+        int data_type;
+}__attribute__ ((packed));
 
 typedef struct {
   int scrnIndex;
@@ -541,7 +631,8 @@ typedef struct {
   struct disp_features features;
   struct established_timings timings1;
   struct std_timings timings2[8];
-  struct detailed_monitor_section det_mon[4];
+  struct detailed_monitor_section det_mon[10];
+  int det_mon_num;
   unsigned long flags;
   int no_sections;
   Uchar *rawData;
--- xserver.orig/hw/xfree86/ddc/interpret_edid.c
+++ xserver/hw/xfree86/ddc/interpret_edid.c
@@ -42,7 +42,7 @@ static void get_established_timing_secti
 static void get_std_timing_section(Uchar*, struct std_timings *,
 				   struct edid_version *);
 static void get_dt_md_section(Uchar *, struct edid_version *,
-			      struct detailed_monitor_section *det_mon);
+			      struct detailed_monitor_section *det_mon,int det_mon_num);
 static void copy_string(Uchar *, Uchar *);
 static void get_dst_timing_section(Uchar *, struct std_timings *,
 				   struct edid_version *);
@@ -64,10 +64,10 @@ handle_edid_quirks(xf86MonPtr m)
      * similar.  Strictly we should refuse to round up too far, but let's
      * see how well this works.
      */
-    for (i = 0; i < 4; i++) {
+    for (i = 0; i < m->det_mon_num; i++) {
 	if (m->det_mon[i].type == DS_RANGES) {
 	    ranges = &m->det_mon[i].section.ranges;
-	    for (j = 0; j < 4; j++) {
+	    for (j = 0; j < m->det_mon_num; j++) {
 		if (m->det_mon[j].type == DT) {
 		    preferred_timing = &m->det_mon[j].section.d_timings;
 		    if (!ranges->max_clock) continue; /* zero is legal */
@@ -99,7 +99,7 @@ handle_edid_quirks(xf86MonPtr m)
 	float target_aspect, timing_aspect;
 	
 	target_aspect = (float)m->features.hsize / (float)m->features.vsize;
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < m->det_mon_num; i++) {
 	    if (m->det_mon[i].type == DT) {
 		struct detailed_timings *timing;
 		timing = &m->det_mon[i].section.d_timings;
@@ -132,6 +132,79 @@ handle_edid_quirks(xf86MonPtr m)
     }
 }
 
+Uchar * xf86DDCGetCEA(xf86MonPtr MonPtr, struct extension_type *type) 
+{
+    struct extension_block *blk;
+    struct cea_ext *cea_blk;
+    struct cea_data_blk *data_collection;
+    Uchar *ret;
+    int data_len ;
+    int data_type;
+    int i;
+
+    ret = NULL;
+    blk = (struct extension_block *) (MonPtr->rawData + EDID1_LEN) ;
+
+    for (i = 0; i < MonPtr->no_sections; i++) {
+
+        if (CEA_EXT == blk ->u.cea.tag) {
+	    ret = (Uchar *)&blk->u.cea;
+            if (CEA_EXT == type->body_type && 0 == type->data_type) {
+                goto end;	
+            }	
+            break;
+        }
+        blk =(struct extension_block *) ((Uchar * )blk + EDID1_LEN);
+    }
+
+    if (NULL == ret)
+	goto end;
+
+    cea_blk = (struct cea_ext *)ret;
+
+    ret = NULL;
+
+    if (CEA_EXT_MIN_DATA_OFFSET >= cea_blk->dt_offset)
+	goto end;
+
+    data_collection = &cea_blk->data_collection ;
+    data_len = 0;
+    while (data_len < cea_blk->dt_offset) {
+    	if (type->data_type == data_collection->tag) {
+            ret = (unsigned char *)data_collection;
+            goto end;
+	}
+	data_len = data_len + data_collection->len + 1;
+	data_collection = (unsigned char *)data_collection + data_len ; 	
+    }		
+				
+				
+end:
+    return ret;
+}
+
+static void get_cea_detail_timing(xf86MonPtr m, Uchar *blk )	
+{
+    int dt_offset = ((struct cea_ext *)blk)->dt_offset;
+
+    if (CEA_EXT_MIN_DATA_OFFSET < dt_offset) {
+        goto end;        
+    }
+
+    while (dt_offset < (CEA_EXT_MAX_DATA_OFFSET - DET_TIMING_INFO_LEN )) { 
+
+        get_dt_md_section(blk + dt_offset, &m->ver, 
+                             m->det_mon + m->det_mon_num, 1);
+
+        m->det_mon_num = m->det_mon_num + 1 ;
+
+        _NEXT_DT_MD_SECTION(dt_offset);
+    }
+
+end:
+    return;  
+}
+
 xf86MonPtr
 xf86InterpretEDID(int scrnIndex, Uchar *block)
 {
@@ -151,9 +224,24 @@ xf86InterpretEDID(int scrnIndex, Uchar *
 				   &m->timings1);
     get_std_timing_section(SECTION(STD_TIMING_SECTION,block),m->timings2,
 			   &m->ver);
-    get_dt_md_section(SECTION(DET_TIMING_SECTION,block),&m->ver, m->det_mon);
+    get_dt_md_section(SECTION(DET_TIMING_SECTION,block),&m->ver, m->det_mon,4);
+    m->det_mon_num  = 4;
     m->no_sections = (int)*(char *)SECTION(NO_EDID,block);
 
+    
+    if (0 != m->no_sections) {
+        unsigned char *blk;
+        struct extension_type type;
+        
+        type.body_type = CEA_EXT;
+        type.data_type = 0;
+        blk = xf86DDCGetCEA(m, &type) ;
+	if (NULL != blk) {
+	    get_cea_detail_timing(m, blk);
+	    m->flags = EDID_CEA_EXTENSION_FLG;
+	}
+    }
+
     handle_edid_quirks(m);
 
     return (m);
@@ -286,11 +374,11 @@ get_std_timing_section(Uchar *c, struct 
 
 static void
 get_dt_md_section(Uchar *c, struct edid_version *ver, 
-		  struct detailed_monitor_section *det_mon)
+		  struct detailed_monitor_section *det_mon,int det_mon_num)
 {
   int i;
  
-  for (i=0;i<DET_TIMINGS;i++) {  
+  for (i=0;i<det_mon_num;i++) {  
     if (ver->version == 1 && ver->revision >= 1 && IS_MONITOR_DESC) {
 
       switch (MONITOR_DESC_TYPE) {
--- xserver.orig/hw/xfree86/ddc/print_edid.c
+++ xserver/hw/xfree86/ddc/print_edid.c
@@ -335,11 +335,12 @@ print_detailed_timings(int scrnIndex, st
 
 static void
 print_detailed_monitor_section(int scrnIndex,
-			       struct detailed_monitor_section *m)
+			       struct detailed_monitor_section *m,
+			       int det_mon_num)
 {
     int i,j;
   
-    for (i=0;i<DET_TIMINGS;i++) {
+    for (i=0;i<det_mon_num;i++) {
 	switch (m[i].type) {
 	case DT:
 	    print_detailed_timings(scrnIndex,&m[i].section.d_timings);
@@ -473,12 +474,12 @@ xf86PrintEDID(xf86MonPtr m)
     print_display(m->scrnIndex, &m->features, &m->ver);
     print_established_timings(m->scrnIndex, &m->timings1);
     print_std_timings(m->scrnIndex, m->timings2);
-    print_detailed_monitor_section(m->scrnIndex, m->det_mon);
+    print_detailed_monitor_section(m->scrnIndex, m->det_mon, m->det_mon_num);
     print_number_sections(m->scrnIndex, m->no_sections);
 
     /* extension block section stuff */
 
-    xf86DrvMsg(m->scrnIndex, X_INFO, "EDID (in hex):\n");
+    xf86DrvMsg(m->scrnIndex, X_INFO, "EDID (in hex): flags is <%d>\n",m->no_sections);
 
     n = 128;
     if (m->flags & EDID_COMPLETE_RAWDATA)
--- xserver.orig/hw/xfree86/ddc/xf86DDC.c
+++ xserver/hw/xfree86/ddc/xf86DDC.c
@@ -213,6 +213,7 @@ xf86DoEEDID(int scrnIndex, I2CBusPtr pBu
     unsigned char *EDID_block = NULL;
     xf86MonPtr tmp = NULL;
     I2CDevPtr dev = NULL;
+    int i,n;
     /* Default DDC and DDC2 to enabled. */
     Bool noddc = FALSE, noddc2 = FALSE;
     OptionInfoPtr options;
@@ -237,21 +238,41 @@ xf86DoEEDID(int scrnIndex, I2CBusPtr pBu
     if (!EDID_block)
 	return NULL;
 
-    if (DDC2Read(dev, 0, EDID_block)) {
-	int i, n = EDID_block[0x7e];
-
-	if (complete && n) {
-	    EDID_block = xrealloc(EDID_block, EDID1_LEN * (1+n));
-
-	    for (i = 0; i < n; i++)
-		DDC2Read(dev, i+1, EDID_block + (EDID1_LEN * (1+i)));
+    if(FALSE ==  DDC2Read(dev, 0, EDID_block)){
+        xfree(EDID_block);
+        return NULL;
+    }   
+    
+       
+    n =  EDID_block[0x7e];
+
+    if (complete && n) {
+        int ret;
+
+        EDID_block = xrealloc(EDID_block, EDID1_LEN * (1+n));
+
+        if (!EDID_block)
+	    return NULL;
+
+        for (i = 0; i < n; i++){
+            ret =  DDC2Read(dev, i+1, EDID_block + (EDID1_LEN * (1+i)));
+            if(FALSE == ret){
+                xfree(EDID_block);
+                return NULL;
+            }
 	}
 
 	tmp = xf86InterpretEEDID(scrnIndex, EDID_block);
-    }
 
-    if (tmp && complete)
+        if(NULL == tmp){
+            xfree(EDID_block);
+            return NULL;
+        } 
+    }
+    
+    if (tmp && complete){
 	tmp->flags |= EDID_COMPLETE_RAWDATA;
+    }
 
     return tmp;
 }
--- xserver.orig/hw/xfree86/ddc/xf86DDC.h
+++ xserver/hw/xfree86/ddc/xf86DDC.h
@@ -44,6 +44,10 @@ extern xf86MonPtr xf86PrintEDID(
 extern xf86MonPtr xf86InterpretEDID(
     int screenIndex, Uchar *block
 );
+extern unsigned char * xf86DDCGetCEA(
+    xf86MonPtr MonPtr,
+    struct extension_type *type
+);
 
 extern xf86MonPtr xf86InterpretEEDID(
     int screenIndex, Uchar *block
--- xserver.orig/hw/xfree86/modes/xf86Crtc.c
+++ xserver/hw/xfree86/modes/xf86Crtc.c
@@ -2683,7 +2683,7 @@ xf86OutputSetEDID (xf86OutputPtr output,
     if (edid_mon)
     {
 	/* Pull out a phyiscal size from a detailed timing if available. */
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < edid_mon->det_mon_num; i++) {
 	    if (edid_mon->det_mon[i].type == DT &&
 		edid_mon->det_mon[i].section.d_timings.h_size != 0 &&
 		edid_mon->det_mon[i].section.d_timings.v_size != 0)
--- xserver.orig/hw/xfree86/modes/xf86EdidModes.c
+++ xserver/hw/xfree86/modes/xf86EdidModes.c
@@ -51,7 +51,7 @@ xf86MonitorSupportsReducedBlanking(xf86M
     /* EDID 1.4 explicitly defines RB support */
     if (DDC->ver.revision >= 4) {
 	int i;
-	for (i = 0; i < DET_TIMINGS; i++) {
+	for (i = 0; i < DDC->det_mon_num; i++) {
 	    struct detailed_monitor_section *det_mon = &DDC->det_mon[i];
 	    if (det_mon->type == DS_RANGES)
 		if (det_mon->section.ranges.supported_blanking & CVT_REDUCED)
@@ -498,6 +498,107 @@ DDCModesFromStandardTiming(struct std_ti
 
     return Modes;
 }
+#define CEA_VIDEO_MODES_NUM  64
+static const DisplayModeRec CEAVideoModes[CEA_VIDEO_MODES_NUM] = {
+    { MODEPREFIX,    25175,  640,  656,  752,  800, 0,  480,  490,  492,  525, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 1:640x480@60Hz */
+    { MODEPREFIX,    27000,  720,  736,  798,  858, 0,  480,  489,  495,  525, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 2:720x480@60Hz */
+    { MODEPREFIX,    27000,  720,  736,  798,  858, 0,  480,  489,  495,  525, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 3:720x480@60Hz */
+    { MODEPREFIX,    74250, 1280, 1390, 1430, 1650, 0,  720,  725,  730,  750, 0, V_PHSYNC | V_PVSYNC, MODESUFFIX }, /* VIC 4: 1280x720@60Hz */
+    { MODEPREFIX,    74250, 1920, 2008, 2052, 2200, 0, 1080, 1084, 1094, 1125, 0, V_PHSYNC | V_PVSYNC | V_INTERLACE, MODESUFFIX }, /* VIC 5:1920x1080i@60Hz */
+    { MODEPREFIX,    27000, 1440, 1478, 1602, 1716, 0,  480,  488,  494,  525, 0, V_NHSYNC | V_NVSYNC | V_INTERLACE, MODESUFFIX }, /* VIC 6:1440x480i@60Hz */
+    { MODEPREFIX,    27000, 1440, 1478, 1602, 1716, 0,  480,  488,  494,  525, 0, V_NHSYNC | V_NVSYNC | V_INTERLACE, MODESUFFIX }, /* VIC 7:1440x480i@60Hz */
+    { MODEPREFIX,    27000, 1440, 1478, 1602, 1716, 0,  240,  244,  247,  262, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 8:1440x240@60Hz */
+    { MODEPREFIX,    27000, 1440, 1478, 1602, 1716, 0,  240,  244,  247,  262, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 9:1440x240@60Hz */
+    { MODEPREFIX,    54000, 2880, 2956, 3204, 3432, 0,  480,  488,  494,  525, 0, V_NHSYNC | V_NVSYNC | V_INTERLACE, MODESUFFIX }, /* VIC 10:2880x480i@60Hz */
+    { MODEPREFIX,    54000, 2880, 2956, 3204, 3432, 0,  480,  488,  494,  525, 0, V_NHSYNC | V_NVSYNC | V_INTERLACE, MODESUFFIX }, /* VIC 11:2880x480i@60Hz */
+    { MODEPREFIX,    54000, 2880, 2956, 3204, 3432, 0,  240,  244,  247,  262, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 12:2880x240@60Hz */
+    { MODEPREFIX,    54000, 2880, 2956, 3204, 3432, 0,  240,  244,  247,  262, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 13:2880x240@60Hz */
+    { MODEPREFIX,    54000, 1440, 1472, 1596, 1716, 0,  480,  489,  495,  525, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 14:1440x480@60Hz */
+    { MODEPREFIX,    54000, 1440, 1472, 1596, 1716, 0,  480,  489,  495,  525, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 15:1440x480@60Hz */
+    { MODEPREFIX,   148500, 1920, 2008, 2052, 2200, 0, 1080, 1084, 1089, 1125, 0, V_PHSYNC | V_PVSYNC, MODESUFFIX }, /* VIC 16:1920x1080@60Hz */
+    { MODEPREFIX,    27000,  720,  732,  796,  864, 0,  576,  581,  586,  625, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 17:720x576@50Hz */
+    { MODEPREFIX,    27000,  720,  732,  796,  864, 0,  576,  581,  586,  625, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 18:720x576@50Hz */
+    { MODEPREFIX,    74250, 1280, 1720, 1760, 1980, 0,  720,  725,  730,  750, 0, V_PHSYNC | V_PVSYNC, MODESUFFIX }, /* VIC 19: 1280x720@50Hz */
+    { MODEPREFIX,    74250, 1920, 2448, 2492, 2640, 0, 1080, 1084, 1094, 1125, 0, V_PHSYNC | V_PVSYNC | V_INTERLACE, MODESUFFIX }, /* VIC 20:1920x1080i@50Hz */
+    { MODEPREFIX,    27000, 1440, 1464, 1590, 1728, 0,  576,  580,  586,  625, 0, V_NHSYNC | V_NVSYNC | V_INTERLACE, MODESUFFIX }, /* VIC 21:1440x576i@50Hz */
+    { MODEPREFIX,    27000, 1440, 1464, 1590, 1728, 0,  576,  580,  586,  625, 0, V_NHSYNC | V_NVSYNC | V_INTERLACE, MODESUFFIX }, /* VIC 22:1440x576i@50Hz */
+    { MODEPREFIX,    27000, 1440, 1464, 1590, 1728, 0,  288,  290,  293,  312, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 23:1440x288@50Hz */
+    { MODEPREFIX,    27000, 1440, 1464, 1590, 1728, 0,  288,  290,  293,  312, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 24:1440x288@50Hz */
+    { MODEPREFIX,    54000, 2880, 2928, 3180, 3456, 0,  576,  580,  586,  625, 0, V_NHSYNC | V_NVSYNC | V_INTERLACE, MODESUFFIX }, /* VIC 25:2880x576i@50Hz */
+    { MODEPREFIX,    54000, 2880, 2928, 3180, 3456, 0,  576,  580,  586,  625, 0, V_NHSYNC | V_NVSYNC | V_INTERLACE, MODESUFFIX }, /* VIC 26:2880x576i@50Hz */
+    { MODEPREFIX,    54000, 2880, 2928, 3180, 3456, 0,  288,  290,  293,  312, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 27:2880x288@50Hz */
+    { MODEPREFIX,    54000, 2880, 2928, 3180, 3456, 0,  288,  290,  293,  312, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 28:2880x288@50Hz */
+    { MODEPREFIX,    54000, 1440, 1464, 1592, 1728, 0,  576,  581,  586,  625, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 29:1440x576@50Hz */
+    { MODEPREFIX,    54000, 1440, 1464, 1592, 1728, 0,  576,  581,  586,  625, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 30:1440x576@50Hz */
+    { MODEPREFIX,   148500, 1920, 2448, 2492, 2640, 0, 1080, 1084, 1089, 1125, 0, V_PHSYNC | V_PVSYNC, MODESUFFIX }, /* VIC 31:1920x1080@50Hz */
+    { MODEPREFIX,    74250, 1920, 2558, 2602, 2750, 0, 1080, 1084, 1089, 1125, 0, V_PHSYNC | V_PVSYNC, MODESUFFIX }, /* VIC 32:1920x1080@24Hz */
+    { MODEPREFIX,    74250, 1920, 2448, 2492, 2640, 0, 1080, 1084, 1089, 1125, 0, V_PHSYNC | V_PVSYNC, MODESUFFIX }, /* VIC 33:1920x1080@25Hz */
+    { MODEPREFIX,    74250, 1920, 2008, 2052, 2200, 0, 1080, 1084, 1089, 1125, 0, V_PHSYNC | V_PVSYNC, MODESUFFIX }, /* VIC 34:1920x1080@30Hz */
+    { MODEPREFIX,   108000, 2880, 2944, 3192, 3432, 0,  480,  489,  495,  525, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 35:2880x480@60Hz */
+    { MODEPREFIX,   108000, 2880, 2944, 3192, 3432, 0,  480,  489,  495,  525, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 36:2880x480@60Hz */
+    { MODEPREFIX,   108000, 2880, 2928, 3184, 3456, 0,  576,  581,  586,  625, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 37:2880x576@50Hz */
+    { MODEPREFIX,   108000, 2880, 2928, 3184, 3456, 0,  576,  581,  586,  625, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 38:2880x576@50Hz */
+    { MODEPREFIX,    72000, 1920, 1952, 2120, 2304, 0, 1080, 1126, 1136, 1250, 0, V_PHSYNC | V_NVSYNC | V_INTERLACE, MODESUFFIX }, /* VIC 39:1920x1080i@50Hz */
+    { MODEPREFIX,   148500, 1920, 2448, 2492, 2640, 0, 1080, 1084, 1094, 1125, 0, V_PHSYNC | V_PVSYNC | V_INTERLACE, MODESUFFIX }, /* VIC 40:1920x1080i@100Hz */
+    { MODEPREFIX,   148500, 1280, 1720, 1760, 1980, 0,  720,  725,  730,  750, 0, V_PHSYNC | V_PVSYNC, MODESUFFIX }, /* VIC 41:1280x720@100Hz */
+    { MODEPREFIX,    54000,  720,  732,  796,  864, 0,  576,  581,  586,  625, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 42:720x576@100Hz */
+    { MODEPREFIX,    54000,  720,  732,  796,  864, 0,  576,  581,  586,  625, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 43:720x576@100Hz */
+    { MODEPREFIX,    54000, 1440, 1464, 1590, 1728, 0,  576,  580,  586,  625, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 44:1440x576i@100Hz */
+    { MODEPREFIX,    54000, 1440, 1464, 1590, 1728, 0,  576,  580,  586,  625, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 45:1440x576i@100Hz */
+    { MODEPREFIX,   148500, 1920, 2008, 2052, 2200, 0, 1080, 1084, 1094, 1125, 0, V_PHSYNC | V_PVSYNC | V_INTERLACE, MODESUFFIX }, /* VIC 46:1920x1080i@120Hz */
+    { MODEPREFIX,   148500, 1280, 1390, 1430, 1650, 0,  720,  725,  730,  750, 0, V_PHSYNC | V_PVSYNC, MODESUFFIX }, /* VIC 47:1280x720@120Hz */
+    { MODEPREFIX,    54000,  720,  736,  798,  858, 0,  480,  489,  495,  525, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 48:720x480@120Hz */
+    { MODEPREFIX,    54000,  720,  736,  798,  858, 0,  480,  489,  495,  525, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 49:720x480@120Hz */
+    { MODEPREFIX,    54000, 1440, 1478, 1602, 1716, 0,  480,  488,  494,  525, 0, V_NHSYNC | V_NVSYNC | V_INTERLACE, MODESUFFIX },/* VIC 50:1440x480i@120Hz */
+    { MODEPREFIX,    54000, 1440, 1478, 1602, 1716, 0,  480,  488,  494,  525, 0, V_NHSYNC | V_NVSYNC | V_INTERLACE, MODESUFFIX },/* VIC 51:1440x480i@120Hz */
+    { MODEPREFIX,   108000,  720,  732,  796,  864, 0,  576,  581,  586,  625, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 52:720x576@200Hz */
+    { MODEPREFIX,   108000,  720,  732,  796,  864, 0,  576,  581,  586,  625, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 53:720x576@200Hz */
+    { MODEPREFIX,   108000, 1440, 1464, 1590, 1728, 0,  576,  580,  586,  625, 0, V_NHSYNC | V_NVSYNC | V_INTERLACE, MODESUFFIX },/* VIC 54:1440x576i@200Hz */
+    { MODEPREFIX,   108000, 1440, 1464, 1590, 1728, 0,  576,  580,  586,  625, 0, V_NHSYNC | V_NVSYNC | V_INTERLACE, MODESUFFIX },/* VIC 55:1440x576i@200Hz */
+    { MODEPREFIX,   108000,  720,  736,  798,  858, 0,  480,  489,  495,  525, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 56:720x480@240Hz */
+    { MODEPREFIX,   108000,  720,  736,  798,  858, 0,  480,  489,  495,  525, 0, V_NHSYNC | V_NVSYNC, MODESUFFIX }, /* VIC 57:720x480@240Hz */
+    { MODEPREFIX,   108000, 1440, 1478, 1602, 1716, 0,  480,  488,  494,  525, 0, V_NHSYNC | V_NVSYNC | V_INTERLACE, MODESUFFIX },/* VIC 58:1440x480i@240 */
+    { MODEPREFIX,   108000, 1440, 1478, 1602, 1716, 0,  480,  488,  494,  525, 0, V_NHSYNC | V_NVSYNC | V_INTERLACE, MODESUFFIX },/* VIC 59:1440x480i@240 */
+    { MODEPREFIX,    59400, 1280, 3040, 3080, 3300, 0,  720,  725,  730,  750, 0, V_PHSYNC | V_PVSYNC, MODESUFFIX }, /* VIC 60: 1280x720@24Hz */
+    { MODEPREFIX,    74250, 3700, 3740, 1430, 3960, 0,  720,  725,  730,  750, 0, V_PHSYNC | V_PVSYNC, MODESUFFIX }, /* VIC 61: 1280x720@25Hz */
+    { MODEPREFIX,    74250, 1280, 3040, 3080, 3300, 0,  720,  725,  730,  750, 0, V_PHSYNC | V_PVSYNC, MODESUFFIX }, /* VIC 62: 1280x720@30Hz */
+    { MODEPREFIX,   297000, 1920, 2008, 2052, 2200, 0, 1080, 1084, 1089, 1125, 0, V_PHSYNC | V_PVSYNC, MODESUFFIX }, /* VIC 63: 1920x1080@120Hz */
+    { MODEPREFIX,   297000, 1920, 2448, 2492, 2640, 0, 1080, 1084, 1094, 1125, 0, V_PHSYNC | V_PVSYNC, MODESUFFIX }, /* VIC 64:1920x1080@100Hz */
+};
+	                
+static DisplayModePtr
+DDCModesFromCeaExtension(int idx, xf86MonPtr MonPtr)
+{
+    DisplayModePtr Modes = NULL, Mode = NULL;
+    struct extension_type type;
+    struct cea_data_blk *data_collection;
+    struct cea_video_blk *video;
+    int num ;
+    int vid;
+ 
+    type.body_type = CEA_EXT ;
+    type.data_type = CEA_VIDEO_BLK;
+
+    data_collection = (struct cea_data_blk *)xf86DDCGetCEA(MonPtr, &type);
+    if (NULL == data_collection)
+        goto end;      
+ 
+    video = &data_collection->u.video;
+    num = 0;
+     
+    while (num < (data_collection->len/sizeof(struct cea_video_blk))) {
+	vid = video[num].video_code & 0x7f;
+
+        if(vid < CEA_VIDEO_MODES_NUM){
+            Mode = xf86DuplicateMode(CEAVideoModes + vid );
+            Modes = xf86ModesAdd(Modes, Mode);
+	}
+	num = num + 1;
+    }
+
+end:
+    return Modes;
+}
 
 /*
  *
@@ -699,7 +800,7 @@ xf86DDCApplyQuirks(int scrnIndex, xf86Mo
     ddc_quirk_t quirks = xf86DDCDetectQuirks (scrnIndex, DDC, FALSE);
     int i;
 
-    for (i = 0; i < DET_TIMINGS; i++) {
+    for (i = 0; i < DDC->det_mon_num; i++) {
 	struct detailed_monitor_section *det_mon = &DDC->det_mon[i];
 
 	if (det_mon->type != DT)
@@ -785,7 +886,7 @@ xf86DDCGetModes(int scrnIndex, xf86MonPt
 
     timing_level = MonitorStandardTimingLevel(DDC);
 
-    for (i = 0; i < DET_TIMINGS; i++) {
+    for (i = 0; i < DDC->det_mon_num; i++) {
 	struct detailed_monitor_section *det_mon = &DDC->det_mon[i];
 
         switch (det_mon->type) {
@@ -821,6 +922,11 @@ xf86DDCGetModes(int scrnIndex, xf86MonPt
     Mode = DDCModesFromStandardTiming(DDC->timings2, quirks, timing_level, rb);
     Modes = xf86ModesAdd(Modes, Mode);
 
+    if(EDID_CEA_EXTENSION_FLG & DDC->flags){
+       Mode = DDCModesFromCeaExtension(scrnIndex,DDC);	
+       Modes = xf86ModesAdd(Modes, Mode);
+    }
+
     if (quirks & DDC_QUIRK_PREFER_LARGE_60)
 	xf86DDCSetPreferredRefresh(scrnIndex, Modes, 60);
 
@@ -863,7 +969,7 @@ xf86DDCMonitorSet(int scrnIndex, MonPtr 
     have_maxpixclock = (Monitor->maxPixClock != 0);
 
     /* Go through the detailed monitor sections */
-    for (i = 0; i < DET_TIMINGS; i++) {
+    for (i = 0; i < DDC->det_mon_num; i++) {
         switch (DDC->det_mon[i].type) {
         case DS_RANGES:
 	    if (!have_hsync) {

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
xorg mailing list
xorg@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/xorg
--ikeVEW9yuYc//A+q--
