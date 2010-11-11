From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] Fix Atmel soc audio boards Kconfig
 dependency
Date: Thu, 11 Nov 2010 11:42:56 +0000
Message-ID: <1289475776.3273.8.camel@odin>
References: <4CDAFA56.2050504@bluewatersys.com>
	<1289423099.3284.52.camel@odin> <4CDB1480.3080109@bluewatersys.com>
	<201011101709.56106.geoffrey@pager.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D1B151037EE
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 12:43:00 +0100 (CET)
Received: by wwb34 with SMTP id 34so17389wwb.20
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 03:43:00 -0800 (PST)
In-Reply-To: <201011101709.56106.geoffrey@pager.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Geoffrey Wossum <geoffrey@pager.net>
Cc: "gwossum@acm.org" <gwossum@acm.org>, Sedji Gaouaou <sedji.gaouaou@atmel.com>, Ryan Mallon <ryan@bluewatersys.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-11-10 at 17:09 -0600, Geoffrey Wossum wrote:
> On Wednesday 10 November 2010 3:54:08 pm Ryan Mallon wrote:
> > On 11/11/2010 10:04 AM, Liam Girdwood wrote:
> > > On Thu, 2010-11-11 at 09:02 +1300, Ryan Mallon wrote:
> > >> Add Kconfig dependency on AT91_PROGRAMMABLE_CLOCKS for the Atmel SoC
> > >> audio SAM9G20-EK and PlayPaq boards. Fixes link errors on missing
> > >> clk_set_parent and clk_set_rate when building without
> > >> AT91_PROGRAMMABLE_CLOCKS.
> > >> 
> > >> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> > > 
> > > Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
> > 
> > Just realised that the PlayPaq board only appears in the sound/soc/atmel
> > directory. I cannot find a board file for it under either
> > arch/arm/mach-at91 or arch/avr32/. The updated patch below only changes
> > the dependency for the SAM9G20-EK board since I think the PlayPaq is
> > actually AVR32, and therefore should not depend on
> > AT91_PROGRAMMABLE_CLOCKS. This patch replaces my previous one.
> 
> PlayPaq is an AT32AP7000 board, so the new patch is correct.
> 
> > ---
> > Add Kconfig dependency on AT91_PROGRAMMABLE_CLOCKS for the Atmel SoC
> > audio  SAM9G20-EK board. Fixes link errors on missing clk_set_parent and
> > clk_set_rate when building without AT91_PROGRAMMABLE_CLOCKS.
> > 
> > Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> 
> Acked-by: Geoffrey Wossum <gwossum@acm.org>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
