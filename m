From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ARM: pxa: add support for Raumfeld DDX
Date: Wed, 16 Nov 2011 13:19:10 +0000
Message-ID: <20111116131910.GE29986@opensource.wolfsonmicro.com>
References: <1320661562-422-1-git-send-email-zonque@gmail.com>
	<20111115141348.GG3077@opensource.wolfsonmicro.com>
	<4EC3B30F.60403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C0E38244DF
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 14:19:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4EC3B30F.60403@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 16, 2011 at 01:56:47PM +0100, Daniel Mack wrote:
> On 11/15/2011 03:13 PM, Mark Brown wrote:

> > Is this really a single driver?  Looking at the code it looks like
> > there's little if any code sharing between the different machines, it'd
> > help with maintainability to have multiple simple drivers.

> Hmm. This new version of Raumfeld's hardware features a new ADC and DAC,
> and the configuration to use is determined by looking at the system
> revision. If this would be split into multiple smaller drivers, there
> would be need for a 'master' to dispatch the possible options. I think

No, not really.

> I'll do that once the next generation is about to land, and leave it as
> it is for now. Ok for you?

What I'd expect here is that the arch/arm code would register a
different platform device depending on which board it's running on
(though actually controlling I2C device registration is enough as ASoC
won't probe the sound driver until the components appear).

> >> +	fmt = SND_SOC_DAIFMT_I2S |
> >> +	      SND_SOC_DAIFMT_NB_NF |
> >> +	      SND_SOC_DAIFMT_CBS_CFS;

> > Set this using dai_fmt in hte machine driver.

> Can you elaborate on this one? I couldn't find an example for this, sorry.

Look at the snd_soc_dai_link definition, and things like speyside.
