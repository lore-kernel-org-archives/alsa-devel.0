From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] ASoC: Fix recursive dependency due to
	select ATMEL_SSC in SND_ATMEL_SOC_SSC
Date: Tue, 10 Jan 2012 13:00:24 +0800
Message-ID: <CAF+7xWkT4+xye=68t1-wfPdzRs7c8rscv6kxd=OPgskbAgXUkQ@mail.gmail.com>
References: <1326101958.10572.1.camel@phoenix>
	<20120109223811.GH30766@opensource.wolfsonmicro.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E553103BAE
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 06:00:47 +0100 (CET)
Received: by lago2 with SMTP id o2so1715656lag.38
	for <alsa-devel@alsa-project.org>; Mon, 09 Jan 2012 21:00:45 -0800 (PST)
In-Reply-To: <20120109223811.GH30766@opensource.wolfsonmicro.com>
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

2012/1/10 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Mon, Jan 09, 2012 at 05:39:18PM +0800, Axel Lin wrote:
>> commit 739be96 "ASoC: Fix build dependency for SND_ATMEL_SOC_SSC"
>> introduces below build warnings:
>
> Applied, thanks.

Hi Mark,
I thought you already applied this one, but you did not.
You apply commit 10024e394 (ASoC: Fix build dependency for
SND_AT91_SOC_AFEB9260) instead.
Thus you need to apply the patch I sent yesterday
([PATCH] Revert "ASoC: Fix build dependency for SND_ATMEL_SOC_SSC")
to fix recursive dependency detected warnings.

Sorry for the mess.

Regards,
Axel
