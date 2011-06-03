From: sdaau <sd-0eUWFqAKQRd/SzgSGea1oA@public.gmane.org>
Subject: Re: AudioArduino - an ALSA soundcard driver for FTDI-based Arduinos
Date: Fri, 03 Jun 2011 20:22:37 +0200
Message-ID: <4DE9266D.70503@imi.aau.dk>
References: <4DE31FE4.4040807@imi.aau.dk> <20110530074204.GA7806@kroah.com> <4DE3B7B4.8000805@imi.aau.dk> <20110603053728.GA20937@kroah.com>
Reply-To: sd-0eUWFqAKQRd/SzgSGea1oA@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040206040602070901080001"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110603053728.GA20937-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Caleb Crome <caleb-EebDDntmC0DYtjvyW6yDsg@public.gmane.org>, sboyce-QgLWrMLu8clzjhtm8Ag3mw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040206040602070901080001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Missed a couple of replies, so I'll try to answer everything now... We 
may be going slightly off topic as far as both linux-usb and alsa-devel 
are concerned - I hope the respective communities won't mind :)

On 2011-05-30 23:15, Sid Boyce wrote:
>>
>> Thanks, just wondered. With many SDR (Software Define Radio) project we
>> are constantly on the lookout for higher performance cards that are not
>> bandwidth restricted.
>>
>> There are many interesting projects out there using arduino, good luck.
>> I've got a Teensy++ 2.0 on the way to have a play with.
>> Regards
>> Sid.
>>

Hah - I noticed the signature, but I didn't really see the connection, 
until you clarified about SDR! :) Thanks for the note, and the reference 
to Teensy (have been hearing about that lately, but haven't had the time 
to look deeper)...




On 2011-06-03 07:37, Greg KH wrote:
> [snip]
>>
>> I've just posted a diff on the SVN repository between the current
>> ftdi_sio-audard.c and the original ftdi_sio.c from kernel 2.6.32:
>>
>> http://sdaaubckp.svn.sourceforge.net/viewvc/sdaaubckp/audard/snd_ftdi_audard-an8m/sio2.6.32-audard.diff?revision=211&view=markup
>>
>> ... the link should show syntax coloring, so it maybe gets easier to
>> see what's going on there.
>
> Care to email it?  That way we can review it here and see how to
> structure it.
>

Of course! I am aware that people exchange patches on mailing lists, but 
unfortunately I don't have much experience with it. So I just attached 
the above-mentioned diff file here...

If needed, I will attach all other relevant files in plain text - let me 
know.


>> [snip]
>> However, if there is some sort of a tutorial/guide (or even a
>> specific existing driver file example) that I could refer to, so as
>> to turn the current architecture into an option-based one, such that
>> I avoid messing with ftdi_sio.c directly -- I'd definitely love to
>> try and do that; so please let me know if there is some sort of a
>> recommended reading for this.
>
> I don't think there is a "tutorial" for something like this, but we
> would be glad to help you out here to do this.
>
> So, care to post the code here?
>

Sure - and just in case, I've attached the other relevant file, 
snd_ftdi_audard.h (which becomes included by the ftdi_sio == 
ftdi_sio-audard.c after its patched); let me know if I should attach the 
other files too (there is the code for the Arduino too, and also 
ftdi_sio.h and ftdi_sio_ids.h, but those are used verbatim - and a 
Makefile too).




On 2011-05-30 23:51, Caleb Crome wrote:
>> FYI, if you can raise the PWM rate on the arduino output, you can use
>> modulation tricks to increase the resolution.

On the Arduino Duemillanove , there is 16 MHz clock and ATmega328 - as 
far as I could gather, the highest possible PWM frequency there is 62.5 
kHz (in Fast PWM mode - achievable by setting the correct prescalers).


>> There are a lot of
>> limitations here, but there is probably some degree of improvement possible.
>>   Virtually all modern codecs do this to the extreme -- they sample really
>> fast, like 12 MHz, but only use 1 bit of resolution.  Modern 24-bit codecs
>> are really only 1 bit on the business end, but really fast.  Search for
>> delta-sigma or sigma-delta modulators if you're not familiar.
>>

Thanks for the reference - I've studied delta-sigma waay back, and 
forgotten most of that; however, even then I haven't quite made the 
connection to what is referred to as 1-bit; so thanks for this, 
certainly something to read up on! As a side note, the ATmega328 on the 
sampling side, if I recall correctly, has a successive-approximation ADC 
built in (plus a multiplexer in front of it, to provide for multiple 
analog channels)...


>> If you can transmit, say, 10 bits and run your sample rate at ~4x your
>> intended rate, you can probably get about 10-bits of resolution on the
>> output.

Interesting - I'm not sure if I understand that statement correctly: in 
this case, an output compare (OC) unit of an 8-bit timer/counter of the 
Arduino's ATMega328 is used to produce PWM output; and since I by 
default can only write 8-bit values there in the microcontroller code, I 
have a hard time seeing how I could squeeze out 10 bits on output in 
that context; but maybe you had a different context in mind?


>> It requires a lowpass (antialiasing) filter though -- which gets
>> really nasty at sample rates below 40khz -- because then they need to be
>> sharp so you don't hear the aliasing.

Heh, this is where I got surprised :)

I too expected that at least I would hear some high-frequency "buzz" due 
to the 'hard edges' of the PWM signal - which would assume that I don't 
have a low pass filter which is sharp enough, as you state. But the 
surprising bit for me was that I could just stick this 62.5 kHz 
(carrying a 44.1 kHz data) PWM signal raw in a loudspeaker - and I can 
*not* hear a high-frequency "buzz" that I expected :) Obviously, the 
loudspeaker itself performs low pass filtering - I just thought 
originally it would not be sharp enough :)


>> Modern codecs manage this by shoving
>> all the aliasing noise up at a few MHz, so a simple RC filter is enough to
>> eliminate aliasing issues.  And not even necessary if driving
>> speakers/headphones directly.
>>

Thanks for mentioning this too - I have often heard about the technique 
of "pushing aliasing noise up to MHz", however, still do not understand 
it practically yet. And interesting that you state it is "not necessary" 
for speakers/headphones - I'd agree with that (based on my above 
experience), but I wander if that is mainly due to the mechanical 
inertia of the loudspeaker membrane - or because of presence of 
coil/inductor?


>> Anyway, 9-bits is going to be much better than 8, so if you can run the
>> arduino at 88.2k, you could probably get roughly 9 bits of resolution.
>>   You'd probably do the upsampling on the linux side -- since the AVR is not
>> exactly bursting with MIPS.
>>

I could send a data stream at 88.2 kHz, and there would be available 
data bandwidth too - however, since I have only an 8-bit timer/counter 
OC as a PWM generator, I still cannot see how I could get 9-bit 
resolution out of that. Maybe you imply some technique - like, I don't 
know - padding the 9-bit value to 16-bit, and then reproduce the MSB and 
LSB of this 16-bit value in rapid succession on the 8-bit PWM (though 
I'm just saying this off top of my head, this rapid succession thing 
would probably not work at all)?


>> Hmmm, or another idea:  what if you use 2 PWM channels and mix the outputs
>> together with an op-amp?
>> You could potentially get much improved resolution that way.  Basically, use
>> a summing node on your op-amp with one signal at unity, and the other signal
>> at 1/256*unity.

Heh, that's exactly what I was thinking too :) (I think its mentioned 
very briefly in the end of the paper) - basically, one 8-bit PWM 
reproduces the MSB of the 16-bit sample; and the other PWM reproduces 
the LSB of this 16-bit simple, and they are appropriately mixed in the 
analog domain. However, as you say:

>> I doubt that you'd ever get near 96 dB SNR (the ideal for
>> 16-bits), but you'd probably do better than 1 channel PWM at 8-bits could do
>> (theoretical best is 48 dB).
>>

... yes, I too was asking myself whether the gains of reproducing 16-bit 
would not be offset by noise, added in the process of analog mixing of 
8-bit MSB and LSB analog values separately (which is, I believe, the 
same that you are saying; however, I have not yet the context to learn 
working with dB as measure of SNR properly).


>> Of course, if you're going through the trouble to add an op-amp, you might
>> as well skip the arduino all together and put a USB<->  audio chip in. :-)
>>

Heh, indeed :) However, the point of this whole exercise was to have a 
complete overview of a sound card as system (including the PC).

For instance, before this, I've always had the misconception that when, 
say, Audacity plays a file, it sends the value for each sample (say, 
16-bit) one-by-one to the soundcard, and so the soundcard plays back the 
samples one-by-one. And that is not what happens: ALSA does its own 
chunking, then USB does its own chunking - which means that, at least 
for playback, as a code for the device (soundcard) you better be storing 
those incoming bursts of data in an array somewhere, and *then* 
reproduce sample-by-sample (from the stored data) at the requested 
reproduction rate.

Of course, in such a system, one needs to think about the analog domain 
as well - I tried to document a simple board, that would take the 
AudioArduino as is, and try to provide an analog line in/out interface 
to it with the simplest approaches (e.g. a discrete ramp-and-hold 
circuit, to convert the PWM signal to analog voltage levels); however, 
all I could conclude was that simple approaches actually produce 
slightly worse results (than just having the AudioArduino PWM out going 
directly into a speaker).


Cheers!



--------------040206040602070901080001
Content-Type: text/x-patch;
 name="sio2.6.32-audard.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sio2.6.32-audard.diff"

--- ftdi_sio-2.6.32.c	2011-05-30 16:47:50.777015768 +0200
+++ ftdi_sio-audard.c	2011-05-30 16:21:10.013078023 +0200
@@ -1,5 +1,6 @@
 /*
- * USB FTDI SIO driver
+ * USB FTDI SIO driver - 'AudioArduino' modification (using snd_ftdi_audard.h)
+ * modification 2010 by sdaau (sd@{imi,create}.aau.dk)
  *
  *	Copyright (C) 1999 - 2001
  *	    Greg Kroah-Hartman (greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org)
@@ -29,6 +30,16 @@
 /* Thanx to gkh and the rest of the usb dev group for all code I have
    assimilated :-) */
 
+/*
+NOTE: this driver code is set up to compile for kernel 2.6.32 (as on Ubuntu Lucid)
+
+If you want to compile it for kernel 2.6.38 (as on Ubuntu Natty), please
+look for comments containing '2.6.38' below, and modify the code accordingly.
+
+Note that for 2.6.38, this code will generate quite a few warnings, but the driver should still work.
+*/
+
+
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -49,16 +60,24 @@
 /*
  * Version Information
  */
-#define DRIVER_VERSION "v1.5.0"
-#define DRIVER_AUTHOR "Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Bill Ryder <bryder-sJ/iWh9BUns@public.gmane.org>, Kuba Ober <kuba-6OO/Rnbgvk2D7HvB/+pQRQ@public.gmane.org>, Andreas Mohr"
-#define DRIVER_DESC "USB FTDI Serial Converters Driver"
+#define DRIVER_VERSION "v1.5.0audard"
+#define DRIVER_AUTHOR "Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Bill Ryder <bryder-sJ/iWh9BUns@public.gmane.org>, Kuba Ober <kuba-6OO/Rnbgvk2D7HvB/+pQRQ@public.gmane.org>, Andreas Mohr, sdaau <sd@{imi,create}.aau.dk>"
+#define DRIVER_DESC "Audio Arduino - USB FTDI Serial Converters Driver"
+
+//"ftdi_sio"
+#define DRVNAME "ftdi_sio_audard"
+//"FTDI USB Serial Device"
+#define SIODEVDESC "Audio Arduino FTDI USB Serial Device"
 
 static int debug;
 static __u16 vendor = FTDI_VID;
 static __u16 product;
 
