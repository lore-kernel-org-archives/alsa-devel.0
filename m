From: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Subject: Re: [PATCH 2/5] ALSA: snd-usb: implement new endpoint
	streaming model
Date: Wed, 21 Dec 2011 17:11:51 +0000
Message-ID: <CAE-xCyNV0u1PBiHt_tXQT5dqgGE=LhLYyTEfuoAKxO1TvqOXyQ@mail.gmail.com>
References: <1324424088-5705-1-git-send-email-zonque@gmail.com>
	<1324424088-5705-3-git-send-email-zonque@gmail.com>
	<CAE-xCyM-RZxQHbXUH4aswQS_xraEM-vMVynfDiSsj5ZUyq5Gkw@mail.gmail.com>
	<4EF20A81.9070307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1AD7A243EB
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 18:11:53 +0100 (CET)
Received: by vcbf13 with SMTP id f13so5093276vcb.38
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 09:11:51 -0800 (PST)
In-Reply-To: <4EF20A81.9070307@gmail.com>
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

>> In dmesg, I get the following:
>> [ =A0 92.185624] BUG: unable to handle kernel NULL pointer dereference
>> at 0000000000000008
>> [ =A0 92.185637] IP: [<ffffffffa05c9768>]
>> snd_usb_endpoint_activate+0x18/0x90 [snd_usb_audio]
>
> Can you do a quick fix and add the following two lines right at the
> beginning of snd_usb_endpoint_activate() in sound/usb/endpoint.c:
>
> =A0 =A0 =A0 =A0if (!ep)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> ? I'll fix this in a nicer way, but that should work.

Code changed and compiled.
Unfortunately my whole machine freezes as soon as I start Jack.

What info should I provide to you?

Aur=E9lien
