From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [RFC] re-queuing usx2y-fw
Date: Thu, 31 Mar 2005 13:58:48 +0200
Message-ID: <20050331115848.GA13462@tuba>
References: <20050328155151.GA3552@tuba> <s5hfyyeijh8.wl@alsa2.suse.de> <20050329165816.GA2696@tuba> <s5h7jjqidv3.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 7EECD240
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2005 13:58:15 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <s5h7jjqidv3.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 29, 2005 at 07:03:12PM +0200, Takashi Iwai wrote:
> At Tue, 29 Mar 2005 18:58:16 +0200,
> Martin Langer wrote:
> > 
> > On Tue, Mar 29, 2005 at 05:01:55PM +0200, Takashi Iwai wrote:
> > > At Mon, 28 Mar 2005 17:51:51 +0200,
> > > Martin Langer wrote:
> > > > 
> > > > The code still depends on as31 (8031/8051 
> > > > crosss-assembler) which still isn't available as .rpm or .deb, at least 
> > > > newer versions since 2.1. Should we care about it?
> > > 
> > > For convenience, we may include both the firmware source and binary in
> > > the CVS repository, so that one can install even without as31.
> > 
> > Yep. I will try to introduce a new configure option like 
> > '--enable-buildfw' for it, or any similar solution.
> 
> That'll be nice.

Here it is. The new configure option for alsa-firmware is called 
'--enable-buildfw'. If you want to build it from source you have to 
install one of the latest versions of as31, which you can find at

http://wiki.erazor-zone.de/doku.php?id=wiki:projects:linux:as31

(e.g. version 2.3.0 is fine)


martin

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usx2y-fw.patch"

--- ../alsa-firmware-1.0.8rc2/configure.in	2005-01-05 07:59:26.000000000 +0100
+++ configure.in	2005-03-31 12:18:12.186771056 +0200
@@ -13,9 +13,21 @@
 AC_ARG_ENABLE(hotplug,
   [  --disable-hotplug       Disable the hotplug fw loader support],
   [hotplug="$enableval"],[hotplug=yes])
+AC_ARG_ENABLE(buildfw,
+  [  --enable-buildfw        Enable building fw from source files],
+  [buildfw="$enableval"],[buildfw=no])
+
+AC_PATH_PROGS(AS31, as31)
+AS31_FLAGS="-Fhex"
+AC_SUBST(AS31_FLAGS)
+
+if test x"${AS31}" = x"";  then
+  buildfw=false
+fi
 
 AM_CONDITIONAL(USE_LOADER, test "$loader" = "yes")
 AM_CONDITIONAL(USE_HOTPLUG, test "$hotplug" = "yes")
