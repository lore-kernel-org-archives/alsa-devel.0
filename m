From: Daniel Mack <zonque@gmail.com>
Subject: Re: snd-usb endpoint rework
Date: Tue, 22 May 2012 00:53:42 +0200
Message-ID: <4FBAC776.9060801@gmail.com>
References: <CAE-xCyN+T_cMnmbALn1SZX2GOVkPZ40p4v=fP29+Upqur6TGug@mail.gmail.com>
	<CAE-xCyP-mN=txZwjnV4Vd6h8UgM-Qgn83jxin6LiYH0Q2-Daiw@mail.gmail.com>
	<4FBA12E3.2040009@gmail.com>
	<CAE-xCyOeKjYJrGsa=yt+1U9Wc7x+OhmhYyWQEFCsELww7+Z+-g@mail.gmail.com>
	<4FBA1F01.4010606@gmail.com>
	<CAE-xCyNAKUEuHereXpoDUzR2VazY_JCUAMOSxxJWe_F65T06jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AD30A10406B
	for <alsa-devel@alsa-project.org>;
	Tue, 22 May 2012 00:53:45 +0200 (CEST)
Received: by bkcjg15 with SMTP id jg15so4602932bkc.38
	for <alsa-devel@alsa-project.org>; Mon, 21 May 2012 15:53:45 -0700 (PDT)
In-Reply-To: <CAE-xCyNAKUEuHereXpoDUzR2VazY_JCUAMOSxxJWe_F65T06jw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

On 21.05.2012 20:45, Aur=E9lien Leblond wrote:
>> Can you try using something like xmms maybe? I'm interested whether the
>> audio interface does consume any data or if the whole thing is stuck.
> =

> This is now getting weirder and weirder, but here are the results of
> today's testing.
> =

> Yesterday and today, I have been running the Kernel 3.2.16 with the Alsa =
git.
> Yesterday I couldn't play any sound whatsoever with the FTU, and the
> UA25-Ex was dying out after a few minutes.
> =

> Today:
> (the testing is done using VLC connecting directly to ALSA, I removed
> pulseaudio from Ubuntu a few days ago to eliminate that as a possible
> cause)
> The first time I started my laptop with the FTU plugged - no sound,
> VLC is not hanging (I can see playing time move along).
> Unplugged the FTU, plugged back - VLC is now playing sound, but the
> sound quality is very "low-def" (I'm not sure how to explain that
> properly).

I think I ran into the same thing today. The reason for me was that the
new mixer controls that were added now allow setting the effect unit.
Actually, if you hear what I heared, this is just a simple reverb effect
that is overlayed. And yes, it sounds cheap :) I ran "alsamixer
-Dhw:Ultra" and switched all related controls off, and the the sound
came back again as expected.

> Restarting my laptop, FTU plugged in - VLC is now playins sound, still
> with very poor sound quality.
> =

> Restarting my laptop with the UA-25Ex plugged in - VLC is working ok,
> sound quality is good, been running it for 10 minutes without a
> problem.

Might be the controls are not yet properly initialized, and the hardware
comes up in an undefined state. That would be easy to solve.

> Im both cases, starting Jack results in an immediate freeze of my
> laptop with CPU going 100% (I guess, as the laptop fan is going
> crazy), and I guess it is related as running Jack on the previous
> driver/original Ubuntu kernel is ok.

That is another issue then, but certainly something I need to look into.

> I cannot reproduce this problem anymore. If I encounter it again, I'll
> save a trace of the dmesg.
> =

> It's quite hard to provide you with proper info as it almost looks
> like everyday produce a new scenario.

Usually the reason for loosing the overview is too many factors that are
involved when testing. Try to minimize the things you change from one
test run to the other as much as possible, and test extensively with one
configuration.

> If there is anything I can provide to help, let me know,

Every bit and piece of empiric information is valuable and might help
finding the issue :)


Thanks for your help,
Daniel