+struct audard_device; //forward declare, for struct ftdi_private
+
 struct ftdi_private {
 	struct kref kref;
+	struct audard_device *audev; // pointer to audard, added
 	ftdi_chip_type_t chip_type;
 				/* type of device, either SIO or FT8U232AM */
 	int baud_base;		/* baud base clock for divisor setting */
@@ -94,6 +113,7 @@
 	unsigned short max_packet_size;
 };
 
+
 /* struct ftdi_sio_quirk is used by devices requiring special attention. */
 struct ftdi_sio_quirk {
 	int (*probe)(struct usb_serial *);
@@ -162,9 +182,6 @@
 	{ USB_DEVICE(FTDI_VID, FTDI_SCS_DEVICE_5_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_SCS_DEVICE_6_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_SCS_DEVICE_7_PID) },
-	{ USB_DEVICE(FTDI_VID, FTDI_USINT_CAT_PID) },
-	{ USB_DEVICE(FTDI_VID, FTDI_USINT_WKEY_PID) },
-	{ USB_DEVICE(FTDI_VID, FTDI_USINT_RS232_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_ACTZWAVE_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_IRTRANS_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_IPLUS_PID) },
@@ -182,11 +199,9 @@
 	{ USB_DEVICE(FTDI_VID, FTDI_OPENDCC_SNIFFER_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_OPENDCC_THROTTLE_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_OPENDCC_GATEWAY_PID) },
-	{ USB_DEVICE(FTDI_VID, FTDI_OPENDCC_GBM_PID) },
 	{ USB_DEVICE(INTERBIOMETRICS_VID, INTERBIOMETRICS_IOBOARD_PID) },
 	{ USB_DEVICE(INTERBIOMETRICS_VID, INTERBIOMETRICS_MINI_IOBOARD_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_SPROG_II) },
-	{ USB_DEVICE(FTDI_VID, FTDI_LENZ_LIUSB_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_XF_632_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_XF_634_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_XF_547_PID) },
@@ -206,7 +221,6 @@
 	{ USB_DEVICE(FTDI_VID, FTDI_MTXORB_5_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_MTXORB_6_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_R2000KU_TRUE_RNG) },
-	{ USB_DEVICE(FTDI_VID, FTDI_VARDAAN_PID) },
 	{ USB_DEVICE(MTXORB_VID, MTXORB_FTDI_RANGE_0100_PID) },
 	{ USB_DEVICE(MTXORB_VID, MTXORB_FTDI_RANGE_0101_PID) },
 	{ USB_DEVICE(MTXORB_VID, MTXORB_FTDI_RANGE_0102_PID) },
@@ -682,6 +696,7 @@
 	{ USB_DEVICE(FTDI_VID, FTDI_RRCIRKITS_LOCOBUFFER_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_ASK_RDR400_PID) },
 	{ USB_DEVICE(ICOM_ID1_VID, ICOM_ID1_PID) },
+	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_TMU_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_ACG_HFDUAL_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_YEI_SERVOCENTER31_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_THORLABS_PID) },
@@ -702,8 +717,6 @@
 	{ USB_DEVICE(FTDI_VID, FTDI_NDI_AURORA_SCU_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_NDI_device_quirk },
 	{ USB_DEVICE(TELLDUS_VID, TELLDUS_TELLSTICK_PID) },
-	{ USB_DEVICE(RTSYSTEMS_VID, RTSYSTEMS_SERIAL_VX7_PID) },
-	{ USB_DEVICE(RTSYSTEMS_VID, RTSYSTEMS_CT29B_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_MAXSTREAM_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_PHI_FISCO_PID) },
 	{ USB_DEVICE(TML_VID, TML_USB_SERIAL_PID) },
@@ -723,37 +736,8 @@
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
 	{ USB_DEVICE(RATOC_VENDOR_ID, RATOC_PRODUCT_ID_USB60F) },
 	{ USB_DEVICE(FTDI_VID, FTDI_REU_TINY_PID) },
-
-	/* Papouch devices based on FTDI chip */
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_SB485_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_AP485_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_SB422_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_SB485_2_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_AP485_2_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_SB422_2_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_SB485S_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_SB485C_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_LEC_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_SB232_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_TMU_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_IRAMP_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_DRAK5_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_QUIDO8x8_PID) },
 	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_QUIDO4x4_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_QUIDO2x2_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_QUIDO10x1_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_QUIDO30x3_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_QUIDO60x3_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_QUIDO2x16_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_QUIDO3x32_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_DRAK6_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_UPSUSB_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_MU_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_SIMUKEY_PID) },
 	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_AD4USB_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_GMUX_PID) },
-	{ USB_DEVICE(PAPOUCH_VID, PAPOUCH_GMSR_PID) },
-
 	{ USB_DEVICE(FTDI_VID, FTDI_DOMINTELL_DGQG_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_DOMINTELL_DUSB_PID) },
 	{ USB_DEVICE(ALTI2_VID, ALTI2_N3_PID) },
@@ -779,32 +763,6 @@
 	{ USB_DEVICE(FTDI_VID, MJSG_SR_RADIO_PID) },
 	{ USB_DEVICE(FTDI_VID, MJSG_HD_RADIO_PID) },
 	{ USB_DEVICE(FTDI_VID, MJSG_XM_RADIO_PID) },
-	{ USB_DEVICE(FTDI_VID, XVERVE_SIGNALYZER_ST_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, XVERVE_SIGNALYZER_SLITE_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, XVERVE_SIGNALYZER_SH2_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, XVERVE_SIGNALYZER_SH4_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, SEGWAY_RMP200_PID) },
-	{ USB_DEVICE(FTDI_VID, ACCESIO_COM4SM_PID) },
-	{ USB_DEVICE(IONICS_VID, IONICS_PLUGCOMPUTER_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, FTDI_CHAMSYS_24_MASTER_WING_PID) },
-	{ USB_DEVICE(FTDI_VID, FTDI_CHAMSYS_PC_WING_PID) },
-	{ USB_DEVICE(FTDI_VID, FTDI_CHAMSYS_USB_DMX_PID) },
-	{ USB_DEVICE(FTDI_VID, FTDI_CHAMSYS_MIDI_TIMECODE_PID) },
-	{ USB_DEVICE(FTDI_VID, FTDI_CHAMSYS_MINI_WING_PID) },
-	{ USB_DEVICE(FTDI_VID, FTDI_CHAMSYS_MAXI_WING_PID) },
-	{ USB_DEVICE(FTDI_VID, FTDI_CHAMSYS_MEDIA_WING_PID) },
-	{ USB_DEVICE(FTDI_VID, FTDI_CHAMSYS_WING_PID) },
-	{ USB_DEVICE(FTDI_VID, FTDI_SCIENCESCOPE_LOGBOOKML_PID) },
-	{ USB_DEVICE(FTDI_VID, FTDI_SCIENCESCOPE_LS_LOGBOOK_PID) },
-	{ USB_DEVICE(FTDI_VID, FTDI_SCIENCESCOPE_HS_LOGBOOK_PID) },
-	{ USB_DEVICE(FTDI_VID, FTDI_DOTEC_PID) },
-	{ USB_DEVICE(QIHARDWARE_VID, MILKYMISTONE_JTAGSERIAL_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
 	{ },					/* Optional parameter entry */
 	{ }					/* Terminating entry */
 };
@@ -812,7 +770,7 @@
 MODULE_DEVICE_TABLE(usb, id_table_combined);
 
 static struct usb_driver ftdi_driver = {
-	.name =		"ftdi_sio",
+	.name =		DRVNAME, //"ftdi_sio",
 	.probe =	usb_serial_probe,
 	.disconnect =	usb_serial_disconnect,
 	.id_table =	id_table_combined,
@@ -877,9 +835,9 @@
 static struct usb_serial_driver ftdi_sio_device = {
 	.driver = {
 		.owner =	THIS_MODULE,
-		.name =		"ftdi_sio",
+		.name =		DRVNAME, //"ftdi_sio",
 	},
-	.description =		"FTDI USB Serial Device",
+	.description =		SIODEVDESC, //"FTDI USB Serial Device",
 	.usb_driver = 		&ftdi_driver ,
 	.id_table =		id_table_combined,
 	.num_ports =		1,
@@ -903,6 +861,8 @@
 	.break_ctl =		ftdi_break_ctl,
 };
 
+/* include sound related defines here - ftdi_private and ftdi_driver and ftdi_open must be known! */
+#include "snd_ftdi_audard.h"
 
 #define WDR_TIMEOUT 5000 /* default urb timeout */
 #define WDR_SHORT_TIMEOUT 1000	/* shorter urb timeout */
@@ -1459,7 +1419,7 @@
 	}
 
 	/* set max packet size based on descriptor */
-	priv->max_packet_size = le16_to_cpu(ep_desc->wMaxPacketSize);
+	priv->max_packet_size = ep_desc->wMaxPacketSize;
 
 	dev_info(&udev->dev, "Setting MaxPacketSize %d\n", priv->max_packet_size);
 }
@@ -1590,6 +1550,8 @@
 {
 	struct ftdi_sio_quirk *quirk =
 				(struct ftdi_sio_quirk *)id->driver_info;
+	int ret; //added
+	//struct usb_device *udev = serial->dev; //added
 
 	if (quirk && quirk->probe) {
 		int ret = quirk->probe(serial);
@@ -1599,6 +1561,25 @@
 
 	usb_set_serial_data(serial, (void *)id->driver_info);
 
+	// * end of ftdi_sio_probe - call audio _probe here
+
+	// **note: here we don't have a ref to ftdi_private;
+	// ** ftdi_private seems to get allocated per serial port
+	// ** but, we don't (necesarilly) want one soundcard per port!
+	// ** yet, from here we cannot attach a struct pointer to anything..
+	// **  (i.e. usb_serial, usb_device are already predefined)
+	// ** so calling without args here - store card to static var
+	// ** and: audard_probe also allocates PCM substreams
+	// (we will now need 2 substreams (playback/capture) per serial port)
+
+	// ** finally, only ftdi_private remains unknown,
+	// ** which will be set afterwards in _port_probe: audard_probe_fpriv
+	/*struct ftdi_private *priv = usb_get_serial_port_data(port);
+	struct usb_serial *serial = port->serial;
+	struct usb_device *udev = serial->dev;*/
+
+	ret = audard_probe(serial);
+
 	return 0;
 }
 
@@ -1607,6 +1588,7 @@
 	struct ftdi_private *priv;
 	struct ftdi_sio_quirk *quirk = usb_get_serial_data(port->serial);
 
+	int ret; //added
 
 	dbg("%s", __func__);
 
@@ -1655,6 +1637,10 @@
 	ftdi_set_max_packet_size(port);
 	read_latency_timer(port);
 	create_sysfs_attrs(port);
+
+	// ** end of ftdi_sio_port_probe - try audard_probe_fpriv here
+	// we need to set priv somehow, which is only now known..
+	ret = audard_probe_fpriv(priv);
 	return 0;
 }
 
@@ -1768,6 +1754,11 @@
 
 	dbg("%s", __func__);
 
+	// remove the soundcard here - even though
+	// it is added on _probe (not on _port_probe)
+	// but this should react on hot-unplug..
+	audard_remove();
+
 	remove_sysfs_attrs(port);
 
 	kref_put(&priv->kref, ftdi_sio_priv_release);
@@ -1799,12 +1790,22 @@
 { /* ftdi_open */
 	struct usb_device *dev = port->serial->dev;
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	struct audard_device *mydev = priv->audev;
 	unsigned long flags;
 
 	int result = 0;
 	char buf[1]; /* Needed for the usb_control_msg I think */
 
-	dbg("%s", __func__);
+	dbg("%s: %p-%p %p/%d", __func__, priv->audev, mydev, mydev->isSerportOpen, mydev->isSerportOpen);
+
+	/** If the port has already been open (i.e. audard), then skip the  */
+	/** rest of the opening procedure, change nothing - and report success */
+	/** isSerportOpen now counter - allow real open only if 0 */
+	if (mydev->isSerportOpen) {
+		mydev->isSerportOpen += 1; // we're already open - increment
+		dbg2("%s - %d: skipping", __func__, mydev->isSerportOpen);
+		return 0;
+	}
 
 	spin_lock_irqsave(&priv->tx_lock, flags);
 	priv->tx_bytes = 0;
@@ -1838,6 +1839,9 @@
 	if (!result)
 		kref_get(&priv->kref);
 
+	/** If we got here, all is fine, so let's lecord that port has been open in audard */
+	mydev->isSerportOpen = 1;
+
 	return result;
 } /* ftdi_open */
 
