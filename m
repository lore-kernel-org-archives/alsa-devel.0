From: Jonathan Gardner <jgardner@jonathangardner.net>
Subject: Re: Gigabyte 880GM-USB3 MIDI and Dolby 5.1/7.1 issues
Date: Thu, 9 Dec 2010 04:12:33 -0800
Message-ID: <AANLkTikTKQkQqAMddajMHCk1trj=4ncvnbOMLbB-Ctjo@mail.gmail.com>
References: <AANLkTimb5AnPm13d0kpMmjq4nOTH0dXA_VyO2CXbr_bQ@mail.gmail.com>
	<4D00C2EA.1060204@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B7A92103C80
	for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2010 13:12:36 +0100 (CET)
Received: by vws20 with SMTP id 20so1462111vws.38
	for <alsa-devel@alsa-project.org>; Thu, 09 Dec 2010 04:12:33 -0800 (PST)
In-Reply-To: <4D00C2EA.1060204@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 9, 2010 at 3:52 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Jonathan Gardner wrote:
>> First, with my older motherboard, I could control the various output
>> and input levels of the channels. With this motherboard, I only have
>> one channel "Internal Audio Analog Stereo".
>
> This looks like PulseAudio's idea of a user-friendly abstraction.
> Try "alsamixer -D hw:0".
>

Beautiful. That's what I'm looking for.

So should I work with PulseAudio to get their GUI working with my
particular situation?

>> Second, I never really got MIDI working, at least not that I recall in
>> my 10 years of Linux. I know MIDI is possible, I just don't know what
>> it takes. I've been playing with musescore which apparently plays the
>> notes over MIDI so you can hear what you wrote, which would be nice.
>
> Your mainboard doesn't support MIDI, but I guess you don't have any
> external MIDI devices anyway.
>
> To play back MIDI data, you need some synthesizer. =A0Try FluidSynth.
>

I'm playing around with qsynth and pianobooster. No success with sound
yet, but I'm keeping notes.

-- =

Jonathan Gardner
jgardner@jonathangardner.net