+AM_CONDITIONAL(BUILD_FW, test "$buildfw" = "yes")
 
 AC_ARG_WITH(hotplug-dir,
   [  --with-hotplug-dir      Specify the hotplug firmware directory],
--- ../alsa-firmware-1.0.8rc2/usx2yloader/Makefile.am	2004-02-17 16:27:54.000000000 +0100
+++ usx2yloader/Makefile.am	2005-03-31 10:56:00.138556352 +0200
@@ -6,7 +6,15 @@
 		tascam_loader.ihx \
 		us122fw.ihx us224fw.ihx us428fw.ihx
 
-EXTRA_DIST = $(cfg_files)
+if BUILD_FW
+bin_SCRIPTS = tascam_loader
+tascam_loader: 
+	$(AS31) $(AS31_FLAGS) -s tascam_loader.asm > tascam_loader.ihx
+endif
+
+EXTRA_DIST = $(cfg_files) \
+	tascam_loader.asm \
+	an2131.asm
 
 firmwaredir = $(datadir)/alsa/firmware/$(MYNAME)
 firmware_DATA = $(cfg_files)
--- /dev/null	2005-03-31 12:13:37.935382568 +0200
+++ usx2yloader/an2131.asm	2004-06-10 21:57:32.000000000 +0200
@@ -0,0 +1,88 @@
+;
+;   Declaration of AN2131xx EZ-USB Registers
+;
+;
+;   Copyright (c) 2004	Martin Langer <martin-langer@gmx.de>
+;
+;
+;   This program is free software; you can redistribute it and/or
+;   modify it under the terms of the GNU General Public License
+;   as published by the Free Software Foundation; either version 2
+;   of the License, or any later version.
+;
+;   This program is distributed in the hope that it will be useful,
+;   but WITHOUT ANY WARRANTY; without even the implied warranty of
+;   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+;   GNU General Public License for more details.
+;
+;   You should have received a copy of the GNU General Public License
+;   along with this program; if not, write to the Free Software
+;   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+;
+;
+
+
+.equ DPL1,	0x84
+.equ DPH1,	0x85
+.equ DPS,	0x86		
+.equ CKCON,	0x8E
+.equ SPC_FNC,	0x8F
+.equ EXIF,	0x91
+.equ MPAGE,	0x92
+.equ SCON0,	0x98
+.equ SBUF0,	0x99
+.equ SCON1,	0xC0
+.equ SBUF1,	0xC1
+.equ EICON,	0xD8
+.equ EIE,	0xE8		; Interrupt Enables
+.equ EIP,	0xF8
+
+
+.equ OUT1BUF,	0x7E40
+.equ IN1BUF,	0x7E80
+.equ OUT0BUF,	0x7EC0
+.equ IN0BUF,	0x7F00
+.equ CPUCS,     0x7F92	
+.equ PORTACFG, 	0x7F93
+.equ PORTBCFG, 	0x7F94
+.equ PORTCCFG, 	0x7F95
+.equ OUTA,     	0x7F96	
+.equ OUTB,     	0x7F97
+.equ OUTC,     	0x7F98
+.equ PINSA,    	0x7F99
+.equ PINSB,    	0x7F9A
+.equ PINSC,    	0x7F9B
+.equ OEA,      	0x7F9C
+.equ OEB,      	0x7F9D
+.equ OEC,      	0x7F9E
+
+.equ I2CS,	0x7FA5		; I2C Control and Status
+.equ I2DAT,	0x7FA6		; I2C Data
+
+.equ IN07IRQ,	0x7FA9		; EP IN Interrupt Request
+.equ OUT07IRQ,	0x7FAA		; EP OUT Interrupt Request
+.equ USBIRQ,	0x7FAB		; USB Interrupt Request
+.equ USBIEN,	0x7FAE		; USB Interrupt Enables
+.equ USBBAV,	0x7FAF		; Breakpoint and Autovector
+.equ EP0CS,	0x7FB4		; Control and Status
+.equ IN0BC,	0x7FB5		; Byte Count
+.equ IN1CS,	0x7FB6
+.equ IN1BC,	0x7FB7
+.equ OUT0BC,	0x7FC5		; Byte Count
+.equ OUT1CS,	0x7FC6
+.equ OUT1BC,	0x7FC7
+.equ USBCS,	0x7FD6		; USB Control and Status
+.equ SD_BMREQ,	0x7FE8		; Setup Data Byte 1: bmRequest 
+					; c0: Vendor Request 'In'
+					; 40: Vendor Request 'Out'
+.equ SD_BREQ,	0x7FE9		; Setup Data Byte 2: bRequest
+					; a0: Internal Firmware Load
+					; a3: External Firmware Load ?
+.equ SD_VALL,	0x7FEA		; Setup Data Byte 3: Starting address (lo)
+.equ SD_VALH,	0x7FEB		; Setup Data Byte 4: Starting address (hi)
+.equ SD_INDL,	0x7FEC		; Setup Data Byte 5: 0x00
+.equ SD_INDH,	0x7FED		; Setup Data Byte 6: 0x00
+.equ SD_LENL,	0x7FEE		; Setup Data Byte 7: Number of Bytes (lo)
+.equ SD_LENH,	0x7FEF		; Setup Data Byte 8: Number of Bytes (hi)
+
+;;
--- /dev/null	2005-03-31 12:13:37.935382568 +0200
+++ usx2yloader/tascam_loader.asm	2005-03-31 13:31:32.765781360 +0200
@@ -0,0 +1,266 @@
+;
+;   Second stage AN2131QC (aka EzUSB) loader
+;
+;	
+;   Copyright (c) 2004-2005 Martin Langer <martin-langer@gmx.de>
+;
+;   Written for Tascam US-122/US-224/US-428 audio/MIDI devices
+;
+;   This program is free software; you can redistribute it and/or
+;   modify it under the terms of the GNU General Public License
+;   as published by the Free Software Foundation; either version 2
+;   of the License, or any later version.
+;
+;   This program is distributed in the hope that it will be useful,
+;   but WITHOUT ANY WARRANTY; without even the implied warranty of
+;   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+;   GNU General Public License for more details.
+;
+;   You should have received a copy of the GNU General Public License
+;   along with this program; if not, write to the Free Software
+;   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+;
+;
+
+.inc	"an2131.asm"
+
+
+; ====================================================== interrupt vectors ===
+
+	.org	0x0000			; reset vector
+	ljmp    init
+
+	.org	0x0043			; int2 vector (USB)
+	ljmp	usb_jump_table		; autovector will replace byte 45
+
+
+; =================================================================== init ===
+
+init:
+	mov	sp, #20h		; move stack pointer to 0x20
+
+	mov	a, EIE
+	setb	acc.0			; enable int2 (USB Interrupt)
+	mov	EIE, a
+	
+	mov	dptr, #USBIRQ
+	mov	a, #00011111b
+	movx	@dptr, a		; clear Interrupt Request
+
+	mov	dptr, #IN07IRQ
+	mov	a, #11111111b
+	movx	@dptr, a		; clear EP IN Interrupt Request
+
+	mov	dptr, #OUT07IRQ
+	mov	a, #11111111b
+	movx	@dptr, a		; clear EP OUT Interrupt Request
+
+	mov	dptr, #PORTCCFG
+	movx	a, @dptr
+	orl	a, #11000000b		; allow read and write on Port C
+	movx	@dptr, a
+
+	mov	dptr, #USBBAV
+	movx	a, @dptr
+	orl	a, #00000001b		; enable Autovector feature
+	movx	@dptr, a
+
+	mov	dptr, #USBIEN
+	movx	a, @dptr
+	orl	a, #00000101b		; enable 'Setup Data Available
+	movx    @dptr, a		; Interrupt Request' and 'Setup Token
+					; Interrupt Request'
+
+	setb	ea			; enable global 8051 Interrupts
+
+loop:
+	sjmp	loop
+
+
+; ========================================= usb interrupt service routines ===
+
+usb_jump_table:
+	ljmp	setup_data_avail_isr	; setup data available 
+	.db	0		
+	ljmp	start_of_frame_isr	; Start of frame
+	.db	0
+	ljmp	setup_token_isr		; loading setup data
+	.db	0
+	ljmp	usb_suspend_isr		; USB suspend
+	.db	0
+	ljmp	usb_reset_isr		; USB reset
+	.db	0
+	ljmp	spare_isr
+	.db	0
+	ljmp	ep0_in_isr
+	.db	0
+	ljmp	ep0_out_isr
+	.db	0
+	ljmp	ep1_in_isr
+	.db	0
+	ljmp	ep1_out_isr
+	.db	0
+	ljmp	ep2_in_isr
+	.db	0
+	ljmp	ep2_out_isr
+	.db	0
+	ljmp	ep3_in_isr
+	.db	0
+	ljmp	ep3_out_isr
+	.db	0
+	ljmp	ep4_in_isr
+	.db	0
+	ljmp	ep4_out_isr
+	.db	0
+	ljmp	ep5_in_isr
+	.db	0
+	ljmp	ep5_out_isr
+	.db	0
+	ljmp	ep6_in_isr
+	.db	0
+	ljmp	ep6_out_isr
+	.db	0
+	ljmp	ep7_in_isr
+	.db	0
+	ljmp	ep7_out_isr
+	.db	0
+
+setup_data_avail_isr:
+	push	acc
+	push	dph
+	push	dpl
+	push	dph1
+	push	dpl1
+	push	dps
+	mov	a, EXIF
+	clr	acc.4			; clear USB Interrupt Request
+	mov	EXIF, a
+	mov	dptr, #USBIRQ
+	mov	a, #00000001b		; Setup Data Avail. Interrupt Request
+	movx	@dptr, a
+	pop	dps
+	pop	dpl1
+	pop	dph1
+	pop	dpl
+	pop	dph
+	pop	acc
+	reti
+
+start_of_frame_isr:
+	push	acc
+	push	dph
+	push	dpl
+	push	dph1
+	push	dpl1
+	push	dps
+	mov	a, EXIF
+	clr	acc.4			; clear USB Interrupt Request
+	mov	EXIF, a
+	mov	dptr, #USBIRQ
+	mov	a, #00000010b		; Start of frame Interrupt Request
+	movx	@dptr, a
+	pop	dps
+	pop	dpl1
+	pop	dph1
+	pop	dpl
+	pop	dph
+	pop	acc
+	reti
+
+setup_token_isr:
+	push	acc
+	push	dph
+	push	dpl
+	push	dph1
+	push	dpl1
+	push	dps
+	mov	a, EXIF
+	clr	acc.4			; clear USB Interrupt Request
+	mov	EXIF, a
+	mov	dptr, #USBIRQ
+	mov	a, #00000100b		; Setup Token Interrupt Request
+	movx	@dptr, a
+	pop	dps
+	pop	dpl1
+	pop	dph1
+	pop	dpl
+	pop	dph
+	pop	acc
+	reti
+
+usb_suspend_isr:
+	push	acc
+	push	dph
+	push	dpl
+	push	dph1
+	push	dpl1
+	push	dps
+	mov	a, EXIF
+	clr	acc.4			; clear USB Interrupt Request
+	mov	EXIF, a
+	mov	dptr, #USBIRQ
+	mov	a, #00001000b		; USB Suspend Interrupt Request
+	movx	@dptr, a
+	pop	dps
+	pop	dpl1
+	pop	dph1
+	pop	dpl
+	pop	dph
+	pop	acc
+	reti
+
+usb_reset_isr:
+	push	acc
+	push	dph
+	push	dpl
+	push	dph1
+	push	dpl1
+	push	dps
+	mov	a, EXIF
+	clr	acc.4			; clear USB Interrupt Request
+	mov	EXIF, a
+	mov	dptr, #USBIRQ
+	mov	a, #00010000b		; USB Reset Interrupt Request
+	movx	@dptr, a
+	pop	dps
+	pop	dpl1
+	pop	dph1
+	pop	dpl
+	pop	dph
+	pop	acc
+	reti
+	
+spare_isr:
+	reti
+ep0_in_isr:
+	reti
+ep0_out_isr:
+	reti
+ep1_in_isr:
+	reti
+ep1_out_isr:
+	reti
+ep2_in_isr:
+	reti
+ep2_out_isr:
+	reti
+ep3_in_isr:
+	reti
+ep3_out_isr:
+	reti
+ep4_in_isr:
+	reti
+ep4_out_isr:
+	reti
+ep5_in_isr:
+	reti
+ep5_out_isr:
+	reti
+ep6_in_isr:
+	reti
+ep6_out_isr:
+	reti
+ep7_in_isr:
+	reti
+ep7_out_isr:
+	reti

--zYM0uCDKw75PZbzx--


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
