From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 2/2] ASoC: omap-mcpdm: Replace legacy
	driver
Date: Tue, 23 Aug 2011 10:52:03 +0300
Message-ID: <1841405.uncpCjWKsY@barack>
References: <1313739679-8975-1-git-send-email-peter.ujfalusi@ti.com>
	<1313739679-8975-3-git-send-email-peter.ujfalusi@ti.com>
	<20110820070113.GB5011@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 31C6D245BC
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 09:51:59 +0200 (CEST)
In-Reply-To: <20110820070113.GB5011@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>, "Lopez Cruz, Misael" <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Saturday 20 August 2011 09:01:14 Mark Brown wrote:
> So, the issue here is that the CODEC you're using on your system lacks
> DAC mute support and doesn't handle the end of the input stream
> gracefully?  This doesn't sound like a McPDM specific issue at all, and
> I'm slightly surprised we don't run into it more often.
> =

> Currently the sequence we use on stream teardown is:
> =

>   1. Mute.
>   2. Stop stream.
>   3. Wait for the DAPM teardown time.
>   4. Power down.
> =

> but it seems like what your CODEC actually wants is:
> =

>   1. Power down.
>   2. Stop stream.

Something like that, yes.

> which isn't at all unresonable and if the CODEC is actually able to
> support that mode of operation well then it'll be lower power.  This
> seems like something we should be supporting in the core as I would
> expect other devices will find it useful, PDM class D speaker drivers
> being the most obvious example.

That's good, if we have other users with similar requirements towards the =

sequencing.
One thing, which might need special care in the down sequence:

1. Stop platform (DMA)
2. Power down (mostly codec side)
3. Stop cpu dai

I'm not sure about this, but we should not have running DMA after =

trigger:stop?

> I do think it'd be helpful to split this code out as a separate patch
> as it's the controversial bit...

It is not that easy.
There's no incremental way from the old driver to the new one.
What I can try however is to write an intermediate driver, which does not h=
ave =

the delayed sequencing. I know that this is a bit problematic, and it is no=
t =

going to work as good as the driver in this series, but probably it will gi=
ve =

the needed separation of the sequencing part.
This going to take some time, since I need to - kind of - write a new drive=
r, =

which is in half way between the two versions ;)

--
P=E9ter
