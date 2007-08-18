From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] dbri: driver cleanup
Date: Sat, 18 Aug 2007 08:27:30 +0200
Message-ID: <46c69152e49fd@wp.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="part46c69152e710b"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 7CD3724527
	for <alsa-devel@alsa-project.org>;
	Sat, 18 Aug 2007 08:27:40 +0200 (CEST)
Received: from poczta-16.free.wp-sa.pl (HELO localhost) ([10.1.1.71])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <alsa-devel@alsa-project.org>; 18 Aug 2007 08:27:30 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--part46c69152e710b
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes white spaces, spelling and formatting
to conform closer to the coding standard of the kernel.
It contains few fixes pointed out by the checkpatch.pl script.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

In case this email is mangled, the original patch is attached.

diff -urp linux-2.6.23.2/sound/sparc/dbri.c linux-2.6.
23/sound/sparc/dbri.c
--- linux-2.6.23.2/sound/sparc/dbri.c	2007-07-09 01:32:16.
000000000 +0200
+++ linux-2.6.23/sound/sparc/dbri.c	2007-08-17 10:48:31.
000000000 +0200
@@ -8,18 +8,18 @@
  * Copyright (C) 1997 Rudolf Koenig (rfkoenig@immd4.informatik.
uni-erlangen.de)
  * Copyright (C) 1998, 1999 Brent Baccala (baccala@freesoft.org)
  *
- * This is the lowlevel driver for the DBRI & MMCODEC duo used=20
for ISDN & AUDIO
- * on Sun SPARCstation 10, 20, LX and Voyager models.
+ * This is the low level driver for the DBRI & MMCODEC duo used=20
for ISDN & AUDIO
+ * on Sun SPARCStation 10, 20, LX and Voyager models.
  *
  * - DBRI: AT&T T5900FX Dual Basic Rates ISDN Interface. It is a=20
32 channel
  *   data time multiplexer with ISDN support (aka T7259)
  *   Interfaces: SBus,ISDN NT & TE, CHI, 4 bits parallel.
  *   CHI: (spelled ki) Concentration Highway Interface (AT&T or=20
Intel bus ?).
  *   Documentation:
- *   - "STP 4000SBus Dual Basic Rate ISDN (DBRI) Tranceiver"=20
from
+ *   - "STP 4000SBus Dual Basic Rate ISDN (DBRI) Transceiver"=20
from
  *     Sparc Technology Business (courtesy of Sun Support)
  *   - Data sheet of the T7903, a newer but very similar ISA bus=20
equivalent
- *     available from the Lucent (formarly AT&T=20
microelectronics) home
+ *     available from the Lucent (formerly AT&T=20
microelectronics) home
  *     page.
  *   - http://www.freesoft.org/Linux/DBRI/
  * - MMCODEC: Crystal Semiconductor CS4215 16 bit Multimedia=20
Audio Codec
@@ -27,21 +27,21 @@
  *   Documentation: from the Crystal Semiconductor home page.
  *
  * The DBRI is a 32 pipe machine, each pipe can transfer some=20
bits between
- * memory and a serial device (long pipes, nr 0-15) or between=20
two serial
- * devices (short pipes, nr 16-31), or simply send a fixed data=20
to a serial
+ * memory and a serial device (long pipes, no. 0-15) or between=20
two serial
+ * devices (short pipes, no. 16-31), or simply send a fixed data=20
to a serial
  * device (short pipes).
- * A timeslot defines the bit-offset and nr of bits read from a=20
serial device.
+ * A timeslot defines the bit-offset and no. of bits read from a=20
serial device.
  * The timeslots are linked to 6 circular lists, one for each=20
direction for
  * each serial device (NT,TE,CHI). A timeslot is associated to 1=20
or 2 pipes
  * (the second one is a monitor/tee pipe, valid only for serial=20
input).
  *
  * The mmcodec is connected via the CHI bus and needs the data &=20
some
- * parameters (volume, output selection) timemultiplexed in 8=20
byte
+ * parameters (volume, output selection) time multiplexed in 8=20
byte
  * chunks. It also has a control mode, which serves for audio=20
format setting.
  *
  * Looking at the CS4215 data sheet it is easy to set up 2 or 4=20
codecs on
- * the same CHI bus, so I thought perhaps it is possible to use=20
the onboard
- * & the speakerbox codec simultanously, giving 2 (not very=20
independent :-)
+ * the same CHI bus, so I thought perhaps it is possible to use=20
the on-board
+ * & the speakerbox codec simultaneously, giving 2 (not very=20
independent :-)
  * audio devices. But the SUN HW group decided against it, at=20
least on my
  * LX the speakerbox connector has at least 1 pin missing and 1=20
wrongly
  * connected.
@@ -56,6 +56,8 @@
 #include <sound/driver.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/io.h>
=20
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -64,8 +66,6 @@
 #include <sound/control.h>
 #include <sound/initval.h>
=20
-#include <asm/irq.h>
-#include <asm/io.h>
 #include <asm/sbus.h>
 #include <asm/atomic.h>
=20
@@ -76,7 +76,8 @@ MODULE_SUPPORTED_DEVICE("{{Sun,DBRI}}");
=20
 static int index[SNDRV_CARDS] =3D SNDRV_DEFAULT_IDX;	/* Index=20
0-MAX */
 static char *id[SNDRV_CARDS] =3D SNDRV_DEFAULT_STR;	/* ID for=20
this card */
-static int enable[SNDRV_CARDS] =3D SNDRV_DEFAULT_ENABLE_PNP;
	/* Enable this card */
+/* Enable this card */
+static int enable[SNDRV_CARDS] =3D SNDRV_DEFAULT_ENABLE_PNP;
=20
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for Sun DBRI soundcard.");
@@ -104,7 +105,7 @@ static char *cmds[] =3D {
 	"SSP", "CHI", "NT", "TE", "CDEC", "TEST", "CDM", "RESRV"
 };
=20
-#define dprintk(a, x...) if(dbri_debug & a) printk(KERN_DEBUG x)
+#define dprintk(a, x...) if (dbri_debug & a) printk(KERN_DEBUG=20
x)
=20
 #else
 #define dprintk(a, x...) do { } while (0)
@@ -131,7 +132,7 @@ struct cs4215 {
 };
=20
 /*
- * Control mode first=20
+ * Control mode first
  */
=20
 /* Time Slot 1, Status register */
