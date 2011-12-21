From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/5] ALSA: snd-usb: implement new endpoint
	streaming model
Date: Wed, 21 Dec 2011 18:18:30 +0100
Message-ID: <4EF214E6.8050405@gmail.com>
References: <1324424088-5705-1-git-send-email-zonque@gmail.com>
	<1324424088-5705-3-git-send-email-zonque@gmail.com>
	<CAE-xCyM-RZxQHbXUH4aswQS_xraEM-vMVynfDiSsj5ZUyq5Gkw@mail.gmail.com>
	<4EF20A81.9070307@gmail.com>
	<CAE-xCyNV0u1PBiHt_tXQT5dqgGE=LhLYyTEfuoAKxO1TvqOXyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 04FD5243F4
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 18:18:35 +0100 (CET)
Received: by eekb57 with SMTP id b57so7348390eek.38
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 09:18:35 -0800 (PST)
In-Reply-To: <CAE-xCyNV0u1PBiHt_tXQT5dqgGE=LhLYyTEfuoAKxO1TvqOXyQ@mail.gmail.com>
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

On 12/21/2011 06:11 PM, Aur=E9lien Leblond wrote:
>>> In dmesg, I get the following:
>>> [   92.185624] BUG: unable to handle kernel NULL pointer dereference
>>> at 0000000000000008
>>> [   92.185637] IP: [<ffffffffa05c9768>]
>>> snd_usb_endpoint_activate+0x18/0x90 [snd_usb_audio]
>>
>> Can you do a quick fix and add the following two lines right at the
>> beginning of snd_usb_endpoint_activate() in sound/usb/endpoint.c:
>>
>>        if (!ep)
>>                return 0;
>>
>> ? I'll fix this in a nicer way, but that should work.
> =

> Code changed and compiled.
> Unfortunately my whole machine freezes as soon as I start Jack.

*sigh*

Which hardware is connected? Did you try that with both? Did you try
with anything else than jack? I'd need more information about your setup
to get an idea.

Daniel
