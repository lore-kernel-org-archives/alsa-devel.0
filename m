From: "Cai, Cliff" <Cliff.Cai@analog.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/5] ASoC codec:
	SSM2602: assign last substream to the master when shutting down
Date: Thu, 4 Jun 2009 16:31:35 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04257C3B@chinexm1.ad.analog.com>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<1243916337-29953-2-git-send-email-vapier@gentoo.org>
	<20090603105223.GE11507@sirena.org.uk>
	<8bd0f97a0906030537y1e65aa7atec4b0c5cdf4ae2f@mail.gmail.com>
	<20090603145316.GA7315@rakim.wolfsonmicro.main>
	<8bd0f97a0906031826j647efa0bs1ffb6492cfd0ccd8@mail.gmail.com>
	<4A2782FE.3080103@gmail.com>
	<8bd0f97a0906040122r2e4ca8feo69e6afb06140cef3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 728011037ED
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 10:28:02 +0200 (CEST)
Content-Class: urn:content-classes:message
In-Reply-To: <8bd0f97a0906040122r2e4ca8feo69e6afb06140cef3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>, Karl Beldan <karl.beldan@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

 =


>-----Original Message-----
>From: Mike Frysinger [mailto:vapier.adi@gmail.com] =

>Sent: Thursday, June 04, 2009 4:23 PM
>To: Karl Beldan
>Cc: Mark Brown; uclinux-dist-devel@blackfin.uclinux.org; =

>alsa-devel@alsa-project.org; Cai, Cliff
>Subject: Re: [alsa-devel] [Uclinux-dist-devel] [PATCH 2/5] =

>ASoC codec: SSM2602: assign last substream to the master when =

>shutting down
>
>On Thu, Jun 4, 2009 at 04:17, Karl Beldan wrote:
>> Mike Frysinger wrote:
>>> On Wed, Jun 3, 2009 at 10:53, Mark Brown wrote:
>>>> On Wed, Jun 03, 2009 at 08:37:54AM -0400, Mike Frysinger wrote:
>>>>> On Wed, Jun 3, 2009 at 06:52, Mark Brown wrote:
>>>>>> However, given that this fix has missed two kernel =

>releases due to =

>>>>>> the very slow rate of responses to review comments I've =

>applied it =

>>>>>> so users get the benefit of the bug fix.
>>>>> not sure what you're referring to
>>>> This looks like a respin of a fix which was originally submitted =

>>>> back in
>>>> 2.6.29 era or so. =A0IIRC there's been two or three =

>versions, each of =

>>>> which needed fixes.
>>>
>>> it could be. =A0i was going by the changes that werent in 2.6.30. =A0i =

>>> thought i looked for previous submissions, but i must have missed =

>>> previous attempts. =A0i'm not familiar with alsa stuff, so i'm not =

>>> always sure when i need to bang on Cliff to get things fixed up =

>>> (changes split / better comments / etc...).
>>
>> Anyways, this commit has been trying to fix something already fixed =

>> since the first submission and if you look at its effect on the =

>> current tree you will see duplicate code.
>
>you're going to have to be a bit more specific.  i dont know =

>alsa, so when i looked at the change history, i saw framework =

>conversions.
>about the only thing that might be related is faab5a32.  is =

>that what you're talking about ?
>-mike
>

The blackfin tree is quite different from the latest mainline tree now,I ne=
ed to make fixes against the mainline tree
And resend the patches

Cliff
