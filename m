From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Sun, 28 Feb 2010 15:32:12 +0800
Message-ID: <4f3252891002272332n420e835fp4dd571742db47f92@mail.gmail.com>
References: <4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
	<4f3252891002172215j7b85313ci3626a1bdad5c040c@mail.gmail.com>
	<20100218181322.GB5606@tango.0pointer.de>
	<alpine.LNX.2.00.1002190916410.28127@eeebox2.perex-int.cz>
	<4f3252891002190257u608073c3l48f2251d8a6458ee@mail.gmail.com>
	<20100219151328.GC25873@tango.0pointer.de>
	<4f3252891002201949k48e0208fw40590803ac1a8192@mail.gmail.com>
	<20100221193933.GA31800@tango.0pointer.de>
	<4f3252891002222047g33ecdb74qce6a997ea5792c0@mail.gmail.com>
	<20100223222004.GA5313@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f197.google.com (mail-pz0-f197.google.com
	[209.85.222.197])
	by alsa0.perex.cz (Postfix) with ESMTP id EF4A924445
	for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2010 08:32:14 +0100 (CET)
Received: by pzk36 with SMTP id 36so1158180pzk.8
	for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2010 23:32:13 -0800 (PST)
In-Reply-To: <20100223222004.GA5313@tango.0pointer.de>
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

2010/2/24 Lennart Poettering <mznyfn@0pointer.de>

> On Tue, 23.02.10 12:47, Raymond Yau (superquad.vortex2@gmail.com) wrote:
>
>
> Are you suggesting that on all drivers the the index part of a
> snd_mixer_selem_id_t directly relates to the subdevice id of a PCM
> stream on the same card? Is that true? Jaroslav, Clemens, Takashi, can
> you say something about that?
>
> (tbh I find that very unlikely, given that the device index would not be
> encoded then)
>
> Lennart
>
>
Those are the per voice volume control of the hardware mixing sound card

This is a little bit different from the pulse pre-application volume control
.

It seem that pulseaudio allow the application open only one audio stream ,
but this per voice volume control allow application to open more than one
audio stream

e.g. Skype need to play the human voice and the ringing bell and it have to
open two audio streams using either two hw devices or dmix
