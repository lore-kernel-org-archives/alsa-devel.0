From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Documentation Bugs
Date: Tue, 27 Jan 2004 11:12:10 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0401271103320.2021-100000@studcom.urz.uni-halle.de>
References: <1074896628.13428.189.camel@moria.arnor.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mlucom10.urz.uni-halle.de (mlucom10.urz.Uni-Halle.DE [141.48.3.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA15168
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2004 11:12:21 +0100
In-reply-to: <1074896628.13428.189.camel@moria.arnor.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: Patrick Shirkey <pshirkey@boosthardware.com>, ALSA Development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Torrey Hoffman wrote:
> My .asoundrc at this point closely follows the documentation (with
> corrections as noted in bug#2) and looks like:
>
> pcm.ac97 {
> 	type hw
> 	card 0
> 	device 0
> }
>
> pcm_slave.sl2 {
> 	pcm ac97
> 	rate 44100
> }
>
> pcm.rate_convert {
> 	type rate
> 	slave sl2
> }
>
> The documentation says:
> "Now you can call this newly created virtual device by: aplay -D
> rate_convert test.wav"
>
> But when I try that, I get this error:
>
> Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> aplay: set_params:805: Broken configuration for this PCM: no configurations available
>
> Note that "aplay -D ac97 test.wav" works, but plays too fast (at 48000),
> and gives the warning "please, try the plug plugin (-Dplug:ac97)". If I
> do that, it works perfectly.

This example is intended to demonstrate a virtual device that accepts
all sample rates and converts them to 44.1 kHz before playing.

However, it seems your hardware supports 48 kHz only.

I think the example should use 48 instead of 44.1 because that is the
only sample rate guaranteed to be available on AC'97 codecs.


HTH
Clemens




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
