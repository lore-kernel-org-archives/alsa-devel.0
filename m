From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: No pcm device?
Date: Mon, 20 Oct 2008 14:24:24 +0100
Message-ID: <20081020132424.GD24360@sirena.org.uk>
References: <520f0cf10810200534j3ccb84cag3e012c4e101de2fe@mail.gmail.com>
	<20081020124038.GB24360@sirena.org.uk>
	<520f0cf10810200551y9b4b6c9xc67f7b025497b96e@mail.gmail.com>
	<20081020130200.GC24360@sirena.org.uk>
	<520f0cf10810200616s2ead02cdg4c034de280cd716c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A83124516
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 15:24:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <520f0cf10810200616s2ead02cdg4c034de280cd716c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Kacur <jkacur@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 20, 2008 at 03:16:27PM +0200, John Kacur wrote:

> ...but I'm still scratching my head when I look at files like
> sound/soc/s3c24xx/s3c24xx-pcm.c
> It appears to be part of the DAI that connects the i2s driver and

No, there is no direct connection between any of the platform drivers
and the codec drivers - the platform drivers will be configured to
produce and understand signals on I2S as configured by a combination of
the machine drivers and core.  The codec will be configured compatibly
but at no point should the codec and platform drivers directly know
anything about each other.

> codec together? So, back to my current source of confusion, do I need
> to implement some basic kind of pcm driver for my scenario?

There should be at least a stub platform driver.  The driver is
responsible for things that apply over the entire platform - for most
platforms this is DMA since the DMA control is the same for all the
different audio interfaces the platform has.

This is nothing to do with creating a card, that is initiated by the
machine driver.
