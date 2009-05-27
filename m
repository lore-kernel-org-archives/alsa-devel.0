From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
Subject: Re: Regarding Sound on Acer Aspire 6935G
Date: Wed, 27 May 2009 16:27:00 -0300
Message-ID: <d54969c50905271227y76eefde2x2e784cd391cd6729@mail.gmail.com>
References: <4b8c423b0905152051w7443e1b4u4080514a560fbb6c@mail.gmail.com>
	<s5h3ab3ey8i.wl%tiwai@suse.de>
	<4b8c423b0905172313o5c51b8e5ud6f9f35d1952132f@mail.gmail.com>
	<4b8c423b0905172317r7314a345me83ae17cd0f20f5a@mail.gmail.com>
	<d54969c50905181600g761b9af4h585a74c45684f1ca@mail.gmail.com>
	<s5hzld9k5zi.wl%tiwai@suse.de>
	<d54969c50905230819m55f532c6kf8006b2455ccfee@mail.gmail.com>
	<s5hmy93el7i.wl%tiwai@suse.de>
	<d54969c50905231651s507ea7ddve40cdf62b0908687@mail.gmail.com>
	<d54969c50905240951v2fd01b97j79d0c618bfdd4578@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id C48131038CA
	for <alsa-devel@alsa-project.org>;
	Wed, 27 May 2009 21:27:02 +0200 (CEST)
Received: by qyk1 with SMTP id 1so6509291qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2009 12:27:01 -0700 (PDT)
In-Reply-To: <d54969c50905240951v2fd01b97j79d0c618bfdd4578@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Karthik Ramgopal <applefreakpeeps@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Did my last email arrive? Any idea on what might be going on?

Emilio

2009/5/24 Emilio L=F3pez <buhitoescolar@gmail.com>

> Well, it seems my last email was too heavy with the 4 files attached. I
> have uploaded them to drop.io, here is the link:
> http://drop.io/alsaonaceraspire6930
>
> Thanks!
>
> 2009/5/23 Emilio L=F3pez <buhitoescolar@gmail.com>
>
> Here you are, I ran alsa-info.sh in the old alsa (with model=3Dacer) and
>> saved the output of the script when side was enabled and disabled, with
>> volumes 0 and 100. Hope you can work out the problem with this, do not
>> hesitate to ask for more debug info if you need.
>>
>> Thanks for all!
>>
>> Emilio
>>
>> PS: On my previous email (cited below) I wrote "Mic sensing" incorrectly,
>> I wanted to write "headphones sensing".
>>
>> 2009/5/23 Takashi Iwai <tiwai@suse.de>
>>
>> At Sat, 23 May 2009 12:19:12 -0300,
>>> Emilio L=F3pez wrote:
>>> >
>>> > I reinstalled 1.0.20 today and almost everything started working when=
 I
>>> set
>>> > model=3Dacer-aspire-4930g. Mic sensing works, my mic now records too.=
 But
>>> my
>>> > bass does not, and I cannot control it with "Side" anymore.
>>> >
>>> > Any idea on how to fix it? The audio setup for this laptop will be
>>> fully
>>> > working when I get the bass to play once again.
>>>
>>> Could you check with the older version and what "Side" control changes
>>> in hd-audio codec registers?  You can just get alsa-info.sh output
>>> before and after changing the "Side" control value.
>>>
>>>
>>> thanks,
>>>
>>> Takashi
>>>
>>
>>
>
