From: Lee Revell <rlrevell@joe-job.com>
Subject: [PATCH] fix for ac97->front speaker routing (was Re:
	Some Patches for emu10k1)
Date: Sat, 26 Jun 2004 18:00:34 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1088287234.24275.113.camel@mindpipe>
References: <200406080807.i58878cb012056@www4.pobox.sk>
	 <40CF759E.7050102@jfalk.easynet.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-PhgVDqv7uxxm1hLeULtv"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40CF759E.7050102@jfalk.easynet.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: pzad@pobox.sk, joachim.falk@gmx.de
List-Id: alsa-devel@alsa-project.org


--=-PhgVDqv7uxxm1hLeULtv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-06-15 at 18:18, Joachim Falk wrote:
> |>But some FX buses seam to be connected to outputs even if there is no
> |>code in the dsp. Is that hardcoded in hardware or configurable and if
> |>yes where ?
> |
> |
> | This is maybe hardware feature or ld10k1 bug. If you connect FX bus
> | 0,1 to AC97 PCM output I think it will stop to do this.
> This seams to be a hardware feature of the EMU10K1 I think because if
> you clear the dsp code than FX bus channels 0,1 and 8,9 will be
> forwarded to Output channels 0,1 and 8,9. This I can say for sure.
> The others (2-7 and 10-15) I can not be sure because I have no speakers
> on these channels or they are not connected to output on my card. But I
> assume that to be the case too. As soon as you start driving an output
> within your DSP code the forwarding seams to vanish. I think this can
> not be a alsa driver feature because you can verify that the DSP really
> is empty by catting /proc/asound/Live/fx8010_acode. So the alsa driver
> has no possibility to magically insert some of its one forwardings if
> none are programmed by the user.

I believe I have figured this out.  The following lines are taken from
8010.h in the kX Project SDK.  This file is basically the same as
emu10k1.h in the ALSA driver, with some interesting additions.  The
following lines are *not* present in the ALSA driver:

    // HCFG2 for 10k2: 0x18:
    #define HCFG_K2                 0x18
    // -- unknown; experiments only FIXME
    #define HCFG_K2_GPINPUT_MASK    0x0000ff00
    #define HCFG_K2_GPOUTPUT_MASK   0x000000ff
    #define HCFG_K2_DISABLE_ANALOG  0x40                    // = 'enable' for Audigy2 (chiprev=4)
    #define HCFG_K2_ENABLE_DIGITAL  0x04
    #define HCFG_K2_BYPASS          0x02                    // drive's internal bypass (?)
    #define HCFG_K2_UNKNOWN_20      0x20
    #define HCFG_K2_UNKNOWN_80      0x80                    // turn off ac97 front -> front (10k2.1)
    #define HCFG_K2_MULTIPURPOSE_JACK       0x2000          // center+swf+rear_center (a2/a2ex)
                                                            // + digital for generic 10k2
    #define HCFG_K2_DIGITAL_JACK    0x1000                  // digital for a2 platinum
    #define HCFG_K2_FRONT_JACK      0x4000
    #define HCFG_K2_REAR_JACK       0x8000
    #define HCFG_K2_PHONES_JACK     0x0100          // LiveDrive

    // outputs:
    //   for audigy2 platinum: 0xa00
    //   for a2 platinum ex: 0x1c00
    //   for a1 platinum: 0x0

It appears that HCFG_K2_UNKNOWN_80 is used to disable the ac97 front -> front 
output routing.

If you compare 8010.h to emu10k1.h, there are several ofthese places where gaps 
appear in the sequence of register values, and they have filled many of them in,
by reverse engineering.

I have attached a patch to add these defines to emu10k1.h, renaming the variables 
in keeping with the ALSA convention.  Please retain the lines that attribute this code 
to the kX project; I added this because there is a part of 8010.h which they copied 
from emu10k1.h (the DBG_ stuff), and they give credit to ALSA in the comments.

Lee




--=-PhgVDqv7uxxm1hLeULtv
Content-Description: 
Content-Disposition: attachment; filename=audigy_hcfg.patch
Content-Type: text/x-patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa-kernel/include/emu10k1.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/emu10k1.h,v
retrieving revision 1.41
diff -u -r1.41 emu10k1.h
--- alsa-kernel/include/emu10k1.h	23 Jun 2004 11:49:07 -0000	1.41
+++ alsa-kernel/include/emu10k1.h	26 Jun 2004 04:56:40 -0000
@@ -218,6 +218,32 @@
 						/* Should be set to 1 when the EMU10K1 is	*/
 						/* completely initialized.			*/
 
+/* the following A_HCFG_* lines (including comments) are taken from 8010.h in the kX driver SDK.*/
+
+// HCFG2 for 10k2: 0x18:
+#define A_HCFG                 0x18
+// -- unknown; experiments only FIXME
+#define A_HCFG_GPINPUT_MASK    0x0000ff00
+#define A_HCFG_GPOUTPUT_MASK   0x000000ff
+#define A_HCFG_DISABLE_ANALOG  0x40		/* 'enable' for Audigy2 (chiprev=4)		*/
+#define A_HCFG_ENABLE_DIGITAL  0x04
+#define A_HCFG_BYPASS          0x02		/* drive's internal bypass (?)			*/
+#define A_HCFG_UNKNOWN_20      0x20
+#define A_HCFG_UNKNOWN_80      0x80		/* turn off ac97 front -> front (10k2.1)	*/
+#define A_HCFG_MULTIPURPOSE_JACK       0x2000	/* center+swf+rear_center (a2/a2ex)		*/
+						/* + digital for generic 10k2			*/
+#define A_HCFG_DIGITAL_JACK    0x1000		/* digital for a2 platinum			*/
+#define A_HCFG_FRONT_JACK      0x4000
+#define A_HCFG_REAR_JACK       0x8000
+#define A_HCFG_PHONES_JACK     0x0100		/* LiveDrive					*/
+
+// outputs:
+//   for audigy2 platinum: 0xa00
+//   for a2 platinum ex: 0x1c00
+//   for a1 platinum: 0x0
+
+/* end section from kX driver									*/
+
 //For Audigy, MPU port move to 0x70-0x74 ptr register
 
 #define MUDATA			0x18		/* MPU401 data register (8 bits)       		*/

--=-PhgVDqv7uxxm1hLeULtv--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
