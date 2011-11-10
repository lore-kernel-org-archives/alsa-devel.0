From: Matteo Frigo <athena@fftw.org>
Subject: Success with TASCAM US144 MKII, linux-3.0
Date: Thu, 10 Nov 2011 11:15:29 -0500
Message-ID: <877h38ar8e.fsf@fftw.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from athena.fftw.org (athena.fftw.org [74.126.30.74])
	by alsa0.perex.cz (Postfix) with ESMTP id D0BA824396
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 17:15:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Tobias.Hansen@physik.uni-hamburg.de
List-Id: alsa-devel@alsa-project.org

Dear ALSA developers,

The purpose of this email is to report that I was able to play music
with a TASCAM US144 MKII using linux-3.0, specifically
linux-3.0.0-2-amd64 from Debian wheezy.  Various reports on this mailing
list and elsewhere seem to suggest that the US144 works with ALSA but
that the US144-MKII does not work.  I want to confirm that the
US144-MKII does in fact work with snd_usb_us122l, at least in playback
mode.  Here is what I did.

*Before* inserting the USB cable, execute "rmmod ehci-hcd".  It seems
like the unit uses a different protocol in USB2 mode, and I guess it
must be plugged into a USB1 interface.  The unit does not work if booted
in USB2 mode and then reset to USB1.

Add these lines to /etc/asound.conf:

pcm.!usb_stream {
	type usb_stream
	card "1"
}
ctl.!usb_stream {
	type hw
	card 1
}

Then

  aplay --buffer-size=1000 -MDplug:usb_stream foo.wav

works for me, where foo.wav is a {16,24}-bit stereo {44.1,48}-KHz PCM
file.

I am not sure whether the --buffer-size=1000 is necessary---I am using a
slow Atom netbook and the sound is choppy with the default buffer size.
Increasing the buffer size seems to fix the problem.

I don't know if the firmware revision matters, but my US144-MKII unit
has the lastest firmware 2.03, which I installed via a Windows machine.

Regards,
Matteo Frigo
