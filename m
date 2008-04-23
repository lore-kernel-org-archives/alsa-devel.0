From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: SoC sound support for imx27
Date: Wed, 23 Apr 2008 16:36:26 +0100
Message-ID: <1208964986.3286.62.camel@localhost.localdomain>
References: <200804231654.44526.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D7434245E9
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Apr 2008 17:36:28 +0200 (CEST)
In-Reply-To: <200804231654.44526.jbe@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Juergen Beisert <jbe@pengutronix.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2008-04-23 at 16:54 +0200, Juergen Beisert wrote:
> Hi,
> 
> I'm going to adapt Freescale's i.MX27 CPU to the SoC sound support via I2S. I 
> found the imx21 already in the repository (may it will help for my job). Is 
> anybody else working on i.MX27 support (to avoid to reinvention everything)?
> 

It's not fully supported atm. However I've had interest from a few folks
who are interested in completing support.

Currently working :-

 o i.MX2x SSI is complete (same as i.MX3)

Todo:

 o i.MX2x DMA is not completed. There is a half ASoC ported OSS based
implementation in git atm, although it's not complete due to my only
remaining i.MX21 board dying. Should be only about 1 weeks effort to
complete this.

Liam
