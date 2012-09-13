From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: codecs: Add DA9055 codec driver
Date: Thu, 13 Sep 2012 20:03:53 +0800
Message-ID: <20120913120351.GA8374@opensource.wolfsonmicro.com>
References: <1347375823.12329.14.camel@matrix>
 <20120912025709.GD9162@opensource.wolfsonmicro.com>
 <1347538116.16763.6.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3BE9A2625E6
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 14:03:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347538116.16763.6.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 13, 2012 at 05:38:36PM +0530, Ashish Chavan wrote:
> On Wed, 2012-09-12 at 10:57 +0800, Mark Brown wrote:

> > > +	aif_ctrl |= (DA9055_AIF_OE | DA9055_AIF_EN);

> > DAPM.

> Here the trouble in making it DAPM based is that there is no separate
> control for AIF input and output. It is confirmed that AIF_EN is the
> master control bit, which enables both output as well as input. The AIF
> _OE bit is redundant. If we use the same control bit(i.e AIF_EN) for
> both DAPM_AIF_IN and DAPM_AIF_OUT, there will be obvious side effects.
> Is there any other way to take care of this? Or should we leave it
> outside DAPM?

Use a supply widget.
