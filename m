From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: mx31 snd and mc13783 codec status
Date: Wed, 31 Mar 2010 10:38:20 +0200
Message-ID: <20100331083820.GS2241@pengutronix.de>
References: <4BB22576.1070108@epfl.ch> <20100330204021.GA4666@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 4FF4B10381C
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Mar 2010 10:38:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100330204021.GA4666@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Valentin Longchamp <valentin.longchamp@epfl.ch>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 30, 2010 at 09:40:21PM +0100, Mark Brown wrote:
> On Tue, Mar 30, 2010 at 06:23:18PM +0200, Valentin Longchamp wrote:
> 
> > I have quickly hacked something based on what you had done for
> > pcm037 with the MC13783 codec in some of your first sound patches. I
> > know that this is not ready for mainline and I'm still struggling to
> > debug my code, but I would like to have results quite soon so that
> > my colleague could see what sounds (especially regarding to the
> > volume) our system is capable to produce.
> 
> If you're struggling to find time to do full support for the CODEC a
> good technique is often to get just very basic fixed function support
> (say just DAC to headphone support) implemented and merged, then go back
> and implement
> 
> I'd also suggest looking at the current Freescale BSPs - obviously this
> device is used on a lot of Freescale reference boards and I believe
> there's a reasonably mainlineish driver in the BSPs they have for
> current devices.

I think they dropped support for the MC13783 in their BSPs. The MC13783
code is still contained in sound/arm/mxc-alsa-pmic.c and a 200k file
drivers/mxc/pmic/mc13783/pmic_audio.c. That's not exactly mainlineish...

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
