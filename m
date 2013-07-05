From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCHv2 31/31] ALSA: hdspm - Added some comments and
	control register documentation
Date: Fri,  5 Jul 2013 11:28:23 +0200
Message-ID: <1373016503-9474-32-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1373016503-9474-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-3-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-4-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-5-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-6-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-7-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-8-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-9-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-10-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-11-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-12-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-13-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-14-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-15-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-16-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-17-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-18-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-19-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-20-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-21-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-22-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-23-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-24-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-25-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-26-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-27-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-28-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-29-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-30-git-send-email-adi@drcomp.erfurt.thur.de>
 <1373016503-9474-31-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373016503-9474-31-git-send-email-adi@drcomp.erfurt.thur.de>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org, Martin Dausel <martin.dausel@iosono-sound.com>
List-Id: alsa-devel@alsa-project.org

From: Martin Dausel <martin.dausel@iosono-sound.com>

Signed-off-by: Martin Dausel <martin.dausel@iosono-sound.com>
Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 7a09b2d..a3a71ac 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -38,6 +38,97 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
  */
+
+/* *************    Register Documentation   *******************************************************
+ *
+ * Work in progress! Documentation is based on the code in this file.
+ *
+ * --------- HDSPM_controlRegister ---------
+ * :7654.3210:7654.3210:7654.3210:7654.3210: bit number per byte
+ * :||||.||||:||||.||||:||||.||||:||||.||||:
+ * :3322.2222:2222.1111:1111.1100:0000.0000: bit number
+ * :1098.7654:3210.9876:5432.1098:7654.3210: 0..31
+ * :||||.||||:||||.||||:||||.||||:||||.||||:
+ * :8421.8421:8421.8421:8421.8421:8421.8421: hex digit
+ * :    .    :    .    :    .    :  x .    :  HDSPM_AudioInterruptEnable \_ setting both bits
+ * :    .    :    .    :    .    :    .   x:  HDSPM_Start                /  enables audio IO
+ * :    .    :    .    :    .    :   x.    :  HDSPM_ClockModeMaster - 1: Master, 0: Slave
+ * :    .    :    .    :    .    :    .210 :  HDSPM_LatencyMask - 3 Bit value for latency
+ * :    .    :    .    :    .    :    .    :      0:64, 1:128, 2:256, 3:512,
+ * :    .    :    .    :    .    :    .    :      4:1024, 5:2048, 6:4096, 7:8192
+ * :x   .    :    .    :    .   x:xx  .    :  HDSPM_FrequencyMask
+ * :    .    :    .    :    .    :10  .    :  HDSPM_Frequency1|HDSPM_Frequency0: 1=32K,2=44.1K,3=48K,0=??
+ * :    .    :    .    :    .   x:    .    :  <MADI> HDSPM_DoubleSpeed
+ * :x   .    :    .    :    .    :    .    :  <MADI> HDSPM_QuadSpeed
+ * :    .  3 :    .  10:  2 .    :    .    :  HDSPM_SyncRefMask :
+ * :    .    :    .   x:    .    :    .    :  HDSPM_SyncRef0
+ * :    .    :    .  x :    .    :    .    :  HDSPM_SyncRef1
+ * :    .    :    .    :  x .    :    .    :  <AES32> HDSPM_SyncRef2
+ * :    .  x :    .    :    .    :    .    :  <AES32> HDSPM_SyncRef3
+ * :    .    :    .  10:    .    :    .    :  <MADI> sync ref: 0:WC, 1:Madi, 2:TCO, 3:SyncIn
+ * :    .  3 :    .  10:  2 .    :    .    :  <AES32>  0:WC, 1:AES1 ... 8:AES8, 9: TCO, 10:SyncIn?
+ * :    .  x :    .    :    .    :    .    :  <MADIe> HDSPe_FLOAT_FORMAT
+ * :    .    :    .    : x  .    :    .    :  <MADI> HDSPM_InputSelect0 : 0=optical,1=coax
+ * :    .    :    .    :x   .    :    .    :  <MADI> HDSPM_InputSelect1
+ * :    .    :    .x   :    .    :    .    :  <MADI> HDSPM_clr_tms
+ * :    .    :    .    :    . x  :    .    :  <MADI> HDSPM_TX_64ch
+ * :    .    :    .    :    . x  :    .    :  <AES32> HDSPM_Emphasis
+ * :    .    :    .    :    .x   :    .    :  <MADI> HDSPM_AutoInp
+ * :    .    :    . x  :    .    :    .    :  <MADI> HDSPM_SMUX
+ * :    .    :    .x   :    .    :    .    :  <MADI> HDSPM_clr_tms
+ * :    .    :   x.    :    .    :    .    :  <MADI> HDSPM_taxi_reset
+ * :    .   x:    .    :    .    :    .    :  <MADI> HDSPM_LineOut
+ * :    .   x:    .    :    .    :    .    :  <AES32> ??????????????????
+ * :    .    :   x.    :    .    :    .    :  <AES32> HDSPM_WCK48
+ * :    .    :    .    :    .x   :    .    :  <AES32> HDSPM_Dolby
+ * :    .    : x  .    :    .    :    .    :  HDSPM_Midi0InterruptEnable
+ * :    .    :x   .    :    .    :    .    :  HDSPM_Midi1InterruptEnable
+ * :    .    :  x .    :    .    :    .    :  HDSPM_Midi2InterruptEnable
+ * :    . x  :    .    :    .    :    .    :  <MADI> HDSPM_Midi3InterruptEnable
+ * :    . x  :    .    :    .    :    .    :  <AES32> HDSPM_DS_DoubleWire
+ * :    .x   :    .    :    .    :    .    :  <AES32> HDSPM_QS_DoubleWire
+ * :   x.    :    .    :    .    :    .    :  <AES32> HDSPM_QS_QuadWire
+ * :    .    :    .    :    .  x :    .    :  <AES32> HDSPM_Professional
+ * : x  .    :    .    :    .    :    .    :  HDSPM_wclk_sel
+ * :    .    :    .    :    .    :    .    :
+ * :7654.3210:7654.3210:7654.3210:7654.3210: bit number per byte
+ * :||||.||||:||||.||||:||||.||||:||||.||||:
+ * :3322.2222:2222.1111:1111.1100:0000.0000: bit number
+ * :1098.7654:3210.9876:5432.1098:7654.3210: 0..31
+ * :||||.||||:||||.||||:||||.||||:||||.||||:
+ * :8421.8421:8421.8421:8421.8421:8421.8421:hex digit
+ *
+ *
+ *
+ * AIO / RayDAT only
+ *
+ * ------------ HDSPM_WR_SETTINGS ----------
+ * :3322.2222:2222.1111:1111.1100:0000.0000: bit number per byte
+ * :1098.7654:3210.9876:5432.1098:7654.3210:
+ * :||||.||||:||||.||||:||||.||||:||||.||||: bit number
+ * :7654.3210:7654.3210:7654.3210:7654.3210: 0..31
+ * :||||.||||:||||.||||:||||.||||:||||.||||:
+ * :8421.8421:8421.8421:8421.8421:8421.8421: hex digit
+ * :    .    :    .    :    .    :    .   x: HDSPM_c0Master 1: Master, 0: Slave
+ * :    .    :    .    :    .    :    .  x : HDSPM_c0_SyncRef0
+ * :    .    :    .    :    .    :    . x  : HDSPM_c0_SyncRef1
+ * :    .    :    .    :    .    :    .x   : HDSPM_c0_SyncRef2
+ * :    .    :    .    :    .    :   x.    : HDSPM_c0_SyncRef3
+ * :    .    :    .    :    .    :   3.210 : HDSPM_c0_SyncRefMask:
+ * :    .    :    .    :    .    :    .    :  RayDat: 0:WC, 1:AES, 2:SPDIF, 3..6: ADAT1..4,
+ * :    .    :    .    :    .    :    .    :          9:TCO, 10:SyncIn
+ * :    .    :    .    :    .    :    .    :  AIO: 0:WC, 1:AES, 2: SPDIF, 3: ATAT,
+ * :    .    :    .    :    .    :    .    :          9:TCO, 10:SyncIn
+ * :    .    :    .    :    .    :    .    :
+ * :    .    :    .    :    .    :    .    :
+ * :3322.2222:2222.1111:1111.1100:0000.0000: bit number per byte
+ * :1098.7654:3210.9876:5432.1098:7654.3210:
+ * :||||.||||:||||.||||:||||.||||:||||.||||: bit number
+ * :7654.3210:7654.3210:7654.3210:7654.3210: 0..31
+ * :||||.||||:||||.||||:||||.||||:||||.||||:
+ * :8421.8421:8421.8421:8421.8421:8421.8421: hex digit
+ *
+ */
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
@@ -95,7 +186,7 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 #define HDSPM_controlRegister	     64
 #define HDSPM_interruptConfirmation  96
 #define HDSPM_control2Reg	     256  /* not in specs ???????? */
