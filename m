From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] ALSA: ac97c: Fix an error handling path in
 'atmel_ac97c_probe()'
Date: Thu, 31 Aug 2017 11:57:54 +0200
Message-ID: <20170831095754.t2impdwghk3z3tz6@piout.net>
References: <20170831044042.23306-1-christophe.jaillet@wanadoo.fr>
 <20170831081021.g4luo557ggtnyfyg@piout.net>
 <alpine.DEB.2.20.1708311020340.3243@hadrien>
 <1504170243.25945.170.camel@linux.intel.com>
 <20170831093557.mhr5txmaiox7gxiq@piout.net>
 <1504172297.25945.171.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 19CEA26731C
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 11:58:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1504172297.25945.171.camel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, garsilva@embeddedor.com, kernel-janitors@vger.kernel.org, nicolas.ferre@microchip.com, tiwai@suse.com, Julia Lawall <julia.lawall@lip6.fr>, broonie@kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, arvind.yadav.cs@gmail.com, bhumirks@gmail.com
List-Id: alsa-devel@alsa-project.org

On 31/08/2017 at 12:38:17 +0300, Andy Shevchenko wrote:
> On Thu, 2017-08-31 at 11:35 +0200, Alexandre Belloni wrote:
> > On 31/08/2017 at 12:04:03 +0300, Andy Shevchenko wrote:
> > > On Thu, 2017-08-31 at 10:23 +0200, Julia Lawall wrote:
> > > > 
> > > > On Thu, 31 Aug 2017, Alexandre Belloni wrote:
> > > > 
> > > > > On 31/08/2017 at 06:40:42 +0200, Christophe JAILLET wrote:
> > > > > > 
> 
> > > I didn't look into the code, though speculating it might be the case
> > > when CLK framework is not enabled, though many drivers are dependent
> > > to
> > > it, so, it would never fail in such cases.
> > 
> > It is not the case, it would return 0. Anyway, this will not happen
> > because that driver depends on ARCH_AT91 which selects COMMON_CLK_AT91
> > which selects COMMON_CLK.
> > 
> > > Nevertheless there might be
> > > other cases for CLK API to fail.
> > > 
> > 
> > The only case would be for a clock to be enabled without being
> > prepared
> > and this will never happen because clk_prepare_enable is used.
> > 
> > This call will just never fail.
> 
> So, then this is a bug of CLK API per se to have a prototype to return
> int, right?
> 

No because it may fail on other platforms.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
