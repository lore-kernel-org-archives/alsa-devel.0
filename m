From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: pxa2xx-i2s
Date: Fri, 23 Jan 2009 16:58:11 +0000
Message-ID: <20090123165808.GE24871@sirena.org.uk>
References: <4975E030.5080905@acdstar.com> <4975F160.8040001@gmail.com>
	<4976042B.6060604@acdstar.com> <49764F15.6080008@acdstar.com>
	<20090121132313.GA29953@sirena.org.uk>
	<49775159.7070708@linespeed.net>
	<20090121193230.GA15911@sirena.org.uk> <497781D8.50003@acdstar.com>
	<20090121222718.GA23539@sirena.org.uk> <4979F55F.70600@acdstar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 447CB24471
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 17:58:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4979F55F.70600@acdstar.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Rhodes <bgr@acdstar.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 23, 2009 at 10:50:39AM -0600, Brian Rhodes wrote:

> I'm curious if you think this problem may be arising from the toggling 
> of the direction of BCLK on the PXA while the I2S clock is enabled.  I'm 
> sure there are people who have a reason for switching the bit clock 
> master, but I'm thinking that this should not be explicitly done if it 
> is not changing.

Looking at the way the clock is enabled it looks like the hardware
requires the clock to be enabled to write to the registers, though again
I've not actually looked at the reference manual to check so this is
idle speculation.

Avoiding changing the register settings if they are already correct does
seem like a reasonable thing to try, though.  The ordering used when
configuring may be worth looking at too.
