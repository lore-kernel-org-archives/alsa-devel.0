From: Shapeshifter <sphaerodactylus@gmail.com>
Subject: USB microphone not working. No sound,
	although device visible.
Date: Tue, 23 Jun 2009 22:05:22 +0200
Message-ID: <4A413582.30605@archlinux.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 766C32445E
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 22:06:01 +0200 (CEST)
Received: by fxm26 with SMTP id 26so351415fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2009 13:06:01 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

Hi there. Following problem, details below:

PROBLEM:

I can't record anything using the microphone which is integrated into my
USB webcam. The cam shows up as a device, and I can adjust the only
available mixer which is for <Mic> in [Capture]. It's not muted and it's
maxed out.

DETAILS and PASTES:

Alsa-info output:
http://www.alsa-project.org/db/?f=f12fd357bc269d27ebdb4b5d562227bbe22a1086

You might notice the device comes up as [default]. If I run...

$ arecord -Dplughw:1,0 -f cd -vv /dev/null
or
$ arecord -Ddefault -f cd -vv /dev/null

then it out puts a lot of stuff (both the same) which I pasted in the
below pastebin, but at the bottom it doesn't show any #'s and %'s to
indicate the volume. The blue light on the webcam also turns on. If I
save to a file instead of /dev/null and aplay it, it's just silence.
Here's the output from the above command:
http://pastie.org/521697

Although if I run

$ arecord -Dhw:1,0 -f cd -vv /dev/null

then it fails with:

-> Recording WAVE '/dev/null' : Signed 16 bit Little Endian, Rate 44100
Hz, Stereo
-> arecord: set_params:984: Channels count non available"

I made a screenshot illustrating that everything is turned up and unmuted:
http://omploader.org/vMXZldg

ALREADY TRIED:

- Switching the two devices so that 0 becomes the webcam and 1 the
intel-hda through modprobe.conf but that had no other effect other than
the switching.
- Playing a lot with the device, muting, triplechecking volumes etc. etc.
- Trying recording something in audacity. First time, the light goes on
but it doesn't record, on subsequent tries, audacity spits an error
stating "error opening sound device".
- Trying it in linphone, light turns on, but other party can't hear
anything.




Any ideas how to fix hits? Btw, it used to work in ubuntu 9.04 for some
reason. Tried it on two Archlinux boxes, it's exactly the same on both.
But everything works really, everything is very up to date (I'm sure
ubuntu has older versions of stuff). Well, all the info is in the
alsa-info link above. Hope I can work this out!

Thanks for any input!

Regards.
