From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: Flag the i.MX SSI driver
	as	using symmetric rates
Date: Mon, 11 Jan 2010 11:36:31 +0000
Message-ID: <20100111113631.GE3440@sirena.org.uk>
References: <1262967598-4096-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1262967598-4096-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20100111112047.GT6923@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F177824586
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 12:36:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100111112047.GT6923@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Timur Tabi <timur@freescale.com>, alsa-devel@alsa-project.org, Javier Martin <javier.martin@vista-silicon.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 11, 2010 at 12:20:47PM +0100, Sascha Hauer wrote:

> Why this limitation? I can successfully record with 16000Hz while
> playing at 48000Hz on my PCM037 board. What is missing in the driver to
> 'officially' support asymmetric rates?

At least some of the driver was unconditionally setting both TX and RX
configuration simultaneously, though looking again hw_params() is OK.
I'll drop the patch.  Like I say, I've never actually seen the driver
working - even when configured as the master it doesn't seem to do any
DMA (well, FIQs).
