From: Thomas Charbonnel <thomas@undata.org>
Subject: [PATCH] HDSP rms and peak registers correct offsets (was: Re:
	hdsp driver)
Date: 03 Mar 2003 00:43:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046648582.1702.9.camel@satellite.undata.org>
References: <200302271843.h1RIhYa04397@linuxaudiosystems.com>
	 <1046636688.1523.37.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-WwxXO8MkpAL2ng0+uFji"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1046636688.1523.37.camel@satellite.undata.org>
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


--=-WwxXO8MkpAL2ng0+uFji
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2003-03-02 at 21:24, Thomas Charbonnel wrote:
> On Thu, 2003-02-27 at 19:43, Paul Davis wrote:
> > i haven't had time today to get the patch for the hdsp ready. however,
> > the new source works here (i have some CVS sync issues). i'll get it
> > out to the list on monday (i'm gone for the weekend).
> > 
> Did you sort out the rms register issue ? I'm currently implementing the
> metering part of HDSPMixer and the rms values returned are obviously
> bogus.
> 
> Thomas

Ok, I sorted it out myself, the offsets for the rms and peak registers
were wrong. Sorry Paul, I could have seen this much earlier if I had
done more extensive tests: I kept on testing inputs 1 and 2 while the
input rms offset pointed on input 3... :-\

The correct offsets can be found in the attached patch.

Thomas


--=-WwxXO8MkpAL2ng0+uFji
Content-Disposition: attachment; filename=hdsp_registers.patch
Content-Type: text/plain; name=hdsp_registers.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- hdsp.c.orig	2003-03-03 00:30:46.000000000 +0100
+++ hdsp.c	2003-03-03 00:32:10.000000000 +0100
@@ -123,9 +123,9 @@
 
 #define HDSP_playbackPeakLevel  4096  /* 26 * 32 bit values */
 #define HDSP_inputPeakLevel     4224  /* 26 * 32 bit values */
-#define HDSP_outputPeakLevel    4100  /* 26 * 32 bit values */
+#define HDSP_outputPeakLevel    4096  /* 26 * 32 bit values */
 #define HDSP_playbackRmsLevel   4612  /* 26 * 64 bit values */
-#define HDSP_inputRmsLevel      4884  /* 26 * 64 bit values */
+#define HDSP_inputRmsLevel      4868  /* 26 * 64 bit values */
 
 #define HDSP_IO_EXTENT     5192
 

--=-WwxXO8MkpAL2ng0+uFji--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
