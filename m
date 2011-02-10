From: linux@audioscience.com
Subject: [PATCH 15/28] Cosmetic + a minor comments.
Date: Thu, 10 Feb 2011 17:26:08 +1300
Message-ID: <1297311981-30448-16-git-send-email-linux@audioscience.com>
References: <1297311981-30448-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1297311981-30448-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/hpi.h          |   23 +++++++----------
 pci/asihpi/hpi6205.c      |   59 ++++++++++++++++++++++++++++++++++++++++++++-
 pci/asihpi/hpi_internal.h |   17 +++++++-----
 pci/asihpi/hpicmn.h       |    1 +
 pci/asihpi/hpidspcd.h     |    2 +-
 pci/asihpi/hpimsgx.c      |    2 +-
 6 files changed, 80 insertions(+), 24 deletions(-)

diff --git a/pci/asihpi/hpi.h b/pci/asihpi/hpi.h
index 212a016..bef90d4 100644
--- a/pci/asihpi/hpi.h
+++ b/pci/asihpi/hpi.h
@@ -957,8 +957,7 @@ enum HPI_ERROR_CODES {
 	/** Reserved for OEMs. */
 	HPI_ERROR_RESERVED_1 = 290,
 
-	/* HPI_ERROR_INVALID_STREAM = 300,
-	   use HPI_ERROR_INVALID_OBJ_INDEX  */
+	/* HPI_ERROR_INVALID_STREAM = 300 use HPI_ERROR_INVALID_OBJ_INDEX */
 	/** Invalid compression format. */
 	HPI_ERROR_INVALID_FORMAT = 301,
 	/** Invalid format samplerate */
@@ -969,12 +968,8 @@ enum HPI_ERROR_CODES {
 	HPI_ERROR_INVALID_BITRATE = 304,
 	/** Invalid datasize used for stream read/write. */
 	HPI_ERROR_INVALID_DATASIZE = 305,
-	/* Stream buffer is full during stream write.
-	   HPI_ERROR_BUFFER_FULL = 306,
-	   Stream buffer is empty during stream read.
-	   HPI_ERROR_BUFFER_EMPTY = 307,
-	   Use HPI_ERROR_INVALID_DATASIZE
-	 */
+	/* HPI_ERROR_BUFFER_FULL = 306 use HPI_ERROR_INVALID_DATASIZE */
+	/* HPI_ERROR_BUFFER_EMPTY = 307 use HPI_ERROR_INVALID_DATASIZE */
 	/** Null data pointer used for stream read/write. */
 	HPI_ERROR_INVALID_DATA_POINTER = 308,
 	/** Packet ordering error for stream read/write. */
@@ -1098,16 +1093,16 @@ struct hpi_anc_frame {
 */
 struct hpi_async_event {
 	u16 event_type;	/**< type of event. \sa async_event  */
-	u16 sequence;  /**< Sequence number, allows lost event detection */
-	u32 state;    /**< New state */
-	u32 h_object;	 /**< handle to the object returning the event. */
+	u16 sequence; /**< Sequence number, allows lost event detection */
+	u32 state; /**< New state */
+	u32 h_object; /**< handle to the object returning the event. */
 	union {
 		struct {
 			u16 index; /**< GPIO bit index. */
 		} gpio;
 		struct {
 			u16 node_index;	/**< what node is the control on ? */
-			u16 node_type;	/**< what type of node is the control on ? */
+			u16 node_type; /**< what type of node is the control on ? */
 		} control;
 	} u;
 };
@@ -1635,8 +1630,8 @@ u16 hpi_cobranet_get_static_ip_address(u32 h_control, u32 *pdw_ip_address);
 
 u16 hpi_cobranet_set_static_ip_address(u32 h_control, u32 dw_ip_address);
 
-u16 hpi_cobranet_get_macaddress(u32 h_control, u32 *pmAC_MS_bs,
-	u32 *pmAC_LS_bs);
+u16 hpi_cobranet_get_macaddress(u32 h_control, u32 *p_mac_msbs,
+	u32 *p_mac_lsbs);
 
 /*************************/
 /* Tone Detector control */
diff --git a/pci/asihpi/hpi6205.c b/pci/asihpi/hpi6205.c
index cbf79a9..eefe459 100644
--- a/pci/asihpi/hpi6205.c
+++ b/pci/asihpi/hpi6205.c
@@ -752,6 +752,9 @@ static void delete_adapter_obj(struct hpi_adapter_obj *pao)
 }
 
 /*****************************************************************************/
+/* Adapter functions */
+
+/*****************************************************************************/
 /* OutStream Host buffer functions */
 
 /** Allocate or attach buffer for busmastering
@@ -1781,12 +1784,66 @@ static u16 boot_loader_config_emif(struct hpi_adapter_obj *pao, int dsp_index)
 		   BAR1 via BootLoader_WriteMem32) */
 		boot_loader_write_mem32(pao, dsp_index, C6713_EMIF_GCTL,
 			0x000034A8);
+
+		/* EMIF CE0 setup - 2Mx32 Sync DRAM
+		   31..28       Wr setup
+		   27..22       Wr strobe
+		   21..20       Wr hold
+		   19..16       Rd setup
+		   15..14       -
+		   13..8        Rd strobe
+		   7..4         MTYPE   0011            Sync DRAM 32bits
+		   3            Wr hold MSB
+		   2..0         Rd hold
+		 */
 		boot_loader_write_mem32(pao, dsp_index, C6713_EMIF_CE0,
 			0x00000030);
+
+		/* EMIF SDRAM Extension
+		   0x00
+		   31-21        0000b 0000b 000b
+		   20           WR2RD = 2cycles-1  = 1b
+
+		   19-18        WR2DEAC = 3cycle-1 = 10b
+		   17           WR2WR = 2cycle-1   = 1b
+		   16-15        R2WDQM = 4cycle-1  = 11b
+		   14-12        RD2WR = 6cycles-1  = 101b
+
+		   11-10        RD2DEAC = 4cycle-1 = 11b
+		   9            RD2RD = 2cycle-1   = 1b
+		   8-7          THZP = 3cycle-1    = 10b
+		   6-5          TWR  = 2cycle-1    = 01b (tWR = 17ns)
+		   4            TRRD = 2cycle      = 0b  (tRRD = 14ns)
+		   3-1          TRAS = 5cycle-1    = 100b (Tras=42ns)
+		   1            CAS latency = 3cyc = 1b
+		   (for Micron 2M32-7 operating at 100MHz)
+		 */
 		boot_loader_write_mem32(pao, dsp_index, C6713_EMIF_SDRAMEXT,
 			0x001BDF29);
+
+		/* EMIF SDRAM control - set up for a 2Mx32 SDRAM (512x32x4 bank)
+		   31           -       0b       -
+		   30           SDBSZ   1b              4 bank
+		   29..28       SDRSZ   00b             11 row address pins
+
+		   27..26       SDCSZ   01b             8 column address pins
+		   25           RFEN    1b              refersh enabled
+		   24           INIT    1b              init SDRAM!
+
+		   23..20       TRCD    0001b                   (Trcd/Tcyc)-1 = (20/10)-1 = 1
+
+		   19..16       TRP     0001b                   (Trp/Tcyc)-1 = (20/10)-1 = 1
+
+		   15..12       TRC     0110b                   (Trc/Tcyc)-1 = (70/10)-1 = 6
+
+		   11..0        -       0000b 0000b 0000b
+		 */
 		boot_loader_write_mem32(pao, dsp_index, C6713_EMIF_SDRAMCTL,
-			0x47117000);
+			0x47116000);
+
+		/* SDRAM refresh timing
+		   Need 4,096 refresh cycles every 64ms = 15.625us = 1562cycles of 100MHz = 0x61A
+		 */
 		boot_loader_write_mem32(pao, dsp_index,
 			C6713_EMIF_SDRAMTIMING, 0x00000410);
 
diff --git a/pci/asihpi/hpi_internal.h b/pci/asihpi/hpi_internal.h
index a99aa9a..9f003a4 100644
--- a/pci/asihpi/hpi_internal.h
+++ b/pci/asihpi/hpi_internal.h
@@ -553,12 +553,10 @@ struct hpi_resource {
 /** Format info used inside struct hpi_message
     Not the same as public API struct hpi_format */
 struct hpi_msg_format {
-	u32 sample_rate;
-				/**< 11025, 32000, 44100 ... */
-	u32 bit_rate;	      /**< for MPEG */
-	u32 attributes;
-				/**< Stereo/JointStereo/Mono */
-	u16 channels;	      /**< 1,2..., (or ancillary mode or idle bit */
+	u32 sample_rate; /**< 11025, 32000, 44100 etc. */
+	u32 bit_rate; /**< for MPEG */
+	u32 attributes;	/**< stereo/joint_stereo/mono */
+	u16 channels; /**< 1,2..., (or ancillary mode or idle bit */
 	u16 format; /**< HPI_FORMAT_PCM16, _MPEG etc. see \ref HPI_FORMATS. */
 };
 
@@ -593,7 +591,7 @@ struct hpi_data_compat32 {
 struct hpi_buffer {
   /** placehoder for backward compatability (see dwBufferSize) */
 	struct hpi_msg_format reserved;
-	u32 command;	/**< HPI_BUFFER_CMD_xxx*/
+	u32 command; /**< HPI_BUFFER_CMD_xxx*/
 	u32 pci_address; /**< PCI physical address of buffer for DSP DMA */
 	u32 buffer_size; /**< must line up with data_size of HPI_DATA*/
 };
@@ -1125,6 +1123,11 @@ struct hpi_message {
 	sizeof(struct hpi_message_header) + sizeof(struct hpi_async_msg) \
 }
 
+/*
+Note that the wSpecificError error field should be inspected and potentially
+reported whenever HPI_ERROR_DSP_COMMUNICATION or HPI_ERROR_DSP_BOOTLOAD is
+returned in wError.
+*/
 struct hpi_response_header {
 	u16 size;
 	u8 type;		/* HPI_TYPE_RESPONSE  */
diff --git a/pci/asihpi/hpicmn.h b/pci/asihpi/hpicmn.h
index 6db1e0b..590f0b6 100644
--- a/pci/asihpi/hpicmn.h
+++ b/pci/asihpi/hpicmn.h
@@ -45,6 +45,7 @@ struct hpi_control_cache {
 };
 
 struct hpi_adapter_obj *hpi_find_adapter(u16 adapter_index);
+
 u16 hpi_add_adapter(struct hpi_adapter_obj *pao);
 
 void hpi_delete_adapter(struct hpi_adapter_obj *pao);
diff --git a/pci/asihpi/hpidspcd.h b/pci/asihpi/hpidspcd.h
index d7c2403..65f0ca7 100644
--- a/pci/asihpi/hpidspcd.h
+++ b/pci/asihpi/hpidspcd.h
@@ -87,7 +87,7 @@ void hpi_dsp_code_rewind(struct dsp_code *ps_dsp_code);
 */
 short hpi_dsp_code_read_word(struct dsp_code *ps_dsp_code,
 				      /**< DSP code descriptor */
-	u32 *pword /**< where to store the read word */
+	u32 *pword /**< Where to store the read word */
 	);
 
 /** Get a block of dsp code into an internal buffer, and provide a pointer to
diff --git a/pci/asihpi/hpimsgx.c b/pci/asihpi/hpimsgx.c
index b4e7d9a..bcbdf30 100644
--- a/pci/asihpi/hpimsgx.c
+++ b/pci/asihpi/hpimsgx.c
@@ -230,7 +230,7 @@ static void subsys_message(struct hpi_message *phm, struct hpi_response *phr,
 
 		break;
 	default:
-		/* Must explicitly send subsys messages to individual backends */
+		/* Must explicitly handle every subsys message in this switch */
 		hpi_init_response(phr, HPI_OBJ_SUBSYSTEM, phm->function,
 			HPI_ERROR_INVALID_FUNC);
 		break;
-- 
1.7.0.4