@@ -1878,8 +1882,22 @@
 static void ftdi_close(struct usb_serial_port *port)
 { /* ftdi_close */
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
+	struct audard_device *mydev = priv->audev;
 
-	dbg("%s", __func__);
+	//~ dbg("%s", __func__);
+	dbg("%s: %p-%p %p/%d", __func__, priv->audev, mydev, mydev->isSerportOpen, mydev->isSerportOpen);
+
+	/** make sure audard_device 'open serport' flag is reset */
+	/** but now isSerportOpen is not bool, but counter */
+	/** so decrement - and do real close ONLY if it ends at zero */
+	/** (this to make sure audio ops (i.e. `Audacity`) and cmdline ops (i.e. `cat`) can interact) */
+	if (mydev->isSerportOpen > 0)
+		mydev->isSerportOpen -= 1;
+
+	if (mydev->isSerportOpen) { // is it still not zero?
+		dbg2("%s - %d: skipping", __func__, mydev->isSerportOpen);
+		return; // don't do close - exit in that case
+	}
 
 	/* shutdown our bulk read */
 	usb_kill_urb(port->read_urb);
@@ -2111,7 +2129,7 @@
 	char flag;
 	char *ch;
 
-	dbg("%s - port %d", __func__, port->number);
+	dbg3("%s - port %d: %d; r:%d", __func__, port->number, len, priv->audev->running);
 
 	if (len < 2) {
 		dbg("malformed packet");
@@ -2128,6 +2146,7 @@
 		priv->prev_status = status;
 	}
 
+	dbg3("+ len: %d; packet: '%s';", len, packet);
 	/*
 	 * Although the device uses a bitmask and hence can have multiple
 	 * errors on a packet - the order here sets the priority the error is
@@ -2157,11 +2176,24 @@
 		return 0;	/* status only */
 	ch = packet + 2;
 
-	if (!(port->console && port->sysrq) && flag == TTY_NORMAL)
+	// check first for audio processing - and leave tty afterwards ?!
+	if (priv->audev->running) {
+		audard_xfer_buf(priv->audev, ch, len);
+		// but also, tty could be null here - handle it:
+		// meaning, return so we don't kernel panic
+		// at the tty_insert_flip_string afterwards.
+		if (!tty) return len;
+	}
+
+	// note:  port->console for kernel 2.6.32 (lucid)
+  //        port->port.console for kernel 2.6.38 (natty)
+	if (!(port->console && port->sysrq) && flag == TTY_NORMAL) // kernel 2.6.32 (lucid)
+	//~ if (!(port->port.console && port->sysrq) && flag == TTY_NORMAL) // kernel 2.6.38 (natty)
 		tty_insert_flip_string(tty, ch, len);
 	else {
 		for (i = 0; i < len; i++, ch++) {
-			if (!usb_serial_handle_sysrq_char(tty, port, *ch))
+			if (!usb_serial_handle_sysrq_char(tty, port, *ch)) // for kernel 2.6.32 (lucid)
+			//~ if (!usb_serial_handle_sysrq_char(port, *ch)) // for kernel 2.6.38 (natty)
 				tty_insert_flip_char(tty, *ch, flag);
 		}
 	}
@@ -2178,8 +2210,25 @@
 	int len;
 	int count = 0;
 
+	// check if we are running audio processing
+	// - if so, process accordingly (as below, to keep all counts)
+	//~ if (priv->audev->running) {
+
+		//~ for (i = 0; i < urb->actual_length; i += priv->max_packet_size) {
+			//~ len = min_t(int, urb->actual_length - i, priv->max_packet_size);
+			//~ count += ftdi_process_packet(tty, port, priv, &data[i], len);
+		//~ }
+
+		//~ // since we're returning void, just return here
+		//~ // (have it commented, to leave the tty engine running in 'parallel')
+		//~ // return;
+	//~ }
+	// naah - for parallel, we try a bit different: && (!priv->audev->running)
+	// return early only if BOTH no tty AND no audio running
+	// and then handle in ftdi_process_packet
+
 	tty = tty_port_tty_get(&port->port);
-	if (!tty)
+	if ( (!tty) && (!priv->audev->running) )
 		return;
 
 	for (i = 0; i < urb->actual_length; i += priv->max_packet_size) {
@@ -2187,6 +2236,10 @@
 		count += ftdi_process_packet(tty, port, priv, &data[i], len);
 	}
 
+	// here we could have 'count', but tty could be NULL (if it is just audio);
+	// handle that:
+	if (!tty) return;
+
 	if (count)
 		tty_flip_buffer_push(tty);
 	tty_kref_put(tty);
@@ -2596,6 +2649,10 @@
 	if (retval)
 		goto failed_usb_register;
 
+	//~ retval = alsa_card_audard_init();
+	//~ if (retval)
+		//~ goto failed_usb_register;
+
 	printk(KERN_INFO KBUILD_MODNAME ": " DRIVER_VERSION ":"
 	       DRIVER_DESC "\n");
 	return 0;
@@ -2608,6 +2665,14 @@
 
 static void __exit ftdi_exit(void)
 {
+	// ** exit seems to run before ftdi_sio_port_remove
+
+	// we cannot pass any structs to audard_remove
+	// from here anyways - so use static var there
+	//audard_remove();
+	// well, this is called when module exits, which is
+	// not the same as hot-unplug when the module is
+	// insmodded ! so moving to ftdi_sio_port_remove
 
 	dbg("%s", __func__);
 

--------------040206040602070901080001
Content-Type: text/x-chdr;
 name="snd_ftdi_audard.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="snd_ftdi_audard.h"

/*
 * snd_ftdi_audard.h
 * Driver definitions for the Audio Arduino FTDI USB driver - sound/ALSA related
 * (based on http://www.alsa-project.org/main/index.php/Minivosc {dummy.c; aloop-kernel.c} ) 
 * 
 * USB FTDI SIO driver - 'AudioArduino' modification
 * Copyright (C) 2010 by sdaau (sd@{imi,create}.aau.dk) 
 *
 *	This program is free software; you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation; either version 2 of the License, or
 *	(at your option) any later version.
 *
 */
/*
 *
 * Trying to place (audio) functions in .h file, 
 * since including them in standalone .c might
 * screw up (other) includes... 
 *
 */
/* 
 * Check functions proc_audio_usbbus_read, 
 * proc_audio_usbid_read, snd_usb_audio_create_proc 
 * from usbaudio.c, to see how common proc files are 
 * manipulated to show the usb device info
 */



// * Use our own dbg macro: 
// * http://www.n1ywb.com/projects/darts/darts-usb/darts-usb.c
// * 
// * ftdi-sio seems to include something that defines dbg, 
// * which spews massive ammounts of log; 
// * to tame it down, we define it as nothing here:
#undef dbg
#define dbg(format, arg...) do { } while (0)
//~ static int debug = 1;
//~ #define dbg(format, arg...) do { if (debug) printk( ": " format "\n" , ## arg); } while (0)

#define dbg2(format, arg...) do { } while (0)
//~ #define dbg2(format, arg...) do { printk( ": " format "\n" , ## arg); } while (0) // removed { if (debug) ...

#define dbg3(format, arg...) do { } while (0)
//~ #define dbg3(format, arg...) do { if (debug) printk( ": " format "\n" , ## arg); } while (0)

//~ #define dbg4(format, arg...) do { } while (0)
#define dbg4(format, arg...) do { printk( ": " format "\n" , ## arg); } while (0)


// * Here is our user defined breakpoint, to 
// * initiate communication with remote (k)gdb 
// * don't use if not actually using kgdb 
#define BREAKPOINT() asm("   int $3");

// * from usbaudio.h: handling of USB 
// * vendor/product ID pairs as 32-bit numbers 
#define USB_ID(vendor, product) (((vendor) << 16) | (product))
#define USB_ID_VENDOR(id) ((id) >> 16)
#define USB_ID_PRODUCT(id) ((u16)(id))


// * copy from audard.c/aloop-kernel.c: 
#include <linux/jiffies.h>
#include <linux/time.h>
#include <linux/platform_device.h>
#include <sound/core.h>
#include <sound/control.h>
#include <sound/pcm.h>
#include <sound/initval.h>
#include <sound/info.h> //for snd_card_proc_new

// * "Module parameters" writing.pdf:
// * There are standard module options for ALSA. 
// * At least, each module should have the index, id and enable options. 
// * If the module supports multiple cards (usually up to 8 = 
// * SNDRV_CARDS cards), they should be arrays.
// * If the module supports only a single card, they could be  
// * single variables, instead. 
// * enable option is not always necessary in this case, but it  
// * would be better to have a dummy option for compatibility. 
// * * Of course, SNDRV_CARDS will say - how many actual card 
// * hardwares we have connected to the system, at time of probing

static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
static int enable[SNDRV_CARDS] = {1, [1 ... (SNDRV_CARDS - 1)] = 0};

// aloop.c + writing.pdf
module_param_array(index, int, NULL, 0444);
MODULE_PARM_DESC(index, "Index value for Audio Arduino soundcard.");
module_param_array(id, charp, NULL, 0444);
MODULE_PARM_DESC(id, "ID string for Audio Arduino soundcard.");
module_param_array(enable, bool, NULL, 0444);
MODULE_PARM_DESC(enable, "Enable this Audio Arduino soundcard.");

// author, desc defined in main ftdi_sio-audard.c file 
//~ MODULE_AUTHOR("sdaau");
//~ MODULE_DESCRIPTION("An audio Arduino FTDI soundcard module");
//~ MODULE_LICENSE("GPL");

MODULE_SUPPORTED_DEVICE("{{ALSA,Audio Arduino soundcard}}");

// SO25771
const char *buildString = "This build XXXX was compiled at " __DATE__ ", " __TIME__ ".";


// ripped from dummy.c - for separate substreams:
#define MAX_PCM_DEVICES		4 	// we're not using this here - single device..
#define MAX_PCM_SUBSTREAMS	1 	// 16 // don't have 16 subdevices 
								//~ .. ((!sub)streams) per device here, 
								//~ .. only 1 (playback+capture). 
#ifndef add_playback_constraints
#define add_playback_constraints(x) 0
#endif
#ifndef add_capture_constraints
#define add_capture_constraints(x) 0
#endif

// * pcm_devs used only in probe, we 
// * .. count on using only 1 here, though
// * .. - so not used here
//~ static int pcm_devs[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1}; 

static int pcm_substreams[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1}; // 8}; // otherwise, 8 subdevices in aplay/arecord; although - it's reset in probe



// * here we must have some reference to the 'card':
static struct snd_card *thiscard; 

#define byte_pos(x)	((x) / HZ)
#define frac_pos(x)	((x) * HZ)

//~ #define MAX_BUFFER (32 * 48) 	// from bencol
#define MAX_BUFFER (64*1024)  		// default dummy.c:

// * was a single struct  for capture only previously..
//~ static struct snd_pcm_hardware audard_pcm_hw = 
static struct snd_pcm_hardware audard_pcm_hw_playback =
{
	.info = (SNDRV_PCM_INFO_MMAP |
	SNDRV_PCM_INFO_INTERLEAVED |
	SNDRV_PCM_INFO_BLOCK_TRANSFER |
	SNDRV_PCM_INFO_MMAP_VALID),
	.formats          = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16,
	.rates            = SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_44100,
	.rate_min         = 8000,
	.rate_max         = 44100,
	.channels_min     = 1,
	.channels_max     = 2,
	.buffer_bytes_max = MAX_BUFFER, //(64*1024) dummy.c, was (32 * 48) = 1536, 
	.period_bytes_min = 64, //dummy.c, was 48, 
	.period_bytes_max = MAX_BUFFER, //was 48, coz dummy.c: #def MAX_PERIOD_SIZE MAX_BUFFER
	.periods_min      = 1,
	.periods_max      = 1024, //dummy.c, was 32, 
};

static struct snd_pcm_hardware audard_pcm_hw_capture =
{
	.info = (SNDRV_PCM_INFO_MMAP |
	SNDRV_PCM_INFO_INTERLEAVED |
	SNDRV_PCM_INFO_BLOCK_TRANSFER |
	SNDRV_PCM_INFO_MMAP_VALID),
	.formats          = SNDRV_PCM_FMTBIT_U8,
	.rates            = SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_44100,
	.rate_min         = 8000,
	.rate_max         = 44100,
	.channels_min     = 1,
	.channels_max     = 1,
	.buffer_bytes_max = MAX_BUFFER, //(64*1024) dummy.c, was (32 * 48) = 1536, 
	.period_bytes_min = 352, // 64, //dummy.c // was 48 // now 2*bytesperjiffy (2*176)  
	.period_bytes_max = MAX_BUFFER, //was 48, coz dummy.c #def MAX_PERIOD_SIZE MAX_BUFFER
	.periods_min      = 1,
	.periods_max      = 1024, //dummy.c, was 32, 
};

// added - struct for intermediate RX (ring) buffer:
struct ringbuf {
	char *buf;
	// specify 32-bit integers instead of just 'int'
	int32_t size; 
	int32_t head;
	int32_t tail;
	uint32_t tlRecv; // total received bytes from USB since last prepare (follows tail)
	uint32_t hdWsnd; // total bytes written to ALSA pcm since last prepare (follows head)
	char *wrapbuf;	// to store remaining bytes when wrapping pcm_buffer/dma_area..
	int wrapbtw; 	// wrap bytes to write - flag; either 0, or ammount of wrap bytes in wrapbuf
};

struct snd_audard_pcm; // declare this here..
struct audard_device
{
	struct snd_card *card;
	struct snd_pcm *pcm; 						// snd_pcm will describe the
												//~ .. only 'device' in this driver
	struct snd_audard_pcm *playcaptstreams[2]; 	// ref to the playback and 
												//~ .. capture streams, related 
												//~ .. to the single pcm 'device'
	struct ftdi_private *ftdipr; 				// pointer back 
	unsigned char isSerportOpen; 
	/* mixer related variables - not used here: */
	//~ spinlock_t mixer_lock;
	//~ int mixer_volume[MIXER_ADDR_LAST+1][2];
	//~ int capture_source[MIXER_ADDR_LAST+1][2];
	struct mutex cable_lock; 					// mutex here - just in case
	struct ringbuf IMRX; 						//intermediate RX buffer...  
	char* tempbuf8b; 							// to store 'cast' int16_t from audacity to 8-bit
	char tempbuf8b_extra;						// counter - if we have 1,2 or 3 extra (overflow) 
												//   bytes from the stereo, 16-bit dma_area 
												//   remaining from the last period (so char 
												//   range:-128:127 should be enough)
	char tempbuf8b_extra_prev;					// previous val of _extra: needed to handle specific period wrapping cases 
	char* tempbuf8b_frame;						// if _extra > 0, then a frame has been cut; 
												//   we will save the pieces in _frame; once 
												//   _frame is complete, we can represent it with 
												//   a byte in tempbuf8b .. 
	unsigned int playawbprd;	// actually written playback bytes; needed to compare with buf_pos
								//   in case we're missing a frame for CD playback
	// * flags * /
	unsigned int valid;							// (not used)
	unsigned int running;
	unsigned int period_update_pending :1;		// (not used)
	/* from snd_usb_audio struct: */
	u32 usb_id;
};

// * here declaration of functions that will need to be in _ops, before they are defined
static int snd_card_audard_pcm_hw_params(struct snd_pcm_substream *ss,
                        struct snd_pcm_hw_params *hw_params);
static int snd_card_audard_pcm_hw_free(struct snd_pcm_substream *ss);

//~ static int audard_pcm_open(struct snd_pcm_substream *ss);
static int snd_card_audard_pcm_playback_open(struct snd_pcm_substream *ss);
static int snd_card_audard_pcm_capture_open(struct snd_pcm_substream *ss);

static int snd_card_audard_pcm_playback_close(
							struct snd_pcm_substream *substream);
static int snd_card_audard_pcm_capture_close(
							struct snd_pcm_substream *substream);

static int snd_card_audard_pcm_dev_free(struct snd_device *device);
static int snd_card_audard_pcm_free(struct audard_device *chip); 

// * don't really have to declare these, but here they are:
static int audard_probe(struct usb_serial *serial);
static void audard_remove(void);

/* these we don't need - __init/__exit is handled at module (ftdi_sio) level, 
// and we won't use the platform_ stuff: 
static void audard_unregister_all(void)
static int alsa_card_audard_init(void)
*/

// * timer/interrupt functions - _xfer_buf is called from the ftdi_sio-audard.c
static void audard_xfer_buf(struct audard_device *mydev, char *inch, unsigned int count);
static void audard_fill_capture_buf(struct audard_device *mydev, char *inch, unsigned int bytes);

// dummy.c funcs headers:
static int snd_card_audard_new_pcm(struct audard_device *mydev, 
				int device, int substreams); // no __devinit here - "Section mismatch in reference from ... This is often because audard_probe lacks a __devinit"
static struct snd_audard_pcm *new_pcm_stream(struct snd_pcm_substream *substream);
static void snd_card_audard_runtime_free(struct snd_pcm_runtime *runtime);


static inline void snd_card_audard_pcm_timer_start(struct snd_audard_pcm *dpcm);
static inline void snd_card_audard_pcm_timer_stop(struct snd_audard_pcm *dpcm);
static int snd_card_audard_pcm_trigger(struct snd_pcm_substream *substream, int cmd);
static int snd_card_audard_pcm_prepare(struct snd_pcm_substream *substream);
static void snd_card_audard_pcm_timer_function(unsigned long data);
static snd_pcm_uframes_t snd_card_audard_pcm_pointer(struct snd_pcm_substream *substream);


//~ static struct snd_pcm_ops audard_pcm_ops; // was a single for capture only previously.. 
// * Since now we need separate capture and playback substreams, 
// * we separate callbacks for them - the below is ripped from dummy.c **********
static struct snd_pcm_ops audard_pcm_playback_ops =
{
	.open      = snd_card_audard_pcm_playback_open,
	.close     = snd_card_audard_pcm_playback_close, //audard_pcm_playback_close,
	.ioctl     = snd_pcm_lib_ioctl,
	.hw_params = snd_card_audard_pcm_hw_params,
	.hw_free   = snd_card_audard_pcm_hw_free,
	.prepare   = snd_card_audard_pcm_prepare, //audard_pcm_prepare,
	.trigger   = snd_card_audard_pcm_trigger, //audard_pcm_trigger,
	.pointer   = snd_card_audard_pcm_pointer, //audard_pcm_pointer,
};

static struct snd_pcm_ops audard_pcm_capture_ops =
{
	.open      = snd_card_audard_pcm_capture_open,
	.close     = snd_card_audard_pcm_capture_close, //audard_pcm_capture_close,
	.ioctl     = snd_pcm_lib_ioctl,
	.hw_params = snd_card_audard_pcm_hw_params,
	.hw_free   = snd_card_audard_pcm_hw_free,
	.prepare   = snd_card_audard_pcm_prepare, //audard_pcm_prepare,
	.trigger   = snd_card_audard_pcm_trigger, //audard_pcm_trigger,
	.pointer   = snd_card_audard_pcm_pointer, //audard_pcm_pointer,
};


// * Main pcm struct

struct snd_audard_pcm {
	struct audard_device *mydev;
	spinlock_t lock;
	struct timer_list timer;
	unsigned int pcm_buffer_size;
	unsigned int pcm_period_size;
	unsigned int pcm_bpj;		/* bytes per 1 jiffies */
	unsigned int pcm_bps;		/* bytes per second */
	unsigned int pcm_hz;		/* HZ */
	unsigned int pcm_irq_pos;	/* IRQ position */
	unsigned int pcm_buf_pos;	/* position in buffer */
	struct snd_pcm_substream *substream;
};


// * FUNCTIONS

static inline void snd_card_audard_pcm_timer_start(struct snd_audard_pcm *dpcm)
{
	dpcm->timer.expires = 1 + jiffies;
	add_timer(&dpcm->timer);
}

static inline void snd_card_audard_pcm_timer_stop(struct snd_audard_pcm *dpcm)
{
	del_timer(&dpcm->timer);
}

static int snd_card_audard_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
{
	struct snd_pcm_runtime *runtime = substream->runtime;
	struct snd_audard_pcm *dpcm = runtime->private_data;
	struct audard_device *mydev = dpcm->mydev; 
	//~ struct ftdi_private *priv = mydev->ftdipr;
	struct usb_serial_port *usport = mydev->ftdipr->port;
	//~ unsigned long flags;
	//~ int result = 0;
	
	int err = 0;
	char cmds[16]="          ";
	char ttystr[32]="          ";
	cmds[15]='\0';
	ttystr[31]='\0';

	// either a playback or a capture substream could trigger here.. 
	
	// do not use ftdi_open/close (call funcs that sleep) in _trigger (it is atomic)!
	// trying to move in hw_params/hw_free
	
	sprintf( &cmds[0], "%d", cmd );
	spin_lock(&dpcm->lock);
	switch (cmd) {
	case SNDRV_PCM_TRIGGER_START:
	case SNDRV_PCM_TRIGGER_RESUME:
		sprintf( &cmds[0], "%d START", cmd);
		//~ ftdi_open(NULL, mydev->ftdipr->port); // try open port
		// * Start reading from the device */ // NO!!!! 
		//~ result = ftdi_submit_read_urb(usport, GFP_KERNEL);
		//~ if (!result)
			//~ kref_get(&priv->kref); // end start reading
		snd_card_audard_pcm_timer_start(dpcm);
		mydev->running |= (1 << substream->stream); // set running bit @ playback (0) or capture (1) bit position
		break;
	case SNDRV_PCM_TRIGGER_STOP:
	case SNDRV_PCM_TRIGGER_SUSPEND:
		sprintf( &cmds[0], "%d STOP", cmd); 
		//~ ftdi_close(mydev->ftdipr->port); // try close port
		// * shutdown our bulk read */ // NO!!!
		//~ usb_kill_urb(usport->read_urb);
		//~ kref_put(&priv->kref, ftdi_sio_priv_release);	// end shutdown bulk read
		mydev->running &= ~(1 << substream->stream); // clear running bit @ playback (0) or capture (1) bit position
		snd_card_audard_pcm_timer_stop(dpcm);
		break;
	default:
		err = -EINVAL;
		break;
	}
	spin_unlock(&dpcm->lock);
	//~ dbg2("	%s: %s -- portnum %d ", __func__, cmds, mydev->ftdipr->port->number);// OK
	//~ spin_lock_irqsave(&usport->lock, flags);
	// probably no need for spinlock - however usport->port.tty could be 0x0! 
	if (usport->port.tty) {
		sprintf( &ttystr[0], "ttyindx %d, ttyname %s", usport->port.tty->index, usport->port.tty->name );
	} else {
		sprintf( &ttystr[0], "port.tty %p", usport->port.tty);
	}
	
	dbg2("	%s: %s -- portnum %d, %s", __func__, cmds, mydev->ftdipr->port->number, ttystr);
	//~ spin_unlock_irqrestore(&usport->lock, flags);
	return 0;
}

static int snd_card_audard_pcm_prepare(struct snd_pcm_substream *substream)
{
	struct snd_pcm_runtime *runtime = substream->runtime;
	struct snd_audard_pcm *dpcm = runtime->private_data;
	struct audard_device *mydev = dpcm->mydev; // just for tlRecv;hdWsnd; reset
	int bps;
	int bpj; // no float in kernel; "__floatsisf" undefined !!

	bps = snd_pcm_format_width(runtime->format) * runtime->rate *
		runtime->channels / 8;

	if (bps <= 0)
		return -EINVAL;

	mydev->IMRX.tlRecv = 0;
	mydev->IMRX.hdWsnd = 0;
	
	
	bpj = bps/HZ; // this will be truncated as int(eger)

	// for 1 jiffies, time is 1/HZ ;
	// HZ should be cca 100 Hz, so even for 8K, it is like 80 bytes.. 
	dpcm->pcm_bpj = bpj; 
	
	dpcm->pcm_bps = bps;	
	dpcm->pcm_hz = HZ;
	dpcm->pcm_buffer_size = snd_pcm_lib_buffer_bytes(substream);
	dpcm->pcm_period_size = snd_pcm_lib_period_bytes(substream);
	dpcm->pcm_irq_pos = 0;
	dpcm->pcm_buf_pos = 0;
	
	// since wrapbuf needs not be bigger than pcm_buffer_size,
	// realloc it free (and finally kill it where IMRX.buf is killed)
	if (mydev->IMRX.wrapbuf) 
		kfree(mydev->IMRX.wrapbuf);
	mydev->IMRX.wrapbuf = kzalloc(dpcm->pcm_buffer_size, GFP_KERNEL);

	// tempbuf8b - realloc it (via free) - if playback
	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
		int samplewidth = snd_pcm_format_width(substream->runtime->format);
		if ((samplewidth == 16) && (substream->runtime->channels == 2)) {
			if (mydev->tempbuf8b) 
				kfree(mydev->tempbuf8b);
			// make sure there is one extra byte in tempbuf8b - for period wrap (isBufFramePreinc)!! 
			mydev->tempbuf8b = kzalloc(bytes_to_frames(substream->runtime, dpcm->pcm_bpj), GFP_KERNEL); //framesToWrite; bytesToWrite = dpcm->pcm_bpj
			// same realloc for tempbuf8b_frame - it needs to be 4 bytes, i.e. 1 frame, in size
			if (mydev->tempbuf8b_frame) 
				kfree(mydev->tempbuf8b_frame);				
			mydev->tempbuf8b_frame = kzalloc(frames_to_bytes(substream->runtime, 1), GFP_KERNEL); 
		}
		// also reset the overflow counter here:
		mydev->tempbuf8b_extra = 0;
		mydev->tempbuf8b_extra_prev = 0;
		mydev->playawbprd = 0;
	}
	
	dbg2("	%s: bps:%d bpj: %d, HZ: %d, buffer_size: %d, pcm_period_size: %d, dma_bytes %d, dma_samples %d, fmt|nch|rt %d|%d|%d", __func__, bps, bpj, HZ, dpcm->pcm_buffer_size, dpcm->pcm_period_size, runtime->dma_bytes, bytes_to_samples(runtime, runtime->dma_bytes), snd_pcm_format_width(runtime->format), runtime->channels, runtime->rate);
	
	snd_pcm_format_set_silence(runtime->format, runtime->dma_area,
			bytes_to_samples(runtime, runtime->dma_bytes));

	if (! mydev->IMRX.wrapbuf)
		dbg2("	cannot alloc wrapbuf!");
		return 1; 	
	
	return 0;
}

// NOTE: this function can be called EITHER by playback OR by capture! 
static void snd_card_audard_pcm_timer_function(unsigned long data)
{
	struct snd_audard_pcm *dpcm = (struct snd_audard_pcm *)data;
	unsigned long flags;
	
	// retrieve a ref to substream in the calling pcm struct:
	struct snd_pcm_substream *ss = dpcm->substream;
	// playback or capture direction.. 
	int dir_playcap = ss->stream;
	// destination - ref to main dma area
	char *dst = ss->runtime->dma_area;
	// ref to device struct
	struct audard_device *mydev = dpcm->mydev;
	
	unsigned int bytesToWrite;
	int imrfill;
	int bytesSilence;
	int bytesToWriteBWrap, bytesToWriteBWrapRemain, actuallyWrittenBytes;
		
	//~ spin_lock_irqsave(&dpcm->lock, flags);
	
	bytesToWrite = dpcm->pcm_bpj; // same for both playback and capture?
	bytesSilence = 0;
	
	if (dir_playcap == SNDRV_PCM_STREAM_PLAYBACK) {
		// we simply assume that ALSA has already written pcm_bpj in the past interval,
		// and given it to us in dma_area? 
		// if so - then just execute ftdi_write? 
		//~ ftdi_write(struct tty_struct *tty, struct usb_serial_port *port, const unsigned char *buf, int count)
		// seems here we only have to handle the case of dma_area wrapping
		// (otherwise, here we have nothing to do with IMRX) 
		// and no need to deal with silence here - just push bytes as long as ALSA says :) 
		struct usb_serial_port *usport = mydev->ftdipr->port;
		int samplewidth = snd_pcm_format_width(ss->runtime->format);
		
		// NOTE: currently, hardware wise, we want Arduino to 
		//   support mono, 8-bit, 44100 Hz: 
		// - `aplay` can support this kind of a stream directly
		// - `audacity` converts internally everything to stereo @ default sample format (16) @ project rate (44100)
		// so for each original 8-bit sample, `audacity` (via ALSA) will here
		//  give us 2 channels * 16 bits = 32 bits = 4 bytes
		// SO: if we use `aplay`, we can handle copy/wrap with bytes calc directly
		// if we use `audacity`, we must cast 4 bytes (stereo 16-bit) to 1 byte
		// snd_pcm_format_width(runtime->format), runtime->channels, runtime->rate
		
		// check wrap of dma_area - only interested in actual bytes (not silence)
		// handle like this, instead of modulo - are we over pcm buffer size with this write?
		bytesToWriteBWrap = dpcm->pcm_buf_pos + bytesToWrite - dpcm->pcm_buffer_size;
		bytesToWriteBWrapRemain = 0; 
		// bytesToWriteBWrap will be negative if no wrap... else:
		// (now must also handle differently 8-bit mono `arecord` and 16-bit stereo `audacity`)
		// for 8-bit mono, no problem with few bytes being wrapped from dma_area (no need for tempbuf8b_extra) 
		if ((samplewidth == 8) && (ss->runtime->channels == 1)) { // this should be `arecord` - 8 bit mono
			if (bytesToWriteBWrap > 0) { // we're wrapping
				bytesToWriteBWrapRemain = bytesToWrite - bytesToWriteBWrap;
				ftdi_write(NULL, usport, dst+dpcm->pcm_buf_pos, bytesToWriteBWrapRemain);
				ftdi_write(NULL, usport, dst, bytesToWriteBWrap);
			} else {
				bytesToWriteBWrap = 0; // set to 0 for neg vals, to avoid confusion
				ftdi_write(NULL, usport, dst+dpcm->pcm_buf_pos, bytesToWrite);
			}
		}
		
		if ((samplewidth == 16) && (ss->runtime->channels == 2)) { // this should be `audacity` - 16 bit stereo
			// here we expect 1 frame = num_channels * sample-size = 2*16 = 32 bit
			// NOTE, here bpj could be 705 (instead of usual 176 for mono 8-bit)
			
			// we want to represent each frame with a single byte (mono 8-bit)
			// we could do mixdown and such, but its pointless:
			// better to extract a 16-bit int from a single channel, and simply 
			// cast that to 8 bit
			
			// well - we cannot just simply "cast" between signed 16 and unsigned 8;
			// we'd also like ranges to match (i.e. [-32767, 32767] -> [0, 256])
			// to do that: MSB(int16) is extracted - and its most significant bit inverted
			// or: to extract MSB: bitshift (int16) right 8 places; ...
			// .... and AND (&) with 8-bit bitmask 0b11111111 = 0xFF (to handle signed bitshift, which may expand to 32 bits)
			// .... and finally, use XOR (^) with mask 0b10000000 = 0x80 to invert most significant bit
			// .. or formula: (sign16bit >> 8 & 0xFF) ^ 0x80 == (sign16bit >> 8 & 0b11111111) ^ 0b10000000
			
			// finally, 1 frame = 2 channels * 16 bits; however, if bpj is an even number; 
			// we may remain with 1, 2 or 3 bytes extra - we should record these in
			// tempbuf8b; and mark with tempbuf8b_extra - for prepending in next period
			
			// assuming we are interleaved here:
			// programmatically, easiest to read through an int pointer
			//  say in while loop, and the _write the extracted byte
			//  BUT - that may be a bad idea, queuing too many _writes ?
			// otherwise, we'll again have to have a temp buffer, and copy into it

			// new algo, handling all kindsa wrap:
			int tbExR; // tempbuf8b_extra Remain help var; also can serve as pcmpreinc
			int framesToWrite; // how many frames to write - changes between periods
			int bytesToWritePWrapRemain; // how many unwritten bytes at end of period
			int frameSizeBytes; // (numchannels*samplesize_in_bytes); frames_to_bytes 
			int breakstap; // 'fake' var, so systemtap can add a breakpoint
			int tframe, isBufFramePreinc, wrapped_dma_buf_pos; 
			int16_t left16bitsample;				
			
			
			frameSizeBytes			= frames_to_bytes(ss->runtime, 1); // for 1 frame, should be 4 bytes - for stereo, 16 bit
			tbExR 					= (frameSizeBytes - mydev->tempbuf8b_extra) % frameSizeBytes;
			framesToWrite 			= bytes_to_frames(ss->runtime, (bytesToWrite - tbExR)); //(bytesToWrite-tbExR)/frameSizeBytes; 
			bytesToWritePWrapRemain = bytesToWrite - tbExR - frames_to_bytes(ss->runtime, framesToWrite); //framesToWrite*frameSizeBytes # this is also "future" tempbuf8b_extra.. 
			isBufFramePreinc = 0; breakstap = 0;
			
			// ok, regardless if we wrap dpcm->buffer_size; we might have a 
			//   wrap due to a frame being split at period (say, odd bytesToWrite);
			// so first check if there's tempbuf8b_extra from last period, 
			//   handle that first, and preincrement counters - and only then, do the rest
			if (mydev->tempbuf8b_extra > 0) {
				// here we should have first tempbuf8b_extra bytes of split frame 
				//   in tempbuf8b_frame - populate with remainder of bytes first;
				//   which should be at beginning of dma_area
				if (tbExR > 0) { // since now, _extra could also be frameSizeBytes - not anymore, but keep it 
					memcpy(mydev->tempbuf8b_frame+mydev->tempbuf8b_extra, dst+dpcm->pcm_buf_pos, tbExR);
					// now tempbuf8b_frame should be having a frame, with full frameSizeBytes (4)
					// "cast" it to byte, and store it in tempbuf8b
					// as tempbuf8b will always get fully used at the end of this function, 
					// here we just fill it from the beginning.. 
					left16bitsample = *(int16_t*)(mydev->tempbuf8b_frame);
					*(mydev->tempbuf8b) = (char) (left16bitsample >> 8 & 0b11111111) ^ 0b10000000;
					// right, now we have the first sample in tempbuf8b - rest of code should know
					// set isBufFramePreinc:
					//    it means 1 byte already in tempbuf8b!
					//  then, we can use it as correct offset for writing in tempbuf8b... 
					isBufFramePreinc = 1; // else it is zero from start. 
				}
			}
			
			// we have now exact number of frames - which will definitely not wrap IN PERIOD - to send this period; handle:
			tframe = 0; 
			while (tframe<framesToWrite) {
				// tframe = 0 -> bytes: L: 0 1 R: 2 3 (stereo, 16-bit, interleave)
				int BwrapBytesRemain; 
				wrapped_dma_buf_pos = dpcm->pcm_buf_pos+tbExR+frameSizeBytes*tframe;
				BwrapBytesRemain = wrapped_dma_buf_pos + frameSizeBytes - (dpcm->pcm_buffer_size - 1); //also advance by frameSizeBytes
				if (BwrapBytesRemain > 0) { // ... however, we may still be in a frame that wraps on dma pcm BUFFER size boundary
					if (BwrapBytesRemain < frameSizeBytes) {
						char brokenEndFrame[4] = ""; // should be frameSizeBytes, but: "error: variable-sized object may not be initialized" for variable-length arrays; and else should again kzmalloc / kfree with _ATOMIC.. so easiest hardcoded for now
						memcpy(&brokenEndFrame[0], dst+wrapped_dma_buf_pos, frameSizeBytes-BwrapBytesRemain); // copy from end of dma_area
						memcpy(&brokenEndFrame[frameSizeBytes-BwrapBytesRemain], dst, BwrapBytesRemain); // copy from start of dma_area
						left16bitsample = *(int16_t*)(&brokenEndFrame[0]);
						*(mydev->tempbuf8b + isBufFramePreinc + tframe) = (char) (left16bitsample >> 8 & 0b11111111) ^ 0b10000000; //(char)left16bitsample;
						tframe+=1; 
					}
					wrapped_dma_buf_pos = (dpcm->pcm_buf_pos+tbExR+frameSizeBytes*tframe) % dpcm->pcm_buffer_size; // not just wrapped_dma_buf_pos % dpcm->pcm_buffer_size; - also refresh new val of tframe?!
				}
				left16bitsample = *(int16_t*)(dst+wrapped_dma_buf_pos);
				// dereference pointer (instead of assigning array)
				*(mydev->tempbuf8b + isBufFramePreinc + tframe) = (char) (left16bitsample >> 8 & 0b11111111) ^ 0b10000000; //(char)left16bitsample;
				tframe+=1;
			}
			
			// tempbuf should be ready now, send
			ftdi_write(NULL, usport, mydev->tempbuf8b, tframe+isBufFramePreinc); // framesToWrite bytes --  corresponding to frames! 
			mydev->playawbprd += (tframe+isBufFramePreinc)*frameSizeBytes; // sync to actual ftdi writes! 
			
			// here we re-set mydev->tempbuf8b_extra again: 
			// after the ftdi_write, we can see if anything should be put in tempbuf8b_frame
			// as obviously: framesToWrite*frameSizeBytes <= bytesToWrite!
			// with framesToWrite - we have exhausted (numchan*samplesize)*framesToWrite bytes
			//   in dma_area; check if some are remaining voa modulo 4 (numchan*samplesize) ...  
			// also (numchan*samplesize) = frames_to_bytes(1)
			// and obviously: (framesToWrite*frameSizeBytes) % frameSizeBytes; is zero! use bytesToWrite...
			// ... actually, bytesToWrite +  tempbuf8b_extra (not isBufFramePreinc)!
			// ... actually - it is the (new) bytesToWritePWrapRemain:
			mydev->tempbuf8b_extra = bytesToWritePWrapRemain; //(bytesToWrite + mydev->tempbuf8b_extra) % frameSizeBytes; // reset counter first
			
			if (mydev->tempbuf8b_extra > 0) {
				// ok we have some leftovers, save:
				// framesToWrite*frameSizeBytes + tempbuf8b_extra (should be =) bytesToWrite
				wrapped_dma_buf_pos = (dpcm->pcm_buf_pos+tbExR+frameSizeBytes*tframe) % dpcm->pcm_buffer_size;
				memcpy(mydev->tempbuf8b_frame, dst+wrapped_dma_buf_pos, mydev->tempbuf8b_extra);
			}
			
			mydev->tempbuf8b_extra_prev = mydev->tempbuf8b_extra; 
			
			if (dpcm->pcm_buf_pos+bytesToWrite >= dpcm->pcm_buffer_size) { // sync playawbprd wrap with  buf_pos
				mydev->playawbprd %= dpcm->pcm_buffer_size;	//dpcm->pcm_buf_pos
			}
			// ok, now that we've done this - let's note, that we have
			//   'actually written' only "framesToWrite"*frameSizeBytes (+ preinc) !!
			// so for the update of pcm_buf_pos below, 
			//    we must correct bytesToWrite! - NEVER, screws up timing..
			//~ bytesToWrite = pcmpreinc+fwrite*frameSizeBytes; 
			// actually NO - now instead of correction, we have temp buffer?? 
			breakstap = breakstap+1; // breakpoint line for systemtap
			//~ kfree(tempbuf8b);
		}
	} // end if (dir_playcap == SNDRV_PCM_STREAM_PLAYBACK) 
	
	// * ONLY bother with IMRX and such if we are capturing; 
	// * so we need to check stream direction, as we use a single timer
	// * function (to handle both playback and capture directions) 
	if (dir_playcap == SNDRV_PCM_STREAM_CAPTURE) {
		
		// * here we call timer_func each 1 jiffy period ... 
		// * can we use dpcm->pcm_bps?? we need bytes per jiffies.. 
		// * > Within the Linux 2.6 operating system kernel, since
		// * >  release 2.6.13, on the Intel i386 platform a jiffy
		// * >  is by default 4 ms, or 1/250 of a second
		// * > The Linux kernel maintains a global variable called
		// * >  jiffies, which represents the number of timer 
		// * >  ticks since the machine started.
		// * > http://www.xml.com/ldd/chapter/book/ch06.html: 
		// * >  jiq_timer.expires = jiffies + HZ; /* one second */ 
		// * >  "jiffies value in seconds %lu\n",(jiffies/HZ))
		// * if there are HZ (system) timer interrupts in a second, 
		// * there are HZ jiffies in a second. - seems jiffy period 
		// * can be like 0.04 sec ... - in the end, bpj=bps/Hz
		// * NOTE ----- will have to fill empty bytes if there is no 
		// *   packet, because pcm_irq_pos determines whether  
		// *   elapsed will fire; 
		// * if we don't, we'll fill just 6633 bytes, and stop, 
		// *   where dpcm->pcm_period_size * dpcm->pcm_hz  
		// *   could be 12000.. 
		// * we also need to protect near end of IMRX...
		
		
		// * we should in principle transfer 'bytesToWrite' = bpj
		// * bytes from IMRX to dma_area during capture..
		// * Check first 'imrfill', though - how many bytes 
		// * remain (as of yet) unprocessed in IMRX
		
		//~ bytesToWrite = dpcm->pcm_bpj;
		imrfill = mydev->IMRX.tail - mydev->IMRX.head;
		if (imrfill < 0) imrfill = 0; 
		if (bytesToWrite > imrfill) bytesToWrite = imrfill; 
		bytesSilence = dpcm->pcm_bpj - bytesToWrite;
		
		// check wrap of dma_area - only interested in actual bytes (not silence)
		// handle like this, instead of modulo - are we over pcm buffer size with this write?
		bytesToWriteBWrap = dpcm->pcm_buf_pos + bytesToWrite - dpcm->pcm_buffer_size;
		bytesToWriteBWrapRemain = 0; 
		// bytesToWriteBWrap will be negative if no wrap... else:
		if (bytesToWriteBWrap > 0) { // we're wrapping
			// oops, wrap - these remaining bytes will have to be written 
			// in the *next* pcm buffer ! so we have to save them somewhere? NOT anymore
			spin_lock_irqsave(&dpcm->lock, flags);			
			mydev->IMRX.wrapbtw = bytesToWriteBWrap;
			bytesToWriteBWrapRemain = bytesToWrite - bytesToWriteBWrap;
			// apparently, we don't need to copy to IMRX.wrapbuf anymore - not used
			//~ memcpy(mydev->IMRX.wrapbuf, mydev->IMRX.buf+mydev->IMRX.head+bytesToWriteBWrapRemain, bytesToWriteBWrap); 
			spin_unlock_irqrestore(&dpcm->lock, flags);
			
			dbg2("  inwrap: bWWR:%d, bWW:%d, bWr:%d ", bytesToWriteBWrapRemain, bytesToWriteBWrap, bytesToWrite);
			//bytesSilence = 0; //since we're wrapping, we need not write silence... well; keep it for this change.. 
			bytesToWrite = bytesToWriteBWrapRemain;
		} else bytesToWriteBWrap = 0; // set to 0 for neg vals, to avoid confusion
		
		dbg2(" %s: bWr:%d bsl:%d pbpos: %d, irqps: %d, hd: %d, tl: %d, sz: %d, tlR: %d, hdW: %d, Wrp: %d-%d", "tmr_fnc", bytesToWrite, bytesSilence, dpcm->pcm_buf_pos, dpcm->pcm_irq_pos, mydev->IMRX.head, mydev->IMRX.tail, mydev->IMRX.size, mydev->IMRX.tlRecv, mydev->IMRX.hdWsnd, bytesToWriteBWrap, mydev->IMRX.wrapbtw);
		
		// * check if by any chance we have wrap from last time? 
		actuallyWrittenBytes = 0; // reset here, so we can take wrapbtw into account
		
		// when IMRX.wrapbtw is set, it is == bytesToWriteBWrap; we don't want to execute in that frame
		// next time, bytesToWriteBWrap will be zero; so  && (! bytesToWriteBWrap)  ensures execution next frame
		
		// k, lets forget the above for now, and try to write while wrapping (circular buffer)
		// here we do the bytesToWriteBWrapRemain up to end of buffer; 
		// and piece after that will write the beginning of dma_area...
		// since we preincrease buf_pos here, we cannot use actuallyWrittenBytes cumulatively to set buf_pos at end.. so we keep aWB just as a check variable
		if (bytesToWriteBWrapRemain > 0) {
			memcpy(dst+dpcm->pcm_buf_pos, mydev->IMRX.buf+mydev->IMRX.head, bytesToWriteBWrapRemain);
			actuallyWrittenBytes += bytesToWriteBWrapRemain; // awb was 0 initially, so == to btWWR now.. 
			dpcm->pcm_irq_pos += bytesToWriteBWrapRemain;
			dpcm->pcm_buf_pos += bytesToWriteBWrapRemain; // this should bring buf_pos up to pcm_buffer_size
			dpcm->pcm_buf_pos %= dpcm->pcm_buffer_size; // buf_pos should now become zero
			mydev->IMRX.head += bytesToWriteBWrapRemain; 
			mydev->IMRX.hdWsnd += bytesToWriteBWrapRemain; 
			
			bytesToWrite = bytesToWriteBWrap; // set to bwWrap now, for piece at beginning
			mydev->IMRX.wrapbtw = 0; // reset this here, as we're not using - so it don't clog the log 
		}
		
		
		// * actual write
		if (bytesToWrite > 0) { // * if we have something, write it, 
								// * and fill rest - if any - with zeroes 
			memcpy(dst+dpcm->pcm_buf_pos, mydev->IMRX.buf+mydev->IMRX.head, bytesToWrite); 
			if (bytesSilence>0) memset(dst+dpcm->pcm_buf_pos+bytesToWrite, 0, bytesSilence);
			// * it is relevant to change head only here - and 
			// * ALWAYS in respect to bytesToWrite! NOT dpcm->pcm_bpj
			mydev->IMRX.head += bytesToWrite; // 
			mydev->IMRX.hdWsnd += bytesToWrite; // 
			actuallyWrittenBytes += bytesToWrite + bytesSilence;
		} else { 	// * no data, just fill zeroes - (silence) -  
					// * - and explicitly pcm_bpj bytes
					// * well... if bWr ==0; bsl = pcm_bpj; so use bsl (so its ok also for wrap? )
			memset(dst+dpcm->pcm_buf_pos, 0, bytesSilence);
			actuallyWrittenBytes += bytesSilence; 
		}
		
		dbg2("  fin: aWB:%d ", actuallyWrittenBytes); // should be bpj now.. 
		
		// * 'recover' IMRX - if we reached end of its 
		// *   contents, set head=tail=0
		if (mydev->IMRX.head == mydev->IMRX.tail) { 
			mydev->IMRX.head = mydev->IMRX.tail = 0; 
		}
	
	} // end if dir_playcap == SNDRV_PCM_STREAM_CAPTURE
	
	// * otherwise, try to move the buf_pos 
	// * counters for both capture and playback: 
	// *   here we can directly increase position 
	// *   counters  by pcm_bpj - since we also fill silence now !!
	dpcm->pcm_irq_pos += bytesToWrite + bytesSilence; //actuallyWrittenBytes; //dpcm->pcm_bpj; 
	dpcm->pcm_buf_pos += bytesToWrite + bytesSilence; //actuallyWrittenBytes; //dpcm->pcm_bpj; 
	// nope - modulo loses bytes at start, and maybe causes drips at end.. 
	//~ dpcm->pcm_buf_pos %= dpcm->pcm_buffer_size; // * wrap, if gone overflowing
												// * though, it shouldn't happen
												// * if we're timed; same as check
												// * .. if (buf_pos >= _buffer_size) ..
	// * handle buffer overflows 'manually' - but now,
	// * with the checks above, we should get max ==, never > 
	// * this should now never happen, since we 'break'/wrap manually (circ) in same array
	// but let's keep it, see if it has an effect.. maybe problematic? 
	// * WE MUST HAVE THIS - when there is just silence, we do NOT handle the 
	// * buf_pos wrap manually ! Then buf_pos just grows - and this is the ONLY 
	// * part to keep it in check! If not there, then getting SEVERE crashes - 
	// * even VirtualBox doesn't break into gdb, but instead crashes with "Guru Meditation" mode!
	// * apparently, because we're out of bounds for the middle layer dma_area!! 
	if (dpcm->pcm_buf_pos >= dpcm->pcm_buffer_size) {
		dbg2("  OVER: _buf_pos:%d ", dpcm->pcm_buf_pos);
		dpcm->pcm_buf_pos %= dpcm->pcm_buffer_size;	// 0; // don;t set to zero, wrap to modulo as originally:
													// when we have data, we should manually wrap (to zero, and then further);
													// when we have *only* silence, this will handle the monotonic
													// increase properly, so it's in sync with timing and irq_pos! 
		if (bytesSilence>0) { // if there was silence at all, blank the start of this wrap - just in case?  
			memset(dst, 0, dpcm->pcm_buf_pos);
		}
	}
	
	spin_lock_irqsave(&dpcm->lock, flags);
	
	// * set off timer, again
	dpcm->timer.expires = 1 + jiffies;
	add_timer(&dpcm->timer);
	
	// * check if we need to call _period_elapsed
	// *   depending on amount of bytes written 
	// *   since last period.. 
	// * modulo for irq_pos should be fine,
	// *   we don't use it to read - and with modulo, more proper timing? 
	if (dpcm->pcm_irq_pos >= dpcm->pcm_period_size) {
		dpcm->pcm_irq_pos %= dpcm->pcm_period_size ;
		spin_unlock_irqrestore(&dpcm->lock, flags);
		snd_pcm_period_elapsed(ss); //(dpcm->substream)
	} else
		spin_unlock_irqrestore(&dpcm->lock, flags);
}

static snd_pcm_uframes_t snd_card_audard_pcm_pointer(struct snd_pcm_substream *substream)
{
	struct snd_pcm_runtime *runtime = substream->runtime;
	struct snd_audard_pcm *dpcm = runtime->private_data;

	// * ALSA middle layer will call this function, to find
	// *   out where we are in this (play or capt) substream
	// *   - we have to answer in frames.
	// * hmm... as we run per jiffy now, we don't use 
	// *   dpcm->pcm_hz anymore, and we calc directly in 
	// *   bytes... so, just return the direct buf_pos.
	
	//~ return bytes_to_frames(runtime, dpcm->pcm_buf_pos / dpcm->pcm_hz);
	return bytes_to_frames(runtime, dpcm->pcm_buf_pos);
}

static void snd_card_audard_runtime_free(struct snd_pcm_runtime *runtime)
{
	kfree(runtime->private_data);
}

static struct snd_audard_pcm *new_pcm_stream(struct snd_pcm_substream *substream)
{
	struct snd_audard_pcm *dpcm;

	dpcm = kzalloc(sizeof(*dpcm), GFP_KERNEL);
	if (! dpcm)
		return dpcm;
	init_timer(&dpcm->timer);
	dpcm->timer.data = (unsigned long) dpcm;
	dpcm->timer.function = snd_card_audard_pcm_timer_function;
	spin_lock_init(&dpcm->lock);
	dpcm->substream = substream;
	return dpcm;
}

static int snd_card_audard_new_pcm(struct audard_device *mydev, 
							int device, int substreams) // no __devinit here
{
	struct snd_pcm *pcm;
	int err;

	// * NOTE:
	// * > I want to make sure I'm implementing things properly for full duplex
	// * > capability.  I'm creating the pcm device via:
	// * > 
	// * > snd_pcm_new(
	// * > 		card, "my dev", 0, 1 /* play streams */, 1 /* capt streams */, &pcm)
	// * ... ... ...
	// * in our case: int substreams = pcm_substreams[dev] = 1 ... 
	// * ... ... ...
	// * Also, sometimes:	ret = snd_pcm_new(card, card->driver; 
	// * 					strcpy(pcm->name, mydev->card->shortname);

	
	err = snd_pcm_new(mydev->card, "AudArd PCM", device,
									substreams, substreams, &pcm);
	
	dbg2("%s: snd_pcm_new: %d, dev %d, subs %d", __func__, err, device, substreams); 
	
	if (err < 0)
		return err;
	mydev->pcm = pcm;
	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &audard_pcm_playback_ops); 
	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &audard_pcm_capture_ops); 
	pcm->private_data = mydev; // 'pcm' is snd_pcm struct - has private_data 
	pcm->info_flags = 0;
	strcpy(pcm->name, "AudArd PCM");
	
	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
					      snd_dma_continuous_data(GFP_KERNEL),
					      0, 64*1024);
	return 0;
}

