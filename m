From: yvonne barrymore <yvonneyb@gmail.com>
Subject: aloop / asym (ttable-bindings) Merging audio stream
	with SIP/Skype - .asoundrc struggle
Date: Wed, 28 Oct 2009 14:38:26 -0700
Message-ID: <47f89ad0910281438o2feefc7ao70c116189df8ad32@mail.gmail.com>
References: <47f89ad0910281125r6ce1ddfdp950e28987c9f6c0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.150])
	by alsa0.perex.cz (Postfix) with ESMTP id E923B24349
	for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2009 22:38:27 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 14so326251qwa.56
	for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2009 14:38:27 -0700 (PDT)
In-Reply-To: <47f89ad0910281125r6ce1ddfdp950e28987c9f6c0e@mail.gmail.com>
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

(NOTE: RESENT as received an email the alsa-devel mailinglist had moved.)


OBJECTIVE: merge =A0(mplayer cli or aplay) =A0audio stream with SIP/Skype
so that music can be heard during chat.

Really need help from a developer I think as alsa-users mailinglist
not able to help during past 2 weeks.

2 weeks happily studying alsa/plugins, posted/searched on mailing
lists and tried irc as well. Could really use a guru assist. I get the
parts mostly, though obviously not how it all comes together in an
.asoundrc.

=A0- aloop driver is installed.

After scores of attempts now wondering: =A0maybe having the music track
playing on it's own soundcard or loopback and having that merge into
the microphone? channel of sip/skype's soundcard.

Like, have the music play out on the intel card 0, and loopback
through aloop card 1, then merge that with asym/dmix onto sip/skype's
headset card 2 =A0????

I kinda know what the plugs do, though not how to hook-up through .asoundrc.

I've found 3 or 4 great posts on alsa-devel and alsa-users though
ultimately for me just glimmers of working.

Rather than glut up the list here I've only posted my aplay -l
Can anyone comment on exactly what I'd put in my .asoundrc? What the
flow/parts would be even?
To stop stuttering (fighting for card control ? etc.) I guessed that
the music playing on it's own card might be good?

Very happy to post what I've got though thought I should ask first if
anyone has found a best practice for this.

**** List of PLAYBACK Hardware Devices ****

card 0: Intel [HDA Intel], device 0: ALC1200 Analog [ALC1200 Analog]
=A0Subdevices: 1/1
=A0Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: ALC1200 Digital [ALC1200 Digital]
=A0Subdevices: 1/1
=A0Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 6: Si3054 Modem [Si3054 Modem]
=A0Subdevices: 1/1
=A0Subdevice #0: subdevice #0

card 1: Loopback [Loopback], device 0: Loopback PCM [Loopback PCM]
=A0Subdevices: 8/8
=A0Subdevice #0: subdevice #0
=A0Subdevice #1: subdevice #1
=A0Subdevice #2: subdevice #2
=A0Subdevice #3: subdevice #3
=A0Subdevice #4: subdevice #4
=A0Subdevice #5: subdevice #5
=A0Subdevice #6: subdevice #6
=A0Subdevice #7: subdevice #7
card 1: Loopback [Loopback], device 1: Loopback PCM [Loopback PCM]
=A0Subdevices: 8/8
=A0Subdevice #0: subdevice #0
=A0Subdevice #1: subdevice #1
=A0Subdevice #2: subdevice #2
=A0Subdevice #3: subdevice #3
=A0Subdevice #4: subdevice #4
=A0Subdevice #5: subdevice #5
=A0Subdevice #6: subdevice #6
=A0Subdevice #7: subdevice #7

card 2: default [C-Media USB Headphone Set =A0], device 0: USB Audio [USB A=
udio]
=A0Subdevices: 1/1
=A0Subdevice #0: subdevice #0
