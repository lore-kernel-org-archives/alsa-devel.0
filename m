From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Fast Track Ultra mixer - opinions anyone?
Date: Mon, 16 Apr 2012 14:45:25 +0200
Message-ID: <CAFz=ag4X99L2qfEf7RA0TjUH+Oc9ZYghaTqN+ydabGNMrUAGgA@mail.gmail.com>
References: <CAFz=ag4SmifT2jVE-NqcWXg_+go_WYD06c9ZM0HtC1KHKg7k6Q@mail.gmail.com>
	<CACckToVQ6Gm5th91-vyPugSGAPuWp9ZDDdZLqGerHWT==apHRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F420243BC
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 14:45:27 +0200 (CEST)
Received: by yenl1 with SMTP id l1so2489298yen.38
	for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2012 05:45:26 -0700 (PDT)
In-Reply-To: <CACckToVQ6Gm5th91-vyPugSGAPuWp9ZDDdZLqGerHWT==apHRQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

2012/4/16 Grant Diffey <gdiffey@gmail.com>:
>> ** dB values **
>>
>> Currently alsamixer does not report any dB changes when you change a
>> control value. I =A0don't know how to fix it. Anyone else?
>>
>
> What does dB value mean in this context given there's a hardware volume k=
nob
> on the device? is it just the db difference or is supposed to be some sort
> of dBm absolute output level

What I meant was: At the moment we can just change raw control values
without knowing what they mean. E.g. if we put some control value to
50% do we get linear gain of 50% . Do we have a logarithmic scale or a
"M-Audio-we-work-on-standards-but-dont-support-them" scale?
