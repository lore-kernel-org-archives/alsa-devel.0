From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC/multi-component: fix au1x platform
Date: Thu, 19 Aug 2010 15:35:56 +0100
Message-ID: <20100819143555.GB29453@opensource.wolfsonmicro.com>
References: <AANLkTikyZKhs6t8RRRd36KjW_Enb-+NGvUCraxEakHO5@mail.gmail.com>
	<20100819140649.GA29395@opensource.wolfsonmicro.com>
	<AANLkTik_VdzUEZ0+079iZciOryRbFNDyjE-jdzJXztcW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <AANLkTik_VdzUEZ0+079iZciOryRbFNDyjE-jdzJXztcW@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: alsa-devel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 19, 2010 at 04:30:10PM +0200, Manuel Lauss wrote:
> On Thu, Aug 19, 2010 at 4:06 PM, Mark Brown

> > As far as your comments about multiple cards go this should now be
> > supported, though the fact that you're modifying the static data for the
> > DAI means that the aux1x drivers probably don't support this or only
> > support it in a limited fashion.

> The hardware does support it with the issue you mentioned fixed, but the
> global "soc_ac97_ops" needs to go away first.  The alchemy line can
> support up to 4 independent ac97 "cards" with certain models.

So this comment only applies to the AC97 DAIs, not the I2S ones?
Actually, even for AC97 I'd expect things to work fine off the top of my
head - while you are forced to use the same ops for everything the ops
is just a vtable which I'd expect to be the same for all DAIs?
