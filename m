From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix recursive dependency due to
 select ATMEL_SSC in SND_ATMEL_SOC_SSC
Date: Mon, 9 Jan 2012 21:23:19 -0800
Message-ID: <20120110052318.GA32504@opensource.wolfsonmicro.com>
References: <1326101958.10572.1.camel@phoenix>
	<20120109223811.GH30766@opensource.wolfsonmicro.com>
	<CAF+7xWkT4+xye=68t1-wfPdzRs7c8rscv6kxd=OPgskbAgXUkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 718AB103BBA
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 06:23:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAF+7xWkT4+xye=68t1-wfPdzRs7c8rscv6kxd=OPgskbAgXUkQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Paul Bolle <pebolle@tiscali.nl>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 10, 2012 at 01:00:24PM +0800, Axel Lin wrote:

> I thought you already applied this one, but you did not.
> You apply commit 10024e394 (ASoC: Fix build dependency for
> SND_AT91_SOC_AFEB9260) instead.

Oh, gah.  I've just dropped this patch. 

> Thus you need to apply the patch I sent yesterday
> ([PATCH] Revert "ASoC: Fix build dependency for SND_ATMEL_SOC_SSC")
> to fix recursive dependency detected warnings.

Please don't just refer to patches on the list unless it's under active
discussion or similar, send the patch.
