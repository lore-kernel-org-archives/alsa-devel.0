From: Karthik Ramgopal <applefreakpeeps@gmail.com>
Subject: Re: Regarding Sound on Acer Aspire 6935G
Date: Sat, 6 Jun 2009 11:22:20 +0800
Message-ID: <4b8c423b0906052022w72e29e8ud91c7c72f92b5827@mail.gmail.com>
References: <4b8c423b0905152051w7443e1b4u4080514a560fbb6c@mail.gmail.com>
	<d54969c50905230819m55f532c6kf8006b2455ccfee@mail.gmail.com>
	<s5hmy93el7i.wl%tiwai@suse.de>
	<d54969c50905231651s507ea7ddve40cdf62b0908687@mail.gmail.com>
	<d54969c50905240951v2fd01b97j79d0c618bfdd4578@mail.gmail.com>
	<d54969c50905271227y76eefde2x2e784cd391cd6729@mail.gmail.com>
	<s5htz361d3i.wl%tiwai@suse.de> <s5hhbz61b8v.wl%tiwai@suse.de>
	<d54969c50905291035v19ab019fsdf455a6410b827de@mail.gmail.com>
	<d54969c50906052020m1202230eveab8ecc18c4b06ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.248])
	by alsa0.perex.cz (Postfix) with ESMTP id E10AA2443B
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Jun 2009 05:22:21 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id l33so352798rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 05 Jun 2009 20:22:20 -0700 (PDT)
In-Reply-To: <d54969c50906052020m1202230eveab8ecc18c4b06ae@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
      Any progress on 6935G? Not even latest alsa-snapshot is able to get
jack detection and mic working. Controls wrongly mapped as usual.

Regards and Thanks,
Karthik

On Sat, Jun 6, 2009 at 11:20 AM, Emilio L=F3pez <buhitoescolar@gmail.com>wr=
ote:

> Takashi, were you able to have a look at it? Any idea on what might be
> going on? I guess this is an easy to fix issue, as it worked with the old
> mode, the channel might just need registering or something.
>
> Thanks!
>
> 2009/5/29 Emilio L=F3pez <buhitoescolar@gmail.com>
>
>>
>>
>> 2009/5/27 Takashi Iwai <tiwai@suse.de>
>>
>>> At Wed, 27 May 2009 22:54:09 +0200,
>>> I wrote:
>>> >
>>> > At Wed, 27 May 2009 16:27:00 -0300,
>>> > Emilio L=F3pez wrote:
>>> > >
>>> > > Did my last email arrive? Any idea on what might be going on?
>>> >
>>> > Sorry, no time for this right now.
>>> > It's usually just a missing channel connection or the lack of
>>> > the corresponding amp control.  In most cases, it's trivial if someone
>>> > with a knowledge of HD-audio spec sees it...
>>>
>>> Just took a quick look now, I found that you didn't unmute "Side
>>> Playback Switch" in the disabled case.  Do you mean that as
>>> "disabled"?
>>
>>
>> Disabled =3D Muted =3D Off, Enabled =3D Unmuted =3D On. So sound works o=
n enabled,
>> doesn't work on disabled.
>>
>>>
>>>
>>> I assume that these files are from the "old" driver with the bass
>>> working as Side volume.  Is it correct?
>>
>>
>> Yes
>>
>>>
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>>
>> Thanks for having a look at it :)
>>
>> Emilio
>>
>>
>>
>>
>>
>>>
>>>
>>> > Takashi
>>> >
>>> > >
>>> > > Emilio
>>> > >
>>> > > 2009/5/24 Emilio L=F3pez <buhitoescolar@gmail.com>
>>> > >
>>> > >     Well, it seems my last email was too heavy with the 4 files
>>> attached. I
>>> > >     have uploaded them to drop.io, here is the link: http://drop.io/
>>> > >     alsaonaceraspire6930
>>> > >
>>> > >     Thanks!
>>> > >
>>> > >     2009/5/23 Emilio L=F3pez <buhitoescolar@gmail.com>
>>> > >
>>> > >         Here you are, I ran alsa-info.sh in the old alsa (with
>>> model=3Dacer) and
>>> > >         saved the output of the script when side was enabled and
>>> disabled,
>>> > >         with volumes 0 and 100. Hope you can work out the problem
>>> with this,
>>> > >         do not hesitate to ask for more debug info if you need.
>>> > >
>>> > >         Thanks for all!
>>> > >
>>> > >         Emilio
>>> > >
>>> > >         PS: On my previous email (cited below) I wrote "Mic sensing"
>>> > >         incorrectly, I wanted to write "headphones sensing".
>>> > >
>>> > >         2009/5/23 Takashi Iwai <tiwai@suse.de>
>>> > >
>>> > >             At Sat, 23 May 2009 12:19:12 -0300,
>>> > >             Emilio L=F3pez wrote:
>>> > >             >
>>> > >             > I reinstalled 1.0.20 today and almost everything
>>> started working
>>> > >             when I set
>>> > >             > model=3Dacer-aspire-4930g. Mic sensing works, my mic =
now
>>> records
>>> > >             too. But my
>>> > >             > bass does not, and I cannot control it with "Side"
>>> anymore.
>>> > >             >
>>> > >             > Any idea on how to fix it? The audio setup for this
>>> laptop will
>>> > >             be fully
>>> > >             > working when I get the bass to play once again.
>>> > >
>>> > >             Could you check with the older version and what "Side"
>>> control
>>> > >             changes
>>> > >             in hd-audio codec registers?  You can just get
>>> alsa-info.sh output
>>> > >             before and after changing the "Side" control value.
>>> > >
>>> > >             thanks,
>>> > >
>>> > >             Takashi
>>> > >
>>> > >
>>>
>>
>>
>