-#define HDSPM_freqReg                256  /* for AES32 */
+#define HDSPM_freqReg                256  /* for setting arbitrary clock values (DDS feature) */
 #define HDSPM_midiDataOut0	     352  /* just believe in old code */
 #define HDSPM_midiDataOut1	     356
 #define HDSPM_eeprom_wr		     384  /* for AES32 */
@@ -890,11 +981,11 @@ struct hdspm_midi {
 };
 
 struct hdspm_tco {
-	int input;
-	int framerate;
-	int wordclock;
-	int samplerate;
-	int pull;
+	int input; /* 0: LTC, 1:Video, 2: WC*/
+	int framerate; /* 0=24, 1=25, 2=29.97, 3=29.97d, 4=30, 5=30d */
+	int wordclock; /* 0=1:1, 1=44.1->48, 2=48->44.1 */
+	int samplerate; /* 0=44.1, 1=48, 2= freq from app */
+	int pull; /*   0=0, 1=+0.1%, 2=-0.1%, 3=+4%, 4=-4%*/
 	int term; /* 0 = off, 1 = on */
 };
 
@@ -913,7 +1004,7 @@ struct hdspm {
 
 	u32 control_register;	/* cached value */
 	u32 control2_register;	/* cached value */
-	u32 settings_register;
+	u32 settings_register;  /* cached value for AIO / RayDat (sync reference, master/slave) */
 
 	struct hdspm_midi midi[4];
 	struct tasklet_struct midi_tasklet;
@@ -4137,6 +4228,7 @@ static void hdspm_tco_write(struct hdspm *hdspm)
 static int snd_hdspm_info_tco_sample_rate(struct snd_kcontrol *kcontrol,
 					  struct snd_ctl_elem_info *uinfo)
 {
+	/* TODO freq from app could be supported here, see tco->samplerate */
 	static const char *const texts[] = { "44.1 kHz", "48 kHz" };
 	ENUMERATED_CTL_INFO(uinfo, texts);
 	return 0;
-- 
1.8.3.1
