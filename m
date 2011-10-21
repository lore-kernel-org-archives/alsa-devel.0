From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v7 1/3] ASoC: da7210: Add support for DAPM
Date: Fri, 21 Oct 2011 15:17:26 +0530
Message-ID: <1319190446.24621.158.camel@matrix>
References: <1319119369.24621.84.camel@matrix>
	<20111021085838.GE3513@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	by alsa0.perex.cz (Postfix) with ESMTP id 07E2C103A8A
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 11:36:18 +0200 (CEST)
In-Reply-To: <20111021085838.GE3513@opensource.wolfsonmicro.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>, David@alsa-project.org, Chen <david.chen@diasemi.com>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-10-21 at 09:58 +0100, Mark Brown wrote:
> On Thu, Oct 20, 2011 at 07:32:49PM +0530, Ashish Chavan wrote:
> > This patch adds support for DAPM covering all inputs and outputs
> > as well as ADC and DAC.
> 
> This patch doesn't apply against current code.

That's strange! Let me recheck to see if I messed anything.

> 
> > +/*
> > + * DAPM Controls
> > + *
> > + * Current DAPM implementation covers almost all codec components e.g. IOs,
> > + * mixers, PGAs,ADC and DAC.
> 
> This explanation would better placed next to the code in the probe -
> it's that code which looks out of place in a Linux driver.

Only problem with that is the code to enable individual IOs is not at
one place and is scattered in the probe(). Should I place all such
things in a single block in probe() and put the comment above that?


Thanks,

-- Ashish (GNU FAN)
