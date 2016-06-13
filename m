From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoc: wm8731: add normal mode with
	12MHz XTAL
Date: Mon, 13 Jun 2016 12:59:10 +0100
Message-ID: <20160613115910.GV20422@localhost.localdomain>
References: <1465517516-1917-1-git-send-email-flatmax@flatmax.org>
 <1465517516-1917-2-git-send-email-flatmax@flatmax.org>
 <575BD6F2.70600@flatmax.org> <575CD572.2040700@flatmax.org>
 <20160613083714.GU20422@localhost.localdomain>
 <575E80B2.3040309@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id E1FB9260592
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 13:59:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <575E80B2.3040309@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 13, 2016 at 07:45:22PM +1000, Matt Flax wrote:
> On 13/06/16 18:37, Charles Keepax wrote:
> >On Sun, Jun 12, 2016 at 01:22:26PM +1000, Matt Flax wrote:
> >>It appears that my logic here is flawed.
> >> From what I can tell, it isn't possible to get a suitable bit clock out of
> >>the codec when using a 12 MHz crystal. For that reason, in my hardware I
> >>will change crystals from 12 MHz.
> >This looks correct the chip only has simple dividers so you won't
> >be able to get a good audio rate clock from a 12MHz crystal.
> >
> >>I just want to check ... are there any versions of this codec which output
> >>the bit clock when in USB mode on the BCLK pin ?
> >>
> >Apologies I am not quite sure I follow what USB mode is in this
> >context, and the bit clock surely always comes out of the BCLK
> >pin. Do you simply mean a system with a clock speed that
> >relates to the 48MHz USB clock, such as your 12MHz? Basically any
> >part that has a PLL/FLL should work for that, for example the
> >wm8998:
> >
> >http://www.cirrus.com/en/products/pro/detail/P1265.html
> 
> Literally, with the chip set to usb mode (register 0b0001000 bit 0, page 41
> of the data sheet) it appears that the 12 MHz clock comes out of the BCLK
> pin, rather then the bit clock.

Ah seems there are two versions of the chip the MC and L I was
looking at the datasheet for the version that doesn't have that
mode.

>From that datasheet it looks like it should be possible to
support audio rate clocks from a 12MHz input. Although as you say
the 44.1 clock is not exactly 44.1. I am not sure why you are
getting 12MHz coming out of the BCLK pin the datasheet certainly
does not appear to suggest this should happen. Are you sure the
sample rate and clock divider registers are set sensibly? My
first guess would be if things are in an unsupported state then
perhaps it just fires the clock straight through. I assume we are
very sure the input clock is 12MHz? Only other thing I can
imagine is for some reason we have a higher clock rate than we
expected and on the scope it would be hard to differenciate
between 12.288MHz and 12MHz dead. So for example if it was a
48MHz USB clock coming in rather than 12, then the chip tries to
generate a 3.072MHz bit clock that would look like 12MHz.

Again I guess a newer part with an PLL might be simpler as you
can simply use the PLL to generate audio rate clocks from the
12MHz.

Thanks,
Charles
