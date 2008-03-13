From: Eliot Blennerhassett <linux@audioscience.com>
Subject: [PATCH] asihpi - new checkpatch = more changes
Date: Thu, 13 Mar 2008 13:24:44 +1300
Message-ID: <200803131324.44675.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed; boundary="Boundary-00=_MRH2H502DFgb+8t"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id CAC1424333
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 01:19:59 +0100 (CET)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JXN00GF87KWBH30@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 13 Mar 2008 13:19:57 +1300 (NZDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_MRH2H502DFgb+8t
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Signed-off-by: Eliot Blennerhasssett <linux@audioscience.com>

* HPI version 3.09.15
* Updating to latest version of checkpatch resulted in some more warnings to 
clean up.
* A few whitespace cleanups
* Removed DBG_TXT and DBG_CHAR macros

---
patch attached

--
Eliot Blennerhassett
www.audioscience.com

--Boundary-00=_MRH2H502DFgb+8t
Content-Type: text/x-diff;
  charset="utf-8";
  name="alsa_driver3540_asihpi30915.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alsa_driver3540_asihpi30915.patch"

diff -r e285d93dfd8a pci/asihpi/asihpi.c
--- a/pci/asihpi/asihpi.c	Mon Mar 10 11:49:06 2008 +0100
+++ b/pci/asihpi/asihpi.c	Thu Mar 13 12:27:22 2008 +1300
@@ -54,11 +54,7 @@
 #include <linux/pci.h>
 #include <linux/version.h>
 #include <linux/init.h>
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 5, 0)
 #include <linux/jiffies.h>
-#else
-#include <linux/sched.h>
-#endif
 #include <linux/slab.h>
 #include <linux/time.h>
 #include <linux/wait.h>