//~ static int snd_card_audard_pcm_playback_close(struct snd_pcm_substream *substream)
// end ripped from dummy.c **********



// specifies what func is called @ snd_card_free
// used in snd_device_new
static struct snd_device_ops audard_dev_ops =
{
	.dev_free = snd_card_audard_pcm_dev_free, 
};


// * DRVNAME is 15 chars; include/sound/core.h: 
// *  char driver[16]; char shortname[32]
// * but 15 chars + \0 = 16 ... 
// * so for more than that, sprintf fails. 
// * def'd in ftdi_sio-audard.c
// * #define DRVNAME "ftdi_sio_audard" 

#define SND_AUDARD_DRIVER DRVNAME  //"snd_audard" // using DRVNAME instead


/*
 *
 * Probe/remove functions
 *
 */
// * we cannot use __devinit here anymore 
// * also, we cannot rely on 
// *    audard_probe(struct platform_device *devptr)
// * to tell us the index of the soundcard !! 
static int audard_probe(struct usb_serial *serial)
{
	struct snd_card *card;
	struct audard_device *mydev;
	int ret, i;
	int err; 

	// * this 'dev' used to loop through the *pcm_substreams array
	int dev; // = devptr->id; // from aloop-kernel.c

	// * ref. to master usb device
	struct usb_device *udev = serial->dev;
	
	
	// * get the 'device' number
	// * TODO: make it really handle multiple cards
	// * NOTE - apparently, system will set 'enable' 
	// *   depending on  ammount of cards connected,  
	// *   and user choice - and will present 'enable'  
	// *   here ready to be read...
	// * at this point: enable[0]=1; and all other entries 
	// *   are 0 (and index[i], for all, is -1 ?! means next?!) 
	// * for a single card, we anyway count on just being 
	// *   dev=0 - as enable[0]=1 already 
	
	for (i = 0; i < SNDRV_CARDS; i++) {
		if (enable[i]) {
			dev = i; 
			break;
		}
	}
	//dev = 1; //explicit set for debug
	dbg4("%s: dev: %d, index %d - %s", __func__, dev, index[dev], buildString);
		
	// * adding AUDARD instead of id[dev] here, 
	// *   results with arecord -l (alsa-info) showing: 
	// *     card 1: AUDARD [MySoundCard ftdi_sio_audard], 
	// * 		device 0: ftdi_sio_audard [MySoundCard ftdi_sio_audard]
	// *     state.AUDARD { in alsa-info etc...
	// * else we have:
	// *   card 1: ftdisioaudard [...
	// *    state.ftdisioaudard {...
	
	// * NOTE that snd_card_create (via snd_ctl_dev_register)
	// *   will create the /dev/snd/by-path/ControlC% symlink; 
	// *   which in this case is:
	// *   pci-0000:00:1d.3 -> ../controlC1
	// * That is not a case for concern, if that is actually the USB bus: 
	// *     $ ls /sys/devices/pci0000\:00/0000\:00\:1d.3 | grep usb 
	// *   would give: 
	// *     usb5 usbmon
	// * And, here is a way to check that usb is actually related to sound:
	// *   $ ls /sys/devices/pci0000\:00/0000\:00\:1d.3/*/* | grep '\(sound\|:$\)' | grep 'sound' -B 1
	// *   /sys/devices/pci0000:00/0000:00:1d.3/usb5/5-2:
	// *   sound
	
	ret = snd_card_create(index[dev], "AUDARD",
	                      THIS_MODULE, sizeof(struct audard_device), &card); // id[dev]

	// * no need to kzalloc audard_device separately, if it 
	// *    is included in the snd_card_create above
	
	if (ret < 0)
		goto __nodev;
	
	mydev = card->private_data;
	mydev->card = card;
	thiscard = card; 
	
	mydev->isSerportOpen = 0; 
	
	// * MUST have mutex_init here - else crash on mutex_lock!!
	mutex_init(&mydev->cable_lock); 
	
	sprintf(card->driver, "%s", SND_AUDARD_DRIVER);
	sprintf(card->shortname, "MySoundCard %s", card->driver); //SND_AUDARD_DRIVER);
	sprintf(card->longname, "%s", card->shortname);
	dbg2("-- mydev %p, card->number %d, card->driver '%s', card->shortname '%s'", mydev, card->number, card->driver, card->shortname);

	// init the IMRX buffer here, MAX_BUFFER for start
	// NOTE: we'll allocate IMRX.wrapbuf, where we know 
	//   pcm_buffer_size (in _prepare); wrapbuf needs not be bigger than that. 
	mydev->IMRX.head = mydev->IMRX.tail = 0;
	mydev->IMRX.buf = kzalloc(MAX_BUFFER, GFP_KERNEL);
	if (! mydev->IMRX.buf)
		goto __nodev; 
	mydev->IMRX.size = MAX_BUFFER;	
	
	// * init substreams here 
	// *   here we have only one device, unlike in dummy.c
	// *   so, rip from aloop-kernel.c - allocate pcm streams manually
	// *   for the only device, we have dev=0
	if (pcm_substreams[dev] < 1)
		pcm_substreams[dev] = 1;
	if (pcm_substreams[dev] > MAX_PCM_SUBSTREAMS)
		pcm_substreams[dev] = MAX_PCM_SUBSTREAMS;
	
	// * create the first and only device @ 0 (it will have 
	// *   playback and capture substreams).. 
	// * pcm_substreams[dev] should be 1 - so we get 1 capture 
	// *   AND 1 playback substream
	// * same as in aloop-kernel.c - except there they also 
	// *   explicitly allocate second device (cable) - 
	// *   as in, (mydev, 1, ...)
	err = snd_card_audard_new_pcm(mydev, 0, pcm_substreams[dev]); 
	if (err < 0)
		goto __nodev;
	
	
	// * snd_card_set_dev is present in dummy - not in aloop though
	snd_card_set_dev(card, &serial->dev->dev); 

	// * this set of audard_dev_ops seems to work, because 
	// *   snd_card_audard_pcm_dev_free gets called @ snd_card_free
	ret = snd_device_new(card, SNDRV_DEV_LOWLEVEL, mydev, &audard_dev_ops);

	if (ret < 0)
		goto __nodev;

	// DO NOT USE ftdi_open HERE - AT THIS POINT, ftdipr IS NOT KNOWN!! 
	
	// * from usbaudio.c -  added extra for debugging
	mydev->usb_id = USB_ID(le16_to_cpu(udev->descriptor.idVendor),
		    le16_to_cpu(udev->descriptor.idProduct));
		
	// * static strings from the device - see also 
	// *   udev->descriptor.iManufacturer; udev->descriptor.iProduct
	dbg2("  manufacturer %s, product %s, serial %s, devpath %s", udev->manufacturer, udev->product, udev->serial, udev->devpath); 
	
	if (ret == 0)   	// or... (!ret)
	{
		// * also trying without this platform_set_drvdata 
		// *   so as to lose refs to devptr...
		// * platform_set_drvdata simply does:
		// * "store a pointer to priv (card) data structure".
		//~ platform_set_drvdata(serial->dev, card); //devptr,
		
		return 0; 		// success
	} 
	
	dbg2("  ret %d", ret);
	return ret; 
	
__nodev: 				// as in aloop/dummy...
	dbg2("__nodev reached!!");
	snd_card_free(card); // this will autocall .dev_free (= snd_card_audard_pcm_dev_free)
	return ret;
}

