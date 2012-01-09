From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] Revert "ASoC: Fix build dependency for
	SND_ATMEL_SOC_SSC"
Date: Mon, 9 Jan 2012 12:40:35 +0800
Message-ID: <CAF+7xW=o2NuHZ4joJ7z-JWaA5n7gDpuHKcqHFwsE4f2TBT8CVw@mail.gmail.com>
References: <1326079783.2951.1.camel@phoenix>
	<20120109041545.GK29065@opensource.wolfsonmicro.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DD1A10389E
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 05:40:59 +0100 (CET)
Received: by lago2 with SMTP id o2so1162445lag.38
	for <alsa-devel@alsa-project.org>; Sun, 08 Jan 2012 20:40:57 -0800 (PST)
In-Reply-To: <20120109041545.GK29065@opensource.wolfsonmicro.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Paul Bolle <pebolle@tiscali.nl>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

2012/1/9 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Mon, Jan 09, 2012 at 11:29:43AM +0800, Axel Lin wrote:
>> This reverts commit 739be96ab83755e10fd0c2b6a34c8a73254527f7 because it
>> introduces below build warnings:
>
>> drivers/misc/Kconfig:212: =A0 =A0 =A0 symbol ATMEL_SSC is selected by SN=
D_ATMEL_SOC_SSC
>> sound/soc/atmel/Kconfig:9: =A0 =A0 =A0symbol SND_ATMEL_SOC_SSC is select=
ed by SND_AT91_SOC_SAM9G20_WM8731
>> sound/soc/atmel/Kconfig:18: =A0 =A0 symbol SND_AT91_SOC_SAM9G20_WM8731 d=
epends on ATMEL_SSC
>
>> =A0config SND_ATMEL_SOC_SSC
>> =A0 =A0 =A0 tristate
>> =A0 =A0 =A0 depends on SND_ATMEL_SOC
>> - =A0 =A0 select ATMEL_SSC
>
> Why is this the best fix? =A0It's not obvious to me that the dependency
> from the machine driver to the ATMEL_SSC (rather than a select or
> relying on the SSC driver sorting things out) is correct.

The issue is that SND_ATMEL_SOC_SSC needs ATMEL_SSC to pass compilation.
We now got the build warnings as Stephen points out.
So I revert the patch.
Both SND_AT91_SOC_SAM9G20_WM8731 and SND_AT91_SOC_AFEB9260 selects
SND_ATMEL_SOC_SSC.
Thus we need to make both machine drivers depend on ATMEL_SSC.

I think this patch reverts the problematic patch.
And then you can apply [PATCH] ASoC: Fix build dependency for
SND_AT91_SOC_AFEB9260 (
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-January/047861.ht=
ml
)
