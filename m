From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: [PATCH] HDSP rms and peak registers correct offsets (was: Re:
	hdsp driver)
Date: 03 Mar 2003 15:55:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046703347.1545.44.camel@satellite.undata.org>
References: <200302271843.h1RIhYa04397@linuxaudiosystems.com>
	 <1046636688.1523.37.camel@satellite.undata.org>
	 <1046648582.1702.9.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-U97Z2Pgk0HWq722XVC1l"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1046648582.1702.9.camel@satellite.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-U97Z2Pgk0HWq722XVC1l
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2003-03-03 at 00:43, Thomas Charbonnel wrote:
> The correct offsets can be found in the attached patch.
> 
Err... this wasn't the case.
The attached patch replaces the previous one and enhances it with line
outs metering.

The line outs peak registers were not accessible with the current
driver, so I added code to map them to ctls. The option I took is
mapping all the registers, even the unused ones (i.e. from 19 to 26 on
the Multiface), as those registers are always present, regardless of the
attached box. This approach also avoided ctl index discontinuity. (Due
to the way clts map registers, the ctls mapping the line out registers
(Output Peak) had to have indexes 27 and 29). 
As a side effect this transfers the task of electing relevant registers
to user space applications. (In this perspective I think the 9652
shouldn't look as a digiface from user space, as it has no line outs. It
should have an entry of its own in HDSP_type).

Paul, the meter section of the HDSPMixer is now functional. It helped me
a lot understand how wrong the registers offsets were. I can send you a
copy if you think it can help you implementing 9652 support.

Thomas


--=-U97Z2Pgk0HWq722XVC1l
Content-Disposition: attachment; filename=hdsp_regs_lineout.patch
Content-Type: text/plain; name=hdsp_regs_lineout.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- hdsp.c.orig	2003-03-03 00:30:46.000000000 +0100
+++ hdsp.c	2003-03-03 15:06:38.000000000 +0100
@@ -3,6 +3,7 @@
  *
  *      Copyright (c) 2002  Paul Davis
  *                          Marcus Andersson
+ *                          Thomas Charbonnel
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -123,9 +124,9 @@
 
 #define HDSP_playbackPeakLevel  4096  /* 26 * 32 bit values */
 #define HDSP_inputPeakLevel     4224  /* 26 * 32 bit values */
-#define HDSP_outputPeakLevel    4100  /* 26 * 32 bit values */
+#define HDSP_outputPeakLevel    4352  /* 28 * 32 bit values (26 + 2 line outs) */
 #define HDSP_playbackRmsLevel   4612  /* 26 * 64 bit values */
-#define HDSP_inputRmsLevel      4884  /* 26 * 64 bit values */
+#define HDSP_inputRmsLevel      4868  /* 26 * 64 bit values */
 
 #define HDSP_IO_EXTENT     5192
 
@@ -1864,14 +1865,12 @@
 		if ((err = snd_ctl_add (card, kctl = snd_ctl_new1(&snd_hdsp_playback_mixer, hdsp)))) {
 			return err;
 		}
+	}
+	for (idx = 0; idx < HDSP_MAX_CHANNELS; ++idx) {
 		snd_hdsp_input_peak.index = idx+1;
 		if ((err = snd_ctl_add (card, kctl = snd_ctl_new1(&snd_hdsp_input_peak, hdsp)))) {
 			return err;
 		}
-		snd_hdsp_output_peak.index = idx+1;
-		if ((err = snd_ctl_add (card, kctl = snd_ctl_new1(&snd_hdsp_output_peak, hdsp)))) {
-			return err;
-		}
 		snd_hdsp_playback_peak.index = idx+1;
 		if ((err = snd_ctl_add (card, kctl = snd_ctl_new1(&snd_hdsp_playback_peak, hdsp)))) {
 			return err;
@@ -1885,7 +1884,12 @@
 			return err;
 		}
 	}
-
+	for (idx = 0; idx < HDSP_MAX_CHANNELS + 2 ; ++idx) {
+		snd_hdsp_output_peak.index = idx+1;
+		if ((err = snd_ctl_add (card, kctl = snd_ctl_new1(&snd_hdsp_output_peak, hdsp)))) {
+			return err;
+		}
+	}
 	return 0;
 }
 

--=-U97Z2Pgk0HWq722XVC1l--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
