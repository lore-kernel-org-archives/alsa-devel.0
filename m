From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 4/4] ASoC: Flag the i.MX SSI driver
	as	using symmetric rates
Date: Mon, 11 Jan 2010 13:14:19 +0100
Message-ID: <20100111121419.GV6923@pengutronix.de>
References: <1262967598-4096-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1262967598-4096-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20100111112047.GT6923@pengutronix.de>
	<20100111113631.GE3440@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate02.web.de (fmmailgate02.web.de [217.72.192.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 47C3B1037FB
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 13:14:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100111113631.GE3440@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Timur Tabi <timur@freescale.com>, Javier Martin <javier.martin@vista-silicon.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 11, 2010 at 11:36:31AM +0000, Mark Brown wrote:
> On Mon, Jan 11, 2010 at 12:20:47PM +0100, Sascha Hauer wrote:
> 
> > Why this limitation? I can successfully record with 16000Hz while
> > playing at 48000Hz on my PCM037 board. What is missing in the driver to
> > 'officially' support asymmetric rates?
> 
> At least some of the driver was unconditionally setting both TX and RX
> configuration simultaneously, though looking again hw_params() is OK.

You probably mean imx_ssi_set_dai_fmt(), imx_ssi_set_dai_tdm_slot()
and imx_ssi_set_dai_sysclk(). We do not have the playback/record
information available in these functions. Should we pass a struct
snd_pcm_substream * to the functions?

> I'll drop the patch.  Like I say, I've never actually seen the driver
> working - even when configured as the master it doesn't seem to do any
> DMA (well, FIQs).

Unfortunately I do not have a mx31ads available, so I can't provide a
driver for this board. I never used master mode, but if I understand the
datasheet correctly the SSI unit has two clock inputs, one for the
register accesses which gets enabled by clk_enable and one for the baud
rate which doesn't get touched by the driver atm. Have you checked that
the baud clock is configured correctly?
If you have by chance a mx27ads or a mx35 3stack board I could see that
I make the driver work on one of these boards.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
