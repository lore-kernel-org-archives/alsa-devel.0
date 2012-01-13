From: Zeng Zhaoming <zengzm.kernel@gmail.com>
Subject: Re: duplicated test in sound/soc/codecs/sgtl5000.c
Date: Fri, 13 Jan 2012 16:40:15 +0800
Message-ID: <20120113083916.GA30341@zzm-ubuntu>
References: <alpine.DEB.2.00.1201122210520.25187@pl-59034.rocq.inria.fr>
	<20120112222759.GA23716@opensource.wolfsonmicro.com>
	<7FE21149F4667147B645348EC605788508FBC9@039-SN2MPN1-013.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-tul01m020-f179.google.com (mail-tul01m020-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F31324426
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 09:40:22 +0100 (CET)
Received: by obbuo13 with SMTP id uo13so1860287obb.38
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2012 00:40:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7FE21149F4667147B645348EC605788508FBC9@039-SN2MPN1-013.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng-B29396 <B29396@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Julia Lawall <julia.lawall@lip6.fr>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri 2012-01-13 06:21:00, Dong Aisheng-B29396 wrote:
> > -----Original Message-----
> > From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> > Sent: Friday, January 13, 2012 6:28 AM
> > To: Julia Lawall; Fabio Estevam; Wolfram Sang; Dong Aisheng-B29396; Shawn Guo
> > Cc: lrg@ti.com; alsa-devel@alsa-project.org
> > Subject: Re: duplicated test in sound/soc/codecs/sgtl5000.c
> > Importance: High
> > 
> > On Thu, Jan 12, 2012 at 10:13:24PM +0100, Julia Lawall wrote:
> > > There is a duplicated test in the function sgtl5000_restore_regs in
> > > the file sound/soc/codecs/sgtl5000.c:
> > 
> > >                /* this regs depends on the others */
> > >                 if (reg == SGTL5000_CHIP_ANA_POWER ||
> > >                         reg == SGTL5000_CHIP_CLK_CTRL ||
> > >                         reg == SGTL5000_CHIP_LINREG_CTRL ||
> > >                         reg == SGTL5000_CHIP_LINE_OUT_CTRL ||
> > >                         reg == SGTL5000_CHIP_CLK_CTRL)
> > >                         continue;
> > 
> > > I don't know if some constant other than SGTL5000_CHIP_CLK_CTRL should
> > > be tested, or if the second test should just be deleted.
> > 
> > Adding the people who've been working on the driver.  Generally this is a good
> > idea when reporting issues like this.
> Cc Zhaoming.
> 
> Looking at the code, I guess it's a typo error and the second check should be
> SGTL5000_CHIP_REF_CTRL since it will restore it again.

Hi, Aisheng and Julia:
    Yes, a typo, I will send patch to correct it.

    And Julia, the five regs list there since it should be restore in a particular
order, the order is:
    1. SGTL5000_CHIP_CLK_CTRL MCLK_FREQ bits (1:0) should be restore after 
    SGTL5000_CHIP_ANA_POWER PLL bits set.
    2. SGTL5000_CHIP_LINREG_CTRL should be set before SGTL5000_CHIP_ANA_POWER LINREG_D
     restored.
    3. SGTL5000_CHIP_REF_CTRL controls Analog Ground Voltage, I prefer to resotre it
    after SGTL5000_CHIP_ANA_POWER restored.
    4. for SGTL5000_CHIP_LINE_OUT_CTRL, I forget the real reason, Aisheng, can you help
    verify line-out if remove it?
> 
> Hi Mark,
> Since zhaoming leaved Freescale a few month ago,
> would you mind if I send a patch to add my name under MODULE_AHTOER as
> Co-maintainer for this driver and update Zhaoming's email address?
> 
> Regards
> Dong Aisheng