// just to set ftdi_private - _probe 2nd part:
static int audard_probe_fpriv(struct ftdi_private *priv)
{
	struct snd_card *card;
	struct audard_device *mydev;
	int ret; 
	
	card = thiscard; 		// get from global var
	mydev = card->private_data;

	// * ALSO: STORE audard_device ref in ftdi_private HERE:
	priv->audev = mydev; 
	mydev->ftdipr = priv;	// .. and reflink back ..
		
	// * try open port here?? ftdi_open CRASHES - so bad, no messages, with crashdump!! 
	
	// * since this represents end of all _probe allocations, 
	// *   we should call snd_card_register ...
	// * THIS snd_card_register MUST BE LAST, AFTER ALL ALLOCS!!
	ret = snd_card_register(card);	
	
	dbg2("%s: snd_pcm_new: mydev %p, ftdipriv %p, reg/ret %d, audev %p", __func__, mydev, mydev->ftdipr, ret, priv->audev);
	
	return 0; 
}



// * from dummy/aloop:
// * we cannot use __devexit here anymore
//static int audard_remove(struct platform_device *devptr)
static void audard_remove(void)
{
	struct audard_device *mydev = thiscard->private_data;
	dbg2("%s (%s)", __func__, buildString);
	kfree(mydev->IMRX.buf);
	kfree(mydev->IMRX.wrapbuf);
	kfree(mydev->tempbuf8b);
	kfree(mydev->tempbuf8b_frame);
	snd_card_free(thiscard);
	//~ snd_card_free(platform_get_drvdata(devptr));
	//~ platform_set_drvdata(devptr, NULL);
	return;// 0;
}


