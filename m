From: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Subject: Re: snd-usb endpoint rework
Date: Thu, 31 May 2012 21:32:25 +0100
Message-ID: <CAE-xCyO-X29MPAXvH=68QVT3C-EsHA_c+GHYbQ=pgvhhnqeGow@mail.gmail.com>
References: <CAE-xCyN+T_cMnmbALn1SZX2GOVkPZ40p4v=fP29+Upqur6TGug@mail.gmail.com>
	<CAE-xCyP-mN=txZwjnV4Vd6h8UgM-Qgn83jxin6LiYH0Q2-Daiw@mail.gmail.com>
	<4FBA12E3.2040009@gmail.com>
	<CAE-xCyOeKjYJrGsa=yt+1U9Wc7x+OhmhYyWQEFCsELww7+Z+-g@mail.gmail.com>
	<4FBA1F01.4010606@gmail.com>
	<CAE-xCyNAKUEuHereXpoDUzR2VazY_JCUAMOSxxJWe_F65T06jw@mail.gmail.com>
	<4FBAC776.9060801@gmail.com>
	<CAE-xCyPEhMQjPYdbSShDo8P6nEeYSrKWJdKTMi+B_ws7Wq8sUA@mail.gmail.com>
	<4FBCEBDB.6000209@gmail.com>
	<CACckToWtFep7G4Qn=JAwJMdxwQadiQ8_KSi84D7A2vLKQihV6A@mail.gmail.com>
	<CAFz=ag6p5rouC4zFN7ezr79smS62Fzs8Jt4NBX3nxSUd_PKtdA@mail.gmail.com>
	<CAE-xCyOwFkH7KnfyLt02pJ37F8ZkUtxvi4fdmqReAxoTT2=_FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E74A4104490
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2012 22:32:26 +0200 (CEST)
Received: by vbip1 with SMTP id p1so917609vbi.38
	for <alsa-devel@alsa-project.org>; Thu, 31 May 2012 13:32:25 -0700 (PDT)
In-Reply-To: <CAE-xCyOwFkH7KnfyLt02pJ37F8ZkUtxvi4fdmqReAxoTT2=_FA@mail.gmail.com>
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
Cc: Grant Diffey <gdiffey@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

Hello Daniel,

As I told you in my previous mail, after few hours of frustration and
testing, I decided to do a fresh install of Ubuntu 12.04 64bit.

After reinstalling Ubuntu, my first step was to compile Takashi's kernel.
And it worked! I could play a song on the FTU, run Jackd, etc.

Unfortunately, after re-installing all my music software and updating
Ubuntu, I'm now back to the scenarios I presented to you previously...

What I will do now is:
- Keep the .deb of the different kernel I compiled.
- Re-install once again my laptop.
- Not do any update nor install anything but the kernels
- Do my testings.

If this works, I guess we can conclude that something in Ubuntu is
messing with the sound-usb modules.

I'll keep you updated.

If you have any updates, let me know,

Aur=E9lien

