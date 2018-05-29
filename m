From: Jason Self <j@jxself.org>
Subject: [PATCH 1/1] Add aica firmware source
Date: Tue, 29 May 2018 06:10:37 -0700
Message-ID: <1527599437-28987-1-git-send-email-j@jxself.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: alsa-devel@alsa-project.org, Jason Self <j@jxself.org>
List-Id: alsa-devel@alsa-project.org

This provides a separately-buildable copy of the aica firmware
source.

The documentation in alsa-firmware indicates aica_firmware.bin was
built with code from
http://linuxdc.cvs.sourceforge.net/linuxdc/linux-sh-dc/sound/oss/aica/firmware/

While it's still possible to obtain the firmware source code from
there using rsync the linuxdc project has been defunct for a number
of years and it seems a good idea to get a copy of the source code
stashed away somewhere else just in case.

I don't know that we should necessarily expect people to have a cross
compiler installed on their system and so this patch doesn't change
any of the existing Makefiles so as to leave the default behavior
as-is, but anyone interested in rebuilding aica_firmware.bin would at
least have the option to do so.

Signed-off-by: Jason Self <j@jxself.org>

diff --git a/aica/src/COPYING b/aica/src/COPYING
new file mode 100644
index 0000000..0019417
--- /dev/null
+++ b/aica/src/COPYING
@@ -0,0 +1,25 @@
+(c)2000 Dan Potter
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions
+are met:
+1. Redistributions of source code must retain the above copyright
+   notice, this list of conditions and the following disclaimer.
+2. Redistributions in binary form must reproduce the above copyright
+   notice, this list of conditions and the following disclaimer in the
+   documentation and/or other materials provided with the distribution.
+3. Neither the name of Cryptic Allusion nor the names of its contributors
+   may be used to endorse or promote products derived from this software
+   without specific prior written permission.
+
+THIS SOFTWARE IS PROVIDED BY THE AUTHORS AND CONTRIBUTORS ``AS IS'' AND
+ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS OR CONTRIBUTORS BE LIABLE
+FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
+SUCH DAMAGE.
diff --git a/aica/src/INSTALL b/aica/src/INSTALL
new file mode 100644
index 0000000..2c51ccb
--- /dev/null
+++ b/aica/src/INSTALL
@@ -0,0 +1,7 @@
+To build this you will need the following on the host system:
+
+    * GNU Make
+    * GNU C cross-compiler for ARM:
+        - arm-none-eabi-gcc
+        - arm-none-eabi-objcopy
+        - arm-none-eabi-as
\ No newline at end of file
diff --git a/aica/src/aica.c b/aica/src/aica.c
new file mode 100644
index 0000000..2dc5010
--- /dev/null
+++ b/aica/src/aica.c
@@ -0,0 +1,220 @@
+/* This file is part of the Dreamcast function library.
+ * Please see libdream.c for further details.
+ *
+ * (c)2000 Dan Potter
+ *
+ * $Id: aica.c,v 1.3 2002/10/29 15:43:38 mrbrown Exp $
+ */
+
+#include "aica.h"
+
+void aica_init() {
+	int i, j;
+	
+	/* Initialize AICA channels */	
+	SNDREG32(0x2800) = 0x0000;
+	
+	for (i=0; i<64; i++) {
+		for (j=0; j<0x80; j+=4)
+			CHNREG32(i, j) = 0;
+		CHNREG32(i,0) = 0x8000;
+		CHNREG32(i,20) = 0x1f;
+	}
+
+	SNDREG32(0x2800) = 0x000f;
+}
+
+/* Translates a volume from linear form to logarithmic form (required by
+   the AICA chip */
+/* int logs[] = {
+
+0, 40, 50, 58, 63, 68, 73, 77, 80, 83, 86, 89, 92, 94, 97, 99, 101, 103,
+105, 107, 109, 111, 112, 114, 116, 117, 119, 120, 122, 123, 125, 126, 127,
+129, 130, 131, 133, 134, 135, 136, 137, 139, 140, 141, 142, 143, 144, 145,
+146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 156, 157, 158, 159,
+160, 161, 162, 162, 163, 164, 165, 166, 166, 167, 168, 169, 170, 170, 171,
+172, 172, 173, 174, 175, 175, 176, 177, 177, 178, 179, 180, 180, 181, 182,
+182, 183, 183, 184, 185, 185, 186, 187, 187, 188, 188, 189, 190, 190, 191,
+191, 192, 193, 193, 194, 194, 195, 196, 196, 197, 197, 198, 198, 199, 199,
+200, 201, 201, 202, 202, 203, 203, 204, 204, 205, 205, 206, 206, 207, 207,
+208, 208, 209, 209, 210, 210, 211, 211, 212, 212, 213, 213, 214, 214, 215,
+215, 216, 216, 217, 217, 217, 218, 218, 219, 219, 220, 220, 221, 221, 222,
+222, 222, 223, 223, 224, 224, 225, 225, 225, 226, 226, 227, 227, 228, 228,
+228, 229, 229, 230, 230, 230, 231, 231, 232, 232, 232, 233, 233, 234, 234,
+234, 235, 235, 236, 236, 236, 237, 237, 238, 238, 238, 239, 239, 240, 240,
+240, 241, 241, 241, 242, 242, 243, 243, 243, 244, 244, 244, 245, 245, 245,
+246, 246, 247, 247, 247, 248, 248, 248, 249, 249, 249, 250, 250, 250, 251,
+251, 251, 252, 252, 252, 253, 253, 253, 254, 254, 254, 255
+
+}; */
+
+int logs[] = {
+	0, 15, 22, 27, 31, 35, 39, 42, 45, 47, 50, 52, 55, 57, 59, 61,
+	63, 65, 67, 69, 71, 73, 74, 76, 78, 79, 81, 82, 84, 85, 87, 88,
+	90, 91, 92, 94, 95, 96, 98, 99, 100, 102, 103, 104, 105, 106,
+	108, 109, 110, 111, 112, 113, 114, 116, 117, 118, 119, 120, 121,
+	122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134,
+	135, 136, 137, 138, 138, 139, 140, 141, 142, 143, 144, 145, 146,
+	146, 147, 148, 149, 150, 151, 152, 152, 153, 154, 155, 156, 156,
+	157, 158, 159, 160, 160, 161, 162, 163, 164, 164, 165, 166, 167,
+	167, 168, 169, 170, 170, 171, 172, 173, 173, 174, 175, 176, 176,
+	177, 178, 178, 179, 180, 181, 181, 182, 183, 183, 184, 185, 185,
+	186, 187, 187, 188, 189, 189, 190, 191, 191, 192, 193, 193, 194,
+	195, 195, 196, 197, 197, 198, 199, 199, 200, 200, 201, 202, 202,
+	203, 204, 204, 205, 205, 206, 207, 207, 208, 209, 209, 210, 210,
+	211, 212, 212, 213, 213, 214, 215, 215, 216, 216, 217, 217, 218,
+	219, 219, 220, 220, 221, 221, 222, 223, 223, 224, 224, 225, 225,
+	226, 227, 227, 228, 228, 229, 229, 230, 230, 231, 232, 232, 233,
+	233, 234, 234, 235, 235, 236, 236, 237, 237, 238, 239, 239, 240,
+	240, 241, 241, 242, 242, 243, 243, 244, 244, 245, 245, 246, 246,
+	247, 247, 248, 248, 249, 249, 250, 250, 251, 251, 252, 252, 253, 254, 255
+};
+int vol_to_log(int vol) {
+/*	vol = 0xff - (vol & 0xff); */
+/*	vol = 0xff - logs[vol & 0xff]; */
+/*	vol = 128 - ((vol & 0xff) / 2); */
+	vol = 0xff - logs[128 + ((vol & 0xff) / 2)];
+	return vol;
+}
+
+/* Sets up a sound channel completely. This is generally good if you want
+   a quick and dirty way to play notes. If you want a more comprehensive
+   set of routines (more like PC wavetable cards) see below.
+   
+   ch is the channel to play on (0 - 63)
+   smpptr is the pointer to the sound data; if you're running off the
+     SH4, then this ought to be (ptr - 0xa0800000); otherwise it's just
+     ptr. Basically, it's an offset into sound ram.
+   mode is one of the mode constants (16 bit, 8 bit, ADPCM)
+   nsamp is the number of samples to play (not number of bytes!)
+   freq is the sampling rate of the sound
+   vol is the volume, 0 to 0xff (0xff is louder)
+   pan is a panning constant -- 0 is left, 128 is center, 255 is right.
+
+   This routine (and the similar ones) owe a lot to Marcus' sound example -- 
+   I hadn't gotten quite this far into dissecting the individual regs yet. */
+void aica_play(int ch, unsigned long smpptr, int mode, int loopst, int loopend,
+		int freq, int vol, int pan, int loopflag) {
+	unsigned long freq_lo, freq_base = 5644800;
+	int freq_hi = 7;
+	int i, j;
+
+	/* Stop the channel (if it's already playing) */
+	/*for (i=CHNREG8(ch, 41); i<=0xff; i++) {
+		CHNREG8(ch, 41) = i;
+	} */
+	aica_stop(ch);
+	for (i=0; i<256; i++) {
+		asm("nop");
+		asm("nop");
+		asm("nop");
+		asm("nop");
+	}
+	
+	/* Convert the incoming volume and pan into hardware values */
+	vol = vol_to_log(vol);
+	
+	/* For the moment this is going to have to suffice, until we really
+	   figure out what these mean. */
+	if (pan == 0x80)
+		pan = 0;
+	else if (pan < 0x80)
+		pan = 0x1f;
+	else
+		pan = 0xf;
+	
+	/* Envelope setup. The first of these is the loop point,
+	   e.g., where the sample starts over when it loops. The second
+	   is the loop end. This is the full length of the sample when
+	   you are not looping, or the loop end point when you are (though
+	   storing more than that is a waste of memory if you're not doing
+	   volume enveloping). */
+	CHNREG32(ch, 8) = loopst & 0xffff;
+	CHNREG32(ch, 12) = loopend & 0xffff;
+	
+	/* Need to convert frequency to floating point format
+	   (freq_hi is exponent, freq_lo is mantissa)
+	   Formula is ferq = 44100*2^freq_hi*(1+freq_lo/1024) */
+	while (freq < freq_base && freq_hi > -8) {
+		freq_base >>= 1;
+		--freq_hi;
+	}
+	freq_lo = (freq<<10) / freq_base;
+	
+	/* Write resulting values */
+	CHNREG32(ch, 24) = (freq_hi << 11) | (freq_lo & 1023);
+	
+	/* Set volume, pan, and some other things that we don't know what
+	   they do =) */
+	CHNREG8(ch, 36) = pan;
+	CHNREG8(ch, 37) = 0xf;
+	CHNREG8(ch, 40) = 0x24;
+	CHNREG8(ch, 41) = vol;	/* Vol starts at zero so we can ramp */
+
+	/* If we supported volume envelopes (which we don't yet) then
+	   this value would set that up. The top 4 bits determine the
+	   envelope speed. f is the fastest, 1 is the slowest, and 0
+	   seems to be an invalid value and does weird things). The
+	   default (below) sets it into normal mode (play and terminate/loop).
+	CHNREG32(ch, 16) = 0xf010;
+	*/
+	CHNREG32(ch, 16) = 0x1f;	/* No volume envelope */
+	
+	
+	/* Set sample format, buffer address, and looping control. If
+	   0x0200 mask is set on reg 0, the sample loops infinitely. If
+	   it's not set, the sample plays once and terminates. We'll
+	   also set the bits to start playback here. */
+	CHNREG32(ch, 4) = smpptr & 0xffff;
+	if (loopflag)
+		CHNREG32(ch, 0) = 0xc000 | 0x0200 | (mode<<7) | (smpptr >> 16);	/* Loops */
+	else
+		CHNREG32(ch, 0) = 0xc000 | 0x0000 | (mode<<7) | (smpptr >> 16);	/* No loop */
+	
+
+	/* Enable playback */
+	/* CHNREG32(ch, 0) |= 0xc000; */
+
+	/*for (i=0xff; i>=vol; i--)
+		CHNREG8(ch, 41) = i; */
+}
+
+/* Stop the sound on a given channel */
+void aica_stop(int ch) {
+	CHNREG32(ch, 0) = (CHNREG32(ch, 0) & ~0x4000) | 0x8000;
+}
+
+
+/* The rest of these routines can change the channel in mid-stride so you
+   can do things like vibrato and panning effects. */
+   
+/* Set channel volume */
+void aica_vol(int ch, int vol) {
+	vol = vol_to_log(vol);
+	CHNREG8(ch, 41) = vol;
+}
+
+/* Set channel pan */
+void aica_pan(int ch, int pan) {
+	if (pan == 0x80)
+		pan = 0;
+	else if (pan < 0x80)
+		pan = 0x1f;
+	else
+		pan = 0xf;
+	CHNREG8(ch, 36) = pan;
+}
+
+/* Set channel frequency */
+void aica_freq(int ch, int freq) {
+	unsigned long freq_lo, freq_base = 5644800;
+	int freq_hi = 7;
+
+	while (freq < freq_base && freq_hi > -8) {
+		freq_base >>= 1;
+		freq_hi--;
+	}
+	freq_lo = (freq<<10) / freq_base;
+	CHNREG32(ch, 24) = (freq_hi << 11) | (freq_lo & 1023);
+}
+
diff --git a/aica/src/aica.h b/aica/src/aica.h
new file mode 100644
index 0000000..4c41e33
--- /dev/null
+++ b/aica/src/aica.h
@@ -0,0 +1,25 @@
+/* $Id: aica.h,v 1.3 2002/10/29 15:43:51 mrbrown Exp $ */
+
+#ifndef __AICA_H
+#define __AICA_H
+
+/* volatile unsigned char *dc_snd_base = (unsigned char *)0x00800000; */
+#define dc_snd_base ((volatile unsigned char *)0x00800000)
+
+/* Some convienence macros */
+#define SNDREG32A(x) ((volatile unsigned long *)(dc_snd_base + (x)))
+#define SNDREG32(x) (*SNDREG32A(x))
+#define SNDREG8A(x) (dc_snd_base + (x))
+#define SNDREG8(x) (*SNDREG8A(x))
+#define CHNREG32A(chn, x) SNDREG32A(0x80*(chn) + (x))
+#define CHNREG32(chn, x) (*CHNREG32A(chn, x))
+#define CHNREG8A(chn, x) SNDREG8A(0x80*(chn) + (x))
+#define CHNREG8(chn, x) (*CHNREG8A(chn, x))
+
+/* Sound modes */
+#define SM_8BIT		1
+#define SM_16BIT	0
+#define SM_ADPCM	2
+
+#endif	/* __AICA_H */
+
diff --git a/aica/src/aica_cmd_iface.h b/aica/src/aica_cmd_iface.h
new file mode 100644
index 0000000..df1cac9
--- /dev/null
+++ b/aica/src/aica_cmd_iface.h
@@ -0,0 +1,29 @@
+/* $Id: aica_cmd_iface.h,v 1.2 2002/10/29 15:45:10 mrbrown Exp $ */
+
+#ifndef __ARM_AICA_CMD_IFACE_H
+#define __ARM_AICA_CMD_IFACE_H
+
+#ifndef __ARCH_TYPES_H
+typedef unsigned long uint32;
+#endif
+
+/* Make this 8 dwords long for one aica bus queue */
+typedef struct {
+	uint32		cmd;		/* Command ID		*/
+	uint32		pos;		/* Sample position	*/
+	uint32		length;		/* Sample length	*/
+	uint32		freq;		/* Frequency		*/
+	uint32		vol;		/* Volume 0-255		*/
+	uint32		pan;		/* Pan 0-255		*/
+        uint32		sfmt;	        /* Sound format		*/
+	uint32		flags;	        /* flags		*/
+} aica_channel;
+
+/* Command values */
+#define AICA_CMD_KICK		0x80000000
+#define AICA_CMD_NONE		0
+#define AICA_CMD_START		1
+#define AICA_CMD_STOP		2
+#define AICA_CMD_VOL		3
+
+#endif	/* __ARM_AICA_CMD_IFACE_H */
diff --git a/aica/src/crt0.s b/aica/src/crt0.s
new file mode 100644
index 0000000..438f9c1
--- /dev/null
+++ b/aica/src/crt0.s
@@ -0,0 +1,104 @@
+# Adapted from Marcus' AICA example among a few other sources =)
+#
+# $Id: crt0.s,v 1.3 2002/10/29 15:45:49 mrbrown Exp $
+
+.text
+.globl	arm_main
+.globl	timer
+.globl	jps
+
+# Exception vectors
+	b	start
+	b	undef
+	b	softint
+	b	pref_abort
+	b	data_abort
+	b	rsrvd
+	b	irq
+
+
+# FIQ code adapted from the Marcus AICA example
+fiq:
+	# Save regs
+	#stmdb	sp!, {r0-r14}
+
+	# Grab interrupt type (store as parameter)
+	ldr	r8,intreq
+	ldr	r9,[r8]
+	and	r9,r9,#7
+	cmp	r9,#2
+	bne	fiq_done
+
+	# Type 2 is timer interrupt. Increment timer variable.
+	adr	r8,timer
+	ldr	r9,[r8]
+	add	r9,r9,#1
+	str	r9,[r8]
+	
+	# Request a new timer interrupt. We'll calculate the number
+	# put in here based on the "jps" (jiffies per second). 
+	ldr	r8, timer_control
+	mov	r9,#256-(44100/4410)
+#	ldr	r9,jps
+	str	r9,[r8,#0x10]
+	mov	r9,#0x40
+	str	r9,[r8,#0x24]
+	b	fiq_done
+	
+	# Return from interrupt
+fiq_done:
+
+	# Clear interrupt
+	ldr	r8,intclr
+	mov	r9,#1
+	str	r9,[r8]
+	str	r9,[r8]
+	str	r9,[r8]
+	str	r9,[r8]
+
+	# Restore regs and return
+	#ldmdb	sp!, {r0-r14}
+	subs	pc,r14,#4
+
+intreq:
+	.long	0x00802d00
+intclr:
+	.long	0x00802d04
+timer_control:
+	.long	0x00802880
+timer:
+	.long	0
+jps:
+	.long	256-(44100/1000)
+
+
+start:
+	# Setup a basic stack, disable IRQ, enable FIQ
+	mov	sp,#0xb000
+	mrs	r10,CPSR
+	orr	r10,r10,#0x80
+	bic	r10,r10,#0x40
+	msr	CPSR_all,r10
+
+	# Call the main for the SPU
+	bl	arm_main
+
+	# Loop infinitely if we get here
+here:	b	here
+
+
+# Handlers we don't bother to catch
+undef:
+softint:
+	mov	pc,r14
+pref_abort:
+data_abort:
+irq:
+rsrvd:
+	sub	pc,r14,#4
+
+
+
+
+
+
diff --git a/aica/src/main.c b/aica/src/main.c
new file mode 100644
index 0000000..2a50482
--- /dev/null
+++ b/aica/src/main.c
@@ -0,0 +1,123 @@
+/* Streaming sound driver
+ *
+ * (c)2000 Dan Potter
+ *
+ * This slightly more complicated version allows for sound effect channels,
+ * and full sampling rate, panning, and volume control for each. The two
+ * streaming channels are still always first and always occur at 0x11000 and
+ * 0x21000. All other sample data can begin at 0x31000. "pos" only works for
+ * input on the two streaming channels (which will always have the same
+ * "pos" value).
+ * 
+ * $Id: main.c,v 1.3 2002/10/29 15:48:47 mrbrown Exp $
+ */
+
+#include "aica.h"
+#include "aica_cmd_iface.h"
+
+static int buffer_index;
+static int active;
+
+/****************** Timer *******************************************/
+
+extern volatile int timer;
+
+void timer_wait(int jiffies) {
+	int fin = timer + jiffies;
+	while (timer <= fin)
+		;
+}
+
+/****************** Main Program ************************************/
+
+/* Set channel id at 0x80280d (byte), read position at 0x802814 (long) */
+
+volatile uint32 *cmd = (volatile uint32 *)0x10000;
+volatile aica_channel *chans = (volatile aica_channel *)0x10004;
+
+void start_channel(int chn) {
+  int samplesize = 1;
+  int stereo = (chans[chn].flags & 1);
+  if (chans[chn].sfmt == SM_16BIT) samplesize = 2;
+  if (stereo)
+    {
+      aica_play(0, 0x11000  , chans[chn].sfmt, 0, 0x8000/samplesize, chans[chn].freq, chans[chn].vol, 0, 1);
+      aica_play(1, 0x21000, chans[chn].sfmt, 0, 0x8000/samplesize, chans[chn].freq, chans[chn].vol, 0xff, 1);
+    }
+else
+  {
+    aica_play(chn, 0x11000, chans[chn].sfmt, 0, 0x8000/samplesize, chans[chn].freq, chans[chn].vol, chans[chn].pan, 1);
+  }	
+}
+
+void stop_channel(int chn) {
+	if (chn == 0) {
+		aica_stop(0);
+		aica_stop(1);
+	} else {
+		aica_stop(chn);
+	}
+}
+
+void vol_channel(int chn) {
+	if (chn == 0) {
+		aica_vol(0, chans[chn].vol);
+		aica_vol(1, chans[chn].vol);
+	} else {
+		aica_vol(chn, chans[chn].vol);
+	}
+}
+
+void process_cmd(uint32 cmd) {
+	/* cmd is channel to look at +1 */
+	cmd--;
+	switch(chans[cmd].cmd) {
+		case AICA_CMD_NONE:
+			break;
+		case AICA_CMD_START:
+			start_channel(cmd);
+			active = 0;
+			break;
+		case AICA_CMD_STOP:
+			stop_channel(cmd);
+			active = 0;
+			break;
+		case AICA_CMD_VOL:
+			vol_channel(cmd);
+			break;
+	}
+}
+
+int arm_main() {
+	int cmdl;
+	int flags, shift_buffer, pass;
+	/* Initialize the AICA part of the SPU */
+	aica_init();
+	
+
+	/* Observe channel 0 */
+	SNDREG8(0x280d) = 0;
+
+	/* Wait for a command */
+	while(1) {
+		/* Check for a command */
+		cmdl = *cmd;
+		if (cmdl & AICA_CMD_KICK) {
+			*cmd = 0;
+			process_cmd(cmdl & ~AICA_CMD_KICK);
+		}
+		
+		/* Update position counters */
+		chans[0].pos = SNDREG32(0x2814);
+		
+		/* Little delay to prevent memory lock */
+		timer_wait(10);
+
+	}
+}
+
+
+
+
+
+
-- 
2.7.4
