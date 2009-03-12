From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3][RFC] ASoC: pxa-ssp: Don't
	use	SSCR0_SerClkDiv and SSCR0_SCR
Date: Thu, 12 Mar 2009 19:18:03 +0000
Message-ID: <20090312191803.GA32020@rakim.wolfsonmicro.main>
References: <1236795420-12175-1-git-send-email-philipp.zabel@gmail.com>
	<1236795420-12175-3-git-send-email-philipp.zabel@gmail.com>
	<20090311184416.GA29865@buzzloop.caiaq.de>
	<74d0deb30903111410v5a601709jf779c0d2e64e7de7@mail.gmail.com>
	<20090312004639.GB7462@buzzloop.caiaq.de>
	<20090312102355.GB4038@rakim.wolfsonmicro.main>
	<20090312102749.GA14526@buzzloop.caiaq.de>
	<74d0deb30903121209ke7e84g7c448b9e14118097@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D2CB51038BE
	for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2009 20:18:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74d0deb30903121209ke7e84g7c448b9e14118097@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 12, 2009 at 08:09:21PM +0100, pHilipp Zabel wrote:

> There is one more thing I didn't think about yet. Disabling network
> mode here unconditionally should break Zylonite as is, unless it can
> also be changed to use that special 64fs mode.
> This code is found in zylonite_voice_hw_params right now:

Yes, it completely hoses zylonite.  I'm currently trying to come up with
a non-networked configuration for Zylonite though.

> And I realize I don't quite understand why it handles the mono case at
> all - isn't I2S always stereo?

It's moderately common to transmit mono data in one channel of the
stereo I2S stream.