On Sat, May 26, 2012 at 5:48 PM, Aur=E9lien Leblond <blablack@gmail.com> wr=
ote:
> Hi Daniel,
>
> I have tried to do a bit more thorough testing, find the details below.
> Hope this helps!
>
>>> blablack@igorito:~$ aplay 10\ -\ Track\ 10-L.wav
>>> ALSA lib confmisc.c:768:(parse_card) cannot find card '0'
>>> ALSA lib conf.c:4241:(_snd_config_evaluate) function
>>> snd_func_card_driver returned error: No such file or directory
>>> ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
>>> ALSA lib conf.c:4241:(_snd_config_evaluate) function snd_func_concat
>>> returned error: No such file or directory
>>> ALSA lib confmisc.c:1251:(snd_func_refer) error evaluating name
>>> ALSA lib conf.c:4241:(_snd_config_evaluate) function snd_func_refer
>>> returned error: No such file or directory
>>> ALSA lib conf.c:4720:(snd_config_expand) Evaluate error: No such file
>>> or directory
>>> ALSA lib pcm.c:2217:(snd_pcm_open_noupdate) Unknown PCM default
>>> aplay: main:682: audio open error: No such file or directory
>>
>> What does "aplay -l" show? Also, what does it show on the older Ubuntu
>> kernel? Is there any difference?
>
> That is just me being an idiot. Ubuntu never mounts a USB sound card
> on the first slot.
> Compiling with the original Alsa coming from Ubuntu, I get the same error.
>
>>> No sound...
>>> I tried to reboot several times, unplug/replug, checked alsamixer: all
>>> look fine to me but still no sound.
>>> Actually, it is not "exactly" no sound: I can see the 4 front leds
>>> flash very quickly, and I can hear a click in the speakers (with the
>>> FX, the click is longer due to the reverb, handy to notice it!).
>>
>> The 4 front LEDs on the FTU signal input level activity, not output. Is
>> there anything connected to those inputs?
>
> There are stuff plugged on the 3 first inputs (2 for my guitar, 1 for
> my mic), bit they are all turned off during testing.
> This click and the 4 leds flash is very similar to the one you have
> when the FTU is plugged in to the USB port after being turned on.
> Somehow, when I want to play something, it makes the 4 leds flash + a
> click/crackle in the speakers.
>
>>> IN BOTH CASES, FTU AND UA-25EX
>>>
>>> Starting jack result in an immediate freeze of the system.
>>
>> I really fail to see any of these issues on my system. I tried with both
>> jackd and jackd2 and set them to real time priorities and chose 64 bytes
>> sample frames in PureData. All good, no lockups. Can you describe your
>> jackd setup? How do you start it?
>
> jackd -dalsa -dhw:1 -r48000 -p256 -n3 -Xseq
>
>
> Normal Ubuntu Kernel:
> =A0 =A0 =A0 =A0- Compiled with low latency settings
> =A0 =A0 =A0 =A0- 3.2.18
> =A0 =A0 =A0 =A0- Original Alsa
>
> =A0 =A0 =A0 =A0* FTU
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- mplayer: OK
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- jack: OK
>
> =A0 =A0 =A0 =A0* UA-25Ex
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- mplayer: OK
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- jack: OK
>
> Ubuntu Kernel + Alsa Git:
> =A0 =A0 =A0 =A0- Compiled with low latency settings
> =A0 =A0 =A0 =A0- 3.2.18
> =A0 =A0 =A0 =A0- Alsa from git alsa-kmirror and alsa-driver
> =A0 =A0 =A0 =A0- git alsa-kmirror and alsa-driver fetched today (25th May)
>
> =A0 =A0 =A0 =A0* FTU
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- mplayer: plays but no sound
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- jack: freezes the whole system
>
> =A0 =A0 =A0 =A0* UA-25Ex
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- mplayer: Ok
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- jack: freezes the whole system
>
> "Pig" Kernel:
> =A0 =A0 =A0 =A0- Original Ubuntu Kernel
> =A0 =A0 =A0 =A0- 3.2.18
> =A0 =A0 =A0 =A0- Compiled with low latency settings
> =A0 =A0 =A0 =A0- sound/usb directory from Kernel replaced by sound/usb di=
rectory
> from Takashi's Kernel - thus the name of this setup, "Pig" :) :)
>
> =A0 =A0 =A0 =A0* FTU
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- mplayer: I get click + 4 led flash, and =
then just got half a
> second of the song before it goes mute. Unplug/Replug, same results
> (except the sound goes mute after 5/10 sec, tried several times, I
> couldn't to 15 seconds). Mplayer keeps reading, but there is no sound.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- jack: Works ok, but I have no sound! (wa=
s after unplug/replug)
>
> =A0 =A0 =A0 =A0* UA-25Ex
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- mplayer: OK
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- jack: freezes the whole system
>
>
> Takashi's Kernel:
> =A0 =A0 =A0 =A0- Compiled with low latency settings
> =A0 =A0 =A0 =A0- 3.4.0
> =A0 =A0 =A0 =A0- Alsa from Takashi's kernel
> =A0 =A0 =A0 =A0- Fetched today (26th May)
>
> =A0 =A0 =A0 =A0* FTU
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- mplayer: I get click + 4 led flash, and =
then just got half a
> second of the song before it goes mute. Unplug/Replug, same results
> (except the sound goes mute after 5/10 sec, tried several times, I
> couldn't to 15 seconds). Mplayer keeps reading, but there is no sound.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- jack: =A0Works ok, but I have no sound! =
(was after unplug/replug)
>
> =A0 =A0 =A0 =A0* UA-25Ex
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- mplayer: OK
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0- jack: OK
>
>
> I hope this will help you find out where the problem is.
> At least for now I can use the 3.4.0 kernel with the UA-25Ex
>
> Let me know if I can provide you with any more details.
>
> Regards,
> Aur=E9lien