/*
static void audard_unregister_all(void)
// no __init here.. it crashes
static int alsa_card_audard_init(void)
*/



/*
*
* PCM functions
*
*/

static int snd_card_audard_pcm_hw_params(struct snd_pcm_substream *ss,
                        struct snd_pcm_hw_params *hw_params)
{
	dbg2("%s", __func__);
	
	return snd_pcm_lib_malloc_pages(ss,
	                                params_buffer_bytes(hw_params));
}

static int snd_card_audard_pcm_hw_free(struct snd_pcm_substream *ss)
{
	dbg2("%s", __func__);
	
	return snd_pcm_lib_free_pages(ss);
}


static int snd_card_audard_pcm_playback_open(struct snd_pcm_substream *ss)
{
	struct audard_device *mydev = ss->private_data;
	struct snd_pcm_runtime *runtime = ss->runtime;
	struct snd_audard_pcm *dpcm;
	int err;
	int dir_playcap = ss->stream;	// * integer - stream direction:
									// * playback or capture? 
									// * although, it's implicitly defined, 
									// * as this is playback callback

	//BREAKPOINT();
	dbg2("%s", __func__);

	// copied from aloop-kernel.c:
	mutex_lock(&mydev->cable_lock);
	
	// from dummy.c
	if ((dpcm = new_pcm_stream(ss)) == NULL)
		return -ENOMEM;
	runtime->private_data = dpcm;
	dpcm->mydev = mydev;
	
	// put a reference to this (playback) stream in mydev:
	mydev->playcaptstreams[dir_playcap] = dpcm;
	
	/* makes the infrastructure responsible for freeing dpcm */
	runtime->private_free = snd_card_audard_runtime_free;
	runtime->hw = audard_pcm_hw_playback;
	if (ss->pcm->device & 1) {
		runtime->hw.info &= ~SNDRV_PCM_INFO_INTERLEAVED;
		runtime->hw.info |= SNDRV_PCM_INFO_NONINTERLEAVED;
	}
	if (ss->pcm->device & 2)
		runtime->hw.info &= ~(SNDRV_PCM_INFO_MMAP|SNDRV_PCM_INFO_MMAP_VALID);
	err = add_playback_constraints(runtime);
	if (err < 0)
		return err;	
	
	mutex_unlock(&mydev->cable_lock);	
	
	// try ftdi_open here - it calls allocs that sleep, but 
	//  hw_params should be a non-atomic callback
	// repeated opens should be handled in that function...
	ftdi_open(NULL, mydev->ftdipr->port);
	
	return 0;
}

