From: Erik Slagter <erik@slagter.name>
Subject: SPDIF/IEC958 sample rate on HDA/ALC882
Date: Wed, 01 Nov 2006 17:58:55 +0100
Message-ID: <4548D24F.7080409@slagter.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sorry if this is considered to be "user" question, but I got no response
at all from the "user" list. Guess the real cracks hang around here.

I have lots of questions I cannot resolve from all of the docs, but for
the moment I'll stick to the most important one.

The combination of HDA/ALC882 should be able to deliver sound at 96 kHz
(hda..., right...) Also the ALC882 datasheet says it can deliver sound
at 96 kHz.

In practise, though, I cannot get it to output any other sample rate
than 48 kHz. Any other sample rate handed to hw:0,0 is simply converted
(somewhere??? and badly...) to 48 kHz and the SPDIF is still driven at
48 kHz.

iecset allows me to set the rate to 32/44.1/48 kHz, the spdif output is
still at 48 kHz. Some other flags from iecset are actually honoured
(like "data" and "emphasis").

I can ask aplay to play at various rates (from a suitable PCM file), but
it complains at any other rate than 44.1 or 48 (notably 32) kHz that the
rate is not supported. It plays at 44.1 kHz though. And again converts
it to 48 kHz! Sigh...

Maybe I am using the wrong "hw", there is also a "hw:0,2" device, which
I cannot make work properly at all (only one channel is output, large
chunks are discarded, much much clipping).

Please help, I am totally lost here...

Info:

  0: [ 0]   : control
 16: [ 0- 0]: digital audio playback
 18: [ 0- 2]: digital audio playback
 24: [ 0- 0]: digital audio capture
 25: [ 0- 1]: digital audio capture
 33:        : timer

Alsa version 1.0.12rc1 (linux 2.6.18) on X86_64

Other output on request.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