@@ -177,7 +173,8 @@ static u16 HPI_StreamHostBufferAttach(
 	struct hpi_message hm;
 	struct hpi_response hr;
 
-	if (!hStream) return HPI_ERROR_INVALID_OBJ;
+	if (!hStream)
+		return HPI_ERROR_INVALID_OBJ;
 	if (HPI_HandleObject(hStream) ==  HPI_OBJ_OSTREAM)
 		HPI_InitMessage(&hm,  HPI_OBJ_OSTREAM,
 				HPI_OSTREAM_HOSTBUFFER_ALLOC);
@@ -203,7 +200,8 @@ static u16 HPI_StreamHostBufferDetach(
 	struct hpi_message hm;
 	struct hpi_response hr;
 
-	if (!hStream) return HPI_ERROR_INVALID_OBJ;
+	if (!hStream)
+		return HPI_ERROR_INVALID_OBJ;
 
 	if (HPI_HandleObject(hStream) ==  HPI_OBJ_OSTREAM)
 		HPI_InitMessage(&hm,  HPI_OBJ_OSTREAM,
@@ -880,9 +878,9 @@ static int snd_card_asihpi_playback_open
 	/* struct copy so can create initializer dynamically */
 	runtime->hw = snd_card_asihpi_playback;
 	/* Strictly only necessary for HPI6205 adapters */
-	if ((err =
-	     snd_pcm_hw_constraint_pow2(runtime, 0,
-					SNDRV_PCM_HW_PARAM_BUFFER_SIZE)) < 0)
+	err = snd_pcm_hw_constraint_pow2(runtime, 0,
+					SNDRV_PCM_HW_PARAM_BUFFER_SIZE);
+	if (err < 0)
 		return err;
 
 	snd_pcm_set_sync(substream);
@@ -1094,9 +1092,9 @@ static int snd_card_asihpi_capture_open(
 	runtime->hw = snd_card_asihpi_capture;
 
 	/* Strictly only necessary for HPI6205 adapters */
-	if ((err =
-	     snd_pcm_hw_constraint_pow2(runtime, 0,
-					SNDRV_PCM_HW_PARAM_BUFFER_SIZE)) < 0)
+	err = snd_pcm_hw_constraint_pow2(runtime, 0,
+					SNDRV_PCM_HW_PARAM_BUFFER_SIZE);
+	if (err < 0)
 		return err;
 
 	snd_pcm_set_sync(substream);
@@ -1164,10 +1162,10 @@ static int __devinit snd_card_asihpi_pcm
 	struct snd_pcm *pcm;
 	int err;
 
-	if ((err =
-	     snd_pcm_new(asihpi->card, "Asihpi PCM", device,
+	err = snd_pcm_new(asihpi->card, "Asihpi PCM", device,
 			 asihpi->wNumOutStreams, asihpi->wNumInStreams,
-			 &pcm)) < 0)
+			 &pcm);
+	if (err < 0)
 		return err;
 	/* pointer to ops struct is stored, dont change ops afterwards! */
 	if (asihpi->support_mmap) {
@@ -1530,7 +1528,8 @@ static int snd_asihpi_aesebu_format_get(
 	/* default to N/A */
 	ucontrol->value.enumerated.item[0] = 0;
 	/* return success but set the control to N/A */
-	if (err) return 0;
+	if (err)
+		return 0;
 	if (source == HPI_AESEBU_FORMAT_SPDIF)
 		ucontrol->value.enumerated.item[0] = 1;
 	if (source == HPI_AESEBU_FORMAT_AESEBU)
@@ -1641,7 +1640,8 @@ static int snd_asihpi_tuner_gain_info(st
 	for (idx = 0; idx < 3; idx++) {
 	err = HPI_ControlQuery(phSubSys, hControl, HPI_TUNER_GAIN,
 				idx, 0, &gainRange[idx]);
-		if (err != 0) return err;
+		if (err != 0)
+			return err;
 	}
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
@@ -1693,7 +1693,8 @@ static int asihpi_tuner_band_query(struc
 	for (idx = 0; idx < len; idx++) {
 		err = HPI_ControlQuery(phSubSys, hControl , HPI_TUNER_BAND,
 				idx, 0 , &bandList[idx]);
-		if (err != 0) break;
+		if (err != 0)
+			break;
 	}
 
 	return idx;
@@ -1792,7 +1793,8 @@ static int snd_asihpi_tuner_freq_info(st
 			err = HPI_ControlQuery(phSubSys, hControl,
 				HPI_TUNER_FREQ, idx, tunerBands[band_iter],
 				&tempFreqRange[idx]);
-			if (err != 0) return err;
+			if (err != 0)
+				return err;
 		}
 
 		/* skip band with bogus stepping */
@@ -2306,7 +2308,7 @@ static int snd_asihpi_clklocal_get(struc
 	u32 hControl = kcontrol->private_value;
 	u32 dwRate;
 
-	HPI_SampleClock_GetSampleRate(phSubSys, hControl, &dwRate);
+	HPI_SampleClock_GetLocalRate(phSubSys, hControl, &dwRate);
 	ucontrol->value.integer.value[0] = dwRate;
 	return 0;
 }
diff -r e285d93dfd8a pci/asihpi/hpi.h
--- a/pci/asihpi/hpi.h	Mon Mar 10 11:49:06 2008 +0100
+++ b/pci/asihpi/hpi.h	Thu Mar 13 12:42:18 2008 +1300
@@ -46,7 +46,7 @@ i.e 3.05.02 is a development version
 #define HPI_VER_RELEASE(v) (v & 0xFF)
 
 /* Use single digits for versions less that 10 to avoid octal. */
-#define HPI_VER HPI_VERSION_CONSTRUCTOR(3L, 9, 14)
+#define HPI_VER HPI_VERSION_CONSTRUCTOR(3L, 9, 15)
 
 #ifdef _DOX_ONLY_
 /*****************************************************************************/
@@ -187,6 +187,8 @@ extern "C" {
 #define HPI_ADAPTER_ASI1711             0x1711
 /** ASI1721 - Quad AM/FM+RDS tuner module */
 #define HPI_ADAPTER_ASI1721             0x1721
+/** ASI1722 - Quad FM+RDS tuner module (based on ASI1721 h/w) */
+#define HPI_ADAPTER_ASI1722             0x1722
 /** ASI1731 - Quad TV tuner module */
 #define HPI_ADAPTER_ASI1731             0x1731
 /*ASI2214 - USB 2.0 1xanalog in, 4 x analog out, 1 x AES in/out */
@@ -406,8 +408,10 @@ OBSOLETE - OEM 4 play PCM, MPEG*/
 #define HPI_ADAPTER_ASI8801             0x8801
 
 #define HPI_ADAPTER_FAMILY_ASI8900      0x8900
+/** OEM FM+RDS, 2 module tuner card */
+#define HPI_ADAPTER_ASI8920             0x8920
 /** 2 module tuner card */
-#define HPI_ADAPTER_ASI8920             0x8920
+#define HPI_ADAPTER_ASI8921             0x8921
 
 /** Used in DLL to indicate device not present */
 #define HPI_ADAPTER_ILLEGAL             0xFFFF
diff -r e285d93dfd8a pci/asihpi/hpi6000.c
--- a/pci/asihpi/hpi6000.c	Mon Mar 10 11:49:06 2008 +0100
+++ b/pci/asihpi/hpi6000.c	Thu Mar 13 12:27:16 2008 +1300
@@ -43,64 +43,64 @@
 #define HPI_HIF_BASE (0x00000200)	/* start of C67xx internal RAM */
 #define HPI_HIF_ADDR(member) \
 	(HPI_HIF_BASE + offsetof(struct hpi_hif_6000, member))
-#define HPI_HIF_ERROR_MASK	0x4000
+#define HPI_HIF_ERROR_MASK      0x4000
 
 /* HPI6000 specific error codes */
 
-#define HPI6000_ERROR_BASE				900
-#define HPI6000_ERROR_MSG_RESP_IDLE_TIMEOUT		901
-#define HPI6000_ERROR_MSG_RESP_SEND_MSG_ACK		902
-#define HPI6000_ERROR_MSG_RESP_GET_RESP_ACK		903
-#define HPI6000_ERROR_MSG_GET_ADR			904
-#define HPI6000_ERROR_RESP_GET_ADR			905
-#define HPI6000_ERROR_MSG_RESP_BLOCKWRITE32		906
-#define HPI6000_ERROR_MSG_RESP_BLOCKREAD32		907
-#define HPI6000_ERROR_MSG_INVALID_DSP_INDEX		908
-#define HPI6000_ERROR_CONTROL_CACHE_PARAMS		909
-
-#define HPI6000_ERROR_SEND_DATA_IDLE_TIMEOUT		911
-#define HPI6000_ERROR_SEND_DATA_ACK			912
-#define HPI6000_ERROR_SEND_DATA_ADR			913
-#define HPI6000_ERROR_SEND_DATA_TIMEOUT			914
-#define HPI6000_ERROR_SEND_DATA_CMD			915
-#define HPI6000_ERROR_SEND_DATA_WRITE			916
-#define HPI6000_ERROR_SEND_DATA_IDLECMD			917
-#define HPI6000_ERROR_SEND_DATA_VERIFY			918
-
-#define HPI6000_ERROR_GET_DATA_IDLE_TIMEOUT		921
-#define HPI6000_ERROR_GET_DATA_ACK			922
-#define HPI6000_ERROR_GET_DATA_CMD			923
-#define HPI6000_ERROR_GET_DATA_READ			924
-#define HPI6000_ERROR_GET_DATA_IDLECMD			925
-
-#define HPI6000_ERROR_CONTROL_CACHE_ADDRLEN		951
-#define HPI6000_ERROR_CONTROL_CACHE_READ		952
-#define HPI6000_ERROR_CONTROL_CACHE_FLUSH		953
-
-#define HPI6000_ERROR_MSG_RESP_GETRESPCMD		961
-#define HPI6000_ERROR_MSG_RESP_IDLECMD			962
-#define HPI6000_ERROR_MSG_RESP_BLOCKVERIFY32		963
+#define HPI6000_ERROR_BASE                              900
+#define HPI6000_ERROR_MSG_RESP_IDLE_TIMEOUT             901
+#define HPI6000_ERROR_MSG_RESP_SEND_MSG_ACK             902
+#define HPI6000_ERROR_MSG_RESP_GET_RESP_ACK             903
+#define HPI6000_ERROR_MSG_GET_ADR                       904
+#define HPI6000_ERROR_RESP_GET_ADR                      905
+#define HPI6000_ERROR_MSG_RESP_BLOCKWRITE32             906
+#define HPI6000_ERROR_MSG_RESP_BLOCKREAD32              907
+#define HPI6000_ERROR_MSG_INVALID_DSP_INDEX             908
+#define HPI6000_ERROR_CONTROL_CACHE_PARAMS              909
+
+#define HPI6000_ERROR_SEND_DATA_IDLE_TIMEOUT            911
+#define HPI6000_ERROR_SEND_DATA_ACK                     912
+#define HPI6000_ERROR_SEND_DATA_ADR                     913
+#define HPI6000_ERROR_SEND_DATA_TIMEOUT                 914
+#define HPI6000_ERROR_SEND_DATA_CMD                     915
+#define HPI6000_ERROR_SEND_DATA_WRITE                   916
+#define HPI6000_ERROR_SEND_DATA_IDLECMD                 917
+#define HPI6000_ERROR_SEND_DATA_VERIFY                  918
+
+#define HPI6000_ERROR_GET_DATA_IDLE_TIMEOUT             921
+#define HPI6000_ERROR_GET_DATA_ACK                      922
+#define HPI6000_ERROR_GET_DATA_CMD                      923
+#define HPI6000_ERROR_GET_DATA_READ                     924
+#define HPI6000_ERROR_GET_DATA_IDLECMD                  925
+
+#define HPI6000_ERROR_CONTROL_CACHE_ADDRLEN             951
+#define HPI6000_ERROR_CONTROL_CACHE_READ                952
+#define HPI6000_ERROR_CONTROL_CACHE_FLUSH               953
+
+#define HPI6000_ERROR_MSG_RESP_GETRESPCMD               961
+#define HPI6000_ERROR_MSG_RESP_IDLECMD                  962
+#define HPI6000_ERROR_MSG_RESP_BLOCKVERIFY32            963
 
 /* adapter init errors */
-#define HPI6000_ERROR_UNHANDLED_SUBSYS_ID		930
+#define HPI6000_ERROR_UNHANDLED_SUBSYS_ID               930
 
 /* can't access PCI2040 */
-#define HPI6000_ERROR_INIT_PCI2040			931
+#define HPI6000_ERROR_INIT_PCI2040                      931
 /* can't access DSP HPI i/f */
-#define HPI6000_ERROR_INIT_DSPHPI			932
+#define HPI6000_ERROR_INIT_DSPHPI                       932
 /* can't access internal DSP memory */
-#define HPI6000_ERROR_INIT_DSPINTMEM			933
+#define HPI6000_ERROR_INIT_DSPINTMEM                    933
 /* can't access SDRAM - test#1 */
-#define HPI6000_ERROR_INIT_SDRAM1			934
+#define HPI6000_ERROR_INIT_SDRAM1                       934
 /* can't access SDRAM - test#2 */
-#define HPI6000_ERROR_INIT_SDRAM2			935
-
-#define HPI6000_ERROR_INIT_VERIFY			938
-
-#define HPI6000_ERROR_INIT_NOACK			939
-
-#define HPI6000_ERROR_INIT_PLDTEST1			941
-#define HPI6000_ERROR_INIT_PLDTEST2			942
+#define HPI6000_ERROR_INIT_SDRAM2                       935
+
+#define HPI6000_ERROR_INIT_VERIFY                       938
+
+#define HPI6000_ERROR_INIT_NOACK                        939
+
+#define HPI6000_ERROR_INIT_PLDTEST1                     941
+#define HPI6000_ERROR_INIT_PLDTEST2                     942
 
 /* local defines */
 
@@ -112,22 +112,22 @@
 /* word offsets from CSR base */
 /* use when io addresses defined as u32 * */
 
-#define INTERRUPT_EVENT_SET	0
-#define INTERRUPT_EVENT_CLEAR	1
-#define INTERRUPT_MASK_SET	2
-#define INTERRUPT_MASK_CLEAR	3
-#define HPI_ERROR_REPORT	4
-#define HPI_RESET		5
-#define HPI_DATA_WIDTH		6
+#define INTERRUPT_EVENT_SET     0
+#define INTERRUPT_EVENT_CLEAR   1
+#define INTERRUPT_MASK_SET      2
+#define INTERRUPT_MASK_CLEAR    3
+#define HPI_ERROR_REPORT        4
+#define HPI_RESET               5
+#define HPI_DATA_WIDTH          6
 
 #define MAX_DSPS 2
 /* HPI registers, spaced 8K bytes = 2K words apart */
-#define DSP_SPACING		0x800
-
-#define CONTROL			0x0000
-#define ADDRESS			0x0200
-#define DATA_AUTOINC		0x0400
-#define DATA			0x0600
+#define DSP_SPACING             0x800
+
+#define CONTROL                 0x0000
+#define ADDRESS                 0x0200
+#define DATA_AUTOINC            0x0400
+#define DATA                    0x0600
 
 #define TIMEOUT 500000
 
@@ -701,7 +701,7 @@ static short CreateAdapterObj(
 
 	HPI_DEBUG_LOG(DEBUG, "Get adapter info ASI%04X index %d\n",
 		pao->wAdapterType, pao->wIndex);
-	pao->wOpen = 0;		/* upon creation the adapter is closed */
+	pao->wOpen = 0;	/* upon creation the adapter is closed */
 	return 0;
 }
 
@@ -762,7 +762,7 @@ static short Hpi6000_AdapterBootLoadDsp(
 
 	switch (pao->Pci.wSubSysDeviceId) {
 	case 0x5100:
-	case 0x5110:		/* ASI5100 revB or higher with C6711D */
+	case 0x5110:	/* ASI5100 revB or higher with C6711D */
 	case 0x6100:
 	case 0x6200:
 		nBootLoadFamily = HPI_ADAPTER_FAMILY_ASI6200;
@@ -869,7 +869,7 @@ static short Hpi6000_AdapterBootLoadDsp(
 			HpiWriteWord(pdo, 0x01B7C120, 0x8002);
 			/* peri = 225/2 */
 			HpiWriteWord(pdo, 0x01B7C11C, 0x8001);
-			/* cpu	= 225/1 */
+			/* cpu  = 225/1 */
 			HpiWriteWord(pdo, 0x01B7C118, 0x8000);
 			/* ~200us delay */
 			for (i = 0; i < 2000; i++)
@@ -912,10 +912,10 @@ static short Hpi6000_AdapterBootLoadDsp(
 		}
 
 		/* memory map of ASI6200
-		   00000000-0000FFFF	16Kx32 internal program
-		   01800000-019FFFFF	Internal peripheral
-		   80000000-807FFFFF	CE0 2Mx32 SDRAM running @ 100MHz
-		   90000000-9000FFFF	CE1 Async peripherals:
+		   00000000-0000FFFF    16Kx32 internal program
+		   01800000-019FFFFF    Internal peripheral
+		   80000000-807FFFFF    CE0 2Mx32 SDRAM running @ 100MHz
+		   90000000-9000FFFF    CE1 Async peripherals:
 
 		   EMIF config
 		   ------------
@@ -928,41 +928,41 @@ static short Hpi6000_AdapterBootLoadDsp(
 		   5 EKEN = 1 <--!! C6713 specific, enables ECLKOUT
 		   6 -
 		   7 NOHOLD = 1   external HOLD disabled
-		   8 HOLDA = 0	  HOLDA output is low
-		   9 HOLD = 0		  HOLD input is low
-		   10 ARDY = 1	  ARDY input is high
+		   8 HOLDA = 0    HOLDA output is low
+		   9 HOLD = 0             HOLD input is low
+		   10 ARDY = 1    ARDY input is high
 		   11 BUSREQ = 0   BUSREQ output is low
 		   12,13 Reserved = 1
 		 */
 		HpiWriteWord(pdo, 0x01800000, 0x34A8);
 
 		/* EMIF CE0 setup - 2Mx32 Sync DRAM
-		   31..28	Wr setup
-		   27..22	Wr strobe
-		   21..20	Wr hold
-		   19..16	Rd setup
-		   15..14	-
-		   13..8	Rd strobe
-		   7..4		MTYPE	0011		Sync DRAM 32bits
-		   3		Wr hold MSB
-		   2..0		Rd hold
+		   31..28       Wr setup
+		   27..22       Wr strobe
+		   21..20       Wr hold
+		   19..16       Rd setup
+		   15..14       -
+		   13..8        Rd strobe
+		   7..4         MTYPE   0011            Sync DRAM 32bits
+		   3            Wr hold MSB
+		   2..0         Rd hold
 		 */
 		HpiWriteWord(pdo, 0x01800008, 0x00000030);
 
 		/* EMIF SDRAM Extension
-		   31-21	0
-		   20		WR2RD = 0
-		   19-18	WR2DEAC = 1
-		   17		WR2WR = 0
-		   16-15	R2WDQM = 2
-		   14-12	RD2WR = 4
-		   11-10	RD2DEAC = 1
-		   9		RD2RD = 1
-		   8-7		THZP = 10b
-		   6-5		TWR  = 2-1 = 01b (tWR = 10ns)
-		   4		TRRD = 0b = 2 ECLK (tRRD = 14ns)
-		   3-1		TRAS = 5-1 = 100b (Tras=42ns = 5 ECLK)
-		   1		CAS latency = 3 ECLK
+		   31-21        0
+		   20           WR2RD = 0
+		   19-18        WR2DEAC = 1
+		   17           WR2WR = 0
+		   16-15        R2WDQM = 2
+		   14-12        RD2WR = 4
+		   11-10        RD2DEAC = 1
+		   9            RD2RD = 1
+		   8-7          THZP = 10b
+		   6-5          TWR  = 2-1 = 01b (tWR = 10ns)
+		   4            TRRD = 0b = 2 ECLK (tRRD = 14ns)
+		   3-1          TRAS = 5-1 = 100b (Tras=42ns = 5 ECLK)
+		   1            CAS latency = 3 ECLK
 		   (for Micron 2M32-7 operating at 100Mhz)
 		 */
 
@@ -970,18 +970,18 @@ static short Hpi6000_AdapterBootLoadDsp(
 		HpiWriteWord(pdo, 0x01800020, 0x001BDF29);
 
 		/* EMIF SDRAM control - set up for a 2Mx32 SDRAM (512x32x4 bank)
-		   31		-		-
-		   30		SDBSZ	1		4 bank
-		   29..28	SDRSZ	00		11 row address pins
-		   27..26	SDCSZ	01		8 column address pins
-		   25		RFEN	1		refersh enabled
-		   24		INIT	1		init SDRAM
-		   23..20	TRCD	0001
-		   19..16	TRP		0001
-		   15..12	TRC		0110
-		   11..0	-		-
+		   31           -               -
+		   30           SDBSZ   1               4 bank
+		   29..28       SDRSZ   00              11 row address pins
+		   27..26       SDCSZ   01              8 column address pins
+		   25           RFEN    1               refersh enabled
+		   24           INIT    1               init SDRAM
+		   23..20       TRCD    0001
+		   19..16       TRP             0001
+		   15..12       TRC             0110
+		   11..0        -               -
 		 */
-		/*	need to use this else DSP code crashes */
+		/*      need to use this else DSP code crashes */
 		HpiWriteWord(pdo, 0x01800018, 0x47117000);
 
 		/* EMIF SDRAM Refresh Timing */
@@ -989,15 +989,15 @@ static short Hpi6000_AdapterBootLoadDsp(
 
 		/*MIF CE1 setup - Async peripherals
 		   @100MHz bus speed, each cycle is 10ns,
-		   31..28	Wr setup  = 1
-		   27..22	Wr strobe = 3			30ns
-		   21..20	Wr hold = 1
-		   19..16	Rd setup =1
-		   15..14	Ta = 2
-		   13..8	Rd strobe = 3			30ns
-		   7..4		MTYPE	0010		Async 32bits
-		   3		Wr hold MSB =0
-		   2..0		Rd hold = 1
+		   31..28       Wr setup  = 1
+		   27..22       Wr strobe = 3                   30ns
+		   21..20       Wr hold = 1
+		   19..16       Rd setup =1
+		   15..14       Ta = 2
+		   13..8        Rd strobe = 3                   30ns
+		   7..4         MTYPE   0010            Async 32bits
+		   3            Wr hold MSB =0
+		   2..0         Rd hold = 1
 		 */
 		{
 			u32 dwCE1 = (1L << 28) | (3L << 22) | (1L << 20) |
@@ -1243,7 +1243,7 @@ static short Hpi6000_AdapterBootLoadDsp(
 				return (HPI6000_ERROR_INIT_PLDTEST2);
 			}
 		}
-	}			/* for wNumDSP */
+	}	/* for wNumDSP */
 	return 0;
 }
 
@@ -1480,7 +1480,7 @@ static short Hpi6000_MessageResponseSequ
 	} else
 		dwAddress = phw->dwMessageBufferAddressOnDSP;
 
-	/*	  dwLength = sizeof(struct hpi_message); */
+	/*        dwLength = sizeof(struct hpi_message); */
 	dwLength = phm->wSize;
 
 	/* send it */
@@ -1550,7 +1550,7 @@ static short Hpi6000_SendData_CheckAdr(
 	u32 dwLengthInDwords
 )
 {
-/*#define CHECKING	 // comment this line in to enable checking */
+/*#define CHECKING       // comment this line in to enable checking */
 #ifdef CHECKING
 	if (dwAddress < (u32)MSG_ADDRESS)
 		return 0;
@@ -1658,7 +1658,7 @@ static short Hpi6000_GetData(
 	u32 dwLength, dwAddress;
 	u32 *pData = (u32 *)phm->u.d.u.Data.pbData;
 
-	(void)phr;		/* this parameter not used! */
+	(void)phr;	/* this parameter not used! */
 
 	/* round dwDataSize down to nearest 4 bytes */
 	while (dwDataGot < (phm->u.d.u.Data.dwDataSize & ~3L)) {
@@ -1799,7 +1799,7 @@ static short Hpi6000_WaitDspAck(
 			!Hpi6000_Check_PCI2040_ErrorFlag(pao, H6READ))
 			break;
 		/*for (i=0;i<1000;i++) */
-		/*	dwPause=i+1; */
+		/*      dwPause=i+1; */
 	}
 	if (dwAck & HPI_HIF_ERROR_MASK)
 		/* indicates bad read from DSP -
diff -r e285d93dfd8a pci/asihpi/hpi6000.h
--- a/pci/asihpi/hpi6000.h	Mon Mar 10 11:49:06 2008 +0100
+++ b/pci/asihpi/hpi6000.h	Thu Mar 13 12:27:12 2008 +1300
@@ -57,13 +57,13 @@ struct hpi_hif_6000 {
 		(adapterinfo & 0xff)
 
 /* Command/status exchanged between host and DSP */
-#define HPI_HIF_IDLE		0
-#define HPI_HIF_SEND_MSG	1
-#define HPI_HIF_GET_RESP	2
-#define HPI_HIF_DATA_MASK	0x10
-#define HPI_HIF_SEND_DATA	0x13
-#define HPI_HIF_GET_DATA	0x14
-#define HPI_HIF_SEND_DONE	5
-#define HPI_HIF_RESET		9
+#define HPI_HIF_IDLE            0
+#define HPI_HIF_SEND_MSG        1
+#define HPI_HIF_GET_RESP        2
+#define HPI_HIF_DATA_MASK       0x10
+#define HPI_HIF_SEND_DATA       0x13
+#define HPI_HIF_GET_DATA        0x14
+#define HPI_HIF_SEND_DONE       5
+#define HPI_HIF_RESET           9
 
 #endif				/* _HPI6000_H_ */
diff -r e285d93dfd8a pci/asihpi/hpi6205.c
--- a/pci/asihpi/hpi6205.c	Mon Mar 10 11:49:06 2008 +0100
+++ b/pci/asihpi/hpi6205.c	Thu Mar 13 12:42:49 2008 +1300
@@ -1,4 +1,3 @@
-
 /******************************************************************************
 
     AudioScience HPI driver
@@ -1673,7 +1672,8 @@ static u32 BootLoader_ReadMem32(
 	u32 dwData = 0;
 	__iomem u32 *pData;
 
-	if (nDSPIndex == 0) {	/* DSP 0 is always C6205 */
+	if (nDSPIndex == 0) {
+		/* DSP 0 is always C6205 */
 		if ((dwAddress >= 0x01800000) & (dwAddress < 0x02000000)) {
 			/* BAR1 register access */
 			pData = pao->Pci.apMemBase[1] +
@@ -1694,7 +1694,8 @@ static u32 BootLoader_ReadMem32(
 				dwAddress / sizeof(u32);
 		}
 		dwData = ioread32(pData);
-	} else if (nDSPIndex == 1) {	/* DSP 1 is a C6713 */
+	} else if (nDSPIndex == 1) {
+		/* DSP 1 is a C6713 */
 		u32 dwLsb;
 		BootLoader_WriteMem32(pao, 0, HPIAL_ADDR, dwAddress);
 		BootLoader_WriteMem32(pao, 0, HPIAH_ADDR, dwAddress >> 16);
@@ -1739,7 +1740,8 @@ static u16 BootLoader_WriteMem32(
 				dwAddress / sizeof(u32);
 		}
 		iowrite32(dwData, pData);
-	} else if (nDSPIndex == 1) {	/* DSP 1 is a C6713 */
+	} else if (nDSPIndex == 1) {
+		/* DSP 1 is a C6713 */
 		BootLoader_WriteMem32(pao, 0, HPIAL_ADDR, dwAddress);
 		BootLoader_WriteMem32(pao, 0, HPIAH_ADDR, dwAddress >> 16);
 
@@ -1970,7 +1972,7 @@ static u16 BootLoader_TestMemory(
 	/*for(i=0; i<dwLength; i++) */
 	i = 0;
 	{
-		dwTestAddr = dwStartAddress + (u32)i *4;
+		dwTestAddr = dwStartAddress + i * 4;
 		dwTestData = 0x00000001;
 		for (j = 0; j < 32; j++) {
 			BootLoader_WriteMem32(pao, nDSPIndex, dwTestAddr,
@@ -1993,7 +1995,7 @@ static u16 BootLoader_TestMemory(
 	/* write a zero to the next word in memory before we read */
 	/* the previous write to make sure every memory location is unique */
 	for (i = 0; i < 100; i++) {
-		dwTestAddr = dwStartAddress + (u32)i *4;
+		dwTestAddr = dwStartAddress + i * 4;
 		dwTestData = 0xA5A55A5A;
 		BootLoader_WriteMem32(pao, nDSPIndex, dwTestAddr, dwTestData);
 		BootLoader_WriteMem32(pao, nDSPIndex, dwTestAddr + 4, 0);
@@ -2011,7 +2013,7 @@ static u16 BootLoader_TestMemory(
 
 	/* zero out entire memory block */
 	for (i = 0; i < dwLength; i++) {
-		dwTestAddr = dwStartAddress + (u32)i *4;
+		dwTestAddr = dwStartAddress + i * 4;
 		BootLoader_WriteMem32(pao, nDSPIndex, dwTestAddr, 0x0);
 	}
 	return (0);	/*success! */
diff -r e285d93dfd8a pci/asihpi/hpicmn.c
--- a/pci/asihpi/hpicmn.c	Mon Mar 10 11:49:06 2008 +0100
+++ b/pci/asihpi/hpicmn.c	Thu Mar 13 12:42:19 2008 +1300
@@ -100,18 +100,17 @@ struct hpi_adapter_obj *HpiFindAdapter(
 
 	if (wAdapterIndex >= HPI_MAX_ADAPTERS) {
 		HPI_DEBUG_LOG(VERBOSE,
-			DBG_TEXT("FindAdapter invalid index %d "),
-			wAdapterIndex);
+			"FindAdapter invalid index %d ", wAdapterIndex);
 		return NULL;
 	}
 
 	pao = &adapters.adapter[wAdapterIndex];
 	if (pao->wAdapterType != 0) {
-		HPI_DEBUG_LOG(VERBOSE, DBG_TEXT("Found adapter index %d\n"),
+		HPI_DEBUG_LOG(VERBOSE, "Found adapter index %d\n",
 			wAdapterIndex);
 		return (pao);
 	} else {
-		HPI_DEBUG_LOG(VERBOSE, DBG_TEXT("No adapter index %d\n"),
+		HPI_DEBUG_LOG(VERBOSE, "No adapter index %d\n",
 			wAdapterIndex);
 		return (NULL);
 	}
@@ -154,7 +153,7 @@ static void SubSysGetAdapters(
 	short i;
 	struct hpi_adapter_obj *pao = NULL;
 
-	HPI_DEBUG_LOG(VERBOSE, DBG_TEXT("SubSysGetAdapters\n"));
+	HPI_DEBUG_LOG(VERBOSE, "SubSysGetAdapters\n");
 
 	/* for each adapter, place it's type in the position of the array */
 	/* corresponding to it's adapter number */
@@ -286,8 +285,8 @@ short HpiCheckControlCache(
 		break;
 	}
 	if (found == 0)
-		HPI_DEBUG_LOG(VERBOSE, DBG_TEXT("Adap %d, Control %d, ")
-			DBG_TEXT("Control type %d, Cached %d\n"),
+		HPI_DEBUG_LOG(VERBOSE, "Adap %d, Control %d, "
+			"Control type %d, Cached %d\n",
 			phm->wAdapterIndex, pC->ControlIndex,
 			pC->ControlType, found);
 
diff -r e285d93dfd8a pci/asihpi/hpidebug.c
--- a/pci/asihpi/hpidebug.c	Mon Mar 10 11:49:06 2008 +0100
+++ b/pci/asihpi/hpidebug.c	Thu Mar 13 12:42:23 2008 +1300
@@ -31,7 +31,7 @@ void HPI_DebugInit(
 	void
 )
 {
-	printk(DBG_TEXT("Debug Start\n"));
+	printk(KERN_INFO "Debug Start\n");
 }
 
 int HPI_DebugLevelSet(
@@ -57,12 +57,12 @@ int HPI_DebugLevelGet(
 #include <stdarg.h>
 
 void hpi_debug_printf(
-	DBG_CHAR * fmt,
+	char *fmt,
 	...
 )
 {
 	va_list arglist;
-	DBG_CHAR buffer[128];
+	char buffer[128];
 
 	va_start(arglist, fmt);
 
@@ -84,7 +84,7 @@ static struct treenode nodename = { \
 	ARRAY_SIZE(tmp_strarray_##nodename) \
 };
 
-#define get_treenode_elem(node_ptr, idx, type)	\
+#define get_treenode_elem(node_ptr, idx, type)  \
 	(&(*((type *)(node_ptr)->array)[idx]))
 
 make_treenode_from_array(hpi_subsys_strings, HPI_SUBSYS_STRINGS)
@@ -94,7 +94,7 @@ make_treenode_from_array(hpi_subsys_stri
 	make_treenode_from_array(hpi_mixer_strings, HPI_MIXER_STRINGS)
 	make_treenode_from_array(hpi_node_strings,
 	{
-	DBG_TEXT("NODE is invalid object")})
+	"NODE is invalid object"})
 
 	make_treenode_from_array(hpi_control_strings, HPI_CONTROL_STRINGS)
 	make_treenode_from_array(hpi_nvmemory_strings, HPI_OBJ_STRINGS)
@@ -124,7 +124,7 @@ make_treenode_from_array(hpi_subsys_stri
 
 	compile_time_assert(HPI_OBJ_MAXINDEX == 14, obj_list_doesnt_match);
 
-static DBG_CHAR *hpi_function_string(
+static char *hpi_function_string(
 	unsigned int function
 )
 {
@@ -136,20 +136,20 @@ static DBG_CHAR *hpi_function_string(
 
 	if (object == 0 || object == HPI_OBJ_NODE
 		|| object > hpi_function_strings.numElements)
-		return DBG_TEXT("Invalid object");
+		return "Invalid object";
 
 	tmp = get_treenode_elem(&hpi_function_strings, object - 1,
 		struct treenode *);
 
 	if (function == 0 || function > tmp->numElements)
-		return DBG_TEXT("Invalid function");
-
-	return get_treenode_elem(tmp, function - 1, DBG_CHAR *);
+		return "Invalid function";
+
+	return get_treenode_elem(tmp, function - 1, char *);
 }
 
 void hpi_debug_message(
 	struct hpi_message *phm,
-	DBG_CHAR * szFileline
+	char *szFileline
 )
 {
 	if (phm) {
@@ -185,20 +185,17 @@ void hpi_debug_message(
 			default:
 				break;
 			}
-			printk(DBG_TEXT
-				("%s Adapter %d %s param x%08x \n"),
+			printk("%s Adapter %d %s param x%08x \n",
 				szFileline, phm->wAdapterIndex,
 				hpi_function_string(phm->
 					wFunction), (wAttrib << 16) + wIndex);
 		} else {
-			printk(DBG_TEXT
-				("Adap=%d, Invalid Obj=%d, Func=%d\n"),
+			printk("Adap=%d, Invalid Obj=%d, Func=%d\n",
 				phm->wAdapterIndex, phm->wObject,
 				phm->wFunction);
 		}
 	} else
-		printk(DBG_TEXT
-			("NULL message pointer to hpi_debug_message!\n"));
+		printk("NULL message pointer to hpi_debug_message!\n");
 }
 
 void hpi_debug_data(
@@ -217,12 +214,11 @@ void hpi_debug_data(
 		lines = 8;
 
 	for (i = 0, j = 0; j < lines; j++) {
-		printk(DBG_TEXT("%p:"), (pdata + i));
+		printk(KERN_DEBUG "%p:", (pdata + i));
 
 		for (k = 0; k < cols && i < len; i++, k++)
-			printk(DBG_TEXT("%s%04x"),
-				k == 0 ? "" : " ", pdata[i]);
-
-		printk(DBG_TEXT("\n"));
+			printk("%s%04x", k == 0 ? "" : " ", pdata[i]);
+
+		printk("\n");
 	}
 }
diff -r e285d93dfd8a pci/asihpi/hpidebug.h
--- a/pci/asihpi/hpidebug.h	Mon Mar 10 11:49:06 2008 +0100
+++ b/pci/asihpi/hpidebug.h	Thu Mar 13 12:42:22 2008 +1300
@@ -30,12 +30,6 @@ Debug macros.
 /* *INDENT-OFF* */
 extern "C" {
 /* *INDENT-ON* */
-#endif
-
-/* Default DBG character type definitions. */
-#ifndef DBG_TEXT
-#define DBG_TEXT(s) s
-#define DBG_CHAR char
 #endif
 
 /* Define debugging levels.  */
@@ -53,15 +47,9 @@ enum { HPI_DEBUG_LEVEL_ERROR = 0,	/* Alw
    the start of each message, eg see hpios_linux.h */
 
 #ifdef SOURCEFILE_NAME
-#define FILE_LINE  DBG_TEXT(SOURCEFILE_NAME) \
-			 DBG_TEXT(":") \
-			 DBG_TEXT(__stringify(__LINE__)) \
-			 DBG_TEXT(" ")
+#define FILE_LINE  SOURCEFILE_NAME ":" __stringify(__LINE__) " "
 #else
-#define FILE_LINE  DBG_TEXT(__FILE__) \
-			 DBG_TEXT(":") \
-			 DBG_TEXT(__stringify(__LINE__)) \
-			 DBG_TEXT(" ")
+#define FILE_LINE  __FILE__ ":" __stringify(__LINE__) " "
 #endif
 
 #define HPI_DEBUG_LOG(level, ...) \
@@ -86,7 +74,7 @@ extern int hpiDebugLevel;
 
 void hpi_debug_message(
 	struct hpi_message *phm,
-	DBG_CHAR * szFileline
+	char *szFileline
 );
 
 void hpi_debug_data(
@@ -94,28 +82,28 @@ void hpi_debug_data(
 	u32 len
 );
 
-#define HPI_DEBUG_DATA(pdata, len)					\
-	do {								\
+#define HPI_DEBUG_DATA(pdata, len)                                      \
+	do {                                                            \
 		if (hpiDebugLevel >= HPI_DEBUG_LEVEL_VERBOSE) \
 			hpi_debug_data(pdata, len); \
 	} while (0)
 
-#define HPI_DEBUG_MESSAGE(phm)						\
-	do {								\
-		if (hpiDebugLevel >= HPI_DEBUG_LEVEL_DEBUG) {		\
-			hpi_debug_message(phm,HPI_DEBUG_FLAG_DEBUG	\
-				FILE_LINE DBG_TEXT("DEBUG "));		\
-		}							\
-	} while (0)
-
-#define HPI_DEBUG_RESPONSE(phr)						\
-	do {								\
+#define HPI_DEBUG_MESSAGE(level, phm)                                   \
+	do {                                                            \
+		if (hpiDebugLevel >= HPI_DEBUG_LEVEL_##level) {         \
+			hpi_debug_message(phm,HPI_DEBUG_FLAG_##level    \
+				FILE_LINE __stringify(level));\
+		}                                                       \
+	} while (0)
+
+#define HPI_DEBUG_RESPONSE(phr)                                         \
+	do {                                                            \
 		if ((hpiDebugLevel >= HPI_DEBUG_LEVEL_DEBUG) && (phr->wError))\
 			HPI_DEBUG_LOG(ERROR, \
-				DBG_TEXT("HPI Response - error# %d\n"), \
+				"HPI Response - error# %d\n", \
 				phr->wError); \
 		else if (hpiDebugLevel >= HPI_DEBUG_LEVEL_VERBOSE) \
-			HPI_DEBUG_LOG(VERBOSE, DBG_TEXT("HPI Response OK\n"));\
+			HPI_DEBUG_LOG(VERBOSE, "HPI Response OK\n");\
 	} while (0)
 
 #ifndef compile_time_assert
@@ -131,215 +119,215 @@ void hpi_debug_data(
 /* These strings should be generated using a macro which defines
    the corresponding symbol values.  */
 #define HPI_OBJ_STRINGS \
-{				\
-  DBG_TEXT("HPI_OBJ_SUBSYSTEM"),	\
-  DBG_TEXT("HPI_OBJ_ADAPTER"),		\
-  DBG_TEXT("HPI_OBJ_OSTREAM"),		\
-  DBG_TEXT("HPI_OBJ_ISTREAM"),		\
-  DBG_TEXT("HPI_OBJ_MIXER"),		\
-  DBG_TEXT("HPI_OBJ_NODE"),		\
-  DBG_TEXT("HPI_OBJ_CONTROL"),		\
-  DBG_TEXT("HPI_OBJ_NVMEMORY"),		\
-  DBG_TEXT("HPI_OBJ_DIGITALIO"),	\
-  DBG_TEXT("HPI_OBJ_WATCHDOG"),		\
-  DBG_TEXT("HPI_OBJ_CLOCK"),		\
-  DBG_TEXT("HPI_OBJ_PROFILE"),		\
-  DBG_TEXT("HPI_OBJ_CONTROLEX")		\
-}
-
-#define HPI_SUBSYS_STRINGS	\
-{				\
-  DBG_TEXT("HPI_SUBSYS_OPEN"),		\
-  DBG_TEXT("HPI_SUBSYS_GET_VERSION"),	\
-  DBG_TEXT("HPI_SUBSYS_GET_INFO"),	\
-  DBG_TEXT("HPI_SUBSYS_FIND_ADAPTERS"), \
-  DBG_TEXT("HPI_SUBSYS_CREATE_ADAPTER"),\
-  DBG_TEXT("HPI_SUBSYS_CLOSE"),		\
-  DBG_TEXT("HPI_SUBSYS_DELETE_ADAPTER"), \
-  DBG_TEXT("HPI_SUBSYS_DRIVER_LOAD"), \
-  DBG_TEXT("HPI_SUBSYS_DRIVER_UNLOAD"), \
-  DBG_TEXT("HPI_SUBSYS_READ_PORT_8"),	\
-  DBG_TEXT("HPI_SUBSYS_WRITE_PORT_8"),	\
-  DBG_TEXT("HPI_SUBSYS_GET_NUM_ADAPTERS"),\
-  DBG_TEXT("HPI_SUBSYS_GET_ADAPTER")	\
-}
-
-#define HPI_ADAPTER_STRINGS	\
-{				\
-  DBG_TEXT("HPI_ADAPTER_OPEN"),		\
-  DBG_TEXT("HPI_ADAPTER_CLOSE"),	\
-  DBG_TEXT("HPI_ADAPTER_GET_INFO"),	\
-  DBG_TEXT("HPI_ADAPTER_GET_ASSERT"),	\
-  DBG_TEXT("HPI_ADAPTER_TEST_ASSERT"),	  \
-  DBG_TEXT("HPI_ADAPTER_SET_MODE"),	  \
-  DBG_TEXT("HPI_ADAPTER_GET_MODE"),	  \
-  DBG_TEXT("HPI_ADAPTER_ENABLE_CAPABILITY"),\
-  DBG_TEXT("HPI_ADAPTER_SELFTEST"),	   \
-  DBG_TEXT("HPI_ADAPTER_FIND_OBJECT"),	   \
-  DBG_TEXT("HPI_ADAPTER_QUERY_FLASH"),	   \
-  DBG_TEXT("HPI_ADAPTER_START_FLASH"),	   \
-  DBG_TEXT("HPI_ADAPTER_PROGRAM_FLASH"),   \
-  DBG_TEXT("HPI_ADAPTER_SET_PROPERTY"),    \
-  DBG_TEXT("HPI_ADAPTER_GET_PROPERTY"),    \
-  DBG_TEXT("HPI_ADAPTER_ENUM_PROPERTY"),    \
-  DBG_TEXT("HPI_ADAPTER_MODULE_INFO")	 \
+{                               \
+  "HPI_OBJ_SUBSYSTEM",        \
+  "HPI_OBJ_ADAPTER",          \
+  "HPI_OBJ_OSTREAM",          \
+  "HPI_OBJ_ISTREAM",          \
+  "HPI_OBJ_MIXER",            \
+  "HPI_OBJ_NODE",             \
+  "HPI_OBJ_CONTROL",          \
+  "HPI_OBJ_NVMEMORY",         \
+  "HPI_OBJ_DIGITALIO",        \
+  "HPI_OBJ_WATCHDOG",         \
+  "HPI_OBJ_CLOCK",            \
+  "HPI_OBJ_PROFILE",          \
+  "HPI_OBJ_CONTROLEX"         \
+}
+
+#define HPI_SUBSYS_STRINGS      \
+{                               \
+  "HPI_SUBSYS_OPEN",          \
+  "HPI_SUBSYS_GET_VERSION",   \
+  "HPI_SUBSYS_GET_INFO",      \
+  "HPI_SUBSYS_FIND_ADAPTERS", \
+  "HPI_SUBSYS_CREATE_ADAPTER",\
+  "HPI_SUBSYS_CLOSE",         \
+  "HPI_SUBSYS_DELETE_ADAPTER", \
+  "HPI_SUBSYS_DRIVER_LOAD", \
+  "HPI_SUBSYS_DRIVER_UNLOAD", \
+  "HPI_SUBSYS_READ_PORT_8",   \
+  "HPI_SUBSYS_WRITE_PORT_8",  \
+  "HPI_SUBSYS_GET_NUM_ADAPTERS",\
+  "HPI_SUBSYS_GET_ADAPTER"    \
+}
+
+#define HPI_ADAPTER_STRINGS     \
+{                               \
+  "HPI_ADAPTER_OPEN",         \
+  "HPI_ADAPTER_CLOSE",        \
+  "HPI_ADAPTER_GET_INFO",     \
+  "HPI_ADAPTER_GET_ASSERT",   \
+  "HPI_ADAPTER_TEST_ASSERT",    \
+  "HPI_ADAPTER_SET_MODE",       \
+  "HPI_ADAPTER_GET_MODE",       \
+  "HPI_ADAPTER_ENABLE_CAPABILITY",\
+  "HPI_ADAPTER_SELFTEST",        \
+  "HPI_ADAPTER_FIND_OBJECT",     \
+  "HPI_ADAPTER_QUERY_FLASH",     \
+  "HPI_ADAPTER_START_FLASH",     \
+  "HPI_ADAPTER_PROGRAM_FLASH",   \
+  "HPI_ADAPTER_SET_PROPERTY",    \
+  "HPI_ADAPTER_GET_PROPERTY",    \
+  "HPI_ADAPTER_ENUM_PROPERTY",    \
+  "HPI_ADAPTER_MODULE_INFO"    \
 }
 
 function_count_check(HPI_ADAPTER, 17);
 
-#define HPI_OSTREAM_STRINGS	\
-{				\
-  DBG_TEXT("HPI_OSTREAM_OPEN"),		\
-  DBG_TEXT("HPI_OSTREAM_CLOSE"),	\
-  DBG_TEXT("HPI_OSTREAM_WRITE"),	\
-  DBG_TEXT("HPI_OSTREAM_START"),	\
-  DBG_TEXT("HPI_OSTREAM_STOP"),		\
-  DBG_TEXT("HPI_OSTREAM_RESET"),		\
-  DBG_TEXT("HPI_OSTREAM_GET_INFO"),	\
-  DBG_TEXT("HPI_OSTREAM_QUERY_FORMAT"), \
-  DBG_TEXT("HPI_OSTREAM_DATA"),		\
-  DBG_TEXT("HPI_OSTREAM_SET_VELOCITY"), \
-  DBG_TEXT("HPI_OSTREAM_SET_PUNCHINOUT"), \
-  DBG_TEXT("HPI_OSTREAM_SINEGEN"),	  \
-  DBG_TEXT("HPI_OSTREAM_ANC_RESET"),	  \
-  DBG_TEXT("HPI_OSTREAM_ANC_GET_INFO"),   \
-  DBG_TEXT("HPI_OSTREAM_ANC_READ"),	  \
-  DBG_TEXT("HPI_OSTREAM_SET_TIMESCALE"),\
-  DBG_TEXT("HPI_OSTREAM_SET_FORMAT"), \
-  DBG_TEXT("HPI_OSTREAM_HOSTBUFFER_ALLOC"), \
-  DBG_TEXT("HPI_OSTREAM_HOSTBUFFER_FREE"), \
-  DBG_TEXT("HPI_OSTREAM_GROUP_ADD"),\
-  DBG_TEXT("HPI_OSTREAM_GROUP_GETMAP"), \
-  DBG_TEXT("HPI_OSTREAM_GROUP_RESET"), \
+#define HPI_OSTREAM_STRINGS     \
+{                               \
+  "HPI_OSTREAM_OPEN",         \
+  "HPI_OSTREAM_CLOSE",        \
+  "HPI_OSTREAM_WRITE",        \
+  "HPI_OSTREAM_START",        \
+  "HPI_OSTREAM_STOP",         \
+  "HPI_OSTREAM_RESET",                \
+  "HPI_OSTREAM_GET_INFO",     \
+  "HPI_OSTREAM_QUERY_FORMAT", \
+  "HPI_OSTREAM_DATA",         \
+  "HPI_OSTREAM_SET_VELOCITY", \
+  "HPI_OSTREAM_SET_PUNCHINOUT", \
+  "HPI_OSTREAM_SINEGEN",        \
+  "HPI_OSTREAM_ANC_RESET",      \
+  "HPI_OSTREAM_ANC_GET_INFO",   \
+  "HPI_OSTREAM_ANC_READ",       \
+  "HPI_OSTREAM_SET_TIMESCALE",\
+  "HPI_OSTREAM_SET_FORMAT", \
+  "HPI_OSTREAM_HOSTBUFFER_ALLOC", \
+  "HPI_OSTREAM_HOSTBUFFER_FREE", \
+  "HPI_OSTREAM_GROUP_ADD",\
+  "HPI_OSTREAM_GROUP_GETMAP", \
+  "HPI_OSTREAM_GROUP_RESET", \
 }
 function_count_check(HPI_OSTREAM, 22);
 
-#define HPI_ISTREAM_STRINGS	\
-{				\
-  DBG_TEXT("HPI_ISTREAM_OPEN"),		\
-  DBG_TEXT("HPI_ISTREAM_CLOSE"),	\
-  DBG_TEXT("HPI_ISTREAM_SET_FORMAT"),	\
-  DBG_TEXT("HPI_ISTREAM_READ"),		\
-  DBG_TEXT("HPI_ISTREAM_START"),	\
-  DBG_TEXT("HPI_ISTREAM_STOP"),		\
-  DBG_TEXT("HPI_ISTREAM_RESET"),	\
-  DBG_TEXT("HPI_ISTREAM_GET_INFO"),	\
-  DBG_TEXT("HPI_ISTREAM_QUERY_FORMAT"), \
-  DBG_TEXT("HPI_ISTREAM_ANC_RESET"),	  \
-  DBG_TEXT("HPI_ISTREAM_ANC_GET_INFO"),   \
-  DBG_TEXT("HPI_ISTREAM_ANC_WRITE"),   \
-  DBG_TEXT("HPI_ISTREAM_HOSTBUFFER_ALLOC"),\
-  DBG_TEXT("HPI_ISTREAM_HOSTBUFFER_FREE"), \
-  DBG_TEXT("HPI_ISTREAM_GROUP_ADD"), \
-  DBG_TEXT("HPI_ISTREAM_GROUP_GETMAP"), \
-  DBG_TEXT("HPI_ISTREAM_GROUP_RESET"), \
+#define HPI_ISTREAM_STRINGS     \
+{                               \
+  "HPI_ISTREAM_OPEN",         \
+  "HPI_ISTREAM_CLOSE",        \
+  "HPI_ISTREAM_SET_FORMAT",   \
+  "HPI_ISTREAM_READ",         \
+  "HPI_ISTREAM_START",        \
+  "HPI_ISTREAM_STOP",         \
+  "HPI_ISTREAM_RESET",        \
+  "HPI_ISTREAM_GET_INFO",     \
+  "HPI_ISTREAM_QUERY_FORMAT", \
+  "HPI_ISTREAM_ANC_RESET",      \
+  "HPI_ISTREAM_ANC_GET_INFO",   \
+  "HPI_ISTREAM_ANC_WRITE",   \
+  "HPI_ISTREAM_HOSTBUFFER_ALLOC",\
+  "HPI_ISTREAM_HOSTBUFFER_FREE", \
+  "HPI_ISTREAM_GROUP_ADD", \
+  "HPI_ISTREAM_GROUP_GETMAP", \
+  "HPI_ISTREAM_GROUP_RESET", \
 }
 function_count_check(HPI_ISTREAM, 17);
 
-#define HPI_MIXER_STRINGS	\
-{				\
-  DBG_TEXT("HPI_MIXER_OPEN"),		\
-  DBG_TEXT("HPI_MIXER_CLOSE"),		\
-  DBG_TEXT("HPI_MIXER_GET_INFO"),	\
-  DBG_TEXT("HPI_MIXER_GET_NODE_INFO"),	\
-  DBG_TEXT("HPI_MIXER_GET_CONTROL"),	\
-  DBG_TEXT("HPI_MIXER_SET_CONNECTION"), \
-  DBG_TEXT("HPI_MIXER_GET_CONNECTIONS"),	\
-  DBG_TEXT("HPI_MIXER_GET_CONTROL_BY_INDEX"),	\
-  DBG_TEXT("HPI_MIXER_GET_CONTROL_ARRAY_BY_INDEX"),	\
-  DBG_TEXT("HPI_MIXER_GET_CONTROL_MULTIPLE_VALUES"),	\
-  DBG_TEXT("HPI_MIXER_STORE"),	\
+#define HPI_MIXER_STRINGS       \
+{                               \
+  "HPI_MIXER_OPEN",           \
+  "HPI_MIXER_CLOSE",          \
+  "HPI_MIXER_GET_INFO",       \
+  "HPI_MIXER_GET_NODE_INFO",  \
+  "HPI_MIXER_GET_CONTROL",    \
+  "HPI_MIXER_SET_CONNECTION", \
+  "HPI_MIXER_GET_CONNECTIONS",        \
+  "HPI_MIXER_GET_CONTROL_BY_INDEX",   \
+  "HPI_MIXER_GET_CONTROL_ARRAY_BY_INDEX",     \
+  "HPI_MIXER_GET_CONTROL_MULTIPLE_VALUES",    \
+  "HPI_MIXER_STORE",  \
 }
 function_count_check(HPI_MIXER, 11);
 
-#define HPI_CONTROL_STRINGS	\
-{				\
-  DBG_TEXT("HPI_CONTROL_GET_INFO"),	\
-  DBG_TEXT("HPI_CONTROL_GET_STATE"),	\
-  DBG_TEXT("HPI_CONTROL_SET_STATE")	\
+#define HPI_CONTROL_STRINGS     \
+{                               \
+  "HPI_CONTROL_GET_INFO",     \
+  "HPI_CONTROL_GET_STATE",    \
+  "HPI_CONTROL_SET_STATE"     \
 }
 function_count_check(HPI_CONTROL, 3);
 
-#define HPI_NVMEMORY_STRINGS	\
-{				\
-  DBG_TEXT("HPI_NVMEMORY_OPEN"),	\
-  DBG_TEXT("HPI_NVMEMORY_READ_BYTE"),	\
-  DBG_TEXT("HPI_NVMEMORY_WRITE_BYTE")	\
+#define HPI_NVMEMORY_STRINGS    \
+{                               \
+  "HPI_NVMEMORY_OPEN",        \
+  "HPI_NVMEMORY_READ_BYTE",   \
+  "HPI_NVMEMORY_WRITE_BYTE"   \
 }
 function_count_check(HPI_NVMEMORY, 3);
 
-#define HPI_DIGITALIO_STRINGS	\
-{				\
-  DBG_TEXT("HPI_GPIO_OPEN"),		\
-  DBG_TEXT("HPI_GPIO_READ_BIT"),	\
-  DBG_TEXT("HPI_GPIO_WRITE_BIT"),	\
-  DBG_TEXT("HPI_GPIO_READ_ALL")\
+#define HPI_DIGITALIO_STRINGS   \
+{                               \
+  "HPI_GPIO_OPEN",            \
+  "HPI_GPIO_READ_BIT",        \
+  "HPI_GPIO_WRITE_BIT",       \
+  "HPI_GPIO_READ_ALL"\
 }
 function_count_check(HPI_GPIO, 4);
 
-#define HPI_WATCHDOG_STRINGS	\
-{				\
-  DBG_TEXT("HPI_WATCHDOG_OPEN"),	\
-  DBG_TEXT("HPI_WATCHDOG_SET_TIME"),	\
-  DBG_TEXT("HPI_WATCHDOG_PING")		\
-}
-
-#define HPI_CLOCK_STRINGS	\
-{				\
-  DBG_TEXT("HPI_CLOCK_OPEN"),		\
-  DBG_TEXT("HPI_CLOCK_SET_TIME"),	\
-  DBG_TEXT("HPI_CLOCK_GET_TIME")	\
-}
-
-#define HPI_PROFILE_STRINGS	\
-{				\
-  DBG_TEXT("HPI_PROFILE_OPEN_ALL"),	\
-  DBG_TEXT("HPI_PROFILE_START_ALL"),	\
-  DBG_TEXT("HPI_PROFILE_STOP_ALL"),	\
-  DBG_TEXT("HPI_PROFILE_GET"),		\
-  DBG_TEXT("HPI_PROFILE_GET_IDLECOUNT"),  \
-  DBG_TEXT("HPI_PROFILE_GET_NAME"),	  \
-  DBG_TEXT("HPI_PROFILE_GET_UTILIZATION") \
+#define HPI_WATCHDOG_STRINGS    \
+{                               \
+  "HPI_WATCHDOG_OPEN",        \
+  "HPI_WATCHDOG_SET_TIME",    \
+  "HPI_WATCHDOG_PING"         \
+}
+
+#define HPI_CLOCK_STRINGS       \
+{                               \
+  "HPI_CLOCK_OPEN",           \
+  "HPI_CLOCK_SET_TIME",       \
+  "HPI_CLOCK_GET_TIME"        \
+}
+
+#define HPI_PROFILE_STRINGS     \
+{                               \
+  "HPI_PROFILE_OPEN_ALL",     \
+  "HPI_PROFILE_START_ALL",    \
+  "HPI_PROFILE_STOP_ALL",     \
+  "HPI_PROFILE_GET",          \
+  "HPI_PROFILE_GET_IDLECOUNT",  \
+  "HPI_PROFILE_GET_NAME",       \
+  "HPI_PROFILE_GET_UTILIZATION" \
 }
 function_count_check(HPI_PROFILE, 7);
 
-#define HPI_ASYNCEVENT_STRINGS	\
-{				\
-  DBG_TEXT("HPI_ASYNCEVENT_OPEN"),\
-  DBG_TEXT("HPI_ASYNCEVENT_CLOSE  "),\
-  DBG_TEXT("HPI_ASYNCEVENT_WAIT"),\
-  DBG_TEXT("HPI_ASYNCEVENT_GETCOUNT"),\
-  DBG_TEXT("HPI_ASYNCEVENT_GET"),\
-  DBG_TEXT("HPI_ASYNCEVENT_SENDEVENTS")\
+#define HPI_ASYNCEVENT_STRINGS  \
+{                               \
+  "HPI_ASYNCEVENT_OPEN",\
+  "HPI_ASYNCEVENT_CLOSE  ",\
+  "HPI_ASYNCEVENT_WAIT",\
+  "HPI_ASYNCEVENT_GETCOUNT",\
+  "HPI_ASYNCEVENT_GET",\
+  "HPI_ASYNCEVENT_SENDEVENTS"\
 }
 function_count_check(HPI_ASYNCEVENT, 6);
 
 #define HPI_CONTROL_TYPE_STRINGS \
 { \
-	DBG_TEXT("no control (0)"), \
-	DBG_TEXT("HPI_CONTROL_CONNECTION"), \
-	DBG_TEXT("HPI_CONTROL_VOLUME"), \
-	DBG_TEXT("HPI_CONTROL_METER"), \
-	DBG_TEXT("HPI_CONTROL_MUTE"), \
-	DBG_TEXT("HPI_CONTROL_MULTIPLEXER"), \
-	DBG_TEXT("HPI_CONTROL_AESEBU_TRANSMITTER"), \
-	DBG_TEXT("HPI_CONTROL_AESEBU_RECEIVER"), \
-	DBG_TEXT("HPI_CONTROL_LEVEL"), \
-	DBG_TEXT("HPI_CONTROL_TUNER"), \
-	DBG_TEXT("HPI_CONTROL_ONOFFSWITCH"), \
-	DBG_TEXT("HPI_CONTROL_VOX"), \
-	DBG_TEXT("HPI_CONTROL_AES18_TRANSMITTER"), \
-	DBG_TEXT("HPI_CONTROL_AES18_RECEIVER"), \
-	DBG_TEXT("HPI_CONTROL_AES18_BLOCKGENERATOR"), \
-	DBG_TEXT("HPI_CONTROL_CHANNEL_MODE"), \
-	DBG_TEXT("HPI_CONTROL_BITSTREAM"), \
-	DBG_TEXT("HPI_CONTROL_SAMPLECLOCK"), \
-	DBG_TEXT("HPI_CONTROL_MICROPHONE"), \
-	DBG_TEXT("HPI_CONTROL_PARAMETRIC_EQ"), \
-	DBG_TEXT("HPI_CONTROL_COMPANDER"), \
-	DBG_TEXT("HPI_CONTROL_COBRANET"), \
-	DBG_TEXT("HPI_CONTROL_TONE_DETECT"), \
-	DBG_TEXT("HPI_CONTROL_SILENCE_DETECT") \
+	"no control (0"), \
+	"HPI_CONTROL_CONNECTION", \
+	"HPI_CONTROL_VOLUME", \
+	"HPI_CONTROL_METER", \
+	"HPI_CONTROL_MUTE", \
+	"HPI_CONTROL_MULTIPLEXER", \
+	"HPI_CONTROL_AESEBU_TRANSMITTER", \
+	"HPI_CONTROL_AESEBU_RECEIVER", \
+	"HPI_CONTROL_LEVEL", \
+	"HPI_CONTROL_TUNER", \
+	"HPI_CONTROL_ONOFFSWITCH", \
+	"HPI_CONTROL_VOX", \
+	"HPI_CONTROL_AES18_TRANSMITTER", \
+	"HPI_CONTROL_AES18_RECEIVER", \
+	"HPI_CONTROL_AES18_BLOCKGENERATOR", \
+	"HPI_CONTROL_CHANNEL_MODE", \
+	"HPI_CONTROL_BITSTREAM", \
+	"HPI_CONTROL_SAMPLECLOCK", \
+	"HPI_CONTROL_MICROPHONE", \
+	"HPI_CONTROL_PARAMETRIC_EQ", \
+	"HPI_CONTROL_COMPANDER", \
+	"HPI_CONTROL_COBRANET", \
+	"HPI_CONTROL_TONE_DETECT", \
+	"HPI_CONTROL_SILENCE_DETECT" \
 }
 
 compile_time_assert((HPI_CONTROL_LAST_INDEX + 1) == (24),
@@ -347,16 +335,16 @@ compile_time_assert((HPI_CONTROL_LAST_IN
 
 #define HPI_SOURCENODE_STRINGS \
 { \
-	DBG_TEXT("no source"), \
-	DBG_TEXT("HPI_SOURCENODE_OSTREAM"), \
-	DBG_TEXT("HPI_SOURCENODE_LINEIN"), \
-	DBG_TEXT("HPI_SOURCENODE_AESEBU_IN"), \
-	DBG_TEXT("HPI_SOURCENODE_TUNER"), \
-	DBG_TEXT("HPI_SOURCENODE_RF"), \
-	DBG_TEXT("HPI_SOURCENODE_CLOCK_SOURCE"), \
-	DBG_TEXT("HPI_SOURCENODE_RAW_BITSTREAM"), \
-	DBG_TEXT("HPI_SOURCENODE_MICROPHONE"), \
-	DBG_TEXT("HPI_SOURCENODE_COBRANET") \
+	"no source", \
+	"HPI_SOURCENODE_OSTREAM", \
+	"HPI_SOURCENODE_LINEIN", \
+	"HPI_SOURCENODE_AESEBU_IN", \
+	"HPI_SOURCENODE_TUNER", \
+	"HPI_SOURCENODE_RF", \
+	"HPI_SOURCENODE_CLOCK_SOURCE", \
+	"HPI_SOURCENODE_RAW_BITSTREAM", \
+	"HPI_SOURCENODE_MICROPHONE", \
+	"HPI_SOURCENODE_COBRANET" \
 }
 
 compile_time_assert((HPI_SOURCENODE_LAST_INDEX - HPI_SOURCENODE_BASE + 1) ==
@@ -364,24 +352,24 @@ compile_time_assert((HPI_SOURCENODE_LAST
 
 #define HPI_DESTNODE_STRINGS \
 { \
-	DBG_TEXT("no destination"), \
-	DBG_TEXT("HPI_DESTNODE_ISTREAM"), \
-	DBG_TEXT("HPI_DESTNODE_LINEOUT"), \
-	DBG_TEXT("HPI_DESTNODE_AESEBU_OUT"), \
-	DBG_TEXT("HPI_DESTNODE_RF"), \
-	DBG_TEXT("HPI_DESTNODE_SPEAKER"), \
-	DBG_TEXT("HPI_DESTNODE_COBRANET") \
+	"no destination", \
+	"HPI_DESTNODE_ISTREAM", \
+	"HPI_DESTNODE_LINEOUT", \
+	"HPI_DESTNODE_AESEBU_OUT", \
+	"HPI_DESTNODE_RF", \
+	"HPI_DESTNODE_SPEAKER", \
+	"HPI_DESTNODE_COBRANET" \
 }
 compile_time_assert((HPI_DESTNODE_LAST_INDEX - HPI_DESTNODE_BASE + 1) == (7),
 	destnode_strings_dont_match_defs);
 
 #define HPI_CONTROL_CHANNEL_MODE_STRINGS \
 { \
-	DBG_TEXT("XXX HPI_CHANNEL_MODE_ERROR XXX"), \
-	DBG_TEXT("HPI_CHANNEL_MODE_NORMAL"), \
-	DBG_TEXT("HPI_CHANNEL_MODE_SWAP"), \
-	DBG_TEXT("HPI_CHANNEL_MODE_LEFT_ONLY"), \
-	DBG_TEXT("HPI_CHANNEL_MODE_RIGHT_ONLY") \
+	"XXX HPI_CHANNEL_MODE_ERROR XXX", \
+	"HPI_CHANNEL_MODE_NORMAL", \
+	"HPI_CHANNEL_MODE_SWAP", \
+	"HPI_CHANNEL_MODE_LEFT_ONLY", \
+	"HPI_CHANNEL_MODE_RIGHT_ONLY" \
 }
 
 #ifdef __cplusplus
@@ -389,4 +377,4 @@ compile_time_assert((HPI_DESTNODE_LAST_I
 }
 /* *INDENT-ON* */
 #endif
-#endif				/* _HPIDEBUG_H	*/
+#endif				/* _HPIDEBUG_H  */
diff -r e285d93dfd8a pci/asihpi/hpidspcd.c
--- a/pci/asihpi/hpidspcd.c	Mon Mar 10 11:49:06 2008 +0100
+++ b/pci/asihpi/hpidspcd.c	Thu Mar 13 12:42:25 2008 +1300
@@ -133,7 +133,7 @@ void HpiDspCode_Rewind(
 	struct dsp_code *psDspCode
 )
 {
-	/* Go back to start of	data, after header */
+	/* Go back to start of  data, after header */
 	psDspCode->dwWordCount = sizeof(struct code_header) / sizeof(u32);
 }
 
diff -r e285d93dfd8a pci/asihpi/hpifunc.c
--- a/pci/asihpi/hpifunc.c	Mon Mar 10 11:49:06 2008 +0100
+++ b/pci/asihpi/hpifunc.c	Thu Mar 13 12:42:41 2008 +1300
@@ -3668,14 +3668,14 @@ u16 HPI_FormatCreate(
 		break;
 	case HPI_FORMAT_PCM16_SIGNED:
 	case HPI_FORMAT_PCM16_BIGENDIAN:
-		Format.dwBitRate = (u32)wChannels *dwSampleRate * 2;
+		Format.dwBitRate = wChannels * dwSampleRate * 2;
 		break;
 	case HPI_FORMAT_PCM32_SIGNED:
 	case HPI_FORMAT_PCM32_FLOAT:
-		Format.dwBitRate = (u32)wChannels *dwSampleRate * 4;
+		Format.dwBitRate = wChannels * dwSampleRate * 4;
 		break;
 	case HPI_FORMAT_PCM8_UNSIGNED:
-		Format.dwBitRate = (u32)wChannels *dwSampleRate;
+		Format.dwBitRate = wChannels * dwSampleRate;
 		break;
 	default:
 		Format.dwBitRate = 0;
diff -r e285d93dfd8a pci/asihpi/hpimod.c
--- a/pci/asihpi/hpimod.c	Mon Mar 10 11:49:06 2008 +0100
+++ b/pci/asihpi/hpimod.c	Thu Mar 13 12:27:22 2008 +1300
@@ -75,7 +75,7 @@ module_param(bufsize, int,
 	S_IRUGO
 );
 /* Allow the debug level to be changed after module load.
- E.g.	echo 2 > /sys/module/asihpi/parameters/hpiDebugLevel
+ E.g.   echo 2 > /sys/module/asihpi/parameters/hpiDebugLevel
 */
 module_param(hpiDebugLevel, int,
 	S_IRUGO | S_IWUSR
@@ -194,7 +194,7 @@ static int asihpi_hpi_ioctl(
 	get_user(phm, &phpi_ioctl_data->phm);
 	get_user(phr, &phpi_ioctl_data->phr);
 
-	/* Now read the message size and data from user space.	*/
+	/* Now read the message size and data from user space.  */
 	/* get_user(hm.wSize, (u16 __user *)phm); */
 	uncopied_bytes = copy_from_user(&hm, phm, sizeof(hm));
 	if (uncopied_bytes)
@@ -588,7 +588,7 @@ static int __init hpimod_init(
 		return -EIO;
 	}
 
-	if (!major)		/* Use dynamically allocated major number. */
+	if (!major)	/* Use dynamically allocated major number. */
 		major = chrdev_registered;
 
 	/* would like to create device in "sound" class
diff -r e285d93dfd8a pci/asihpi/hpimsgx.c
--- a/pci/asihpi/hpimsgx.c	Mon Mar 10 11:49:06 2008 +0100
+++ b/pci/asihpi/hpimsgx.c	Thu Mar 13 12:42:44 2008 +1300
@@ -73,7 +73,7 @@ static inline void HW_EntryPoint(
 	if (phm->wAdapterIndex < HPI_MAX_ADAPTERS) {
 		ep = (HPI_HandlerFunc *) hpi_entry_points[phm->wAdapterIndex];
 		if (ep) {
-			HPI_DEBUG_MESSAGE(phm);
+			HPI_DEBUG_MESSAGE(DEBUG, phm);
 			ep(phm, phr);
 			HPI_DEBUG_RESPONSE(phr);
 			return;
@@ -419,7 +419,7 @@ void HPI_MessageEx(
 	void *hOwner
 )
 {
-	HPI_DEBUG_MESSAGE(phm);
+	HPI_DEBUG_MESSAGE(DEBUG, phm);
 
 	if (phm->wType != HPI_TYPE_MESSAGE) {
 		HPI_InitResponse(phr, phm->wObject, phm->wFunction,
@@ -465,8 +465,7 @@ void HPI_MessageEx(
 		void *ep = NULL;
 		char *ep_name;
 
-		hpi_debug_message(phm, HPI_DEBUG_FLAG_DEBUG
-			FILE_LINE DBG_TEXT("DEBUG "));
+		HPI_DEBUG_MESSAGE(ERROR, phm);
 
 		ep = hpi_entry_points[phm->wAdapterIndex];
 
@@ -480,7 +479,7 @@ void HPI_MessageEx(
 			ep_name = "unknown";
 
 		HPI_DEBUG_LOG(ERROR,
-			DBG_TEXT("HPI %s Response - error# %d\n"),
+			"HPI %s Response - error# %d\n",
 			ep_name, phr->wError);
 
 		if (hpiDebugLevel >= HPI_DEBUG_LEVEL_VERBOSE)
@@ -898,7 +897,7 @@ static u16 HPIMSGX_Init(
 		HPI_LookupEntryPointFunction(phm->u.s.Resource.r.Pci);
 
 	if (entry_point_func) {
-		HPI_DEBUG_MESSAGE(phm);
+		HPI_DEBUG_MESSAGE(DEBUG, phm);
 		entry_point_func(phm, &hr);
 	} else {
 		phr->wError = HPI_ERROR_PROCESSING_MESSAGE;
diff -r e285d93dfd8a pci/asihpi/hpimsgx.h
--- a/pci/asihpi/hpimsgx.h	Mon Mar 10 11:49:06 2008 +0100
+++ b/pci/asihpi/hpimsgx.h	Thu Mar 13 12:27:10 2008 +1300
@@ -32,7 +32,7 @@ extern "C" {
 /* *INDENT-ON* */
 #endif
 
-#define HPIMSGX_ALLADAPTERS	(0xFFFF)
+#define HPIMSGX_ALLADAPTERS     (0xFFFF)
 
 void HPI_MessageEx(
 	struct hpi_message *phm,
diff -r e285d93dfd8a pci/asihpi/hpios_linux_kernel.c
--- a/pci/asihpi/hpios_linux_kernel.c	Mon Mar 10 11:49:06 2008 +0100
+++ b/pci/asihpi/hpios_linux_kernel.c	Thu Mar 13 12:42:42 2008 +1300
@@ -26,7 +26,7 @@ HPI Operating System function implementa
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2 , 6 , 14)
 void HpiOs_DelayMicroSeconds(
-	uint32_t dwNumMicroSec
+	u32 dwNumMicroSec
 )
 {
 	if ((usecs_to_jiffies(dwNumMicroSec) > 1) && !in_interrupt()) {
@@ -41,7 +41,7 @@ void HpiOs_DelayMicroSeconds(
 }
 #else
 void HpiOs_DelayMicroSeconds(
-	uint32_t dwNumMicroSec
+	u32 dwNumMicroSec
 )
 {
 	if ((dwNumMicroSec / 1000 >= 1000000 / HZ) && !in_interrupt()) {
@@ -91,8 +91,8 @@ u16 HpiOs_LockedMem_Alloc(
 	}
 }
 
-uint16_t HpiOs_LockedMem_Free(
-	struct consistent_dma_area * pMemArea
+u16 HpiOs_LockedMem_Free(
+	struct consistent_dma_area *pMemArea
 )
 {
 	if (pMemArea->size) {
diff -r e285d93dfd8a pci/asihpi/hpios_linux_kernel.h
--- a/pci/asihpi/hpios_linux_kernel.h	Mon Mar 10 11:49:06 2008 +0100
+++ b/pci/asihpi/hpios_linux_kernel.h	Thu Mar 13 12:42:42 2008 +1300
@@ -72,7 +72,7 @@ struct consistent_dma_area {
 
 static inline u16 HpiOs_LockedMem_GetPhysAddr(
 	struct consistent_dma_area *LockedMemHandle,
-	uint32_t * pPhysicalAddr
+	u32 *pPhysicalAddr
 )
 {
 	*pPhysicalAddr = LockedMemHandle->dma_handle;
diff -r e285d93dfd8a pci/asihpi/hpipci.h
--- a/pci/asihpi/hpipci.h	Mon Mar 10 11:49:06 2008 +0100
+++ b/pci/asihpi/hpipci.h	Thu Mar 13 12:27:07 2008 +1300
@@ -25,7 +25,7 @@ HPI PCI interface function definitions
 #define _HPIPCI_H_
 
 /* PCI config reg defines */
-#define HPIPCI_CDID 0x0		/* Vendor/Device Id */
+#define HPIPCI_CDID 0x0	/* Vendor/Device Id */
 #define HPIPCI_CSTR 0x0004
 #define HPIPCI_CCMR 0x0004
 #define HPIPCI_CCCR 0x0008
@@ -39,9 +39,9 @@ HPI PCI interface function definitions
 #define HPIPCI_CILP 0x00FC
 
 /* bits in command register */
-#define HPIPCI_CCMR_MSE			0x00000002
-#define HPIPCI_CCMR_BM			0x00000004
-#define HPIPCI_CCMR_PERR		0x0000040
+#define HPIPCI_CCMR_MSE                 0x00000002
+#define HPIPCI_CCMR_BM                  0x00000004
+#define HPIPCI_CCMR_PERR                0x0000040
 
 /* NOTE : HpiPci function defintions moved to hpios.h */
 #endif				/* _HPIPCI_H_ */

--Boundary-00=_MRH2H502DFgb+8t
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_MRH2H502DFgb+8t--