@@ -219,7 +220,7 @@ static struct {
 /* Time Slot 7, Input Setting */
 #define CS4215_LG(v)	v	/* Left Gain Setting 0xf: 22.5 dB=20
*/
 #define CS4215_IS	(1<<4)	/* Input Select: 1=3DMicrophone,=20
0=3DLine */
-#define CS4215_OVR	(1<<5)	/* 1: Overrange condition=20
occurred */
+#define CS4215_OVR	(1<<5)	/* 1: Over range condition=20
occurred */
 #define CS4215_PIO0	(1<<6)	/* Parallel I/O 0 */
 #define CS4215_PIO1	(1<<7)
=20
@@ -285,7 +286,7 @@ struct dbri_pipe {
 /* Per stream (playback or record) information */
 struct dbri_streaminfo {
 	struct snd_pcm_substream *substream;
-	u32 dvma_buffer;	/* Device view of Alsa DMA buffer */
+	u32 dvma_buffer;	/* Device view of ALSA DMA buffer */
 	int size;		/* Size of DMA buffer             */
 	size_t offset;		/* offset in user buffer          */
 	int pipe;		/* Data pipe used                 */
@@ -341,11 +342,11 @@ struct snd_dbri {
 /* DBRI Reg1 - Mode and Interrupt Register - defines. (Page 18)=20
*/
 #define D_LITTLE_END	(1<<8)	/* Byte Order */
 #define D_BIG_END	(0<<8)	/* Byte Order */
-#define D_MRR		(1<<4)	/* Multiple Error Ack on SBus=20
(readonly) */
-#define D_MLE		(1<<3)	/* Multiple Late Error on SBus=20
(readonly) */
-#define D_LBG		(1<<2)	/* Lost Bus Grant on SBus=20
(readonly) */
-#define D_MBE		(1<<1)	/* Burst Error on SBus=20
(readonly) */
-#define D_IR		(1<<0)	/* Interrupt Indicator (readonly)=20
*/
+#define D_MRR		(1<<4)	/* Multiple Error Ack on SBus=20
(read only) */
+#define D_MLE		(1<<3)	/* Multiple Late Error on SBus=20
(read only) */
+#define D_LBG		(1<<2)	/* Lost Bus Grant on SBus (read=20
only) */
+#define D_MBE		(1<<1)	/* Burst Error on SBus (read=20
only) */
+#define D_IR		(1<<0)	/* Interrupt Indicator (read=20
only) */
=20
 /* DBRI Reg2 - Parallel IO Register - defines. (Page 18) */
 #define D_ENPIO3	(1<<7)	/* Enable Pin 3 */
@@ -376,11 +377,11 @@ struct snd_dbri {
 #define D_CDM		0xe	/* CHI Data mode command */
=20
 /* Special bits for some commands */
-#define D_PIPE(v)      ((v)<<0)	/* Pipe Nr: 0-15 long, 16-21=20
short */
+#define D_PIPE(v)      ((v)<<0)	/* Pipe No.: 0-15 long,=20
16-21 short */
=20
 /* Setup Data Pipe */
 /* IRM */
-#define D_SDP_2SAME	(1<<18)	/* Report 2nd time in a row=20
value rcvd */
+#define D_SDP_2SAME	(1<<18)	/* Report 2nd time in a row=20
value received */
 #define D_SDP_CHANGE	(2<<18)	/* Report any changes */
 #define D_SDP_EVERY	(3<<18)	/* Report any changes */
 #define D_SDP_EOL	(1<<17)	/* EOL interrupt enable */
@@ -419,7 +420,7 @@ struct snd_dbri {
 #define D_TS_NONCONTIG	(3<<10)	/* Non contiguous mode */
 #define D_TS_ANCHOR	(7<<10)	/* Starting short pipes */
 #define D_TS_MON(v)    ((v)<<5)	/* Monitor Pipe */
-#define D_TS_NEXT(v)   ((v)<<0)	/* Pipe Nr: 0-15 long, 16-21=20
short */
+#define D_TS_NEXT(v)   ((v)<<0)	/* Pipe no.: 0-15 long,=20
16-21 short */
=20
 /* Concentration Highway Interface Modes */
 #define D_CHI_CHICM(v)	((v)<<16)	/* Clock mode */
@@ -435,7 +436,7 @@ struct snd_dbri {
 #define D_NT_NBF	(1<<16)	/* Number of bad frames to=20
loose framing */
 #define D_NT_IRM_IMM	(1<<15)	/* Interrupt Report & Mask:=20
Immediate */
 #define D_NT_IRM_EN	(1<<14)	/* Interrupt Report & Mask:=20
Enable */
-#define D_NT_ISNT	(1<<13)	/* Configfure interface as NT=20
*/
+#define D_NT_ISNT	(1<<13)	/* Configure interface as NT=20
*/
 #define D_NT_FT		(1<<12)	/* Fixed Timing */
 #define D_NT_EZ		(1<<11)	/* Echo Channel is Zeros */
 #define D_NT_IFA	(1<<10)	/* Inhibit Final Activation */
@@ -455,7 +456,7 @@ struct snd_dbri {
 #define D_TEST_RAM(v)	((v)<<16)	/* RAM Pointer */
 #define D_TEST_SIZE(v)	((v)<<11)	/* */
 #define D_TEST_ROMONOFF	0x5	/* Toggle ROM opcode monitor=20
on/off */
-#define D_TEST_PROC	0x6	/* MicroProcessor test */
+#define D_TEST_PROC	0x6	/* Microprocessor test */
 #define D_TEST_SER	0x7	/* Serial-Controller test */
 #define D_TEST_RAMREAD	0x8	/* Copy from Ram to system=20
memory */
 #define D_TEST_RAMWRITE	0x9	/* Copy into Ram from system=20
memory */
@@ -464,12 +465,12 @@ struct snd_dbri {
 #define D_TEST_DUMP	0xe	/* ROM Dump */
=20
 /* CHI Data Mode */
-#define D_CDM_THI	(1<<8)	/* Transmit Data on CHIDR Pin=20
*/
-#define D_CDM_RHI	(1<<7)	/* Receive Data on CHIDX Pin */
-#define D_CDM_RCE	(1<<6)	/* Receive on Rising Edge of=20
CHICK */
-#define D_CDM_XCE	(1<<2)	/* Transmit Data on Rising Edge=20
of CHICK */
-#define D_CDM_XEN	(1<<1)	/* Transmit Highway Enable */
-#define D_CDM_REN	(1<<0)	/* Receive Highway Enable */
+#define D_CDM_THI	(1 << 8)	/* Transmit Data on CHIDR Pin=20
*/
+#define D_CDM_RHI	(1 << 7)	/* Receive Data on CHIDX Pin=20
*/
+#define D_CDM_RCE	(1 << 6)	/* Receive on Rising Edge of=20
CHICK */
+#define D_CDM_XCE	(1 << 2) /* Transmit Data on Rising Edge=20
of CHICK */
+#define D_CDM_XEN	(1 << 1)	/* Transmit Highway Enable */
+#define D_CDM_REN	(1 << 0)	/* Receive Highway Enable */
=20
 /* The Interrupts */
 #define D_INTR_BRDY	1	/* Buffer Ready for processing */
@@ -493,9 +494,9 @@ struct snd_dbri {
 #define D_INTR_CHI	36
 #define D_INTR_CMD	38
=20
-#define D_INTR_GETCHAN(v)	(((v)>>24) & 0x3f)
-#define D_INTR_GETCODE(v)	(((v)>>20) & 0xf)
-#define D_INTR_GETCMD(v)	(((v)>>16) & 0xf)
+#define D_INTR_GETCHAN(v)	(((v) >> 24) & 0x3f)
+#define D_INTR_GETCODE(v)	(((v) >> 20) & 0xf)
+#define D_INTR_GETCMD(v)	(((v) >> 16) & 0xf)
 #define D_INTR_GETVAL(v)	((v) & 0xffff)
 #define D_INTR_GETRVAL(v)	((v) & 0xfffff)
=20
@@ -533,41 +534,42 @@ struct snd_dbri {
 #define D_P_31		31	/* */
=20
 /* Transmit descriptor defines */
-#define DBRI_TD_F	(1<<31)	/* End of Frame */
-#define DBRI_TD_D	(1<<30)	/* Do not append CRC */
-#define DBRI_TD_CNT(v)	((v)<<16)	/* Number of valid=20
bytes in the buffer */
-#define DBRI_TD_B	(1<<15)	/* Final interrupt */
-#define DBRI_TD_M	(1<<14)	/* Marker interrupt */
-#define DBRI_TD_I	(1<<13)	/* Transmit Idle Characters */
-#define DBRI_TD_FCNT(v)	(v)	/* Flag Count */
-#define DBRI_TD_UNR	(1<<3)	/* Underrun: transmitter is=20
out of data */
-#define DBRI_TD_ABT	(1<<2)	/* Abort: frame aborted */
-#define DBRI_TD_TBC	(1<<0)	/* Transmit buffer Complete=20
*/
-#define DBRI_TD_STATUS(v)       ((v)&0xff)	/* Transmit=20
status */
-			/* Maximum buffer size per TD: almost 8Kb */
+#define DBRI_TD_F	(1 << 31)	/* End of Frame */
+#define DBRI_TD_D	(1 << 30)	/* Do not append CRC */
+#define DBRI_TD_CNT(v)	((v) << 16) /* Number of valid bytes=20
in the buffer */
+#define DBRI_TD_B	(1 << 15)	/* Final interrupt */
+#define DBRI_TD_M	(1 << 14)	/* Marker interrupt */
+#define DBRI_TD_I	(1 << 13)	/* Transmit Idle Characters=20
*/
+#define DBRI_TD_FCNT(v)	(v)		/* Flag Count */
+#define DBRI_TD_UNR	(1 << 3) /* Underrun: transmitter is out=20
of data */
+#define DBRI_TD_ABT	(1 << 2)	/* Abort: frame aborted */
+#define DBRI_TD_TBC	(1 << 0)	/* Transmit buffer Complete=20
*/
+#define DBRI_TD_STATUS(v)       ((v) & 0xff)	/* Transmit=20
status */
+			/* Maximum buffer size per TD: almost 8KB */
 #define DBRI_TD_MAXCNT	((1 << 13) - 4)
=20
 /* Receive descriptor defines */
-#define DBRI_RD_F	(1<<31)	/* End of Frame */
-#define DBRI_RD_C	(1<<30)	/* Completed buffer */
-#define DBRI_RD_B	(1<<15)	/* Final interrupt */
-#define DBRI_RD_M	(1<<14)	/* Marker interrupt */
-#define DBRI_RD_BCNT(v)	(v)	/* Buffer size */
-#define DBRI_RD_CRC	(1<<7)	/* 0: CRC is correct */
-#define DBRI_RD_BBC	(1<<6)	/* 1: Bad Byte received */
-#define DBRI_RD_ABT	(1<<5)	/* Abort: frame aborted */
-#define DBRI_RD_OVRN	(1<<3)	/* Overrun: data lost */
-#define DBRI_RD_STATUS(v)      ((v)&0xff)	/* Receive status=20
*/
-#define DBRI_RD_CNT(v) (((v)>>16)&0x1fff)	/* Valid bytes in=20
the buffer */
+#define DBRI_RD_F	(1 << 31)	/* End of Frame */
+#define DBRI_RD_C	(1 << 30)	/* Completed buffer */
+#define DBRI_RD_B	(1 << 15)	/* Final interrupt */
+#define DBRI_RD_M	(1 << 14)	/* Marker interrupt */
+#define DBRI_RD_BCNT(v)	(v)		/* Buffer size */
+#define DBRI_RD_CRC	(1 << 7)	/* 0: CRC is correct */
+#define DBRI_RD_BBC	(1 << 6)	/* 1: Bad Byte received */
+#define DBRI_RD_ABT	(1 << 5)	/* Abort: frame aborted */
+#define DBRI_RD_OVRN	(1 << 3)	/* Overrun: data lost */
+#define DBRI_RD_STATUS(v)      ((v) & 0xff)	/* Receive=20
status */
+#define DBRI_RD_CNT(v) (((v) >> 16) & 0x1fff)	/* Valid bytes=20
in the buffer */
=20
 /* stream_info[] access */
 /* Translate the ALSA direction into the array index */
 #define DBRI_STREAMNO(substream)				\
-		(substream->stream =3D=3D 				\
+		(substream->stream =3D=3D				\
 		 SNDRV_PCM_STREAM_PLAYBACK? DBRI_PLAY: DBRI_REC)
=20
 /* Return a pointer to dbri_streaminfo */
-#define DBRI_STREAM(dbri, substream)
	&dbri->stream_info[DBRI_STREAMNO(substream)]
+#define DBRI_STREAM(dbri, substream)	\
+		&dbri->stream_info[DBRI_STREAMNO(substream)]
=20
 static struct snd_dbri *dbri_list;	/* All DBRI devices */
=20
@@ -612,18 +614,18 @@ Since the DBRI can run in parallel with=20
 synchronization present themselves. The method implemented here=20
is only
 use of the dbri_cmdwait() to wait for execution of batch of sent=20
commands.
=20
-A circular command buffer is used here. A new command is being=20
added=20
+A circular command buffer is used here. A new command is being=20
added
 while another can be executed. The scheme works by adding two=20
WAIT commands
 after each sent batch of commands. When the next batch is=20
prepared it is
 added after the WAIT commands then the WAITs are replaced with=20
single JUMP
-command to the new batch. The the DBRI is forced to reread the=20
last WAIT=20
-command (replaced by the JUMP by then). If the DBRI is still=20
executing=20
+command to the new batch. The the DBRI is forced to reread the=20
last WAIT
+command (replaced by the JUMP by then). If the DBRI is still=20
executing
 previous commands the request to reread the WAIT command is=20
ignored.
=20
 Every time a routine wants to write commands to the DBRI, it=20
must
-first call dbri_cmdlock() and get pointer to a free space in=20
-dbri->dma->cmd buffer. After this, the commands can be written=20
to=20
-the buffer, and dbri_cmdsend() is called with the final pointer=20
value=20
+first call dbri_cmdlock() and get pointer to a free space in
+dbri->dma->cmd buffer. After this, the commands can be written=20
to
+the buffer, and dbri_cmdsend() is called with the final pointer=20
value
 to send them to the DBRI.
=20
 */
@@ -657,7 +659,7 @@ static void dbri_cmdwait(struct snd_dbri
  * Lock the command queue and returns pointer to a space for len=20
cmd words
  * It locks the cmdlock spinlock.
  */
-static s32 *dbri_cmdlock(struct snd_dbri * dbri, int len)
+static s32 *dbri_cmdlock(struct snd_dbri *dbri, int len)
 {
 	/* Space for 2 WAIT cmds (replaced later by 1 JUMP cmd) */
 	len +=3D 2;
@@ -680,7 +682,7 @@ static s32 *dbri_cmdlock(struct snd_dbri
  *
  * Lock must be held before calling this.
  */
-static void dbri_cmdsend(struct snd_dbri * dbri, s32 * cmd,int=20
len)
+static void dbri_cmdsend(struct snd_dbri *dbri, s32 *cmd, int=20
len)
 {
 	s32 tmp, addr;
 	static int wait_id =3D 0;
@@ -700,16 +702,17 @@ static void dbri_cmdsend(struct snd_dbri
 		s32 *ptr;
=20
 		for (ptr =3D dbri->cmdptr; ptr < cmd+2; ptr++)
-			dprintk(D_CMD, "cmd: %lx:%08x\n", (unsigned long)ptr,=20
*ptr);
+			dprintk(D_CMD, "cmd: %lx:%08x\n",
+				(unsigned long)ptr, *ptr);
 	} else {
 		s32 *ptr =3D dbri->cmdptr;
=20
 		dprintk(D_CMD, "cmd: %lx:%08x\n", (unsigned long)ptr,=20
*ptr);
 		ptr++;
 		dprintk(D_CMD, "cmd: %lx:%08x\n", (unsigned long)ptr,=20
*ptr);
-		for (ptr =3D dbri->dma->cmd; ptr < cmd+2; ptr++) {
-			dprintk(D_CMD, "cmd: %lx:%08x\n", (unsigned long)ptr,=20
*ptr);
-		}
+		for (ptr =3D dbri->dma->cmd; ptr < cmd+2; ptr++)
+			dprintk(D_CMD, "cmd: %lx:%08x\n",
+				(unsigned long)ptr, *ptr);
 	}
 #endif
=20
@@ -723,7 +726,7 @@ static void dbri_cmdsend(struct snd_dbri
 }
=20
 /* Lock must be held when calling this */
-static void dbri_reset(struct snd_dbri * dbri)
+static void dbri_reset(struct snd_dbri *dbri)
 {
 	int i;
 	u32 tmp;
@@ -746,7 +749,7 @@ static void dbri_reset(struct snd_dbri *
 }
=20
 /* Lock must not be held before calling this */
-static void dbri_initialize(struct snd_dbri * dbri)
+static void dbri_initialize(struct snd_dbri *dbri)
 {
 	s32 *cmd;
 	u32 dma_addr;
@@ -763,7 +766,7 @@ static void dbri_initialize(struct snd_d
=20
 	spin_lock_init(&dbri->cmdlock);
 	/*
-	 * Initialize the interrupt ringbuffer.
+	 * Initialize the interrupt ring buffer.
 	 */
 	dma_addr =3D dbri->dma_dvma + dbri_dma_off(intr, 0);
 	dbri->dma->intr[0] =3D dma_addr;
@@ -801,7 +804,7 @@ list ordering, among other things.  The=20
 here interface closely with the transmit and receive interrupt=20
code.
=20
 */
-static int pipe_active(struct snd_dbri * dbri, int pipe)
+static int pipe_active(struct snd_dbri *dbri, int pipe)
 {
 	return ((pipe >=3D 0) && (dbri->pipes[pipe].desc !=3D -1));
 }
@@ -811,20 +814,22 @@ static int pipe_active(struct snd_dbri *
  * Called on an in-use pipe to clear anything being transmitted=20
or received
  * Lock must be held before calling this.
  */
-static void reset_pipe(struct snd_dbri * dbri, int pipe)
+static void reset_pipe(struct snd_dbri *dbri, int pipe)
 {
 	int sdp;
 	int desc;
 	s32 *cmd;
=20
 	if (pipe < 0 || pipe > DBRI_MAX_PIPE) {
-		printk(KERN_ERR "DBRI: reset_pipe called with illegal=20
pipe number\n");
+		printk(KERN_ERR "DBRI: reset_pipe called with "
+			"illegal pipe number\n");
 		return;
 	}
=20
 	sdp =3D dbri->pipes[pipe].sdp;
 	if (sdp =3D=3D 0) {
-		printk(KERN_ERR "DBRI: reset_pipe called on=20
uninitialized pipe\n");
+		printk(KERN_ERR "DBRI: reset_pipe called "
+			"on uninitialized pipe\n");
 		return;
 	}
=20
@@ -835,9 +840,10 @@ static void reset_pipe(struct snd_dbri *
 	dbri_cmdsend(dbri, cmd, 3);
=20
 	desc =3D dbri->pipes[pipe].first_desc;
-	if ( desc >=3D 0)
+	if (desc >=3D 0)
 		do {
-			dbri->dma->desc[desc].nda =3D dbri->dma->desc[desc].ba=20
=3D 0;
+			dbri->dma->desc[desc].ba =3D 0;
+			dbri->dma->desc[desc].nda =3D 0;
 			desc =3D dbri->next_desc[desc];
 		} while (desc !=3D -1 && desc !=3D dbri->pipes[pipe].
first_desc);
=20
@@ -848,15 +854,17 @@ static void reset_pipe(struct snd_dbri *
 /*
  * Lock must be held before calling this.
  */
-static void setup_pipe(struct snd_dbri * dbri, int pipe, int=20
sdp)
+static void setup_pipe(struct snd_dbri *dbri, int pipe, int sdp)
 {
 	if (pipe < 0 || pipe > DBRI_MAX_PIPE) {
-		printk(KERN_ERR "DBRI: setup_pipe called with illegal=20
pipe number\n");
+		printk(KERN_ERR "DBRI: setup_pipe called "
+			"with illegal pipe number\n");
 		return;
 	}
=20
 	if ((sdp & 0xf800) !=3D sdp) {
-		printk(KERN_ERR "DBRI: setup_pipe called with strange=20
SDP value\n");
+		printk(KERN_ERR "DBRI: setup_pipe called "
+			"with strange SDP value\n");
 		/* sdp &=3D 0xf800; */
 	}
=20
@@ -877,25 +885,26 @@ static void setup_pipe(struct snd_dbri *
 /*
  * Lock must be held before calling this.
  */
-static void link_time_slot(struct snd_dbri * dbri, int pipe,
+static void link_time_slot(struct snd_dbri *dbri, int pipe,
 			   int prevpipe, int nextpipe,
 			   int length, int cycle)
 {
 	s32 *cmd;
 	int val;
=20
-	if (pipe < 0 || pipe > DBRI_MAX_PIPE=20
+	if (pipe < 0 || pipe > DBRI_MAX_PIPE
 			|| prevpipe < 0 || prevpipe > DBRI_MAX_PIPE
 			|| nextpipe < 0 || nextpipe > DBRI_MAX_PIPE) {
-		printk(KERN_ERR=20
+		printk(KERN_ERR
 		    "DBRI: link_time_slot called with illegal pipe=20
number\n");
 		return;
 	}
=20
-	if (dbri->pipes[pipe].sdp =3D=3D 0=20
+	if (dbri->pipes[pipe].sdp =3D=3D 0
 			|| dbri->pipes[prevpipe].sdp =3D=3D 0
 			|| dbri->pipes[nextpipe].sdp =3D=3D 0) {
-		printk(KERN_ERR "DBRI: link_time_slot called on=20
uninitialized pipe\n");
+		printk(KERN_ERR "DBRI: link_time_slot called "
+			"on uninitialized pipe\n");
 		return;
 	}
=20
@@ -935,17 +944,17 @@ static void link_time_slot(struct snd_db
 /*
  * Lock must be held before calling this.
  */
-static void unlink_time_slot(struct snd_dbri * dbri, int pipe,
+static void unlink_time_slot(struct snd_dbri *dbri, int pipe,
 			     enum in_or_out direction, int prevpipe,
 			     int nextpipe)
 {
 	s32 *cmd;
 	int val;
=20
-	if (pipe < 0 || pipe > DBRI_MAX_PIPE=20
+	if (pipe < 0 || pipe > DBRI_MAX_PIPE
 			|| prevpipe < 0 || prevpipe > DBRI_MAX_PIPE
 			|| nextpipe < 0 || nextpipe > DBRI_MAX_PIPE) {
-		printk(KERN_ERR=20
+		printk(KERN_ERR
 		    "DBRI: unlink_time_slot called with illegal pipe=20
number\n");
 		return;
 	}
@@ -985,7 +994,7 @@ static void unlink_time_slot(struct snd_
  *
  * Lock must not be held before calling it.
  */
-static void xmit_fixed(struct snd_dbri * dbri, int pipe,=20
unsigned int data)
+static void xmit_fixed(struct snd_dbri *dbri, int pipe, unsigned=20
int data)
 {
 	s32 *cmd;
 	unsigned long flags;
@@ -996,7 +1005,8 @@ static void xmit_fixed(struct snd_dbri *
 	}
=20
 	if (D_SDP_MODE(dbri->pipes[pipe].sdp) =3D=3D 0) {
-		printk(KERN_ERR "DBRI: xmit_fixed: Uninitialized pipe %
d\n", pipe);
+		printk(KERN_ERR "DBRI: xmit_fixed: "
+			"Uninitialized pipe %d\n", pipe);
 		return;
 	}
=20
@@ -1006,7 +1016,8 @@ static void xmit_fixed(struct snd_dbri *
 	}
=20
 	if (!(dbri->pipes[pipe].sdp & D_SDP_TO_SER)) {
-		printk(KERN_ERR "DBRI: xmit_fixed: Called on receive=20
pipe %d\n", pipe);
+		printk(KERN_ERR "DBRI: xmit_fixed: Called on receive=20
pipe %d\n",
+			pipe);
 		return;
 	}
=20
@@ -1028,20 +1039,23 @@ static void xmit_fixed(struct snd_dbri *
=20
 }
=20
-static void recv_fixed(struct snd_dbri * dbri, int pipe,=20
volatile __u32 * ptr)
+static void recv_fixed(struct snd_dbri *dbri, int pipe, volatile=20
__u32 *ptr)
 {
 	if (pipe < 16 || pipe > DBRI_MAX_PIPE) {
-		printk(KERN_ERR "DBRI: recv_fixed called with illegal=20
pipe number\n");
+		printk(KERN_ERR "DBRI: recv_fixed called with "
+			"illegal pipe number\n");
 		return;
 	}
=20
 	if (D_SDP_MODE(dbri->pipes[pipe].sdp) !=3D D_SDP_FIXED) {
-		printk(KERN_ERR "DBRI: recv_fixed called on non-fixed=20
pipe %d\n", pipe);
+		printk(KERN_ERR "DBRI: recv_fixed called on "
+			"non-fixed pipe %d\n", pipe);
 		return;
 	}
=20
 	if (dbri->pipes[pipe].sdp & D_SDP_TO_SER) {
-		printk(KERN_ERR "DBRI: recv_fixed called on transmit=20
pipe %d\n", pipe);
+		printk(KERN_ERR "DBRI: recv_fixed called on "
+			"transmit pipe %d\n", pipe);
 		return;
 	}
=20
@@ -1064,7 +1078,7 @@ static void recv_fixed(struct snd_dbri *
  *
  * Lock must be held before calling this.
  */
-static int setup_descs(struct snd_dbri * dbri, int streamno,=20
unsigned int period)
+static int setup_descs(struct snd_dbri *dbri, int streamno,=20
unsigned int period)
 {
 	struct dbri_streaminfo *info =3D &dbri->stream_info[streamno]
;
 	__u32 dvma_buffer;
@@ -1089,21 +1103,23 @@ static int setup_descs(struct snd_dbri *
=20
 	if (streamno =3D=3D DBRI_PLAY) {
 		if (!(dbri->pipes[info->pipe].sdp & D_SDP_TO_SER)) {
-			printk(KERN_ERR "DBRI: setup_descs: Called on receive=20
pipe %d\n",
-			       info->pipe);
+			printk(KERN_ERR "DBRI: setup_descs: "
+				"Called on receive pipe %d\n", info->pipe);
 			return -2;
 		}
 	} else {
 		if (dbri->pipes[info->pipe].sdp & D_SDP_TO_SER) {
-			printk(KERN_ERR=20
+			printk(KERN_ERR
 			    "DBRI: setup_descs: Called on transmit pipe %d\n",
 			     info->pipe);
 			return -2;
 		}
-		/* Should be able to queue multiple buffers to receive=20
on a pipe */
+		/* Should be able to queue multiple buffers
+		 * to receive on a pipe
+		 */
 		if (pipe_active(dbri, info->pipe)) {
-			printk(KERN_ERR "DBRI: recv_on_pipe: Called on active=20
pipe %d\n",
-			       info->pipe);
+			printk(KERN_ERR "DBRI: recv_on_pipe: "
+				"Called on active pipe %d\n", info->pipe);
 			return -2;
 		}
=20
@@ -1113,11 +1129,13 @@ static int setup_descs(struct snd_dbri *
=20
 	/* Free descriptors if pipe has any */
 	desc =3D dbri->pipes[info->pipe].first_desc;
-	if ( desc >=3D 0)
+	if (desc >=3D 0)
 		do {
-			dbri->dma->desc[desc].nda =3D dbri->dma->desc[desc].ba=20
=3D 0;
+			dbri->dma->desc[desc].ba =3D 0;
+			dbri->dma->desc[desc].nda =3D 0;
 			desc =3D dbri->next_desc[desc];
-		} while (desc !=3D -1 && desc !=3D dbri->pipes[info->pipe].
first_desc);
+		} while (desc !=3D -1 &&
+			 desc !=3D dbri->pipes[info->pipe].first_desc);
=20
 	dbri->pipes[info->pipe].desc =3D -1;
 	dbri->pipes[info->pipe].first_desc =3D -1;
@@ -1150,8 +1168,7 @@ static int setup_descs(struct snd_dbri *
 		if (streamno =3D=3D DBRI_PLAY) {
 			dbri->dma->desc[desc].word1 =3D DBRI_TD_CNT(mylen);
 			dbri->dma->desc[desc].word4 =3D 0;
-			dbri->dma->desc[desc].word1 |=3D=20
-			    DBRI_TD_F | DBRI_TD_B;
+			dbri->dma->desc[desc].word1 |=3D DBRI_TD_F | DBRI_TD_B;
 		} else {
 			dbri->dma->desc[desc].word1 =3D 0;
 			dbri->dma->desc[desc].word4 =3D
@@ -1172,7 +1189,8 @@ static int setup_descs(struct snd_dbri *
 	}
=20
 	if (first_desc =3D=3D -1 || last_desc =3D=3D -1) {
-		printk(KERN_ERR "DBRI: setup_descs: Not enough=20
descriptors available\n");
+		printk(KERN_ERR "DBRI: setup_descs: "
+			" Not enough descriptors available\n");
 		return -1;
 	}
=20
@@ -1183,14 +1201,14 @@ static int setup_descs(struct snd_dbri *
 	dbri->pipes[info->pipe].desc =3D first_desc;
=20
 #ifdef DBRI_DEBUG
-	for (desc =3D first_desc; desc !=3D -1; ) {
+	for (desc =3D first_desc; desc !=3D -1;) {
 		dprintk(D_DESC, "DESC %d: %08x %08x %08x %08x\n",
 			desc,
 			dbri->dma->desc[desc].word1,
 			dbri->dma->desc[desc].ba,
 			dbri->dma->desc[desc].nda, dbri->dma->desc[desc].
word4);
 			desc =3D dbri->next_desc[desc];
-			if ( desc =3D=3D first_desc )
+			if (desc =3D=3D first_desc)
 				break;
 	}
 #endif
@@ -1213,7 +1231,8 @@ enum master_or_slave { CHImaster, CHIsla
 /*
  * Lock must not be held before calling it.
  */
-static void reset_chi(struct snd_dbri * dbri, enum=20
master_or_slave master_or_slave,
+static void reset_chi(struct snd_dbri *dbri,
+		      enum master_or_slave master_or_slave,
 		      int bits_per_frame)
 {
 	s32 *cmd;
@@ -1222,7 +1241,7 @@ static void reset_chi(struct snd_dbri *=20
 	/* Set CHI Anchor: Pipe 16 */
=20
 	cmd =3D dbri_cmdlock(dbri, 4);
-	val =3D D_DTS_VO | D_DTS_VI | D_DTS_INS=20
+	val =3D D_DTS_VO | D_DTS_VI | D_DTS_INS
 		| D_DTS_PRVIN(16) | D_PIPE(16) | D_DTS_PRVOUT(16);
 	*(cmd++) =3D DBRI_CMD(D_DTS, 0, val);
 	*(cmd++) =3D D_TS_ANCHOR | D_TS_NEXT(16);
@@ -1246,15 +1265,16 @@ static void reset_chi(struct snd_dbri *=20
 	} else {
 		/* Setup DBRI for CHI Master - generate clock, FS
 		 *
-		 * BPF                          =3D  bits per 8 kHz frame
-		 * 12.288 MHz / CHICM_divisor   =3D clock rate
-		 * FD  =3D  1 - drive CHIFS on rising edge of CHICK
+		 * BPF				=3D  bits per 8 kHz frame
+		 * 12.288 MHz / CHICM_divisor	=3D clock rate
+		 * FD =3D 1 - drive CHIFS on rising edge of CHICK
 		 */
 		int clockrate =3D bits_per_frame * 8;
 		int divisor =3D 12288 / clockrate;
=20
 		if (divisor > 255 || divisor * clockrate !=3D 12288)
-			printk(KERN_ERR "DBRI: illegal bits_per_frame in=20
setup_chi\n");
+			printk(KERN_ERR "DBRI: illegal bits_per_frame "
+				"in setup_chi\n");
=20
 		*(cmd++) =3D DBRI_CMD(D_CHI, 0, D_CHI_CHICM(divisor) |=20
D_CHI_FD
 				    | D_CHI_BPF(bits_per_frame));
@@ -1288,7 +1308,7 @@ to the DBRI via the CHI interface and fe
  * Lock must not be held before calling it.
=20
 */
-static void cs4215_setup_pipes(struct snd_dbri * dbri)
+static void cs4215_setup_pipes(struct snd_dbri *dbri)
 {
 	unsigned long flags;
=20
@@ -1303,9 +1323,9 @@ static void cs4215_setup_pipes(struct sn
 	 *          not relevant for us (only for doublechecking).
 	 *
 	 * Control mode:
-	 * Pipe 17: Send timeslots 1-4 (slots 5-8 are readonly)
+	 * Pipe 17: Send timeslots 1-4 (slots 5-8 are read only)
 	 * Pipe 18: Receive timeslot 1 (clb).
-	 * Pipe 19: Receive timeslot 7 (version).=20
+	 * Pipe 19: Receive timeslot 7 (version).
 	 */
=20
 	setup_pipe(dbri, 4, D_SDP_MEM | D_SDP_TO_SER | D_SDP_MSB);
@@ -1355,7 +1375,7 @@ static int cs4215_init_data(struct cs421
 	return 0;
 }
=20
-static void cs4215_setdata(struct snd_dbri * dbri, int muted)
+static void cs4215_setdata(struct snd_dbri *dbri, int muted)
 {
 	if (muted) {
 		dbri->mm.data[0] |=3D 63;
@@ -1387,7 +1407,7 @@ static void cs4215_setdata(struct snd_db
 /*
  * Set the CS4215 to data mode.
  */
-static void cs4215_open(struct snd_dbri * dbri)
+static void cs4215_open(struct snd_dbri *dbri)
 {
 	int data_width;
 	u32 tmp;
@@ -1452,7 +1472,7 @@ static void cs4215_open(struct snd_dbri=20
 /*
  * Send the control information (i.e. audio format)
  */
-static int cs4215_setctrl(struct snd_dbri * dbri)
+static int cs4215_setctrl(struct snd_dbri *dbri)
 {
 	int i, val;
 	u32 tmp;
@@ -1502,9 +1522,9 @@ static int cs4215_setctrl(struct snd_dbr
=20
 	/*
 	 * Control mode:
-	 * Pipe 17: Send timeslots 1-4 (slots 5-8 are readonly)
+	 * Pipe 17: Send timeslots 1-4 (slots 5-8 are read only)
 	 * Pipe 18: Receive timeslot 1 (clb).
-	 * Pipe 19: Receive timeslot 7 (version).=20
+	 * Pipe 19: Receive timeslot 7 (version).
 	 */
=20
 	link_time_slot(dbri, 17, 16, 16, 32, dbri->mm.offset);
@@ -1522,9 +1542,9 @@ static int cs4215_setctrl(struct snd_dbr
 	sbus_writel(tmp, dbri->regs + REG0);
 	spin_unlock_irqrestore(&dbri->lock, flags);
=20
-	for (i =3D 10; ((dbri->mm.status & 0xe4) !=3D 0x20); --i) {
+	for (i =3D 10; ((dbri->mm.status & 0xe4) !=3D 0x20); --i)
 		msleep_interruptible(1);
-	}
+
 	if (i =3D=3D 0) {
 		dprintk(D_MM, "CS4215 didn't respond to CLB (0x%02x)\n",
 			dbri->mm.status);
@@ -1556,7 +1576,7 @@ static int cs4215_setctrl(struct snd_dbr
  * As part of the process we resend the settings for the data
  * timeslots as well.
  */
-static int cs4215_prepare(struct snd_dbri * dbri, unsigned int=20
rate,
+static int cs4215_prepare(struct snd_dbri *dbri, unsigned int=20
rate,
 			  snd_pcm_format_t format, unsigned int channels)
 {
 	int freq_idx;
@@ -1613,7 +1633,7 @@ static int cs4215_prepare(struct snd_dbr
 /*
  *
  */
-static int cs4215_init(struct snd_dbri * dbri)
+static int cs4215_init(struct snd_dbri *dbri)
 {
 	u32 reg2 =3D sbus_readl(dbri->regs + REG2);
 	dprintk(D_MM, "cs4215_init: reg2=3D0x%x\n", reg2);
@@ -1674,7 +1694,7 @@ interrupts are disabled.
=20
 /* xmit_descs()
  *
- * Starts transmiting the current TD's for recording/playing.
+ * Starts transmitting the current TD's for recording/playing.
  * For playback, ALSA has filled the DMA memory with new data=20
(we hope).
  */
 static void xmit_descs(struct snd_dbri *dbri)
@@ -1701,7 +1721,8 @@ static void xmit_descs(struct snd_dbri *
 			*(cmd++) =3D DBRI_CMD(D_SDP, 0,
 					    dbri->pipes[info->pipe].sdp
 					    | D_SDP_P | D_SDP_EVERY | D_SDP_C);
-			*(cmd++) =3D dbri->dma_dvma + dbri_dma_off(desc,=20
first_td);
+			*(cmd++) =3D dbri->dma_dvma +
+				   dbri_dma_off(desc, first_td);
 			dbri_cmdsend(dbri, cmd, 2);
=20
 			/* Reset our admin of the pipe. */
@@ -1722,7 +1743,8 @@ static void xmit_descs(struct snd_dbri *
 			*(cmd++) =3D DBRI_CMD(D_SDP, 0,
 					    dbri->pipes[info->pipe].sdp
 					    | D_SDP_P | D_SDP_EVERY | D_SDP_C);
-			*(cmd++) =3D dbri->dma_dvma + dbri_dma_off(desc,=20
first_td);
+			*(cmd++) =3D dbri->dma_dvma +
+				   dbri_dma_off(desc, first_td);
 			dbri_cmdsend(dbri, cmd, 2);
=20
 			/* Reset our admin of the pipe. */
@@ -1747,7 +1769,7 @@ static void xmit_descs(struct snd_dbri *
  *
  */
=20
-static void transmission_complete_intr(struct snd_dbri * dbri,=20
int pipe)
+static void transmission_complete_intr(struct snd_dbri *dbri,=20
int pipe)
 {
 	struct dbri_streaminfo *info;
 	int td;
@@ -1763,9 +1785,8 @@ static void transmission_complete_intr(s
 		}
=20
 		status =3D DBRI_TD_STATUS(dbri->dma->desc[td].word4);
-		if (!(status & DBRI_TD_TBC)) {
+		if (!(status & DBRI_TD_TBC))
 			break;
-		}
=20
 		dprintk(D_INT, "TD %d, status 0x%02x\n", td, status);
=20
@@ -1785,7 +1806,7 @@ static void transmission_complete_intr(s
 		snd_pcm_period_elapsed(info->substream);
 }
=20
-static void reception_complete_intr(struct snd_dbri * dbri, int=20
pipe)
+static void reception_complete_intr(struct snd_dbri *dbri, int=20
pipe)
 {
 	struct dbri_streaminfo *info;
 	int rd =3D dbri->pipes[pipe].desc;
@@ -1817,7 +1838,7 @@ static void reception_complete_intr(stru
 		snd_pcm_period_elapsed(info->substream);
 }
=20
-static void dbri_process_one_interrupt(struct snd_dbri * dbri,=20
int x)
+static void dbri_process_one_interrupt(struct snd_dbri *dbri,=20
int x)
 {
 	int val =3D D_INTR_GETVAL(x);
 	int channel =3D D_INTR_GETCHAN(x);
@@ -1889,7 +1910,7 @@ static void dbri_process_one_interrupt(s
  * right now).  Non-zero words require processing and are handed=20
off
  * to dbri_process_one_interrupt AFTER advancing the pointer.
  */
-static void dbri_process_interrupt_buffer(struct snd_dbri *=20
dbri)
+static void dbri_process_interrupt_buffer(struct snd_dbri *dbri)
 {
 	s32 x;
=20
@@ -1965,15 +1986,15 @@ static irqreturn_t snd_dbri_interrupt(in
 		PCM Interface
=20
*****************************************************************
***********/
 static struct snd_pcm_hardware snd_dbri_pcm_hw =3D {
-	.info			=3D (SNDRV_PCM_INFO_MMAP |
-				   SNDRV_PCM_INFO_INTERLEAVED |
-				   SNDRV_PCM_INFO_BLOCK_TRANSFER |
-				   SNDRV_PCM_INFO_MMAP_VALID),
-	.formats		=3D SNDRV_PCM_FMTBIT_MU_LAW |
-				  SNDRV_PCM_FMTBIT_A_LAW |
-				  SNDRV_PCM_FMTBIT_U8 |
-				  SNDRV_PCM_FMTBIT_S16_BE,
-	.rates			=3D SNDRV_PCM_RATE_8000_48000 |=20
SNDRV_PCM_RATE_5512,
+	.info		=3D (SNDRV_PCM_INFO_MMAP |
+			   SNDRV_PCM_INFO_INTERLEAVED |
+			   SNDRV_PCM_INFO_BLOCK_TRANSFER |
+			   SNDRV_PCM_INFO_MMAP_VALID),
+	.formats	=3D SNDRV_PCM_FMTBIT_MU_LAW |
+			  SNDRV_PCM_FMTBIT_A_LAW |
+			  SNDRV_PCM_FMTBIT_U8 |
+			  SNDRV_PCM_FMTBIT_S16_BE,
+	.rates		=3D SNDRV_PCM_RATE_8000_48000 |=20
SNDRV_PCM_RATE_5512,
 	.rate_min		=3D 5512,
 	.rate_max		=3D 48000,
 	.channels_min		=3D 1,
@@ -2011,7 +2032,8 @@ static int snd_hw_rule_channels(struct s
=20
 	snd_interval_any(&ch);
 	if (!(f->bits[0] & SNDRV_PCM_FMTBIT_S16_BE)) {
-		ch.min =3D ch.max =3D 1;
+		ch.min =3D 1;
+		ch.max =3D 1;
 		ch.integer =3D 1;
 		return snd_interval_refine(c, &ch);
 	}
@@ -2035,14 +2057,14 @@ static int snd_dbri_open(struct snd_pcm_
 	info->pipe =3D -1;
 	spin_unlock_irqrestore(&dbri->lock, flags);
=20
-	snd_pcm_hw_rule_add(runtime,0,SNDRV_PCM_HW_PARAM_CHANNELS,
+	snd_pcm_hw_rule_add(runtime, 0,=20
SNDRV_PCM_HW_PARAM_CHANNELS,
 			    snd_hw_rule_format, NULL,=20
SNDRV_PCM_HW_PARAM_FORMAT,
 			    -1);
-	snd_pcm_hw_rule_add(runtime,0,SNDRV_PCM_HW_PARAM_FORMAT,
-			    snd_hw_rule_channels, NULL,=20
+	snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FORMAT,
+			    snd_hw_rule_channels, NULL,
 			    SNDRV_PCM_HW_PARAM_CHANNELS,
 			    -1);
-			=09
+
 	cs4215_open(dbri);
=20
 	return 0;
@@ -2145,7 +2167,7 @@ static int snd_dbri_prepare(struct snd_p
 	spin_lock_irq(&dbri->lock);
 	info->offset =3D 0;
=20
-	/* Setup the all the transmit/receive desciptors to cover=20
the
+	/* Setup the all the transmit/receive descriptors to cover=20
the
 	 * whole DMA buffer.
 	 */
 	ret =3D setup_descs(dbri, DBRI_STREAMNO(substream),
@@ -2205,7 +2227,7 @@ static struct snd_pcm_ops snd_dbri_ops =3D
 	.pointer =3D snd_dbri_pointer,
 };
=20
-static int __devinit snd_dbri_pcm(struct snd_dbri * dbri)
+static int __devinit snd_dbri_pcm(struct snd_dbri *dbri)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -2228,9 +2250,8 @@ static int __devinit snd_dbri_pcm(struct
 	if ((err =3D snd_pcm_lib_preallocate_pages_for_all(pcm,
 			SNDRV_DMA_TYPE_CONTINUOUS,
 			snd_dma_continuous_data(GFP_KERNEL),
-			64 * 1024, 64 * 1024)) < 0) {
+			64 * 1024, 64 * 1024)) < 0)
 		return err;
-	}
=20
 	return 0;
 }
@@ -2271,7 +2292,8 @@ static int snd_cs4215_put_volume(struct=20
 				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_dbri *dbri =3D snd_kcontrol_chip(kcontrol);
-	struct dbri_streaminfo *info =3D=20
&dbri->stream_info[kcontrol->private_value];
+	struct dbri_streaminfo *info =3D
+				&dbri->stream_info[kcontrol->private_value];
 	int changed =3D 0;
=20
 	if (info->left_gain !=3D ucontrol->value.integer.value[0]) {
@@ -2316,18 +2338,16 @@ static int snd_cs4215_get_single(struct=20
 	int invert =3D (kcontrol->private_value >> 24) & 1;
 	snd_assert(dbri !=3D NULL, return -EINVAL);
=20
-	if (elem < 4) {
+	if (elem < 4)
 		ucontrol->value.integer.value[0] =3D
 		    (dbri->mm.data[elem] >> shift) & mask;
-	} else {
+	else
 		ucontrol->value.integer.value[0] =3D
 		    (dbri->mm.ctrl[elem - 4] >> shift) & mask;
-	}
=20
-	if (invert =3D=3D 1) {
+	if (invert =3D=3D 1)
 		ucontrol->value.integer.value[0] =3D
 		    mask - ucontrol->value.integer.value[0];
-	}
 	return 0;
 }
=20
@@ -2378,11 +2398,12 @@ static int snd_cs4215_put_single(struct=20
    timeslots. Shift is the bit offset in the timeslot, mask=20
defines the
    number of bits. invert is a boolean for use with attenuation.
  */
-#define CS4215_SINGLE(xname, entry, shift, mask, invert) \
-{ .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, .name =3D xname, \
-  .info =3D snd_cs4215_info_single, \
-  .get =3D snd_cs4215_get_single, .put =3D snd_cs4215_put_single, \
-  .private_value =3D entry | (shift << 8) | (mask << 16) | (invert=20
<< 24) },
+#define CS4215_SINGLE(xname, entry, shift, mask, invert)	\
+{ .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, .name =3D (xname),		\
+  .info =3D snd_cs4215_info_single,				\
+  .get =3D snd_cs4215_get_single, .put =3D snd_cs4215_put_single,
	\
+  .private_value =3D (entry) | ((shift) << 8) | ((mask) << 16)=20
|	\
+			((invert) << 24) },
=20
 static struct snd_kcontrol_new dbri_controls[] __devinitdata =3D {
 	{
@@ -2411,7 +2432,7 @@ static struct snd_kcontrol_new dbri_cont
 	CS4215_SINGLE("Mic boost", 4, 4, 1, 1)
 };
=20
-static int __init snd_dbri_mixer(struct snd_dbri * dbri)
+static int __init snd_dbri_mixer(struct snd_dbri *dbri)
 {
 	struct snd_card *card;
 	int idx, err;
@@ -2438,7 +2459,8 @@ static int __init snd_dbri_mixer(struct=20
=20
/****************************************************************
************
 			/proc interface
=20
*****************************************************************
***********/
-static void dbri_regs_read(struct snd_info_entry * entry, struct=20
snd_info_buffer *buffer)
+static void dbri_regs_read(struct snd_info_entry *entry,
+			   struct snd_info_buffer *buffer)
 {
 	struct snd_dbri *dbri =3D entry->private_data;
=20
@@ -2449,7 +2471,7 @@ static void dbri_regs_read(struct snd_in
 }
=20
 #ifdef DBRI_DEBUG
-static void dbri_debug_read(struct snd_info_entry * entry,
+static void dbri_debug_read(struct snd_info_entry *entry,
 			    struct snd_info_buffer *buffer)
 {
 	struct snd_dbri *dbri =3D entry->private_data;
@@ -2463,7 +2485,8 @@ static void dbri_debug_read(struct snd_i
 				    "Pipe %d: %s SDP=3D0x%x desc=3D%d, "
 				    "len=3D%d next %d\n",
 				    pipe,
-				   ((pptr->sdp & D_SDP_TO_SER) ? "output" : "input")
,
+				   ((pptr->sdp & D_SDP_TO_SER) ? "output" :
+								 "input"),
 				    pptr->sdp, pptr->desc,
 				    pptr->length, pptr->nextpipe);
 		}
@@ -2471,11 +2494,11 @@ static void dbri_debug_read(struct snd_i
 }
 #endif
=20
-void snd_dbri_proc(struct snd_dbri * dbri)
+void snd_dbri_proc(struct snd_dbri *dbri)
 {
 	struct snd_info_entry *entry;
=20
-	if (! snd_card_proc_new(dbri->card, "regs", &entry))
+	if (!snd_card_proc_new(dbri->card, "regs", &entry))
 		snd_info_set_text_ops(entry, dbri, dbri_regs_read);
=20
 #ifdef DBRI_DEBUG
@@ -2491,7 +2514,7 @@ void snd_dbri_proc(struct snd_dbri * dbr
 **************************** Initialization=20
********************************
=20
*****************************************************************
***********
 */
-static void snd_dbri_free(struct snd_dbri * dbri);
+static void snd_dbri_free(struct snd_dbri *dbri);
=20
 static int __init snd_dbri_create(struct snd_card *card,
 				  struct sbus_dev *sdev,
@@ -2547,7 +2570,7 @@ static int __init snd_dbri_create(struct
 	return 0;
 }
=20
-static void snd_dbri_free(struct snd_dbri * dbri)
+static void snd_dbri_free(struct snd_dbri *dbri)
 {
 	dprintk(D_GEN, "snd_dbri_free\n");
 	dbri_reset(dbri);
@@ -2587,7 +2610,8 @@ static int __init dbri_attach(int prom_n
=20
 	err =3D prom_getproperty(prom_node, "intr", (char *)&irq,=20
sizeof(irq));
 	if (err < 0) {
-		printk(KERN_ERR "DBRI-%d: Firmware node lacks IRQ=20
property.\n", dev);
+		printk(KERN_ERR "DBRI-%d: Firmware node lacks IRQ=20
property.\n",
+			dev);
 		return -ENODEV;
 	}
=20
@@ -2613,12 +2637,14 @@ static int __init dbri_attach(int prom_n
 		goto _err;
=20
 	if ((err =3D snd_dbri_mixer(dbri)) < 0)
+	if ((err =3D snd_dbri_mixer(dbri)) < 0)
 		goto _err;
=20
 	/* /proc file handling */
 	snd_dbri_proc(dbri);
=20
-	if ((err =3D snd_card_register(card)) < 0)
+	err =3D snd_card_register(card);
+	if (err < 0)
 		goto _err;
=20
 	printk(KERN_INFO "audio%d at %p (irq %d) is DBRI(%c)
+CS4215(%d)\n",
@@ -2628,7 +2654,7 @@ static int __init dbri_attach(int prom_n
=20
 	return 0;
=20
- _err:
+_err:
 	snd_dbri_free(dbri);
 	snd_card_free(card);
 	return err;


----------------------------------------------------
Producenci filmu SEZON NA MISIA przedstawiaj=B1
surfuj=B1ce pingwiny w nowej, animowanej komedii
NA FALI -  w kinach od 10 sierpnia!=20
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fnafali_zwi=
astun.html&sid=3D1256

--part46c69152e710b
Content-Type: application/octet-stream; name="dbri-cleanup.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dbri-cleanup.diff"

RnJvbTogS3J6eXN6dG9mIEhlbHQgPGtyenlzenRvZi5oMUB3cC5wbD4KClRoaXMgcGF0Y2ggZml4
ZXMgd2hpdGUgc3BhY2VzLCBzcGVsbGluZyBhbmQgZm9ybWF0dGluZwp0byBjb25mb3JtIGNsb3Nl
ciB0byB0aGUgY29kaW5nIHN0YW5kYXJkIG9mIHRoZSBrZXJuZWwuCkl0IGNvbnRhaW5zIGZldyBm
aXhlcyBwb2ludGVkIG91dCBieSB0aGUgY2hlY2twYXRjaC5wbCBzY3JpcHQuCgpTaWduZWQtb2Zm
LWJ5OiBLcnp5c3p0b2YgSGVsdCA8a3J6eXN6dG9mLmgxQHdwLnBsPgoKLS0tCgpkaWZmIC11cnAg
bGludXgtMi42LjIzLjIvc291bmQvc3BhcmMvZGJyaS5jIGxpbnV4LTIuNi4yMy9zb3VuZC9zcGFy
Yy9kYnJpLmMKLS0tIGxpbnV4LTIuNi4yMy4yL3NvdW5kL3NwYXJjL2RicmkuYwkyMDA3LTA3LTA5
IDAxOjMyOjE2LjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjIzL3NvdW5kL3NwYXJjL2Ri
cmkuYwkyMDA3LTA4LTE3IDEwOjQ4OjMxLjAwMDAwMDAwMCArMDIwMApAQCAtOCwxOCArOCwxOCBA
QAogICogQ29weXJpZ2h0IChDKSAxOTk3IFJ1ZG9sZiBLb2VuaWcgKHJma29lbmlnQGltbWQ0Lmlu
Zm9ybWF0aWsudW5pLWVybGFuZ2VuLmRlKQogICogQ29weXJpZ2h0IChDKSAxOTk4LCAxOTk5IEJy
ZW50IEJhY2NhbGEgKGJhY2NhbGFAZnJlZXNvZnQub3JnKQogICoKLSAqIFRoaXMgaXMgdGhlIGxv
d2xldmVsIGRyaXZlciBmb3IgdGhlIERCUkkgJiBNTUNPREVDIGR1byB1c2VkIGZvciBJU0ROICYg
QVVESU8KLSAqIG9uIFN1biBTUEFSQ3N0YXRpb24gMTAsIDIwLCBMWCBhbmQgVm95YWdlciBtb2Rl
bHMuCisgKiBUaGlzIGlzIHRoZSBsb3cgbGV2ZWwgZHJpdmVyIGZvciB0aGUgREJSSSAmIE1NQ09E
RUMgZHVvIHVzZWQgZm9yIElTRE4gJiBBVURJTworICogb24gU3VuIFNQQVJDU3RhdGlvbiAxMCwg
MjAsIExYIGFuZCBWb3lhZ2VyIG1vZGVscy4KICAqCiAgKiAtIERCUkk6IEFUJlQgVDU5MDBGWCBE
dWFsIEJhc2ljIFJhdGVzIElTRE4gSW50ZXJmYWNlLiBJdCBpcyBhIDMyIGNoYW5uZWwKICAqICAg
ZGF0YSB0aW1lIG11bHRpcGxleGVyIHdpdGggSVNETiBzdXBwb3J0IChha2EgVDcyNTkpCiAgKiAg
IEludGVyZmFjZXM6IFNCdXMsSVNETiBOVCAmIFRFLCBDSEksIDQgYml0cyBwYXJhbGxlbC4KICAq
ICAgQ0hJOiAoc3BlbGxlZCBraSkgQ29uY2VudHJhdGlvbiBIaWdod2F5IEludGVyZmFjZSAoQVQm
VCBvciBJbnRlbCBidXMgPykuCiAgKiAgIERvY3VtZW50YXRpb246Ci0gKiAgIC0gIlNUUCA0MDAw
U0J1cyBEdWFsIEJhc2ljIFJhdGUgSVNETiAoREJSSSkgVHJhbmNlaXZlciIgZnJvbQorICogICAt
ICJTVFAgNDAwMFNCdXMgRHVhbCBCYXNpYyBSYXRlIElTRE4gKERCUkkpIFRyYW5zY2VpdmVyIiBm
cm9tCiAgKiAgICAgU3BhcmMgVGVjaG5vbG9neSBCdXNpbmVzcyAoY291cnRlc3kgb2YgU3VuIFN1
cHBvcnQpCiAgKiAgIC0gRGF0YSBzaGVldCBvZiB0aGUgVDc5MDMsIGEgbmV3ZXIgYnV0IHZlcnkg
c2ltaWxhciBJU0EgYnVzIGVxdWl2YWxlbnQKLSAqICAgICBhdmFpbGFibGUgZnJvbSB0aGUgTHVj
ZW50IChmb3JtYXJseSBBVCZUIG1pY3JvZWxlY3Ryb25pY3MpIGhvbWUKKyAqICAgICBhdmFpbGFi
bGUgZnJvbSB0aGUgTHVjZW50IChmb3JtZXJseSBBVCZUIG1pY3JvZWxlY3Ryb25pY3MpIGhvbWUK
ICAqICAgICBwYWdlLgogICogICAtIGh0dHA6Ly93d3cuZnJlZXNvZnQub3JnL0xpbnV4L0RCUkkv
CiAgKiAtIE1NQ09ERUM6IENyeXN0YWwgU2VtaWNvbmR1Y3RvciBDUzQyMTUgMTYgYml0IE11bHRp
bWVkaWEgQXVkaW8gQ29kZWMKQEAgLTI3LDIxICsyNywyMSBAQAogICogICBEb2N1bWVudGF0aW9u
OiBmcm9tIHRoZSBDcnlzdGFsIFNlbWljb25kdWN0b3IgaG9tZSBwYWdlLgogICoKICAqIFRoZSBE
QlJJIGlzIGEgMzIgcGlwZSBtYWNoaW5lLCBlYWNoIHBpcGUgY2FuIHRyYW5zZmVyIHNvbWUgYml0
cyBiZXR3ZWVuCi0gKiBtZW1vcnkgYW5kIGEgc2VyaWFsIGRldmljZSAobG9uZyBwaXBlcywgbnIg
MC0xNSkgb3IgYmV0d2VlbiB0d28gc2VyaWFsCi0gKiBkZXZpY2VzIChzaG9ydCBwaXBlcywgbnIg
MTYtMzEpLCBvciBzaW1wbHkgc2VuZCBhIGZpeGVkIGRhdGEgdG8gYSBzZXJpYWwKKyAqIG1lbW9y
eSBhbmQgYSBzZXJpYWwgZGV2aWNlIChsb25nIHBpcGVzLCBuby4gMC0xNSkgb3IgYmV0d2VlbiB0
d28gc2VyaWFsCisgKiBkZXZpY2VzIChzaG9ydCBwaXBlcywgbm8uIDE2LTMxKSwgb3Igc2ltcGx5
IHNlbmQgYSBmaXhlZCBkYXRhIHRvIGEgc2VyaWFsCiAgKiBkZXZpY2UgKHNob3J0IHBpcGVzKS4K
LSAqIEEgdGltZXNsb3QgZGVmaW5lcyB0aGUgYml0LW9mZnNldCBhbmQgbnIgb2YgYml0cyByZWFk
IGZyb20gYSBzZXJpYWwgZGV2aWNlLgorICogQSB0aW1lc2xvdCBkZWZpbmVzIHRoZSBiaXQtb2Zm
c2V0IGFuZCBuby4gb2YgYml0cyByZWFkIGZyb20gYSBzZXJpYWwgZGV2aWNlLgogICogVGhlIHRp
bWVzbG90cyBhcmUgbGlua2VkIHRvIDYgY2lyY3VsYXIgbGlzdHMsIG9uZSBmb3IgZWFjaCBkaXJl
Y3Rpb24gZm9yCiAgKiBlYWNoIHNlcmlhbCBkZXZpY2UgKE5ULFRFLENISSkuIEEgdGltZXNsb3Qg
aXMgYXNzb2NpYXRlZCB0byAxIG9yIDIgcGlwZXMKICAqICh0aGUgc2Vjb25kIG9uZSBpcyBhIG1v
bml0b3IvdGVlIHBpcGUsIHZhbGlkIG9ubHkgZm9yIHNlcmlhbCBpbnB1dCkuCiAgKgogICogVGhl
IG1tY29kZWMgaXMgY29ubmVjdGVkIHZpYSB0aGUgQ0hJIGJ1cyBhbmQgbmVlZHMgdGhlIGRhdGEg
JiBzb21lCi0gKiBwYXJhbWV0ZXJzICh2b2x1bWUsIG91dHB1dCBzZWxlY3Rpb24pIHRpbWVtdWx0
aXBsZXhlZCBpbiA4IGJ5dGUKKyAqIHBhcmFtZXRlcnMgKHZvbHVtZSwgb3V0cHV0IHNlbGVjdGlv
bikgdGltZSBtdWx0aXBsZXhlZCBpbiA4IGJ5dGUKICAqIGNodW5rcy4gSXQgYWxzbyBoYXMgYSBj
b250cm9sIG1vZGUsIHdoaWNoIHNlcnZlcyBmb3IgYXVkaW8gZm9ybWF0IHNldHRpbmcuCiAgKgog
ICogTG9va2luZyBhdCB0aGUgQ1M0MjE1IGRhdGEgc2hlZXQgaXQgaXMgZWFzeSB0byBzZXQgdXAg
MiBvciA0IGNvZGVjcyBvbgotICogdGhlIHNhbWUgQ0hJIGJ1cywgc28gSSB0aG91Z2h0IHBlcmhh
cHMgaXQgaXMgcG9zc2libGUgdG8gdXNlIHRoZSBvbmJvYXJkCi0gKiAmIHRoZSBzcGVha2VyYm94
IGNvZGVjIHNpbXVsdGFub3VzbHksIGdpdmluZyAyIChub3QgdmVyeSBpbmRlcGVuZGVudCA6LSkK
KyAqIHRoZSBzYW1lIENISSBidXMsIHNvIEkgdGhvdWdodCBwZXJoYXBzIGl0IGlzIHBvc3NpYmxl
IHRvIHVzZSB0aGUgb24tYm9hcmQKKyAqICYgdGhlIHNwZWFrZXJib3ggY29kZWMgc2ltdWx0YW5l
b3VzbHksIGdpdmluZyAyIChub3QgdmVyeSBpbmRlcGVuZGVudCA6LSkKICAqIGF1ZGlvIGRldmlj
ZXMuIEJ1dCB0aGUgU1VOIEhXIGdyb3VwIGRlY2lkZWQgYWdhaW5zdCBpdCwgYXQgbGVhc3Qgb24g
bXkKICAqIExYIHRoZSBzcGVha2VyYm94IGNvbm5lY3RvciBoYXMgYXQgbGVhc3QgMSBwaW4gbWlz
c2luZyBhbmQgMSB3cm9uZ2x5CiAgKiBjb25uZWN0ZWQuCkBAIC01Niw2ICs1Niw4IEBACiAjaW5j
bHVkZSA8c291bmQvZHJpdmVyLmg+CiAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CiAjaW5j
bHVkZSA8bGludXgvZGVsYXkuaD4KKyNpbmNsdWRlIDxsaW51eC9pcnEuaD4KKyNpbmNsdWRlIDxs
aW51eC9pby5oPgogCiAjaW5jbHVkZSA8c291bmQvY29yZS5oPgogI2luY2x1ZGUgPHNvdW5kL3Bj
bS5oPgpAQCAtNjQsOCArNjYsNiBAQAogI2luY2x1ZGUgPHNvdW5kL2NvbnRyb2wuaD4KICNpbmNs
dWRlIDxzb3VuZC9pbml0dmFsLmg+CiAKLSNpbmNsdWRlIDxhc20vaXJxLmg+Ci0jaW5jbHVkZSA8
YXNtL2lvLmg+CiAjaW5jbHVkZSA8YXNtL3NidXMuaD4KICNpbmNsdWRlIDxhc20vYXRvbWljLmg+
CiAKQEAgLTc2LDcgKzc2LDggQEAgTU9EVUxFX1NVUFBPUlRFRF9ERVZJQ0UoInt7U3VuLERCUkl9
fSIpOwogCiBzdGF0aWMgaW50IGluZGV4W1NORFJWX0NBUkRTXSA9IFNORFJWX0RFRkFVTFRfSURY
OwkvKiBJbmRleCAwLU1BWCAqLwogc3RhdGljIGNoYXIgKmlkW1NORFJWX0NBUkRTXSA9IFNORFJW
X0RFRkFVTFRfU1RSOwkvKiBJRCBmb3IgdGhpcyBjYXJkICovCi1zdGF0aWMgaW50IGVuYWJsZVtT
TkRSVl9DQVJEU10gPSBTTkRSVl9ERUZBVUxUX0VOQUJMRV9QTlA7CS8qIEVuYWJsZSB0aGlzIGNh
cmQgKi8KKy8qIEVuYWJsZSB0aGlzIGNhcmQgKi8KK3N0YXRpYyBpbnQgZW5hYmxlW1NORFJWX0NB
UkRTXSA9IFNORFJWX0RFRkFVTFRfRU5BQkxFX1BOUDsKIAogbW9kdWxlX3BhcmFtX2FycmF5KGlu
ZGV4LCBpbnQsIE5VTEwsIDA0NDQpOwogTU9EVUxFX1BBUk1fREVTQyhpbmRleCwgIkluZGV4IHZh
bHVlIGZvciBTdW4gREJSSSBzb3VuZGNhcmQuIik7CkBAIC0xMDQsNyArMTA1LDcgQEAgc3RhdGlj
IGNoYXIgKmNtZHNbXSA9IHsKIAkiU1NQIiwgIkNISSIsICJOVCIsICJURSIsICJDREVDIiwgIlRF
U1QiLCAiQ0RNIiwgIlJFU1JWIgogfTsKIAotI2RlZmluZSBkcHJpbnRrKGEsIHguLi4pIGlmKGRi
cmlfZGVidWcgJiBhKSBwcmludGsoS0VSTl9ERUJVRyB4KQorI2RlZmluZSBkcHJpbnRrKGEsIHgu
Li4pIGlmIChkYnJpX2RlYnVnICYgYSkgcHJpbnRrKEtFUk5fREVCVUcgeCkKIAogI2Vsc2UKICNk
ZWZpbmUgZHByaW50ayhhLCB4Li4uKSBkbyB7IH0gd2hpbGUgKDApCkBAIC0xMzEsNyArMTMyLDcg
QEAgc3RydWN0IGNzNDIxNSB7CiB9OwogCiAvKgotICogQ29udHJvbCBtb2RlIGZpcnN0IAorICog
Q29udHJvbCBtb2RlIGZpcnN0CiAgKi8KIAogLyogVGltZSBTbG90IDEsIFN0YXR1cyByZWdpc3Rl
ciAqLwpAQCAtMjE5LDcgKzIyMCw3IEBAIHN0YXRpYyBzdHJ1Y3QgewogLyogVGltZSBTbG90IDcs
IElucHV0IFNldHRpbmcgKi8KICNkZWZpbmUgQ1M0MjE1X0xHKHYpCXYJLyogTGVmdCBHYWluIFNl
dHRpbmcgMHhmOiAyMi41IGRCICovCiAjZGVmaW5lIENTNDIxNV9JUwkoMTw8NCkJLyogSW5wdXQg
U2VsZWN0OiAxPU1pY3JvcGhvbmUsIDA9TGluZSAqLwotI2RlZmluZSBDUzQyMTVfT1ZSCSgxPDw1
KQkvKiAxOiBPdmVycmFuZ2UgY29uZGl0aW9uIG9jY3VycmVkICovCisjZGVmaW5lIENTNDIxNV9P
VlIJKDE8PDUpCS8qIDE6IE92ZXIgcmFuZ2UgY29uZGl0aW9uIG9jY3VycmVkICovCiAjZGVmaW5l
IENTNDIxNV9QSU8wCSgxPDw2KQkvKiBQYXJhbGxlbCBJL08gMCAqLwogI2RlZmluZSBDUzQyMTVf
UElPMQkoMTw8NykKIApAQCAtMjg1LDcgKzI4Niw3IEBAIHN0cnVjdCBkYnJpX3BpcGUgewogLyog
UGVyIHN0cmVhbSAocGxheWJhY2sgb3IgcmVjb3JkKSBpbmZvcm1hdGlvbiAqLwogc3RydWN0IGRi
cmlfc3RyZWFtaW5mbyB7CiAJc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW07Ci0J
dTMyIGR2bWFfYnVmZmVyOwkvKiBEZXZpY2UgdmlldyBvZiBBbHNhIERNQSBidWZmZXIgKi8KKwl1
MzIgZHZtYV9idWZmZXI7CS8qIERldmljZSB2aWV3IG9mIEFMU0EgRE1BIGJ1ZmZlciAqLwogCWlu
dCBzaXplOwkJLyogU2l6ZSBvZiBETUEgYnVmZmVyICAgICAgICAgICAgICovCiAJc2l6ZV90IG9m
ZnNldDsJCS8qIG9mZnNldCBpbiB1c2VyIGJ1ZmZlciAgICAgICAgICAqLwogCWludCBwaXBlOwkJ
LyogRGF0YSBwaXBlIHVzZWQgICAgICAgICAgICAgICAgICovCkBAIC0zNDEsMTEgKzM0MiwxMSBA
QCBzdHJ1Y3Qgc25kX2RicmkgewogLyogREJSSSBSZWcxIC0gTW9kZSBhbmQgSW50ZXJydXB0IFJl
Z2lzdGVyIC0gZGVmaW5lcy4gKFBhZ2UgMTgpICovCiAjZGVmaW5lIERfTElUVExFX0VORAkoMTw8
OCkJLyogQnl0ZSBPcmRlciAqLwogI2RlZmluZSBEX0JJR19FTkQJKDA8PDgpCS8qIEJ5dGUgT3Jk
ZXIgKi8KLSNkZWZpbmUgRF9NUlIJCSgxPDw0KQkvKiBNdWx0aXBsZSBFcnJvciBBY2sgb24gU0J1
cyAocmVhZG9ubHkpICovCi0jZGVmaW5lIERfTUxFCQkoMTw8MykJLyogTXVsdGlwbGUgTGF0ZSBF
cnJvciBvbiBTQnVzIChyZWFkb25seSkgKi8KLSNkZWZpbmUgRF9MQkcJCSgxPDwyKQkvKiBMb3N0
IEJ1cyBHcmFudCBvbiBTQnVzIChyZWFkb25seSkgKi8KLSNkZWZpbmUgRF9NQkUJCSgxPDwxKQkv
KiBCdXJzdCBFcnJvciBvbiBTQnVzIChyZWFkb25seSkgKi8KLSNkZWZpbmUgRF9JUgkJKDE8PDAp
CS8qIEludGVycnVwdCBJbmRpY2F0b3IgKHJlYWRvbmx5KSAqLworI2RlZmluZSBEX01SUgkJKDE8
PDQpCS8qIE11bHRpcGxlIEVycm9yIEFjayBvbiBTQnVzIChyZWFkIG9ubHkpICovCisjZGVmaW5l
IERfTUxFCQkoMTw8MykJLyogTXVsdGlwbGUgTGF0ZSBFcnJvciBvbiBTQnVzIChyZWFkIG9ubHkp
ICovCisjZGVmaW5lIERfTEJHCQkoMTw8MikJLyogTG9zdCBCdXMgR3JhbnQgb24gU0J1cyAocmVh
ZCBvbmx5KSAqLworI2RlZmluZSBEX01CRQkJKDE8PDEpCS8qIEJ1cnN0IEVycm9yIG9uIFNCdXMg
KHJlYWQgb25seSkgKi8KKyNkZWZpbmUgRF9JUgkJKDE8PDApCS8qIEludGVycnVwdCBJbmRpY2F0
b3IgKHJlYWQgb25seSkgKi8KIAogLyogREJSSSBSZWcyIC0gUGFyYWxsZWwgSU8gUmVnaXN0ZXIg
LSBkZWZpbmVzLiAoUGFnZSAxOCkgKi8KICNkZWZpbmUgRF9FTlBJTzMJKDE8PDcpCS8qIEVuYWJs
ZSBQaW4gMyAqLwpAQCAtMzc2LDExICszNzcsMTEgQEAgc3RydWN0IHNuZF9kYnJpIHsKICNkZWZp
bmUgRF9DRE0JCTB4ZQkvKiBDSEkgRGF0YSBtb2RlIGNvbW1hbmQgKi8KIAogLyogU3BlY2lhbCBi
aXRzIGZvciBzb21lIGNvbW1hbmRzICovCi0jZGVmaW5lIERfUElQRSh2KSAgICAgICgodik8PDAp
CS8qIFBpcGUgTnI6IDAtMTUgbG9uZywgMTYtMjEgc2hvcnQgKi8KKyNkZWZpbmUgRF9QSVBFKHYp
ICAgICAgKCh2KTw8MCkJLyogUGlwZSBOby46IDAtMTUgbG9uZywgMTYtMjEgc2hvcnQgKi8KIAog
LyogU2V0dXAgRGF0YSBQaXBlICovCiAvKiBJUk0gKi8KLSNkZWZpbmUgRF9TRFBfMlNBTUUJKDE8
PDE4KQkvKiBSZXBvcnQgMm5kIHRpbWUgaW4gYSByb3cgdmFsdWUgcmN2ZCAqLworI2RlZmluZSBE
X1NEUF8yU0FNRQkoMTw8MTgpCS8qIFJlcG9ydCAybmQgdGltZSBpbiBhIHJvdyB2YWx1ZSByZWNl
aXZlZCAqLwogI2RlZmluZSBEX1NEUF9DSEFOR0UJKDI8PDE4KQkvKiBSZXBvcnQgYW55IGNoYW5n
ZXMgKi8KICNkZWZpbmUgRF9TRFBfRVZFUlkJKDM8PDE4KQkvKiBSZXBvcnQgYW55IGNoYW5nZXMg
Ki8KICNkZWZpbmUgRF9TRFBfRU9MCSgxPDwxNykJLyogRU9MIGludGVycnVwdCBlbmFibGUgKi8K
QEAgLTQxOSw3ICs0MjAsNyBAQCBzdHJ1Y3Qgc25kX2RicmkgewogI2RlZmluZSBEX1RTX05PTkNP
TlRJRwkoMzw8MTApCS8qIE5vbiBjb250aWd1b3VzIG1vZGUgKi8KICNkZWZpbmUgRF9UU19BTkNI
T1IJKDc8PDEwKQkvKiBTdGFydGluZyBzaG9ydCBwaXBlcyAqLwogI2RlZmluZSBEX1RTX01PTih2
KSAgICAoKHYpPDw1KQkvKiBNb25pdG9yIFBpcGUgKi8KLSNkZWZpbmUgRF9UU19ORVhUKHYpICAg
KCh2KTw8MCkJLyogUGlwZSBOcjogMC0xNSBsb25nLCAxNi0yMSBzaG9ydCAqLworI2RlZmluZSBE
X1RTX05FWFQodikgICAoKHYpPDwwKQkvKiBQaXBlIG5vLjogMC0xNSBsb25nLCAxNi0yMSBzaG9y
dCAqLwogCiAvKiBDb25jZW50cmF0aW9uIEhpZ2h3YXkgSW50ZXJmYWNlIE1vZGVzICovCiAjZGVm
aW5lIERfQ0hJX0NISUNNKHYpCSgodik8PDE2KQkvKiBDbG9jayBtb2RlICovCkBAIC00MzUsNyAr
NDM2LDcgQEAgc3RydWN0IHNuZF9kYnJpIHsKICNkZWZpbmUgRF9OVF9OQkYJKDE8PDE2KQkvKiBO
dW1iZXIgb2YgYmFkIGZyYW1lcyB0byBsb29zZSBmcmFtaW5nICovCiAjZGVmaW5lIERfTlRfSVJN
X0lNTQkoMTw8MTUpCS8qIEludGVycnVwdCBSZXBvcnQgJiBNYXNrOiBJbW1lZGlhdGUgKi8KICNk
ZWZpbmUgRF9OVF9JUk1fRU4JKDE8PDE0KQkvKiBJbnRlcnJ1cHQgUmVwb3J0ICYgTWFzazogRW5h
YmxlICovCi0jZGVmaW5lIERfTlRfSVNOVAkoMTw8MTMpCS8qIENvbmZpZ2Z1cmUgaW50ZXJmYWNl
IGFzIE5UICovCisjZGVmaW5lIERfTlRfSVNOVAkoMTw8MTMpCS8qIENvbmZpZ3VyZSBpbnRlcmZh
Y2UgYXMgTlQgKi8KICNkZWZpbmUgRF9OVF9GVAkJKDE8PDEyKQkvKiBGaXhlZCBUaW1pbmcgKi8K
ICNkZWZpbmUgRF9OVF9FWgkJKDE8PDExKQkvKiBFY2hvIENoYW5uZWwgaXMgWmVyb3MgKi8KICNk
ZWZpbmUgRF9OVF9JRkEJKDE8PDEwKQkvKiBJbmhpYml0IEZpbmFsIEFjdGl2YXRpb24gKi8KQEAg
LTQ1NSw3ICs0NTYsNyBAQCBzdHJ1Y3Qgc25kX2RicmkgewogI2RlZmluZSBEX1RFU1RfUkFNKHYp
CSgodik8PDE2KQkvKiBSQU0gUG9pbnRlciAqLwogI2RlZmluZSBEX1RFU1RfU0laRSh2KQkoKHYp
PDwxMSkJLyogKi8KICNkZWZpbmUgRF9URVNUX1JPTU9OT0ZGCTB4NQkvKiBUb2dnbGUgUk9NIG9w
Y29kZSBtb25pdG9yIG9uL29mZiAqLwotI2RlZmluZSBEX1RFU1RfUFJPQwkweDYJLyogTWljcm9Q
cm9jZXNzb3IgdGVzdCAqLworI2RlZmluZSBEX1RFU1RfUFJPQwkweDYJLyogTWljcm9wcm9jZXNz
b3IgdGVzdCAqLwogI2RlZmluZSBEX1RFU1RfU0VSCTB4NwkvKiBTZXJpYWwtQ29udHJvbGxlciB0
ZXN0ICovCiAjZGVmaW5lIERfVEVTVF9SQU1SRUFECTB4OAkvKiBDb3B5IGZyb20gUmFtIHRvIHN5
c3RlbSBtZW1vcnkgKi8KICNkZWZpbmUgRF9URVNUX1JBTVdSSVRFCTB4OQkvKiBDb3B5IGludG8g
UmFtIGZyb20gc3lzdGVtIG1lbW9yeSAqLwpAQCAtNDY0LDEyICs0NjUsMTIgQEAgc3RydWN0IHNu
ZF9kYnJpIHsKICNkZWZpbmUgRF9URVNUX0RVTVAJMHhlCS8qIFJPTSBEdW1wICovCiAKIC8qIENI
SSBEYXRhIE1vZGUgKi8KLSNkZWZpbmUgRF9DRE1fVEhJCSgxPDw4KQkvKiBUcmFuc21pdCBEYXRh
IG9uIENISURSIFBpbiAqLwotI2RlZmluZSBEX0NETV9SSEkJKDE8PDcpCS8qIFJlY2VpdmUgRGF0
YSBvbiBDSElEWCBQaW4gKi8KLSNkZWZpbmUgRF9DRE1fUkNFCSgxPDw2KQkvKiBSZWNlaXZlIG9u
IFJpc2luZyBFZGdlIG9mIENISUNLICovCi0jZGVmaW5lIERfQ0RNX1hDRQkoMTw8MikJLyogVHJh
bnNtaXQgRGF0YSBvbiBSaXNpbmcgRWRnZSBvZiBDSElDSyAqLwotI2RlZmluZSBEX0NETV9YRU4J
KDE8PDEpCS8qIFRyYW5zbWl0IEhpZ2h3YXkgRW5hYmxlICovCi0jZGVmaW5lIERfQ0RNX1JFTgko
MTw8MCkJLyogUmVjZWl2ZSBIaWdod2F5IEVuYWJsZSAqLworI2RlZmluZSBEX0NETV9USEkJKDEg
PDwgOCkJLyogVHJhbnNtaXQgRGF0YSBvbiBDSElEUiBQaW4gKi8KKyNkZWZpbmUgRF9DRE1fUkhJ
CSgxIDw8IDcpCS8qIFJlY2VpdmUgRGF0YSBvbiBDSElEWCBQaW4gKi8KKyNkZWZpbmUgRF9DRE1f
UkNFCSgxIDw8IDYpCS8qIFJlY2VpdmUgb24gUmlzaW5nIEVkZ2Ugb2YgQ0hJQ0sgKi8KKyNkZWZp
bmUgRF9DRE1fWENFCSgxIDw8IDIpIC8qIFRyYW5zbWl0IERhdGEgb24gUmlzaW5nIEVkZ2Ugb2Yg
Q0hJQ0sgKi8KKyNkZWZpbmUgRF9DRE1fWEVOCSgxIDw8IDEpCS8qIFRyYW5zbWl0IEhpZ2h3YXkg
RW5hYmxlICovCisjZGVmaW5lIERfQ0RNX1JFTgkoMSA8PCAwKQkvKiBSZWNlaXZlIEhpZ2h3YXkg
RW5hYmxlICovCiAKIC8qIFRoZSBJbnRlcnJ1cHRzICovCiAjZGVmaW5lIERfSU5UUl9CUkRZCTEJ
LyogQnVmZmVyIFJlYWR5IGZvciBwcm9jZXNzaW5nICovCkBAIC00OTMsOSArNDk0LDkgQEAgc3Ry
dWN0IHNuZF9kYnJpIHsKICNkZWZpbmUgRF9JTlRSX0NISQkzNgogI2RlZmluZSBEX0lOVFJfQ01E
CTM4CiAKLSNkZWZpbmUgRF9JTlRSX0dFVENIQU4odikJKCgodik+PjI0KSAmIDB4M2YpCi0jZGVm
aW5lIERfSU5UUl9HRVRDT0RFKHYpCSgoKHYpPj4yMCkgJiAweGYpCi0jZGVmaW5lIERfSU5UUl9H
RVRDTUQodikJKCgodik+PjE2KSAmIDB4ZikKKyNkZWZpbmUgRF9JTlRSX0dFVENIQU4odikJKCgo
dikgPj4gMjQpICYgMHgzZikKKyNkZWZpbmUgRF9JTlRSX0dFVENPREUodikJKCgodikgPj4gMjAp
ICYgMHhmKQorI2RlZmluZSBEX0lOVFJfR0VUQ01EKHYpCSgoKHYpID4+IDE2KSAmIDB4ZikKICNk
ZWZpbmUgRF9JTlRSX0dFVFZBTCh2KQkoKHYpICYgMHhmZmZmKQogI2RlZmluZSBEX0lOVFJfR0VU
UlZBTCh2KQkoKHYpICYgMHhmZmZmZikKIApAQCAtNTMzLDQxICs1MzQsNDIgQEAgc3RydWN0IHNu
ZF9kYnJpIHsKICNkZWZpbmUgRF9QXzMxCQkzMQkvKiAqLwogCiAvKiBUcmFuc21pdCBkZXNjcmlw
dG9yIGRlZmluZXMgKi8KLSNkZWZpbmUgREJSSV9URF9GCSgxPDwzMSkJLyogRW5kIG9mIEZyYW1l
ICovCi0jZGVmaW5lIERCUklfVERfRAkoMTw8MzApCS8qIERvIG5vdCBhcHBlbmQgQ1JDICovCi0j
ZGVmaW5lIERCUklfVERfQ05UKHYpCSgodik8PDE2KQkvKiBOdW1iZXIgb2YgdmFsaWQgYnl0ZXMg
aW4gdGhlIGJ1ZmZlciAqLwotI2RlZmluZSBEQlJJX1REX0IJKDE8PDE1KQkvKiBGaW5hbCBpbnRl
cnJ1cHQgKi8KLSNkZWZpbmUgREJSSV9URF9NCSgxPDwxNCkJLyogTWFya2VyIGludGVycnVwdCAq
LwotI2RlZmluZSBEQlJJX1REX0kJKDE8PDEzKQkvKiBUcmFuc21pdCBJZGxlIENoYXJhY3RlcnMg
Ki8KLSNkZWZpbmUgREJSSV9URF9GQ05UKHYpCSh2KQkvKiBGbGFnIENvdW50ICovCi0jZGVmaW5l
IERCUklfVERfVU5SCSgxPDwzKQkvKiBVbmRlcnJ1bjogdHJhbnNtaXR0ZXIgaXMgb3V0IG9mIGRh
dGEgKi8KLSNkZWZpbmUgREJSSV9URF9BQlQJKDE8PDIpCS8qIEFib3J0OiBmcmFtZSBhYm9ydGVk
ICovCi0jZGVmaW5lIERCUklfVERfVEJDCSgxPDwwKQkvKiBUcmFuc21pdCBidWZmZXIgQ29tcGxl
dGUgKi8KLSNkZWZpbmUgREJSSV9URF9TVEFUVVModikgICAgICAgKCh2KSYweGZmKQkvKiBUcmFu
c21pdCBzdGF0dXMgKi8KLQkJCS8qIE1heGltdW0gYnVmZmVyIHNpemUgcGVyIFREOiBhbG1vc3Qg
OEtiICovCisjZGVmaW5lIERCUklfVERfRgkoMSA8PCAzMSkJLyogRW5kIG9mIEZyYW1lICovCisj
ZGVmaW5lIERCUklfVERfRAkoMSA8PCAzMCkJLyogRG8gbm90IGFwcGVuZCBDUkMgKi8KKyNkZWZp
bmUgREJSSV9URF9DTlQodikJKCh2KSA8PCAxNikgLyogTnVtYmVyIG9mIHZhbGlkIGJ5dGVzIGlu
IHRoZSBidWZmZXIgKi8KKyNkZWZpbmUgREJSSV9URF9CCSgxIDw8IDE1KQkvKiBGaW5hbCBpbnRl
cnJ1cHQgKi8KKyNkZWZpbmUgREJSSV9URF9NCSgxIDw8IDE0KQkvKiBNYXJrZXIgaW50ZXJydXB0
ICovCisjZGVmaW5lIERCUklfVERfSQkoMSA8PCAxMykJLyogVHJhbnNtaXQgSWRsZSBDaGFyYWN0
ZXJzICovCisjZGVmaW5lIERCUklfVERfRkNOVCh2KQkodikJCS8qIEZsYWcgQ291bnQgKi8KKyNk
ZWZpbmUgREJSSV9URF9VTlIJKDEgPDwgMykgLyogVW5kZXJydW46IHRyYW5zbWl0dGVyIGlzIG91
dCBvZiBkYXRhICovCisjZGVmaW5lIERCUklfVERfQUJUCSgxIDw8IDIpCS8qIEFib3J0OiBmcmFt
ZSBhYm9ydGVkICovCisjZGVmaW5lIERCUklfVERfVEJDCSgxIDw8IDApCS8qIFRyYW5zbWl0IGJ1
ZmZlciBDb21wbGV0ZSAqLworI2RlZmluZSBEQlJJX1REX1NUQVRVUyh2KSAgICAgICAoKHYpICYg
MHhmZikJLyogVHJhbnNtaXQgc3RhdHVzICovCisJCQkvKiBNYXhpbXVtIGJ1ZmZlciBzaXplIHBl
ciBURDogYWxtb3N0IDhLQiAqLwogI2RlZmluZSBEQlJJX1REX01BWENOVAkoKDEgPDwgMTMpIC0g
NCkKIAogLyogUmVjZWl2ZSBkZXNjcmlwdG9yIGRlZmluZXMgKi8KLSNkZWZpbmUgREJSSV9SRF9G
CSgxPDwzMSkJLyogRW5kIG9mIEZyYW1lICovCi0jZGVmaW5lIERCUklfUkRfQwkoMTw8MzApCS8q
IENvbXBsZXRlZCBidWZmZXIgKi8KLSNkZWZpbmUgREJSSV9SRF9CCSgxPDwxNSkJLyogRmluYWwg
aW50ZXJydXB0ICovCi0jZGVmaW5lIERCUklfUkRfTQkoMTw8MTQpCS8qIE1hcmtlciBpbnRlcnJ1
cHQgKi8KLSNkZWZpbmUgREJSSV9SRF9CQ05UKHYpCSh2KQkvKiBCdWZmZXIgc2l6ZSAqLwotI2Rl
ZmluZSBEQlJJX1JEX0NSQwkoMTw8NykJLyogMDogQ1JDIGlzIGNvcnJlY3QgKi8KLSNkZWZpbmUg
REJSSV9SRF9CQkMJKDE8PDYpCS8qIDE6IEJhZCBCeXRlIHJlY2VpdmVkICovCi0jZGVmaW5lIERC
UklfUkRfQUJUCSgxPDw1KQkvKiBBYm9ydDogZnJhbWUgYWJvcnRlZCAqLwotI2RlZmluZSBEQlJJ
X1JEX09WUk4JKDE8PDMpCS8qIE92ZXJydW46IGRhdGEgbG9zdCAqLwotI2RlZmluZSBEQlJJX1JE
X1NUQVRVUyh2KSAgICAgICgodikmMHhmZikJLyogUmVjZWl2ZSBzdGF0dXMgKi8KLSNkZWZpbmUg
REJSSV9SRF9DTlQodikgKCgodik+PjE2KSYweDFmZmYpCS8qIFZhbGlkIGJ5dGVzIGluIHRoZSBi
dWZmZXIgKi8KKyNkZWZpbmUgREJSSV9SRF9GCSgxIDw8IDMxKQkvKiBFbmQgb2YgRnJhbWUgKi8K
KyNkZWZpbmUgREJSSV9SRF9DCSgxIDw8IDMwKQkvKiBDb21wbGV0ZWQgYnVmZmVyICovCisjZGVm
aW5lIERCUklfUkRfQgkoMSA8PCAxNSkJLyogRmluYWwgaW50ZXJydXB0ICovCisjZGVmaW5lIERC
UklfUkRfTQkoMSA8PCAxNCkJLyogTWFya2VyIGludGVycnVwdCAqLworI2RlZmluZSBEQlJJX1JE
X0JDTlQodikJKHYpCQkvKiBCdWZmZXIgc2l6ZSAqLworI2RlZmluZSBEQlJJX1JEX0NSQwkoMSA8
PCA3KQkvKiAwOiBDUkMgaXMgY29ycmVjdCAqLworI2RlZmluZSBEQlJJX1JEX0JCQwkoMSA8PCA2
KQkvKiAxOiBCYWQgQnl0ZSByZWNlaXZlZCAqLworI2RlZmluZSBEQlJJX1JEX0FCVAkoMSA8PCA1
KQkvKiBBYm9ydDogZnJhbWUgYWJvcnRlZCAqLworI2RlZmluZSBEQlJJX1JEX09WUk4JKDEgPDwg
MykJLyogT3ZlcnJ1bjogZGF0YSBsb3N0ICovCisjZGVmaW5lIERCUklfUkRfU1RBVFVTKHYpICAg
ICAgKCh2KSAmIDB4ZmYpCS8qIFJlY2VpdmUgc3RhdHVzICovCisjZGVmaW5lIERCUklfUkRfQ05U
KHYpICgoKHYpID4+IDE2KSAmIDB4MWZmZikJLyogVmFsaWQgYnl0ZXMgaW4gdGhlIGJ1ZmZlciAq
LwogCiAvKiBzdHJlYW1faW5mb1tdIGFjY2VzcyAqLwogLyogVHJhbnNsYXRlIHRoZSBBTFNBIGRp
cmVjdGlvbiBpbnRvIHRoZSBhcnJheSBpbmRleCAqLwogI2RlZmluZSBEQlJJX1NUUkVBTU5PKHN1
YnN0cmVhbSkJCQkJXAotCQkoc3Vic3RyZWFtLT5zdHJlYW0gPT0gCQkJCVwKKwkJKHN1YnN0cmVh
bS0+c3RyZWFtID09CQkJCVwKIAkJIFNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0s/IERCUklfUExB
WTogREJSSV9SRUMpCiAKIC8qIFJldHVybiBhIHBvaW50ZXIgdG8gZGJyaV9zdHJlYW1pbmZvICov
Ci0jZGVmaW5lIERCUklfU1RSRUFNKGRicmksIHN1YnN0cmVhbSkJJmRicmktPnN0cmVhbV9pbmZv
W0RCUklfU1RSRUFNTk8oc3Vic3RyZWFtKV0KKyNkZWZpbmUgREJSSV9TVFJFQU0oZGJyaSwgc3Vi
c3RyZWFtKQlcCisJCSZkYnJpLT5zdHJlYW1faW5mb1tEQlJJX1NUUkVBTU5PKHN1YnN0cmVhbSld
CiAKIHN0YXRpYyBzdHJ1Y3Qgc25kX2RicmkgKmRicmlfbGlzdDsJLyogQWxsIERCUkkgZGV2aWNl
cyAqLwogCkBAIC02MTIsMTggKzYxNCwxOCBAQCBTaW5jZSB0aGUgREJSSSBjYW4gcnVuIGluIHBh
cmFsbGVsIHdpdGggCiBzeW5jaHJvbml6YXRpb24gcHJlc2VudCB0aGVtc2VsdmVzLiBUaGUgbWV0
aG9kIGltcGxlbWVudGVkIGhlcmUgaXMgb25seQogdXNlIG9mIHRoZSBkYnJpX2NtZHdhaXQoKSB0
byB3YWl0IGZvciBleGVjdXRpb24gb2YgYmF0Y2ggb2Ygc2VudCBjb21tYW5kcy4KIAotQSBjaXJj
dWxhciBjb21tYW5kIGJ1ZmZlciBpcyB1c2VkIGhlcmUuIEEgbmV3IGNvbW1hbmQgaXMgYmVpbmcg
YWRkZWQgCitBIGNpcmN1bGFyIGNvbW1hbmQgYnVmZmVyIGlzIHVzZWQgaGVyZS4gQSBuZXcgY29t
bWFuZCBpcyBiZWluZyBhZGRlZAogd2hpbGUgYW5vdGhlciBjYW4gYmUgZXhlY3V0ZWQuIFRoZSBz
Y2hlbWUgd29ya3MgYnkgYWRkaW5nIHR3byBXQUlUIGNvbW1hbmRzCiBhZnRlciBlYWNoIHNlbnQg
YmF0Y2ggb2YgY29tbWFuZHMuIFdoZW4gdGhlIG5leHQgYmF0Y2ggaXMgcHJlcGFyZWQgaXQgaXMK
IGFkZGVkIGFmdGVyIHRoZSBXQUlUIGNvbW1hbmRzIHRoZW4gdGhlIFdBSVRzIGFyZSByZXBsYWNl
ZCB3aXRoIHNpbmdsZSBKVU1QCi1jb21tYW5kIHRvIHRoZSBuZXcgYmF0Y2guIFRoZSB0aGUgREJS
SSBpcyBmb3JjZWQgdG8gcmVyZWFkIHRoZSBsYXN0IFdBSVQgCi1jb21tYW5kIChyZXBsYWNlZCBi
eSB0aGUgSlVNUCBieSB0aGVuKS4gSWYgdGhlIERCUkkgaXMgc3RpbGwgZXhlY3V0aW5nIAorY29t
bWFuZCB0byB0aGUgbmV3IGJhdGNoLiBUaGUgdGhlIERCUkkgaXMgZm9yY2VkIHRvIHJlcmVhZCB0
aGUgbGFzdCBXQUlUCitjb21tYW5kIChyZXBsYWNlZCBieSB0aGUgSlVNUCBieSB0aGVuKS4gSWYg
dGhlIERCUkkgaXMgc3RpbGwgZXhlY3V0aW5nCiBwcmV2aW91cyBjb21tYW5kcyB0aGUgcmVxdWVz
dCB0byByZXJlYWQgdGhlIFdBSVQgY29tbWFuZCBpcyBpZ25vcmVkLgogCiBFdmVyeSB0aW1lIGEg
cm91dGluZSB3YW50cyB0byB3cml0ZSBjb21tYW5kcyB0byB0aGUgREJSSSwgaXQgbXVzdAotZmly
c3QgY2FsbCBkYnJpX2NtZGxvY2soKSBhbmQgZ2V0IHBvaW50ZXIgdG8gYSBmcmVlIHNwYWNlIGlu
IAotZGJyaS0+ZG1hLT5jbWQgYnVmZmVyLiBBZnRlciB0aGlzLCB0aGUgY29tbWFuZHMgY2FuIGJl
IHdyaXR0ZW4gdG8gCi10aGUgYnVmZmVyLCBhbmQgZGJyaV9jbWRzZW5kKCkgaXMgY2FsbGVkIHdp
dGggdGhlIGZpbmFsIHBvaW50ZXIgdmFsdWUgCitmaXJzdCBjYWxsIGRicmlfY21kbG9jaygpIGFu
ZCBnZXQgcG9pbnRlciB0byBhIGZyZWUgc3BhY2UgaW4KK2RicmktPmRtYS0+Y21kIGJ1ZmZlci4g
QWZ0ZXIgdGhpcywgdGhlIGNvbW1hbmRzIGNhbiBiZSB3cml0dGVuIHRvCit0aGUgYnVmZmVyLCBh
bmQgZGJyaV9jbWRzZW5kKCkgaXMgY2FsbGVkIHdpdGggdGhlIGZpbmFsIHBvaW50ZXIgdmFsdWUK
IHRvIHNlbmQgdGhlbSB0byB0aGUgREJSSS4KIAogKi8KQEAgLTY1Nyw3ICs2NTksNyBAQCBzdGF0
aWMgdm9pZCBkYnJpX2NtZHdhaXQoc3RydWN0IHNuZF9kYnJpCiAgKiBMb2NrIHRoZSBjb21tYW5k
IHF1ZXVlIGFuZCByZXR1cm5zIHBvaW50ZXIgdG8gYSBzcGFjZSBmb3IgbGVuIGNtZCB3b3Jkcwog
ICogSXQgbG9ja3MgdGhlIGNtZGxvY2sgc3BpbmxvY2suCiAgKi8KLXN0YXRpYyBzMzIgKmRicmlf
Y21kbG9jayhzdHJ1Y3Qgc25kX2RicmkgKiBkYnJpLCBpbnQgbGVuKQorc3RhdGljIHMzMiAqZGJy
aV9jbWRsb2NrKHN0cnVjdCBzbmRfZGJyaSAqZGJyaSwgaW50IGxlbikKIHsKIAkvKiBTcGFjZSBm
b3IgMiBXQUlUIGNtZHMgKHJlcGxhY2VkIGxhdGVyIGJ5IDEgSlVNUCBjbWQpICovCiAJbGVuICs9
IDI7CkBAIC02ODAsNyArNjgyLDcgQEAgc3RhdGljIHMzMiAqZGJyaV9jbWRsb2NrKHN0cnVjdCBz
bmRfZGJyaQogICoKICAqIExvY2sgbXVzdCBiZSBoZWxkIGJlZm9yZSBjYWxsaW5nIHRoaXMuCiAg
Ki8KLXN0YXRpYyB2b2lkIGRicmlfY21kc2VuZChzdHJ1Y3Qgc25kX2RicmkgKiBkYnJpLCBzMzIg
KiBjbWQsaW50IGxlbikKK3N0YXRpYyB2b2lkIGRicmlfY21kc2VuZChzdHJ1Y3Qgc25kX2Ricmkg
KmRicmksIHMzMiAqY21kLCBpbnQgbGVuKQogewogCXMzMiB0bXAsIGFkZHI7CiAJc3RhdGljIGlu
dCB3YWl0X2lkID0gMDsKQEAgLTcwMCwxNiArNzAyLDE3IEBAIHN0YXRpYyB2b2lkIGRicmlfY21k
c2VuZChzdHJ1Y3Qgc25kX2RicmkKIAkJczMyICpwdHI7CiAKIAkJZm9yIChwdHIgPSBkYnJpLT5j
bWRwdHI7IHB0ciA8IGNtZCsyOyBwdHIrKykKLQkJCWRwcmludGsoRF9DTUQsICJjbWQ6ICVseDol
MDh4XG4iLCAodW5zaWduZWQgbG9uZylwdHIsICpwdHIpOworCQkJZHByaW50ayhEX0NNRCwgImNt
ZDogJWx4OiUwOHhcbiIsCisJCQkJKHVuc2lnbmVkIGxvbmcpcHRyLCAqcHRyKTsKIAl9IGVsc2Ug
ewogCQlzMzIgKnB0ciA9IGRicmktPmNtZHB0cjsKIAogCQlkcHJpbnRrKERfQ01ELCAiY21kOiAl
bHg6JTA4eFxuIiwgKHVuc2lnbmVkIGxvbmcpcHRyLCAqcHRyKTsKIAkJcHRyKys7CiAJCWRwcmlu
dGsoRF9DTUQsICJjbWQ6ICVseDolMDh4XG4iLCAodW5zaWduZWQgbG9uZylwdHIsICpwdHIpOwot
CQlmb3IgKHB0ciA9IGRicmktPmRtYS0+Y21kOyBwdHIgPCBjbWQrMjsgcHRyKyspIHsKLQkJCWRw
cmludGsoRF9DTUQsICJjbWQ6ICVseDolMDh4XG4iLCAodW5zaWduZWQgbG9uZylwdHIsICpwdHIp
OwotCQl9CisJCWZvciAocHRyID0gZGJyaS0+ZG1hLT5jbWQ7IHB0ciA8IGNtZCsyOyBwdHIrKykK
KwkJCWRwcmludGsoRF9DTUQsICJjbWQ6ICVseDolMDh4XG4iLAorCQkJCSh1bnNpZ25lZCBsb25n
KXB0ciwgKnB0cik7CiAJfQogI2VuZGlmCiAKQEAgLTcyMyw3ICs3MjYsNyBAQCBzdGF0aWMgdm9p
ZCBkYnJpX2NtZHNlbmQoc3RydWN0IHNuZF9kYnJpCiB9CiAKIC8qIExvY2sgbXVzdCBiZSBoZWxk
IHdoZW4gY2FsbGluZyB0aGlzICovCi1zdGF0aWMgdm9pZCBkYnJpX3Jlc2V0KHN0cnVjdCBzbmRf
ZGJyaSAqIGRicmkpCitzdGF0aWMgdm9pZCBkYnJpX3Jlc2V0KHN0cnVjdCBzbmRfZGJyaSAqZGJy
aSkKIHsKIAlpbnQgaTsKIAl1MzIgdG1wOwpAQCAtNzQ2LDcgKzc0OSw3IEBAIHN0YXRpYyB2b2lk
IGRicmlfcmVzZXQoc3RydWN0IHNuZF9kYnJpICoKIH0KIAogLyogTG9jayBtdXN0IG5vdCBiZSBo
ZWxkIGJlZm9yZSBjYWxsaW5nIHRoaXMgKi8KLXN0YXRpYyB2b2lkIGRicmlfaW5pdGlhbGl6ZShz
dHJ1Y3Qgc25kX2RicmkgKiBkYnJpKQorc3RhdGljIHZvaWQgZGJyaV9pbml0aWFsaXplKHN0cnVj
dCBzbmRfZGJyaSAqZGJyaSkKIHsKIAlzMzIgKmNtZDsKIAl1MzIgZG1hX2FkZHI7CkBAIC03NjMs
NyArNzY2LDcgQEAgc3RhdGljIHZvaWQgZGJyaV9pbml0aWFsaXplKHN0cnVjdCBzbmRfZAogCiAJ
c3Bpbl9sb2NrX2luaXQoJmRicmktPmNtZGxvY2spOwogCS8qCi0JICogSW5pdGlhbGl6ZSB0aGUg
aW50ZXJydXB0IHJpbmdidWZmZXIuCisJICogSW5pdGlhbGl6ZSB0aGUgaW50ZXJydXB0IHJpbmcg
YnVmZmVyLgogCSAqLwogCWRtYV9hZGRyID0gZGJyaS0+ZG1hX2R2bWEgKyBkYnJpX2RtYV9vZmYo
aW50ciwgMCk7CiAJZGJyaS0+ZG1hLT5pbnRyWzBdID0gZG1hX2FkZHI7CkBAIC04MDEsNyArODA0
LDcgQEAgbGlzdCBvcmRlcmluZywgYW1vbmcgb3RoZXIgdGhpbmdzLiAgVGhlIAogaGVyZSBpbnRl
cmZhY2UgY2xvc2VseSB3aXRoIHRoZSB0cmFuc21pdCBhbmQgcmVjZWl2ZSBpbnRlcnJ1cHQgY29k
ZS4KIAogKi8KLXN0YXRpYyBpbnQgcGlwZV9hY3RpdmUoc3RydWN0IHNuZF9kYnJpICogZGJyaSwg
aW50IHBpcGUpCitzdGF0aWMgaW50IHBpcGVfYWN0aXZlKHN0cnVjdCBzbmRfZGJyaSAqZGJyaSwg
aW50IHBpcGUpCiB7CiAJcmV0dXJuICgocGlwZSA+PSAwKSAmJiAoZGJyaS0+cGlwZXNbcGlwZV0u
ZGVzYyAhPSAtMSkpOwogfQpAQCAtODExLDIwICs4MTQsMjIgQEAgc3RhdGljIGludCBwaXBlX2Fj
dGl2ZShzdHJ1Y3Qgc25kX2RicmkgKgogICogQ2FsbGVkIG9uIGFuIGluLXVzZSBwaXBlIHRvIGNs
ZWFyIGFueXRoaW5nIGJlaW5nIHRyYW5zbWl0dGVkIG9yIHJlY2VpdmVkCiAgKiBMb2NrIG11c3Qg
YmUgaGVsZCBiZWZvcmUgY2FsbGluZyB0aGlzLgogICovCi1zdGF0aWMgdm9pZCByZXNldF9waXBl
KHN0cnVjdCBzbmRfZGJyaSAqIGRicmksIGludCBwaXBlKQorc3RhdGljIHZvaWQgcmVzZXRfcGlw
ZShzdHJ1Y3Qgc25kX2RicmkgKmRicmksIGludCBwaXBlKQogewogCWludCBzZHA7CiAJaW50IGRl
c2M7CiAJczMyICpjbWQ7CiAKIAlpZiAocGlwZSA8IDAgfHwgcGlwZSA+IERCUklfTUFYX1BJUEUp
IHsKLQkJcHJpbnRrKEtFUk5fRVJSICJEQlJJOiByZXNldF9waXBlIGNhbGxlZCB3aXRoIGlsbGVn
YWwgcGlwZSBudW1iZXJcbiIpOworCQlwcmludGsoS0VSTl9FUlIgIkRCUkk6IHJlc2V0X3BpcGUg
Y2FsbGVkIHdpdGggIgorCQkJImlsbGVnYWwgcGlwZSBudW1iZXJcbiIpOwogCQlyZXR1cm47CiAJ
fQogCiAJc2RwID0gZGJyaS0+cGlwZXNbcGlwZV0uc2RwOwogCWlmIChzZHAgPT0gMCkgewotCQlw
cmludGsoS0VSTl9FUlIgIkRCUkk6IHJlc2V0X3BpcGUgY2FsbGVkIG9uIHVuaW5pdGlhbGl6ZWQg
cGlwZVxuIik7CisJCXByaW50ayhLRVJOX0VSUiAiREJSSTogcmVzZXRfcGlwZSBjYWxsZWQgIgor
CQkJIm9uIHVuaW5pdGlhbGl6ZWQgcGlwZVxuIik7CiAJCXJldHVybjsKIAl9CiAKQEAgLTgzNSw5
ICs4NDAsMTAgQEAgc3RhdGljIHZvaWQgcmVzZXRfcGlwZShzdHJ1Y3Qgc25kX2RicmkgKgogCWRi
cmlfY21kc2VuZChkYnJpLCBjbWQsIDMpOwogCiAJZGVzYyA9IGRicmktPnBpcGVzW3BpcGVdLmZp
cnN0X2Rlc2M7Ci0JaWYgKCBkZXNjID49IDApCisJaWYgKGRlc2MgPj0gMCkKIAkJZG8gewotCQkJ
ZGJyaS0+ZG1hLT5kZXNjW2Rlc2NdLm5kYSA9IGRicmktPmRtYS0+ZGVzY1tkZXNjXS5iYSA9IDA7
CisJCQlkYnJpLT5kbWEtPmRlc2NbZGVzY10uYmEgPSAwOworCQkJZGJyaS0+ZG1hLT5kZXNjW2Rl
c2NdLm5kYSA9IDA7CiAJCQlkZXNjID0gZGJyaS0+bmV4dF9kZXNjW2Rlc2NdOwogCQl9IHdoaWxl
IChkZXNjICE9IC0xICYmIGRlc2MgIT0gZGJyaS0+cGlwZXNbcGlwZV0uZmlyc3RfZGVzYyk7CiAK
QEAgLTg0OCwxNSArODU0LDE3IEBAIHN0YXRpYyB2b2lkIHJlc2V0X3BpcGUoc3RydWN0IHNuZF9k
YnJpICoKIC8qCiAgKiBMb2NrIG11c3QgYmUgaGVsZCBiZWZvcmUgY2FsbGluZyB0aGlzLgogICov
Ci1zdGF0aWMgdm9pZCBzZXR1cF9waXBlKHN0cnVjdCBzbmRfZGJyaSAqIGRicmksIGludCBwaXBl
LCBpbnQgc2RwKQorc3RhdGljIHZvaWQgc2V0dXBfcGlwZShzdHJ1Y3Qgc25kX2RicmkgKmRicmks
IGludCBwaXBlLCBpbnQgc2RwKQogewogCWlmIChwaXBlIDwgMCB8fCBwaXBlID4gREJSSV9NQVhf
UElQRSkgewotCQlwcmludGsoS0VSTl9FUlIgIkRCUkk6IHNldHVwX3BpcGUgY2FsbGVkIHdpdGgg
aWxsZWdhbCBwaXBlIG51bWJlclxuIik7CisJCXByaW50ayhLRVJOX0VSUiAiREJSSTogc2V0dXBf
cGlwZSBjYWxsZWQgIgorCQkJIndpdGggaWxsZWdhbCBwaXBlIG51bWJlclxuIik7CiAJCXJldHVy
bjsKIAl9CiAKIAlpZiAoKHNkcCAmIDB4ZjgwMCkgIT0gc2RwKSB7Ci0JCXByaW50ayhLRVJOX0VS
UiAiREJSSTogc2V0dXBfcGlwZSBjYWxsZWQgd2l0aCBzdHJhbmdlIFNEUCB2YWx1ZVxuIik7CisJ
CXByaW50ayhLRVJOX0VSUiAiREJSSTogc2V0dXBfcGlwZSBjYWxsZWQgIgorCQkJIndpdGggc3Ry
YW5nZSBTRFAgdmFsdWVcbiIpOwogCQkvKiBzZHAgJj0gMHhmODAwOyAqLwogCX0KIApAQCAtODc3
LDI1ICs4ODUsMjYgQEAgc3RhdGljIHZvaWQgc2V0dXBfcGlwZShzdHJ1Y3Qgc25kX2RicmkgKgog
LyoKICAqIExvY2sgbXVzdCBiZSBoZWxkIGJlZm9yZSBjYWxsaW5nIHRoaXMuCiAgKi8KLXN0YXRp
YyB2b2lkIGxpbmtfdGltZV9zbG90KHN0cnVjdCBzbmRfZGJyaSAqIGRicmksIGludCBwaXBlLAor
c3RhdGljIHZvaWQgbGlua190aW1lX3Nsb3Qoc3RydWN0IHNuZF9kYnJpICpkYnJpLCBpbnQgcGlw
ZSwKIAkJCSAgIGludCBwcmV2cGlwZSwgaW50IG5leHRwaXBlLAogCQkJICAgaW50IGxlbmd0aCwg
aW50IGN5Y2xlKQogewogCXMzMiAqY21kOwogCWludCB2YWw7CiAKLQlpZiAocGlwZSA8IDAgfHwg
cGlwZSA+IERCUklfTUFYX1BJUEUgCisJaWYgKHBpcGUgPCAwIHx8IHBpcGUgPiBEQlJJX01BWF9Q
SVBFCiAJCQl8fCBwcmV2cGlwZSA8IDAgfHwgcHJldnBpcGUgPiBEQlJJX01BWF9QSVBFCiAJCQl8
fCBuZXh0cGlwZSA8IDAgfHwgbmV4dHBpcGUgPiBEQlJJX01BWF9QSVBFKSB7Ci0JCXByaW50ayhL
RVJOX0VSUiAKKwkJcHJpbnRrKEtFUk5fRVJSCiAJCSAgICAiREJSSTogbGlua190aW1lX3Nsb3Qg
Y2FsbGVkIHdpdGggaWxsZWdhbCBwaXBlIG51bWJlclxuIik7CiAJCXJldHVybjsKIAl9CiAKLQlp
ZiAoZGJyaS0+cGlwZXNbcGlwZV0uc2RwID09IDAgCisJaWYgKGRicmktPnBpcGVzW3BpcGVdLnNk
cCA9PSAwCiAJCQl8fCBkYnJpLT5waXBlc1twcmV2cGlwZV0uc2RwID09IDAKIAkJCXx8IGRicmkt
PnBpcGVzW25leHRwaXBlXS5zZHAgPT0gMCkgewotCQlwcmludGsoS0VSTl9FUlIgIkRCUkk6IGxp
bmtfdGltZV9zbG90IGNhbGxlZCBvbiB1bmluaXRpYWxpemVkIHBpcGVcbiIpOworCQlwcmludGso
S0VSTl9FUlIgIkRCUkk6IGxpbmtfdGltZV9zbG90IGNhbGxlZCAiCisJCQkib24gdW5pbml0aWFs
aXplZCBwaXBlXG4iKTsKIAkJcmV0dXJuOwogCX0KIApAQCAtOTM1LDE3ICs5NDQsMTcgQEAgc3Rh
dGljIHZvaWQgbGlua190aW1lX3Nsb3Qoc3RydWN0IHNuZF9kYgogLyoKICAqIExvY2sgbXVzdCBi
ZSBoZWxkIGJlZm9yZSBjYWxsaW5nIHRoaXMuCiAgKi8KLXN0YXRpYyB2b2lkIHVubGlua190aW1l
X3Nsb3Qoc3RydWN0IHNuZF9kYnJpICogZGJyaSwgaW50IHBpcGUsCitzdGF0aWMgdm9pZCB1bmxp
bmtfdGltZV9zbG90KHN0cnVjdCBzbmRfZGJyaSAqZGJyaSwgaW50IHBpcGUsCiAJCQkgICAgIGVu
dW0gaW5fb3Jfb3V0IGRpcmVjdGlvbiwgaW50IHByZXZwaXBlLAogCQkJICAgICBpbnQgbmV4dHBp
cGUpCiB7CiAJczMyICpjbWQ7CiAJaW50IHZhbDsKIAotCWlmIChwaXBlIDwgMCB8fCBwaXBlID4g
REJSSV9NQVhfUElQRSAKKwlpZiAocGlwZSA8IDAgfHwgcGlwZSA+IERCUklfTUFYX1BJUEUKIAkJ
CXx8IHByZXZwaXBlIDwgMCB8fCBwcmV2cGlwZSA+IERCUklfTUFYX1BJUEUKIAkJCXx8IG5leHRw
aXBlIDwgMCB8fCBuZXh0cGlwZSA+IERCUklfTUFYX1BJUEUpIHsKLQkJcHJpbnRrKEtFUk5fRVJS
IAorCQlwcmludGsoS0VSTl9FUlIKIAkJICAgICJEQlJJOiB1bmxpbmtfdGltZV9zbG90IGNhbGxl
ZCB3aXRoIGlsbGVnYWwgcGlwZSBudW1iZXJcbiIpOwogCQlyZXR1cm47CiAJfQpAQCAtOTg1LDcg
Kzk5NCw3IEBAIHN0YXRpYyB2b2lkIHVubGlua190aW1lX3Nsb3Qoc3RydWN0IHNuZF8KICAqCiAg
KiBMb2NrIG11c3Qgbm90IGJlIGhlbGQgYmVmb3JlIGNhbGxpbmcgaXQuCiAgKi8KLXN0YXRpYyB2
b2lkIHhtaXRfZml4ZWQoc3RydWN0IHNuZF9kYnJpICogZGJyaSwgaW50IHBpcGUsIHVuc2lnbmVk
IGludCBkYXRhKQorc3RhdGljIHZvaWQgeG1pdF9maXhlZChzdHJ1Y3Qgc25kX2RicmkgKmRicmks
IGludCBwaXBlLCB1bnNpZ25lZCBpbnQgZGF0YSkKIHsKIAlzMzIgKmNtZDsKIAl1bnNpZ25lZCBs
b25nIGZsYWdzOwpAQCAtOTk2LDcgKzEwMDUsOCBAQCBzdGF0aWMgdm9pZCB4bWl0X2ZpeGVkKHN0
cnVjdCBzbmRfZGJyaSAqCiAJfQogCiAJaWYgKERfU0RQX01PREUoZGJyaS0+cGlwZXNbcGlwZV0u
c2RwKSA9PSAwKSB7Ci0JCXByaW50ayhLRVJOX0VSUiAiREJSSTogeG1pdF9maXhlZDogVW5pbml0
aWFsaXplZCBwaXBlICVkXG4iLCBwaXBlKTsKKwkJcHJpbnRrKEtFUk5fRVJSICJEQlJJOiB4bWl0
X2ZpeGVkOiAiCisJCQkiVW5pbml0aWFsaXplZCBwaXBlICVkXG4iLCBwaXBlKTsKIAkJcmV0dXJu
OwogCX0KIApAQCAtMTAwNiw3ICsxMDE2LDggQEAgc3RhdGljIHZvaWQgeG1pdF9maXhlZChzdHJ1
Y3Qgc25kX2RicmkgKgogCX0KIAogCWlmICghKGRicmktPnBpcGVzW3BpcGVdLnNkcCAmIERfU0RQ
X1RPX1NFUikpIHsKLQkJcHJpbnRrKEtFUk5fRVJSICJEQlJJOiB4bWl0X2ZpeGVkOiBDYWxsZWQg
b24gcmVjZWl2ZSBwaXBlICVkXG4iLCBwaXBlKTsKKwkJcHJpbnRrKEtFUk5fRVJSICJEQlJJOiB4
bWl0X2ZpeGVkOiBDYWxsZWQgb24gcmVjZWl2ZSBwaXBlICVkXG4iLAorCQkJcGlwZSk7CiAJCXJl
dHVybjsKIAl9CiAKQEAgLTEwMjgsMjAgKzEwMzksMjMgQEAgc3RhdGljIHZvaWQgeG1pdF9maXhl
ZChzdHJ1Y3Qgc25kX2RicmkgKgogCiB9CiAKLXN0YXRpYyB2b2lkIHJlY3ZfZml4ZWQoc3RydWN0
IHNuZF9kYnJpICogZGJyaSwgaW50IHBpcGUsIHZvbGF0aWxlIF9fdTMyICogcHRyKQorc3RhdGlj
IHZvaWQgcmVjdl9maXhlZChzdHJ1Y3Qgc25kX2RicmkgKmRicmksIGludCBwaXBlLCB2b2xhdGls
ZSBfX3UzMiAqcHRyKQogewogCWlmIChwaXBlIDwgMTYgfHwgcGlwZSA+IERCUklfTUFYX1BJUEUp
IHsKLQkJcHJpbnRrKEtFUk5fRVJSICJEQlJJOiByZWN2X2ZpeGVkIGNhbGxlZCB3aXRoIGlsbGVn
YWwgcGlwZSBudW1iZXJcbiIpOworCQlwcmludGsoS0VSTl9FUlIgIkRCUkk6IHJlY3ZfZml4ZWQg
Y2FsbGVkIHdpdGggIgorCQkJImlsbGVnYWwgcGlwZSBudW1iZXJcbiIpOwogCQlyZXR1cm47CiAJ
fQogCiAJaWYgKERfU0RQX01PREUoZGJyaS0+cGlwZXNbcGlwZV0uc2RwKSAhPSBEX1NEUF9GSVhF
RCkgewotCQlwcmludGsoS0VSTl9FUlIgIkRCUkk6IHJlY3ZfZml4ZWQgY2FsbGVkIG9uIG5vbi1m
aXhlZCBwaXBlICVkXG4iLCBwaXBlKTsKKwkJcHJpbnRrKEtFUk5fRVJSICJEQlJJOiByZWN2X2Zp
eGVkIGNhbGxlZCBvbiAiCisJCQkibm9uLWZpeGVkIHBpcGUgJWRcbiIsIHBpcGUpOwogCQlyZXR1
cm47CiAJfQogCiAJaWYgKGRicmktPnBpcGVzW3BpcGVdLnNkcCAmIERfU0RQX1RPX1NFUikgewot
CQlwcmludGsoS0VSTl9FUlIgIkRCUkk6IHJlY3ZfZml4ZWQgY2FsbGVkIG9uIHRyYW5zbWl0IHBp
cGUgJWRcbiIsIHBpcGUpOworCQlwcmludGsoS0VSTl9FUlIgIkRCUkk6IHJlY3ZfZml4ZWQgY2Fs
bGVkIG9uICIKKwkJCSJ0cmFuc21pdCBwaXBlICVkXG4iLCBwaXBlKTsKIAkJcmV0dXJuOwogCX0K
IApAQCAtMTA2NCw3ICsxMDc4LDcgQEAgc3RhdGljIHZvaWQgcmVjdl9maXhlZChzdHJ1Y3Qgc25k
X2RicmkgKgogICoKICAqIExvY2sgbXVzdCBiZSBoZWxkIGJlZm9yZSBjYWxsaW5nIHRoaXMuCiAg
Ki8KLXN0YXRpYyBpbnQgc2V0dXBfZGVzY3Moc3RydWN0IHNuZF9kYnJpICogZGJyaSwgaW50IHN0
cmVhbW5vLCB1bnNpZ25lZCBpbnQgcGVyaW9kKQorc3RhdGljIGludCBzZXR1cF9kZXNjcyhzdHJ1
Y3Qgc25kX2RicmkgKmRicmksIGludCBzdHJlYW1ubywgdW5zaWduZWQgaW50IHBlcmlvZCkKIHsK
IAlzdHJ1Y3QgZGJyaV9zdHJlYW1pbmZvICppbmZvID0gJmRicmktPnN0cmVhbV9pbmZvW3N0cmVh
bW5vXTsKIAlfX3UzMiBkdm1hX2J1ZmZlcjsKQEAgLTEwODksMjEgKzExMDMsMjMgQEAgc3RhdGlj
IGludCBzZXR1cF9kZXNjcyhzdHJ1Y3Qgc25kX2RicmkgKgogCiAJaWYgKHN0cmVhbW5vID09IERC
UklfUExBWSkgewogCQlpZiAoIShkYnJpLT5waXBlc1tpbmZvLT5waXBlXS5zZHAgJiBEX1NEUF9U
T19TRVIpKSB7Ci0JCQlwcmludGsoS0VSTl9FUlIgIkRCUkk6IHNldHVwX2Rlc2NzOiBDYWxsZWQg
b24gcmVjZWl2ZSBwaXBlICVkXG4iLAotCQkJICAgICAgIGluZm8tPnBpcGUpOworCQkJcHJpbnRr
KEtFUk5fRVJSICJEQlJJOiBzZXR1cF9kZXNjczogIgorCQkJCSJDYWxsZWQgb24gcmVjZWl2ZSBw
aXBlICVkXG4iLCBpbmZvLT5waXBlKTsKIAkJCXJldHVybiAtMjsKIAkJfQogCX0gZWxzZSB7CiAJ
CWlmIChkYnJpLT5waXBlc1tpbmZvLT5waXBlXS5zZHAgJiBEX1NEUF9UT19TRVIpIHsKLQkJCXBy
aW50ayhLRVJOX0VSUiAKKwkJCXByaW50ayhLRVJOX0VSUgogCQkJICAgICJEQlJJOiBzZXR1cF9k
ZXNjczogQ2FsbGVkIG9uIHRyYW5zbWl0IHBpcGUgJWRcbiIsCiAJCQkgICAgIGluZm8tPnBpcGUp
OwogCQkJcmV0dXJuIC0yOwogCQl9Ci0JCS8qIFNob3VsZCBiZSBhYmxlIHRvIHF1ZXVlIG11bHRp
cGxlIGJ1ZmZlcnMgdG8gcmVjZWl2ZSBvbiBhIHBpcGUgKi8KKwkJLyogU2hvdWxkIGJlIGFibGUg
dG8gcXVldWUgbXVsdGlwbGUgYnVmZmVycworCQkgKiB0byByZWNlaXZlIG9uIGEgcGlwZQorCQkg
Ki8KIAkJaWYgKHBpcGVfYWN0aXZlKGRicmksIGluZm8tPnBpcGUpKSB7Ci0JCQlwcmludGsoS0VS
Tl9FUlIgIkRCUkk6IHJlY3Zfb25fcGlwZTogQ2FsbGVkIG9uIGFjdGl2ZSBwaXBlICVkXG4iLAot
CQkJICAgICAgIGluZm8tPnBpcGUpOworCQkJcHJpbnRrKEtFUk5fRVJSICJEQlJJOiByZWN2X29u
X3BpcGU6ICIKKwkJCQkiQ2FsbGVkIG9uIGFjdGl2ZSBwaXBlICVkXG4iLCBpbmZvLT5waXBlKTsK
IAkJCXJldHVybiAtMjsKIAkJfQogCkBAIC0xMTEzLDExICsxMTI5LDEzIEBAIHN0YXRpYyBpbnQg
c2V0dXBfZGVzY3Moc3RydWN0IHNuZF9kYnJpICoKIAogCS8qIEZyZWUgZGVzY3JpcHRvcnMgaWYg
cGlwZSBoYXMgYW55ICovCiAJZGVzYyA9IGRicmktPnBpcGVzW2luZm8tPnBpcGVdLmZpcnN0X2Rl
c2M7Ci0JaWYgKCBkZXNjID49IDApCisJaWYgKGRlc2MgPj0gMCkKIAkJZG8gewotCQkJZGJyaS0+
ZG1hLT5kZXNjW2Rlc2NdLm5kYSA9IGRicmktPmRtYS0+ZGVzY1tkZXNjXS5iYSA9IDA7CisJCQlk
YnJpLT5kbWEtPmRlc2NbZGVzY10uYmEgPSAwOworCQkJZGJyaS0+ZG1hLT5kZXNjW2Rlc2NdLm5k
YSA9IDA7CiAJCQlkZXNjID0gZGJyaS0+bmV4dF9kZXNjW2Rlc2NdOwotCQl9IHdoaWxlIChkZXNj
ICE9IC0xICYmIGRlc2MgIT0gZGJyaS0+cGlwZXNbaW5mby0+cGlwZV0uZmlyc3RfZGVzYyk7CisJ
CX0gd2hpbGUgKGRlc2MgIT0gLTEgJiYKKwkJCSBkZXNjICE9IGRicmktPnBpcGVzW2luZm8tPnBp
cGVdLmZpcnN0X2Rlc2MpOwogCiAJZGJyaS0+cGlwZXNbaW5mby0+cGlwZV0uZGVzYyA9IC0xOwog
CWRicmktPnBpcGVzW2luZm8tPnBpcGVdLmZpcnN0X2Rlc2MgPSAtMTsKQEAgLTExNTAsOCArMTE2
OCw3IEBAIHN0YXRpYyBpbnQgc2V0dXBfZGVzY3Moc3RydWN0IHNuZF9kYnJpICoKIAkJaWYgKHN0
cmVhbW5vID09IERCUklfUExBWSkgewogCQkJZGJyaS0+ZG1hLT5kZXNjW2Rlc2NdLndvcmQxID0g
REJSSV9URF9DTlQobXlsZW4pOwogCQkJZGJyaS0+ZG1hLT5kZXNjW2Rlc2NdLndvcmQ0ID0gMDsK
LQkJCWRicmktPmRtYS0+ZGVzY1tkZXNjXS53b3JkMSB8PSAKLQkJCSAgICBEQlJJX1REX0YgfCBE
QlJJX1REX0I7CisJCQlkYnJpLT5kbWEtPmRlc2NbZGVzY10ud29yZDEgfD0gREJSSV9URF9GIHwg
REJSSV9URF9COwogCQl9IGVsc2UgewogCQkJZGJyaS0+ZG1hLT5kZXNjW2Rlc2NdLndvcmQxID0g
MDsKIAkJCWRicmktPmRtYS0+ZGVzY1tkZXNjXS53b3JkNCA9CkBAIC0xMTcyLDcgKzExODksOCBA
QCBzdGF0aWMgaW50IHNldHVwX2Rlc2NzKHN0cnVjdCBzbmRfZGJyaSAqCiAJfQogCiAJaWYgKGZp
cnN0X2Rlc2MgPT0gLTEgfHwgbGFzdF9kZXNjID09IC0xKSB7Ci0JCXByaW50ayhLRVJOX0VSUiAi
REJSSTogc2V0dXBfZGVzY3M6IE5vdCBlbm91Z2ggZGVzY3JpcHRvcnMgYXZhaWxhYmxlXG4iKTsK
KwkJcHJpbnRrKEtFUk5fRVJSICJEQlJJOiBzZXR1cF9kZXNjczogIgorCQkJIiBOb3QgZW5vdWdo
IGRlc2NyaXB0b3JzIGF2YWlsYWJsZVxuIik7CiAJCXJldHVybiAtMTsKIAl9CiAKQEAgLTExODMs
MTQgKzEyMDEsMTQgQEAgc3RhdGljIGludCBzZXR1cF9kZXNjcyhzdHJ1Y3Qgc25kX2RicmkgKgog
CWRicmktPnBpcGVzW2luZm8tPnBpcGVdLmRlc2MgPSBmaXJzdF9kZXNjOwogCiAjaWZkZWYgREJS
SV9ERUJVRwotCWZvciAoZGVzYyA9IGZpcnN0X2Rlc2M7IGRlc2MgIT0gLTE7ICkgeworCWZvciAo
ZGVzYyA9IGZpcnN0X2Rlc2M7IGRlc2MgIT0gLTE7KSB7CiAJCWRwcmludGsoRF9ERVNDLCAiREVT
QyAlZDogJTA4eCAlMDh4ICUwOHggJTA4eFxuIiwKIAkJCWRlc2MsCiAJCQlkYnJpLT5kbWEtPmRl
c2NbZGVzY10ud29yZDEsCiAJCQlkYnJpLT5kbWEtPmRlc2NbZGVzY10uYmEsCiAJCQlkYnJpLT5k
bWEtPmRlc2NbZGVzY10ubmRhLCBkYnJpLT5kbWEtPmRlc2NbZGVzY10ud29yZDQpOwogCQkJZGVz
YyA9IGRicmktPm5leHRfZGVzY1tkZXNjXTsKLQkJCWlmICggZGVzYyA9PSBmaXJzdF9kZXNjICkK
KwkJCWlmIChkZXNjID09IGZpcnN0X2Rlc2MpCiAJCQkJYnJlYWs7CiAJfQogI2VuZGlmCkBAIC0x
MjEzLDcgKzEyMzEsOCBAQCBlbnVtIG1hc3Rlcl9vcl9zbGF2ZSB7IENISW1hc3RlciwgQ0hJc2xh
CiAvKgogICogTG9jayBtdXN0IG5vdCBiZSBoZWxkIGJlZm9yZSBjYWxsaW5nIGl0LgogICovCi1z
dGF0aWMgdm9pZCByZXNldF9jaGkoc3RydWN0IHNuZF9kYnJpICogZGJyaSwgZW51bSBtYXN0ZXJf
b3Jfc2xhdmUgbWFzdGVyX29yX3NsYXZlLAorc3RhdGljIHZvaWQgcmVzZXRfY2hpKHN0cnVjdCBz
bmRfZGJyaSAqZGJyaSwKKwkJICAgICAgZW51bSBtYXN0ZXJfb3Jfc2xhdmUgbWFzdGVyX29yX3Ns
YXZlLAogCQkgICAgICBpbnQgYml0c19wZXJfZnJhbWUpCiB7CiAJczMyICpjbWQ7CkBAIC0xMjIy
LDcgKzEyNDEsNyBAQCBzdGF0aWMgdm9pZCByZXNldF9jaGkoc3RydWN0IHNuZF9kYnJpICogCiAJ
LyogU2V0IENISSBBbmNob3I6IFBpcGUgMTYgKi8KIAogCWNtZCA9IGRicmlfY21kbG9jayhkYnJp
LCA0KTsKLQl2YWwgPSBEX0RUU19WTyB8IERfRFRTX1ZJIHwgRF9EVFNfSU5TIAorCXZhbCA9IERf
RFRTX1ZPIHwgRF9EVFNfVkkgfCBEX0RUU19JTlMKIAkJfCBEX0RUU19QUlZJTigxNikgfCBEX1BJ
UEUoMTYpIHwgRF9EVFNfUFJWT1VUKDE2KTsKIAkqKGNtZCsrKSA9IERCUklfQ01EKERfRFRTLCAw
LCB2YWwpOwogCSooY21kKyspID0gRF9UU19BTkNIT1IgfCBEX1RTX05FWFQoMTYpOwpAQCAtMTI0
NiwxNSArMTI2NSwxNiBAQCBzdGF0aWMgdm9pZCByZXNldF9jaGkoc3RydWN0IHNuZF9kYnJpICog
CiAJfSBlbHNlIHsKIAkJLyogU2V0dXAgREJSSSBmb3IgQ0hJIE1hc3RlciAtIGdlbmVyYXRlIGNs
b2NrLCBGUwogCQkgKgotCQkgKiBCUEYgICAgICAgICAgICAgICAgICAgICAgICAgID0gIGJpdHMg
cGVyIDgga0h6IGZyYW1lCi0JCSAqIDEyLjI4OCBNSHogLyBDSElDTV9kaXZpc29yICAgPSBjbG9j
ayByYXRlCi0JCSAqIEZEICA9ICAxIC0gZHJpdmUgQ0hJRlMgb24gcmlzaW5nIGVkZ2Ugb2YgQ0hJ
Q0sKKwkJICogQlBGCQkJCT0gIGJpdHMgcGVyIDgga0h6IGZyYW1lCisJCSAqIDEyLjI4OCBNSHog
LyBDSElDTV9kaXZpc29yCT0gY2xvY2sgcmF0ZQorCQkgKiBGRCA9IDEgLSBkcml2ZSBDSElGUyBv
biByaXNpbmcgZWRnZSBvZiBDSElDSwogCQkgKi8KIAkJaW50IGNsb2NrcmF0ZSA9IGJpdHNfcGVy
X2ZyYW1lICogODsKIAkJaW50IGRpdmlzb3IgPSAxMjI4OCAvIGNsb2NrcmF0ZTsKIAogCQlpZiAo
ZGl2aXNvciA+IDI1NSB8fCBkaXZpc29yICogY2xvY2tyYXRlICE9IDEyMjg4KQotCQkJcHJpbnRr
KEtFUk5fRVJSICJEQlJJOiBpbGxlZ2FsIGJpdHNfcGVyX2ZyYW1lIGluIHNldHVwX2NoaVxuIik7
CisJCQlwcmludGsoS0VSTl9FUlIgIkRCUkk6IGlsbGVnYWwgYml0c19wZXJfZnJhbWUgIgorCQkJ
CSJpbiBzZXR1cF9jaGlcbiIpOwogCiAJCSooY21kKyspID0gREJSSV9DTUQoRF9DSEksIDAsIERf
Q0hJX0NISUNNKGRpdmlzb3IpIHwgRF9DSElfRkQKIAkJCQkgICAgfCBEX0NISV9CUEYoYml0c19w
ZXJfZnJhbWUpKTsKQEAgLTEyODgsNyArMTMwOCw3IEBAIHRvIHRoZSBEQlJJIHZpYSB0aGUgQ0hJ
IGludGVyZmFjZSBhbmQgZmUKICAqIExvY2sgbXVzdCBub3QgYmUgaGVsZCBiZWZvcmUgY2FsbGlu
ZyBpdC4KIAogKi8KLXN0YXRpYyB2b2lkIGNzNDIxNV9zZXR1cF9waXBlcyhzdHJ1Y3Qgc25kX2Ri
cmkgKiBkYnJpKQorc3RhdGljIHZvaWQgY3M0MjE1X3NldHVwX3BpcGVzKHN0cnVjdCBzbmRfZGJy
aSAqZGJyaSkKIHsKIAl1bnNpZ25lZCBsb25nIGZsYWdzOwogCkBAIC0xMzAzLDkgKzEzMjMsOSBA
QCBzdGF0aWMgdm9pZCBjczQyMTVfc2V0dXBfcGlwZXMoc3RydWN0IHNuCiAJICogICAgICAgICAg
bm90IHJlbGV2YW50IGZvciB1cyAob25seSBmb3IgZG91YmxlY2hlY2tpbmcpLgogCSAqCiAJICog
Q29udHJvbCBtb2RlOgotCSAqIFBpcGUgMTc6IFNlbmQgdGltZXNsb3RzIDEtNCAoc2xvdHMgNS04
IGFyZSByZWFkb25seSkKKwkgKiBQaXBlIDE3OiBTZW5kIHRpbWVzbG90cyAxLTQgKHNsb3RzIDUt
OCBhcmUgcmVhZCBvbmx5KQogCSAqIFBpcGUgMTg6IFJlY2VpdmUgdGltZXNsb3QgMSAoY2xiKS4K
LQkgKiBQaXBlIDE5OiBSZWNlaXZlIHRpbWVzbG90IDcgKHZlcnNpb24pLiAKKwkgKiBQaXBlIDE5
OiBSZWNlaXZlIHRpbWVzbG90IDcgKHZlcnNpb24pLgogCSAqLwogCiAJc2V0dXBfcGlwZShkYnJp
LCA0LCBEX1NEUF9NRU0gfCBEX1NEUF9UT19TRVIgfCBEX1NEUF9NU0IpOwpAQCAtMTM1NSw3ICsx
Mzc1LDcgQEAgc3RhdGljIGludCBjczQyMTVfaW5pdF9kYXRhKHN0cnVjdCBjczQyMQogCXJldHVy
biAwOwogfQogCi1zdGF0aWMgdm9pZCBjczQyMTVfc2V0ZGF0YShzdHJ1Y3Qgc25kX2RicmkgKiBk
YnJpLCBpbnQgbXV0ZWQpCitzdGF0aWMgdm9pZCBjczQyMTVfc2V0ZGF0YShzdHJ1Y3Qgc25kX2Ri
cmkgKmRicmksIGludCBtdXRlZCkKIHsKIAlpZiAobXV0ZWQpIHsKIAkJZGJyaS0+bW0uZGF0YVsw
XSB8PSA2MzsKQEAgLTEzODcsNyArMTQwNyw3IEBAIHN0YXRpYyB2b2lkIGNzNDIxNV9zZXRkYXRh
KHN0cnVjdCBzbmRfZGIKIC8qCiAgKiBTZXQgdGhlIENTNDIxNSB0byBkYXRhIG1vZGUuCiAgKi8K
LXN0YXRpYyB2b2lkIGNzNDIxNV9vcGVuKHN0cnVjdCBzbmRfZGJyaSAqIGRicmkpCitzdGF0aWMg
dm9pZCBjczQyMTVfb3BlbihzdHJ1Y3Qgc25kX2RicmkgKmRicmkpCiB7CiAJaW50IGRhdGFfd2lk
dGg7CiAJdTMyIHRtcDsKQEAgLTE0NTIsNyArMTQ3Miw3IEBAIHN0YXRpYyB2b2lkIGNzNDIxNV9v
cGVuKHN0cnVjdCBzbmRfZGJyaSAKIC8qCiAgKiBTZW5kIHRoZSBjb250cm9sIGluZm9ybWF0aW9u
IChpLmUuIGF1ZGlvIGZvcm1hdCkKICAqLwotc3RhdGljIGludCBjczQyMTVfc2V0Y3RybChzdHJ1
Y3Qgc25kX2RicmkgKiBkYnJpKQorc3RhdGljIGludCBjczQyMTVfc2V0Y3RybChzdHJ1Y3Qgc25k
X2RicmkgKmRicmkpCiB7CiAJaW50IGksIHZhbDsKIAl1MzIgdG1wOwpAQCAtMTUwMiw5ICsxNTIy
LDkgQEAgc3RhdGljIGludCBjczQyMTVfc2V0Y3RybChzdHJ1Y3Qgc25kX2RicgogCiAJLyoKIAkg
KiBDb250cm9sIG1vZGU6Ci0JICogUGlwZSAxNzogU2VuZCB0aW1lc2xvdHMgMS00IChzbG90cyA1
LTggYXJlIHJlYWRvbmx5KQorCSAqIFBpcGUgMTc6IFNlbmQgdGltZXNsb3RzIDEtNCAoc2xvdHMg
NS04IGFyZSByZWFkIG9ubHkpCiAJICogUGlwZSAxODogUmVjZWl2ZSB0aW1lc2xvdCAxIChjbGIp
LgotCSAqIFBpcGUgMTk6IFJlY2VpdmUgdGltZXNsb3QgNyAodmVyc2lvbikuIAorCSAqIFBpcGUg
MTk6IFJlY2VpdmUgdGltZXNsb3QgNyAodmVyc2lvbikuCiAJICovCiAKIAlsaW5rX3RpbWVfc2xv
dChkYnJpLCAxNywgMTYsIDE2LCAzMiwgZGJyaS0+bW0ub2Zmc2V0KTsKQEAgLTE1MjIsOSArMTU0
Miw5IEBAIHN0YXRpYyBpbnQgY3M0MjE1X3NldGN0cmwoc3RydWN0IHNuZF9kYnIKIAlzYnVzX3dy
aXRlbCh0bXAsIGRicmktPnJlZ3MgKyBSRUcwKTsKIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZk
YnJpLT5sb2NrLCBmbGFncyk7CiAKLQlmb3IgKGkgPSAxMDsgKChkYnJpLT5tbS5zdGF0dXMgJiAw
eGU0KSAhPSAweDIwKTsgLS1pKSB7CisJZm9yIChpID0gMTA7ICgoZGJyaS0+bW0uc3RhdHVzICYg
MHhlNCkgIT0gMHgyMCk7IC0taSkKIAkJbXNsZWVwX2ludGVycnVwdGlibGUoMSk7Ci0JfQorCiAJ
aWYgKGkgPT0gMCkgewogCQlkcHJpbnRrKERfTU0sICJDUzQyMTUgZGlkbid0IHJlc3BvbmQgdG8g
Q0xCICgweCUwMngpXG4iLAogCQkJZGJyaS0+bW0uc3RhdHVzKTsKQEAgLTE1NTYsNyArMTU3Niw3
IEBAIHN0YXRpYyBpbnQgY3M0MjE1X3NldGN0cmwoc3RydWN0IHNuZF9kYnIKICAqIEFzIHBhcnQg
b2YgdGhlIHByb2Nlc3Mgd2UgcmVzZW5kIHRoZSBzZXR0aW5ncyBmb3IgdGhlIGRhdGEKICAqIHRp
bWVzbG90cyBhcyB3ZWxsLgogICovCi1zdGF0aWMgaW50IGNzNDIxNV9wcmVwYXJlKHN0cnVjdCBz
bmRfZGJyaSAqIGRicmksIHVuc2lnbmVkIGludCByYXRlLAorc3RhdGljIGludCBjczQyMTVfcHJl
cGFyZShzdHJ1Y3Qgc25kX2RicmkgKmRicmksIHVuc2lnbmVkIGludCByYXRlLAogCQkJICBzbmRf
cGNtX2Zvcm1hdF90IGZvcm1hdCwgdW5zaWduZWQgaW50IGNoYW5uZWxzKQogewogCWludCBmcmVx
X2lkeDsKQEAgLTE2MTMsNyArMTYzMyw3IEBAIHN0YXRpYyBpbnQgY3M0MjE1X3ByZXBhcmUoc3Ry
dWN0IHNuZF9kYnIKIC8qCiAgKgogICovCi1zdGF0aWMgaW50IGNzNDIxNV9pbml0KHN0cnVjdCBz
bmRfZGJyaSAqIGRicmkpCitzdGF0aWMgaW50IGNzNDIxNV9pbml0KHN0cnVjdCBzbmRfZGJyaSAq
ZGJyaSkKIHsKIAl1MzIgcmVnMiA9IHNidXNfcmVhZGwoZGJyaS0+cmVncyArIFJFRzIpOwogCWRw
cmludGsoRF9NTSwgImNzNDIxNV9pbml0OiByZWcyPTB4JXhcbiIsIHJlZzIpOwpAQCAtMTY3NCw3
ICsxNjk0LDcgQEAgaW50ZXJydXB0cyBhcmUgZGlzYWJsZWQuCiAKIC8qIHhtaXRfZGVzY3MoKQog
ICoKLSAqIFN0YXJ0cyB0cmFuc21pdGluZyB0aGUgY3VycmVudCBURCdzIGZvciByZWNvcmRpbmcv
cGxheWluZy4KKyAqIFN0YXJ0cyB0cmFuc21pdHRpbmcgdGhlIGN1cnJlbnQgVEQncyBmb3IgcmVj
b3JkaW5nL3BsYXlpbmcuCiAgKiBGb3IgcGxheWJhY2ssIEFMU0EgaGFzIGZpbGxlZCB0aGUgRE1B
IG1lbW9yeSB3aXRoIG5ldyBkYXRhICh3ZSBob3BlKS4KICAqLwogc3RhdGljIHZvaWQgeG1pdF9k
ZXNjcyhzdHJ1Y3Qgc25kX2RicmkgKmRicmkpCkBAIC0xNzAxLDcgKzE3MjEsOCBAQCBzdGF0aWMg
dm9pZCB4bWl0X2Rlc2NzKHN0cnVjdCBzbmRfZGJyaSAqCiAJCQkqKGNtZCsrKSA9IERCUklfQ01E
KERfU0RQLCAwLAogCQkJCQkgICAgZGJyaS0+cGlwZXNbaW5mby0+cGlwZV0uc2RwCiAJCQkJCSAg
ICB8IERfU0RQX1AgfCBEX1NEUF9FVkVSWSB8IERfU0RQX0MpOwotCQkJKihjbWQrKykgPSBkYnJp
LT5kbWFfZHZtYSArIGRicmlfZG1hX29mZihkZXNjLCBmaXJzdF90ZCk7CisJCQkqKGNtZCsrKSA9
IGRicmktPmRtYV9kdm1hICsKKwkJCQkgICBkYnJpX2RtYV9vZmYoZGVzYywgZmlyc3RfdGQpOwog
CQkJZGJyaV9jbWRzZW5kKGRicmksIGNtZCwgMik7CiAKIAkJCS8qIFJlc2V0IG91ciBhZG1pbiBv
ZiB0aGUgcGlwZS4gKi8KQEAgLTE3MjIsNyArMTc0Myw4IEBAIHN0YXRpYyB2b2lkIHhtaXRfZGVz
Y3Moc3RydWN0IHNuZF9kYnJpICoKIAkJCSooY21kKyspID0gREJSSV9DTUQoRF9TRFAsIDAsCiAJ
CQkJCSAgICBkYnJpLT5waXBlc1tpbmZvLT5waXBlXS5zZHAKIAkJCQkJICAgIHwgRF9TRFBfUCB8
IERfU0RQX0VWRVJZIHwgRF9TRFBfQyk7Ci0JCQkqKGNtZCsrKSA9IGRicmktPmRtYV9kdm1hICsg
ZGJyaV9kbWFfb2ZmKGRlc2MsIGZpcnN0X3RkKTsKKwkJCSooY21kKyspID0gZGJyaS0+ZG1hX2R2
bWEgKworCQkJCSAgIGRicmlfZG1hX29mZihkZXNjLCBmaXJzdF90ZCk7CiAJCQlkYnJpX2NtZHNl
bmQoZGJyaSwgY21kLCAyKTsKIAogCQkJLyogUmVzZXQgb3VyIGFkbWluIG9mIHRoZSBwaXBlLiAq
LwpAQCAtMTc0Nyw3ICsxNzY5LDcgQEAgc3RhdGljIHZvaWQgeG1pdF9kZXNjcyhzdHJ1Y3Qgc25k
X2RicmkgKgogICoKICAqLwogCi1zdGF0aWMgdm9pZCB0cmFuc21pc3Npb25fY29tcGxldGVfaW50
cihzdHJ1Y3Qgc25kX2RicmkgKiBkYnJpLCBpbnQgcGlwZSkKK3N0YXRpYyB2b2lkIHRyYW5zbWlz
c2lvbl9jb21wbGV0ZV9pbnRyKHN0cnVjdCBzbmRfZGJyaSAqZGJyaSwgaW50IHBpcGUpCiB7CiAJ
c3RydWN0IGRicmlfc3RyZWFtaW5mbyAqaW5mbzsKIAlpbnQgdGQ7CkBAIC0xNzYzLDkgKzE3ODUs
OCBAQCBzdGF0aWMgdm9pZCB0cmFuc21pc3Npb25fY29tcGxldGVfaW50cihzCiAJCX0KIAogCQlz
dGF0dXMgPSBEQlJJX1REX1NUQVRVUyhkYnJpLT5kbWEtPmRlc2NbdGRdLndvcmQ0KTsKLQkJaWYg
KCEoc3RhdHVzICYgREJSSV9URF9UQkMpKSB7CisJCWlmICghKHN0YXR1cyAmIERCUklfVERfVEJD
KSkKIAkJCWJyZWFrOwotCQl9CiAKIAkJZHByaW50ayhEX0lOVCwgIlREICVkLCBzdGF0dXMgMHgl
MDJ4XG4iLCB0ZCwgc3RhdHVzKTsKIApAQCAtMTc4NSw3ICsxODA2LDcgQEAgc3RhdGljIHZvaWQg
dHJhbnNtaXNzaW9uX2NvbXBsZXRlX2ludHIocwogCQlzbmRfcGNtX3BlcmlvZF9lbGFwc2VkKGlu
Zm8tPnN1YnN0cmVhbSk7CiB9CiAKLXN0YXRpYyB2b2lkIHJlY2VwdGlvbl9jb21wbGV0ZV9pbnRy
KHN0cnVjdCBzbmRfZGJyaSAqIGRicmksIGludCBwaXBlKQorc3RhdGljIHZvaWQgcmVjZXB0aW9u
X2NvbXBsZXRlX2ludHIoc3RydWN0IHNuZF9kYnJpICpkYnJpLCBpbnQgcGlwZSkKIHsKIAlzdHJ1
Y3QgZGJyaV9zdHJlYW1pbmZvICppbmZvOwogCWludCByZCA9IGRicmktPnBpcGVzW3BpcGVdLmRl
c2M7CkBAIC0xODE3LDcgKzE4MzgsNyBAQCBzdGF0aWMgdm9pZCByZWNlcHRpb25fY29tcGxldGVf
aW50cihzdHJ1CiAJCXNuZF9wY21fcGVyaW9kX2VsYXBzZWQoaW5mby0+c3Vic3RyZWFtKTsKIH0K
IAotc3RhdGljIHZvaWQgZGJyaV9wcm9jZXNzX29uZV9pbnRlcnJ1cHQoc3RydWN0IHNuZF9kYnJp
ICogZGJyaSwgaW50IHgpCitzdGF0aWMgdm9pZCBkYnJpX3Byb2Nlc3Nfb25lX2ludGVycnVwdChz
dHJ1Y3Qgc25kX2RicmkgKmRicmksIGludCB4KQogewogCWludCB2YWwgPSBEX0lOVFJfR0VUVkFM
KHgpOwogCWludCBjaGFubmVsID0gRF9JTlRSX0dFVENIQU4oeCk7CkBAIC0xODg5LDcgKzE5MTAs
NyBAQCBzdGF0aWMgdm9pZCBkYnJpX3Byb2Nlc3Nfb25lX2ludGVycnVwdChzCiAgKiByaWdodCBu
b3cpLiAgTm9uLXplcm8gd29yZHMgcmVxdWlyZSBwcm9jZXNzaW5nIGFuZCBhcmUgaGFuZGVkIG9m
ZgogICogdG8gZGJyaV9wcm9jZXNzX29uZV9pbnRlcnJ1cHQgQUZURVIgYWR2YW5jaW5nIHRoZSBw
b2ludGVyLgogICovCi1zdGF0aWMgdm9pZCBkYnJpX3Byb2Nlc3NfaW50ZXJydXB0X2J1ZmZlcihz
dHJ1Y3Qgc25kX2RicmkgKiBkYnJpKQorc3RhdGljIHZvaWQgZGJyaV9wcm9jZXNzX2ludGVycnVw
dF9idWZmZXIoc3RydWN0IHNuZF9kYnJpICpkYnJpKQogewogCXMzMiB4OwogCkBAIC0xOTY1LDE1
ICsxOTg2LDE1IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBzbmRfZGJyaV9pbnRlcnJ1cHQoaW4KIAkJ
UENNIEludGVyZmFjZQogKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KIHN0YXRpYyBzdHJ1Y3Qgc25kX3Bj
bV9oYXJkd2FyZSBzbmRfZGJyaV9wY21faHcgPSB7Ci0JLmluZm8JCQk9IChTTkRSVl9QQ01fSU5G
T19NTUFQIHwKLQkJCQkgICBTTkRSVl9QQ01fSU5GT19JTlRFUkxFQVZFRCB8Ci0JCQkJICAgU05E
UlZfUENNX0lORk9fQkxPQ0tfVFJBTlNGRVIgfAotCQkJCSAgIFNORFJWX1BDTV9JTkZPX01NQVBf
VkFMSUQpLAotCS5mb3JtYXRzCQk9IFNORFJWX1BDTV9GTVRCSVRfTVVfTEFXIHwKLQkJCQkgIFNO
RFJWX1BDTV9GTVRCSVRfQV9MQVcgfAotCQkJCSAgU05EUlZfUENNX0ZNVEJJVF9VOCB8Ci0JCQkJ
ICBTTkRSVl9QQ01fRk1UQklUX1MxNl9CRSwKLQkucmF0ZXMJCQk9IFNORFJWX1BDTV9SQVRFXzgw
MDBfNDgwMDAgfCBTTkRSVl9QQ01fUkFURV81NTEyLAorCS5pbmZvCQk9IChTTkRSVl9QQ01fSU5G
T19NTUFQIHwKKwkJCSAgIFNORFJWX1BDTV9JTkZPX0lOVEVSTEVBVkVEIHwKKwkJCSAgIFNORFJW
X1BDTV9JTkZPX0JMT0NLX1RSQU5TRkVSIHwKKwkJCSAgIFNORFJWX1BDTV9JTkZPX01NQVBfVkFM
SUQpLAorCS5mb3JtYXRzCT0gU05EUlZfUENNX0ZNVEJJVF9NVV9MQVcgfAorCQkJICBTTkRSVl9Q
Q01fRk1UQklUX0FfTEFXIHwKKwkJCSAgU05EUlZfUENNX0ZNVEJJVF9VOCB8CisJCQkgIFNORFJW
X1BDTV9GTVRCSVRfUzE2X0JFLAorCS5yYXRlcwkJPSBTTkRSVl9QQ01fUkFURV84MDAwXzQ4MDAw
IHwgU05EUlZfUENNX1JBVEVfNTUxMiwKIAkucmF0ZV9taW4JCT0gNTUxMiwKIAkucmF0ZV9tYXgJ
CT0gNDgwMDAsCiAJLmNoYW5uZWxzX21pbgkJPSAxLApAQCAtMjAxMSw3ICsyMDMyLDggQEAgc3Rh
dGljIGludCBzbmRfaHdfcnVsZV9jaGFubmVscyhzdHJ1Y3QgcwogCiAJc25kX2ludGVydmFsX2Fu
eSgmY2gpOwogCWlmICghKGYtPmJpdHNbMF0gJiBTTkRSVl9QQ01fRk1UQklUX1MxNl9CRSkpIHsK
LQkJY2gubWluID0gY2gubWF4ID0gMTsKKwkJY2gubWluID0gMTsKKwkJY2gubWF4ID0gMTsKIAkJ
Y2guaW50ZWdlciA9IDE7CiAJCXJldHVybiBzbmRfaW50ZXJ2YWxfcmVmaW5lKGMsICZjaCk7CiAJ
fQpAQCAtMjAzNSwxNCArMjA1NywxNCBAQCBzdGF0aWMgaW50IHNuZF9kYnJpX29wZW4oc3RydWN0
IHNuZF9wY21fCiAJaW5mby0+cGlwZSA9IC0xOwogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRi
cmktPmxvY2ssIGZsYWdzKTsKIAotCXNuZF9wY21faHdfcnVsZV9hZGQocnVudGltZSwwLFNORFJW
X1BDTV9IV19QQVJBTV9DSEFOTkVMUywKKwlzbmRfcGNtX2h3X3J1bGVfYWRkKHJ1bnRpbWUsIDAs
IFNORFJWX1BDTV9IV19QQVJBTV9DSEFOTkVMUywKIAkJCSAgICBzbmRfaHdfcnVsZV9mb3JtYXQs
IE5VTEwsIFNORFJWX1BDTV9IV19QQVJBTV9GT1JNQVQsCiAJCQkgICAgLTEpOwotCXNuZF9wY21f
aHdfcnVsZV9hZGQocnVudGltZSwwLFNORFJWX1BDTV9IV19QQVJBTV9GT1JNQVQsCi0JCQkgICAg
c25kX2h3X3J1bGVfY2hhbm5lbHMsIE5VTEwsIAorCXNuZF9wY21faHdfcnVsZV9hZGQocnVudGlt
ZSwgMCwgU05EUlZfUENNX0hXX1BBUkFNX0ZPUk1BVCwKKwkJCSAgICBzbmRfaHdfcnVsZV9jaGFu
bmVscywgTlVMTCwKIAkJCSAgICBTTkRSVl9QQ01fSFdfUEFSQU1fQ0hBTk5FTFMsCiAJCQkgICAg
LTEpOwotCQkJCQorCiAJY3M0MjE1X29wZW4oZGJyaSk7CiAKIAlyZXR1cm4gMDsKQEAgLTIxNDUs
NyArMjE2Nyw3IEBAIHN0YXRpYyBpbnQgc25kX2RicmlfcHJlcGFyZShzdHJ1Y3Qgc25kX3AKIAlz
cGluX2xvY2tfaXJxKCZkYnJpLT5sb2NrKTsKIAlpbmZvLT5vZmZzZXQgPSAwOwogCi0JLyogU2V0
dXAgdGhlIGFsbCB0aGUgdHJhbnNtaXQvcmVjZWl2ZSBkZXNjaXB0b3JzIHRvIGNvdmVyIHRoZQor
CS8qIFNldHVwIHRoZSBhbGwgdGhlIHRyYW5zbWl0L3JlY2VpdmUgZGVzY3JpcHRvcnMgdG8gY292
ZXIgdGhlCiAJICogd2hvbGUgRE1BIGJ1ZmZlci4KIAkgKi8KIAlyZXQgPSBzZXR1cF9kZXNjcyhk
YnJpLCBEQlJJX1NUUkVBTU5PKHN1YnN0cmVhbSksCkBAIC0yMjA1LDcgKzIyMjcsNyBAQCBzdGF0
aWMgc3RydWN0IHNuZF9wY21fb3BzIHNuZF9kYnJpX29wcyA9CiAJLnBvaW50ZXIgPSBzbmRfZGJy
aV9wb2ludGVyLAogfTsKIAotc3RhdGljIGludCBfX2RldmluaXQgc25kX2RicmlfcGNtKHN0cnVj
dCBzbmRfZGJyaSAqIGRicmkpCitzdGF0aWMgaW50IF9fZGV2aW5pdCBzbmRfZGJyaV9wY20oc3Ry
dWN0IHNuZF9kYnJpICpkYnJpKQogewogCXN0cnVjdCBzbmRfcGNtICpwY207CiAJaW50IGVycjsK
QEAgLTIyMjgsOSArMjI1MCw4IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IHNuZF9kYnJpX3BjbShz
dHJ1Y3QKIAlpZiAoKGVyciA9IHNuZF9wY21fbGliX3ByZWFsbG9jYXRlX3BhZ2VzX2Zvcl9hbGwo
cGNtLAogCQkJU05EUlZfRE1BX1RZUEVfQ09OVElOVU9VUywKIAkJCXNuZF9kbWFfY29udGludW91
c19kYXRhKEdGUF9LRVJORUwpLAotCQkJNjQgKiAxMDI0LCA2NCAqIDEwMjQpKSA8IDApIHsKKwkJ
CTY0ICogMTAyNCwgNjQgKiAxMDI0KSkgPCAwKQogCQlyZXR1cm4gZXJyOwotCX0KIAogCXJldHVy
biAwOwogfQpAQCAtMjI3MSw3ICsyMjkyLDggQEAgc3RhdGljIGludCBzbmRfY3M0MjE1X3B1dF92
b2x1bWUoc3RydWN0IAogCQkJCSBzdHJ1Y3Qgc25kX2N0bF9lbGVtX3ZhbHVlICp1Y29udHJvbCkK
IHsKIAlzdHJ1Y3Qgc25kX2RicmkgKmRicmkgPSBzbmRfa2NvbnRyb2xfY2hpcChrY29udHJvbCk7
Ci0Jc3RydWN0IGRicmlfc3RyZWFtaW5mbyAqaW5mbyA9ICZkYnJpLT5zdHJlYW1faW5mb1trY29u
dHJvbC0+cHJpdmF0ZV92YWx1ZV07CisJc3RydWN0IGRicmlfc3RyZWFtaW5mbyAqaW5mbyA9CisJ
CQkJJmRicmktPnN0cmVhbV9pbmZvW2tjb250cm9sLT5wcml2YXRlX3ZhbHVlXTsKIAlpbnQgY2hh
bmdlZCA9IDA7CiAKIAlpZiAoaW5mby0+bGVmdF9nYWluICE9IHVjb250cm9sLT52YWx1ZS5pbnRl
Z2VyLnZhbHVlWzBdKSB7CkBAIC0yMzE2LDE4ICsyMzM4LDE2IEBAIHN0YXRpYyBpbnQgc25kX2Nz
NDIxNV9nZXRfc2luZ2xlKHN0cnVjdCAKIAlpbnQgaW52ZXJ0ID0gKGtjb250cm9sLT5wcml2YXRl
X3ZhbHVlID4+IDI0KSAmIDE7CiAJc25kX2Fzc2VydChkYnJpICE9IE5VTEwsIHJldHVybiAtRUlO
VkFMKTsKIAotCWlmIChlbGVtIDwgNCkgeworCWlmIChlbGVtIDwgNCkKIAkJdWNvbnRyb2wtPnZh
bHVlLmludGVnZXIudmFsdWVbMF0gPQogCQkgICAgKGRicmktPm1tLmRhdGFbZWxlbV0gPj4gc2hp
ZnQpICYgbWFzazsKLQl9IGVsc2UgeworCWVsc2UKIAkJdWNvbnRyb2wtPnZhbHVlLmludGVnZXIu
dmFsdWVbMF0gPQogCQkgICAgKGRicmktPm1tLmN0cmxbZWxlbSAtIDRdID4+IHNoaWZ0KSAmIG1h
c2s7Ci0JfQogCi0JaWYgKGludmVydCA9PSAxKSB7CisJaWYgKGludmVydCA9PSAxKQogCQl1Y29u
dHJvbC0+dmFsdWUuaW50ZWdlci52YWx1ZVswXSA9CiAJCSAgICBtYXNrIC0gdWNvbnRyb2wtPnZh
bHVlLmludGVnZXIudmFsdWVbMF07Ci0JfQogCXJldHVybiAwOwogfQogCkBAIC0yMzc4LDExICsy
Mzk4LDEyIEBAIHN0YXRpYyBpbnQgc25kX2NzNDIxNV9wdXRfc2luZ2xlKHN0cnVjdCAKICAgIHRp
bWVzbG90cy4gU2hpZnQgaXMgdGhlIGJpdCBvZmZzZXQgaW4gdGhlIHRpbWVzbG90LCBtYXNrIGRl
ZmluZXMgdGhlCiAgICBudW1iZXIgb2YgYml0cy4gaW52ZXJ0IGlzIGEgYm9vbGVhbiBmb3IgdXNl
IHdpdGggYXR0ZW51YXRpb24uCiAgKi8KLSNkZWZpbmUgQ1M0MjE1X1NJTkdMRSh4bmFtZSwgZW50
cnksIHNoaWZ0LCBtYXNrLCBpbnZlcnQpIFwKLXsgLmlmYWNlID0gU05EUlZfQ1RMX0VMRU1fSUZB
Q0VfTUlYRVIsIC5uYW1lID0geG5hbWUsIFwKLSAgLmluZm8gPSBzbmRfY3M0MjE1X2luZm9fc2lu
Z2xlLCBcCi0gIC5nZXQgPSBzbmRfY3M0MjE1X2dldF9zaW5nbGUsIC5wdXQgPSBzbmRfY3M0MjE1
X3B1dF9zaW5nbGUsIFwKLSAgLnByaXZhdGVfdmFsdWUgPSBlbnRyeSB8IChzaGlmdCA8PCA4KSB8
IChtYXNrIDw8IDE2KSB8IChpbnZlcnQgPDwgMjQpIH0sCisjZGVmaW5lIENTNDIxNV9TSU5HTEUo
eG5hbWUsIGVudHJ5LCBzaGlmdCwgbWFzaywgaW52ZXJ0KQlcCit7IC5pZmFjZSA9IFNORFJWX0NU
TF9FTEVNX0lGQUNFX01JWEVSLCAubmFtZSA9ICh4bmFtZSksCQlcCisgIC5pbmZvID0gc25kX2Nz
NDIxNV9pbmZvX3NpbmdsZSwJCQkJXAorICAuZ2V0ID0gc25kX2NzNDIxNV9nZXRfc2luZ2xlLCAu
cHV0ID0gc25kX2NzNDIxNV9wdXRfc2luZ2xlLAlcCisgIC5wcml2YXRlX3ZhbHVlID0gKGVudHJ5
KSB8ICgoc2hpZnQpIDw8IDgpIHwgKChtYXNrKSA8PCAxNikgfAlcCisJCQkoKGludmVydCkgPDwg
MjQpIH0sCiAKIHN0YXRpYyBzdHJ1Y3Qgc25kX2tjb250cm9sX25ldyBkYnJpX2NvbnRyb2xzW10g
X19kZXZpbml0ZGF0YSA9IHsKIAl7CkBAIC0yNDExLDcgKzI0MzIsNyBAQCBzdGF0aWMgc3RydWN0
IHNuZF9rY29udHJvbF9uZXcgZGJyaV9jb250CiAJQ1M0MjE1X1NJTkdMRSgiTWljIGJvb3N0Iiwg
NCwgNCwgMSwgMSkKIH07CiAKLXN0YXRpYyBpbnQgX19pbml0IHNuZF9kYnJpX21peGVyKHN0cnVj
dCBzbmRfZGJyaSAqIGRicmkpCitzdGF0aWMgaW50IF9faW5pdCBzbmRfZGJyaV9taXhlcihzdHJ1
Y3Qgc25kX2RicmkgKmRicmkpCiB7CiAJc3RydWN0IHNuZF9jYXJkICpjYXJkOwogCWludCBpZHgs
IGVycjsKQEAgLTI0MzgsNyArMjQ1OSw4IEBAIHN0YXRpYyBpbnQgX19pbml0IHNuZF9kYnJpX21p
eGVyKHN0cnVjdCAKIC8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCiAJCQkvcHJvYyBpbnRlcmZhY2UKICoq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKiovCi1zdGF0aWMgdm9pZCBkYnJpX3JlZ3NfcmVhZChzdHJ1Y3Qgc25k
X2luZm9fZW50cnkgKiBlbnRyeSwgc3RydWN0IHNuZF9pbmZvX2J1ZmZlciAqYnVmZmVyKQorc3Rh
dGljIHZvaWQgZGJyaV9yZWdzX3JlYWQoc3RydWN0IHNuZF9pbmZvX2VudHJ5ICplbnRyeSwKKwkJ
CSAgIHN0cnVjdCBzbmRfaW5mb19idWZmZXIgKmJ1ZmZlcikKIHsKIAlzdHJ1Y3Qgc25kX2Ricmkg
KmRicmkgPSBlbnRyeS0+cHJpdmF0ZV9kYXRhOwogCkBAIC0yNDQ5LDcgKzI0NzEsNyBAQCBzdGF0
aWMgdm9pZCBkYnJpX3JlZ3NfcmVhZChzdHJ1Y3Qgc25kX2luCiB9CiAKICNpZmRlZiBEQlJJX0RF
QlVHCi1zdGF0aWMgdm9pZCBkYnJpX2RlYnVnX3JlYWQoc3RydWN0IHNuZF9pbmZvX2VudHJ5ICog
ZW50cnksCitzdGF0aWMgdm9pZCBkYnJpX2RlYnVnX3JlYWQoc3RydWN0IHNuZF9pbmZvX2VudHJ5
ICplbnRyeSwKIAkJCSAgICBzdHJ1Y3Qgc25kX2luZm9fYnVmZmVyICpidWZmZXIpCiB7CiAJc3Ry
dWN0IHNuZF9kYnJpICpkYnJpID0gZW50cnktPnByaXZhdGVfZGF0YTsKQEAgLTI0NjMsNyArMjQ4
NSw4IEBAIHN0YXRpYyB2b2lkIGRicmlfZGVidWdfcmVhZChzdHJ1Y3Qgc25kX2kKIAkJCQkgICAg
IlBpcGUgJWQ6ICVzIFNEUD0weCV4IGRlc2M9JWQsICIKIAkJCQkgICAgImxlbj0lZCBuZXh0ICVk
XG4iLAogCQkJCSAgICBwaXBlLAotCQkJCSAgICgocHB0ci0+c2RwICYgRF9TRFBfVE9fU0VSKSA/
ICJvdXRwdXQiIDogImlucHV0IiksCisJCQkJICAgKChwcHRyLT5zZHAgJiBEX1NEUF9UT19TRVIp
ID8gIm91dHB1dCIgOgorCQkJCQkJCQkgImlucHV0IiksCiAJCQkJICAgIHBwdHItPnNkcCwgcHB0
ci0+ZGVzYywKIAkJCQkgICAgcHB0ci0+bGVuZ3RoLCBwcHRyLT5uZXh0cGlwZSk7CiAJCX0KQEAg
LTI0NzEsMTEgKzI0OTQsMTEgQEAgc3RhdGljIHZvaWQgZGJyaV9kZWJ1Z19yZWFkKHN0cnVjdCBz
bmRfaQogfQogI2VuZGlmCiAKLXZvaWQgc25kX2RicmlfcHJvYyhzdHJ1Y3Qgc25kX2RicmkgKiBk
YnJpKQordm9pZCBzbmRfZGJyaV9wcm9jKHN0cnVjdCBzbmRfZGJyaSAqZGJyaSkKIHsKIAlzdHJ1
Y3Qgc25kX2luZm9fZW50cnkgKmVudHJ5OwogCi0JaWYgKCEgc25kX2NhcmRfcHJvY19uZXcoZGJy
aS0+Y2FyZCwgInJlZ3MiLCAmZW50cnkpKQorCWlmICghc25kX2NhcmRfcHJvY19uZXcoZGJyaS0+
Y2FyZCwgInJlZ3MiLCAmZW50cnkpKQogCQlzbmRfaW5mb19zZXRfdGV4dF9vcHMoZW50cnksIGRi
cmksIGRicmlfcmVnc19yZWFkKTsKIAogI2lmZGVmIERCUklfREVCVUcKQEAgLTI0OTEsNyArMjUx
NCw3IEBAIHZvaWQgc25kX2RicmlfcHJvYyhzdHJ1Y3Qgc25kX2RicmkgKiBkYnIKICoqKioqKioq
KioqKioqKioqKioqKioqKioqKiogSW5pdGlhbGl6YXRpb24gKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioKICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKICovCi1zdGF0aWMgdm9pZCBzbmRfZGJy
aV9mcmVlKHN0cnVjdCBzbmRfZGJyaSAqIGRicmkpOworc3RhdGljIHZvaWQgc25kX2RicmlfZnJl
ZShzdHJ1Y3Qgc25kX2RicmkgKmRicmkpOwogCiBzdGF0aWMgaW50IF9faW5pdCBzbmRfZGJyaV9j
cmVhdGUoc3RydWN0IHNuZF9jYXJkICpjYXJkLAogCQkJCSAgc3RydWN0IHNidXNfZGV2ICpzZGV2
LApAQCAtMjU0Nyw3ICsyNTcwLDcgQEAgc3RhdGljIGludCBfX2luaXQgc25kX2RicmlfY3JlYXRl
KHN0cnVjdAogCXJldHVybiAwOwogfQogCi1zdGF0aWMgdm9pZCBzbmRfZGJyaV9mcmVlKHN0cnVj
dCBzbmRfZGJyaSAqIGRicmkpCitzdGF0aWMgdm9pZCBzbmRfZGJyaV9mcmVlKHN0cnVjdCBzbmRf
ZGJyaSAqZGJyaSkKIHsKIAlkcHJpbnRrKERfR0VOLCAic25kX2RicmlfZnJlZVxuIik7CiAJZGJy
aV9yZXNldChkYnJpKTsKQEAgLTI1ODcsNyArMjYxMCw4IEBAIHN0YXRpYyBpbnQgX19pbml0IGRi
cmlfYXR0YWNoKGludCBwcm9tX24KIAogCWVyciA9IHByb21fZ2V0cHJvcGVydHkocHJvbV9ub2Rl
LCAiaW50ciIsIChjaGFyICopJmlycSwgc2l6ZW9mKGlycSkpOwogCWlmIChlcnIgPCAwKSB7Ci0J
CXByaW50ayhLRVJOX0VSUiAiREJSSS0lZDogRmlybXdhcmUgbm9kZSBsYWNrcyBJUlEgcHJvcGVy
dHkuXG4iLCBkZXYpOworCQlwcmludGsoS0VSTl9FUlIgIkRCUkktJWQ6IEZpcm13YXJlIG5vZGUg
bGFja3MgSVJRIHByb3BlcnR5LlxuIiwKKwkJCWRldik7CiAJCXJldHVybiAtRU5PREVWOwogCX0K
IApAQCAtMjYxMywxMiArMjYzNywxNCBAQCBzdGF0aWMgaW50IF9faW5pdCBkYnJpX2F0dGFjaChp
bnQgcHJvbV9uCiAJCWdvdG8gX2VycjsKIAogCWlmICgoZXJyID0gc25kX2RicmlfbWl4ZXIoZGJy
aSkpIDwgMCkKKwlpZiAoKGVyciA9IHNuZF9kYnJpX21peGVyKGRicmkpKSA8IDApCiAJCWdvdG8g
X2VycjsKIAogCS8qIC9wcm9jIGZpbGUgaGFuZGxpbmcgKi8KIAlzbmRfZGJyaV9wcm9jKGRicmkp
OwogCi0JaWYgKChlcnIgPSBzbmRfY2FyZF9yZWdpc3RlcihjYXJkKSkgPCAwKQorCWVyciA9IHNu
ZF9jYXJkX3JlZ2lzdGVyKGNhcmQpOworCWlmIChlcnIgPCAwKQogCQlnb3RvIF9lcnI7CiAKIAlw
cmludGsoS0VSTl9JTkZPICJhdWRpbyVkIGF0ICVwIChpcnEgJWQpIGlzIERCUkkoJWMpK0NTNDIx
NSglZClcbiIsCkBAIC0yNjI4LDcgKzI2NTQsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBkYnJpX2F0
dGFjaChpbnQgcHJvbV9uCiAKIAlyZXR1cm4gMDsKIAotIF9lcnI6CitfZXJyOgogCXNuZF9kYnJp
X2ZyZWUoZGJyaSk7CiAJc25kX2NhcmRfZnJlZShjYXJkKTsKIAlyZXR1cm4gZXJyOwo=

--part46c69152e710b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--part46c69152e710b--
