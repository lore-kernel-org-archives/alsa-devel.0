From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: da7210: convert to soc-cache
Date: Wed, 12 Oct 2011 11:47:08 +0100
Message-ID: <20111012104708.GG3647@opensource.wolfsonmicro.com>
References: <mailman.1102.1318385889.2097.alsa-devel@alsa-project.org>
	<1318414416.12107.101.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4C392244CF
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 12:47:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318414416.12107.101.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: alsa-devel@alsa-project.org, axel.lin@gmail.com, kuninori.morimoto.gx@renesas.com, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 12, 2011 at 03:43:35PM +0530, Ashish Chavan wrote:
> Hi Axel,

Don't top post and fix your mail client to thread mails properly; I
didn't actually see your mail until just now due to the lack of
threading.

> I am thinking of going forward with my posting which is based on current
> version of da7210 mainline driver. In am ready to take the
> responsibility of updating(to base it on my patch series) and testing
> your patch on the hardware that we have.

> Other option is to wait till your changes gets approved and then base my
> patch series on updated driver with your changes. But as this may take
> some time and I definitely want to get more eyes on the patches early,
> this would be least preferred.

There's no reason you couldn't do both.

I have to be honest here and say that even if I'd seen your mail before
I applied Axel's patch there's no way I'd have held off on it due to
your unpublished work.  Axel's patch is here now, is a clear win and
he's got a strong track record of doing this sort of valuable cleanup
work.  In contrast you guys have been working for something like a year
to get the driver for one of your PMICs integrated and haven't yet sent
any patches for audio at all.  Without a track record of contributions
it's hard to have confidence that the changes you're proposing will
arrive when you say, or to have any idea about the level of difficulty
in integrating them.
