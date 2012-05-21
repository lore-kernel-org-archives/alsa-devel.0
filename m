From: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Subject: Re: snd-usb endpoint rework
Date: Mon, 21 May 2012 19:45:19 +0100
Message-ID: <CAE-xCyNAKUEuHereXpoDUzR2VazY_JCUAMOSxxJWe_F65T06jw@mail.gmail.com>
References: <CAE-xCyN+T_cMnmbALn1SZX2GOVkPZ40p4v=fP29+Upqur6TGug@mail.gmail.com>
	<CAE-xCyP-mN=txZwjnV4Vd6h8UgM-Qgn83jxin6LiYH0Q2-Daiw@mail.gmail.com>
	<4FBA12E3.2040009@gmail.com>
	<CAE-xCyOeKjYJrGsa=yt+1U9Wc7x+OhmhYyWQEFCsELww7+Z+-g@mail.gmail.com>
	<4FBA1F01.4010606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CF4E910405A
	for <alsa-devel@alsa-project.org>;
	Mon, 21 May 2012 20:45:20 +0200 (CEST)
Received: by vbip1 with SMTP id p1so3893715vbi.38
	for <alsa-devel@alsa-project.org>; Mon, 21 May 2012 11:45:19 -0700 (PDT)
In-Reply-To: <4FBA1F01.4010606@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

> Can you try using something like xmms maybe? I'm interested whether the
> audio interface does consume any data or if the whole thing is stuck.

This is now getting weirder and weirder, but here are the results of
today's testing.

Yesterday and today, I have been running the Kernel 3.2.16 with the Alsa gi=
t.
Yesterday I couldn't play any sound whatsoever with the FTU, and the
UA25-Ex was dying out after a few minutes.

Today:
(the testing is done using VLC connecting directly to ALSA, I removed
pulseaudio from Ubuntu a few days ago to eliminate that as a possible
cause)
The first time I started my laptop with the FTU plugged - no sound,
VLC is not hanging (I can see playing time move along).
Unplugged the FTU, plugged back - VLC is now playing sound, but the
sound quality is very "low-def" (I'm not sure how to explain that
properly).
Restarting my laptop, FTU plugged in - VLC is now playins sound, still
with very poor sound quality.

Restarting my laptop with the UA-25Ex plugged in - VLC is working ok,
sound quality is good, been running it for 10 minutes without a
problem.

Im both cases, starting Jack results in an immediate freeze of my
laptop with CPU going 100% (I guess, as the laptop fan is going
crazy), and I guess it is related as running Jack on the previous
driver/original Ubuntu kernel is ok.

>> Although the mixers are ok, I'm starting to wonder if they might still
>> be muted.
>
> There were some other patches to augment the mixer routing
> possibilities. Not sure if that has any relation to your issues, but I
> doubt it.
>

>> - I haven't tested the UA-25Ex with that setup, I'll try that this eveni=
ng.
>>
>>>> When the sound dies out, dmesg prints:
>>>>
>>>> [ =A0550.114621] urb status -32
>>>> [ =A0551.601237] urb status -32
>>>> [ =A0551.681206] urb status -32
>>>> [ =A0553.563336] urb status -32
>>>> [ =A0565.588044] urb status -32
>>>> [ =A0566.786965] urb status -32
>>>> [ =A0625.130221] cannot submit urb 0, error -28: not enough bandwidth
>>>>
>>>> If there is any other info I can provide, let me know,
>>>
>>> Can you provide more context of the logs?

I cannot reproduce this problem anymore. If I encounter it again, I'll
save a trace of the dmesg.

It's quite hard to provide you with proper info as it almost looks
like everyday produce a new scenario.

If there is anything I can provide to help, let me know,

Aur=E9lien