static int snd_card_audard_pcm_playback_close(struct snd_pcm_substream *substream)
{
	struct audard_device *mydev = substream->private_data;

	// try ftdi_close here
	// repeated closes should be handled in that function...
	ftdi_close(mydev->ftdipr->port);
	
	return 0;
}


static int snd_card_audard_pcm_capture_open(struct snd_pcm_substream *ss)
{
	struct audard_device *mydev = ss->private_data;
	struct snd_pcm_runtime *runtime = ss->runtime;
	struct snd_audard_pcm *dpcm;
	int err;
	int dir_playcap = ss->stream;	// * integer - stream direction:
									// * playback or capture? 
									// * although, it's implicitly defined, 
									// * as this is capture callback

	// copied from aloop-kernel.c:
	mutex_lock(&mydev->cable_lock);
		
	// from dummy.c
	if ((dpcm = new_pcm_stream(ss)) == NULL)
		return -ENOMEM;
	runtime->private_data = dpcm;
	dpcm->mydev = mydev;
	
	// put a reference to this (playback) stream in mydev:
	mydev->playcaptstreams[dir_playcap] = dpcm;
	
	/* makes the infrastructure responsible for freeing dpcm */
	runtime->private_free = snd_card_audard_runtime_free;
	runtime->hw = audard_pcm_hw_capture;
	if (ss->pcm->device & 1) {
		runtime->hw.info &= ~SNDRV_PCM_INFO_INTERLEAVED;
		runtime->hw.info |= SNDRV_PCM_INFO_NONINTERLEAVED;
	}
	if (ss->pcm->device & 2)
		runtime->hw.info &= ~(SNDRV_PCM_INFO_MMAP|SNDRV_PCM_INFO_MMAP_VALID);
	err = add_playback_constraints(runtime);
	if (err < 0)
		return err;	
	
	mutex_unlock(&mydev->cable_lock);

	// try ftdi_open here - it calls allocs that sleep, but 
	//  hw_params should be a non-atomic callback
	// repeated opens should be handled in that function...
	ftdi_open(NULL, mydev->ftdipr->port);
	
	return 0;
}

