From: Daniel Mack <zonque@gmail.com>
Subject: Re: snd-usb endpoint rework
Date: Mon, 21 May 2012 12:54:57 +0200
Message-ID: <4FBA1F01.4010606@gmail.com>
References: <CAE-xCyN+T_cMnmbALn1SZX2GOVkPZ40p4v=fP29+Upqur6TGug@mail.gmail.com>
	<CAE-xCyP-mN=txZwjnV4Vd6h8UgM-Qgn83jxin6LiYH0Q2-Daiw@mail.gmail.com>
	<4FBA12E3.2040009@gmail.com>
	<CAE-xCyOeKjYJrGsa=yt+1U9Wc7x+OhmhYyWQEFCsELww7+Z+-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id DE589243EA
	for <alsa-devel@alsa-project.org>;
	Mon, 21 May 2012 12:55:11 +0200 (CEST)
Received: by bkcjg15 with SMTP id jg15so3954946bkc.38
	for <alsa-devel@alsa-project.org>; Mon, 21 May 2012 03:55:11 -0700 (PDT)
In-Reply-To: <CAE-xCyOeKjYJrGsa=yt+1U9Wc7x+OhmhYyWQEFCsELww7+Z+-g@mail.gmail.com>
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

On 21.05.2012 12:19, Aur=E9lien Leblond wrote:
>> On 20.05.2012 16:13, Aur=E9lien Leblond wrote:
>>>> Hello everyone,
>>>>
>>>> I compiled today the Kernel 3.4.0-rc7 from the git and used this git
>>>> to add the FTU support:
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>>>>
>>>> Unfortunately, all my USB sound card simply stopped working.
>>>>
>>>> The FTU doesn't produce any sound, nor through Alsa or Jack.
>>>> I tried playing a simple song through mplayer and nothing. I double
>>>> checked the mixer, all volumes are set as they should.
>>>> I checked dmesg, no error that could help.
>>>> I'm running Ubuntu, and the only thing I can hear is the welcoming
>>>> sound of ubuntu being cut-off almost instantly.
>>>>
>>>> I tested my Edirol UA-25Ex, it is working all ok.
>>>
>>> Correction, the UA-25Ex doesn't work either.
>>> The sound dies out after a few minutes being used.
>>
>> Odd. I did just that - built a kernel from Takashi's master branch - and
>> cannot reproduce the effect you're seeing. I'm testing with both the FTU
>> and a NI Traktor Audio 6 (which is a class compliant device) and both
>> stream reliable.
>>
>> Are you totally sure that your hardware setup is ok? Did you change the
>> USB cables or anything? Does running an older kernel, while leaving
>> everthing else the same, solve the problem?
> =

> Yes, I checked running the standard Ubuntu Kernel, and the FTU/UA25-Ex
> are running ok.
> But it is a 3.2 Kernel, so the stream logic is not available.
> =

> Yesterday, I compiled alsa-driver from the alsa-driver.git and
> alsa-kmirror.git (I'm actually not sure what is the difference between
> this gits and the one from Takashi) and installed it on the kernel 3.2
> coming with Ubuntu.
> I get the exact same results:
> - the FTU doesn't produce any sound BUT the Ubuntu welcome one.

Can you try using something like xmms maybe? I'm interested whether the
audio interface does consume any data or if the whole thing is stuck.

> Although the mixers are ok, I'm starting to wonder if they might still
> be muted.

There were some other patches to augment the mixer routing
possibilities. Not sure if that has any relation to your issues, but I
doubt it.

> (on that note, the "internal" sound of the FTU is ok, I can play my
> guitar plugged on the soundcard and hear it properly).

That doesn't include any streaming to the host and back, so that doesn't
help much unfortunately.

> - I haven't tested the UA-25Ex with that setup, I'll try that this evenin=
g.
> =

>>> When the sound dies out, dmesg prints:
>>>
>>> [  550.114621] urb status -32
>>> [  551.601237] urb status -32
>>> [  551.681206] urb status -32
>>> [  553.563336] urb status -32
>>> [  565.588044] urb status -32
>>> [  566.786965] urb status -32
>>> [  625.130221] cannot submit urb 0, error -28: not enough bandwidth
>>>
>>> If there is any other info I can provide, let me know,
>>
>> Can you provide more context of the logs?
> =

> I'll provide a fuller log this evening.

Please do and also include the lines that are produced when you plug in
the device.

Felix, Grant - can you try booting a kernel built from Takashi's master
branch and check with the FTU and other cards?


Thanks,
Daniel
