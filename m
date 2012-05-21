From: Daniel Mack <zonque@gmail.com>
Subject: Re: snd-usb endpoint rework
Date: Mon, 21 May 2012 12:03:15 +0200
Message-ID: <4FBA12E3.2040009@gmail.com>
References: <CAE-xCyN+T_cMnmbALn1SZX2GOVkPZ40p4v=fP29+Upqur6TGug@mail.gmail.com>
	<CAE-xCyP-mN=txZwjnV4Vd6h8UgM-Qgn83jxin6LiYH0Q2-Daiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 71CD724399
	for <alsa-devel@alsa-project.org>;
	Mon, 21 May 2012 12:03:30 +0200 (CEST)
Received: by bkcjg15 with SMTP id jg15so3911276bkc.38
	for <alsa-devel@alsa-project.org>; Mon, 21 May 2012 03:03:30 -0700 (PDT)
In-Reply-To: <CAE-xCyP-mN=txZwjnV4Vd6h8UgM-Qgn83jxin6LiYH0Q2-Daiw@mail.gmail.com>
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

Hi Aur=E9lien,

On 20.05.2012 16:13, Aur=E9lien Leblond wrote:
>> Hello everyone,
>>
>> I compiled today the Kernel 3.4.0-rc7 from the git and used this git
>> to add the FTU support:
>> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>>
>> Unfortunately, all my USB sound card simply stopped working.
>>
>> The FTU doesn't produce any sound, nor through Alsa or Jack.
>> I tried playing a simple song through mplayer and nothing. I double
>> checked the mixer, all volumes are set as they should.
>> I checked dmesg, no error that could help.
>> I'm running Ubuntu, and the only thing I can hear is the welcoming
>> sound of ubuntu being cut-off almost instantly.
>>
>> I tested my Edirol UA-25Ex, it is working all ok.
> =

> Correction, the UA-25Ex doesn't work either.
> The sound dies out after a few minutes being used.

Odd. I did just that - built a kernel from Takashi's master branch - and
cannot reproduce the effect you're seeing. I'm testing with both the FTU
and a NI Traktor Audio 6 (which is a class compliant device) and both
stream reliable.

Are you totally sure that your hardware setup is ok? Did you change the
USB cables or anything? Does running an older kernel, while leaving
everthing else the same, solve the problem?

> When the sound dies out, dmesg prints:
> =

> [  550.114621] urb status -32
> [  551.601237] urb status -32
> [  551.681206] urb status -32
> [  553.563336] urb status -32
> [  565.588044] urb status -32
> [  566.786965] urb status -32
> [  625.130221] cannot submit urb 0, error -28: not enough bandwidth
> =

> If there is any other info I can provide, let me know,

Can you provide more context of the logs?


Thanks,
Daniel