static int snd_card_audard_pcm_capture_close(struct snd_pcm_substream *substream)
{
	struct audard_device *mydev = substream->private_data;

	// try ftdi_close here
	// repeated closes should be handled in that function...
	ftdi_close(mydev->ftdipr->port);
	
	return 0;
}



/*
 *
 * called on incoming USB (from _ftdi_audard.c)
 * CABLE_PLAYBACK: 1, CABLE_CAPTURE: 2, CABLE_BOTH: 3
 */

#define CABLE_PLAYBACK	(1 << SNDRV_PCM_STREAM_PLAYBACK)
#define CABLE_CAPTURE	(1 << SNDRV_PCM_STREAM_CAPTURE)
#define CABLE_BOTH	(CABLE_PLAYBACK | CABLE_CAPTURE)

static void audard_xfer_buf(struct audard_device *mydev, char *inch, unsigned int count)
{
	dbg2(">audard_xfer_buf: count: %d - %d (P:%d, C:%d)", count, mydev->running, CABLE_PLAYBACK, CABLE_CAPTURE );

	// * as in aloop-kernel.c...
	
	switch (mydev->running) {
		case CABLE_CAPTURE:
		case CABLE_BOTH:
			audard_fill_capture_buf(mydev, inch, count);
			break;
	}

}

static void audard_fill_capture_buf(struct audard_device *mydev, char *inch, unsigned int bytes)
{
	
	// * This function takes care only of adding,
	// *    or copying, to intermediate RX buffer. 
	// * First, check if we will fit in IMRX - else "realloc"
	// * But, since no "realloc" in kernel, use trick: http://lkml.indiana.edu/hypermail/linux/kernel/0002.0/0365.html
	// * On incoming bytes (here), we move the tail; 
	// *   on pcm_elapsed (timer_func) - the head is moved.
	
	int newtail;
	char* buftail;
	
	// * mutex causing increased ammount of kernel warnings here! 
	//~ mutex_lock(&mydev->cable_lock); 
	
	newtail = mydev->IMRX.tail + bytes;
	if (newtail > mydev->IMRX.size - 1) {
		// * instead of falling into this many times, 
		// *   if packets are like 62 bytes each, 
		// *   lets just 'realloc' +MAX_BUFFER bytes
		int newsize = mydev->IMRX.size + MAX_BUFFER;
		char* newimrx = kmalloc(newsize, GFP_ATOMIC); //was GFP_KERNEL
		char* oldhead = mydev->IMRX.buf + mydev->IMRX.head; 
		if (! newimrx) { // handle alloc fail
			dbg2("%s: - new IMRX is %p, tl: %d", __func__, newimrx, mydev->IMRX.tail);
			return;
		}
		
		// * the actual 'realloc'
		memcpy(newimrx, oldhead, mydev->IMRX.size);
		kfree(mydev->IMRX.buf);
		mydev->IMRX.buf = newimrx;
		
		// * since now we start where old tail was, "reset" head and tail
		mydev->IMRX.tail -= mydev->IMRX.head;
		mydev->IMRX.head = 0; 
		mydev->IMRX.size = newsize; 
	}
	
	// * ok, now do fill (copy data into) our buffer
	buftail = mydev->IMRX.buf + mydev->IMRX.tail;
	memcpy(buftail, inch, bytes);
	mydev->IMRX.tail += bytes;
	mydev->IMRX.tlRecv += bytes; 
	
	
	//~ mutex_unlock(&mydev->cable_lock); 
}


/*
 *
 * snd_device_ops / PCM free functions
 *
 */
// * these should eventually get called by 
// * snd_card_free (via .dev_free)
// * however, since we do no special allocations,
// * we need not free anything 
static int snd_card_audard_pcm_free(struct 
audard_device *chip)
{
	dbg2("%s", __func__);
	//~ kfree(chip->IMRX.buf); // possibly cause for segfault here? Now in _remove..
	return 0;
}

static int snd_card_audard_pcm_dev_free(struct snd_device *device)
{
	dbg2("%s", __func__);
	return snd_card_audard_pcm_free(device->device_data);
}
 

--------------040206040602070901080001--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
