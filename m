From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH] ASoC: codecs: Add DA9055 codec driver
Date: Thu, 13 Sep 2012 17:38:36 +0530
Message-ID: <1347538116.16763.6.camel@matrix>
References: <1347375823.12329.14.camel@matrix>
 <20120912025709.GD9162@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 by alsa0.perex.cz (Postfix) with ESMTP id E2D712625DC
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 13:57:13 +0200 (CEST)
In-Reply-To: <20120912025709.GD9162@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-09-12 at 10:57 +0800, Mark Brown wrote:
> 
> > +	aif_ctrl |= (DA9055_AIF_OE | DA9055_AIF_EN);
> 
> DAPM.

Here the trouble in making it DAPM based is that there is no separate
control for AIF input and output. It is confirmed that AIF_EN is the
master control bit, which enables both output as well as input. The AIF
_OE bit is redundant. If we use the same control bit(i.e AIF_EN) for
both DAPM_AIF_IN and DAPM_AIF_OUT, there will be obvious side effects.
Is there any other way to take care of this? Or should we leave it
outside DAPM?
