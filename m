From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 03/17] mfd: madera: Add common support
 for Cirrus Logic Madera codecs
Date: Mon, 05 Jun 2017 03:40:00 -0700
Message-ID: <1496659200.15643.15.camel@perches.com>
References: <1496415790-19164-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1496415790-19164-4-git-send-email-rf@opensource.wolfsonmicro.com>
 <20170605103227.no257u6v4ob65bvg@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0032.hostedemail.com
 [216.40.44.32]) by alsa0.perex.cz (Postfix) with ESMTP id 4E45E266D11
 for <alsa-devel@alsa-project.org>; Mon,  5 Jun 2017 12:40:05 +0200 (CEST)
In-Reply-To: <20170605103227.no257u6v4ob65bvg@dell>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, jason@lakedaemon.net, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, tglx@linutronix.de
List-Id: alsa-devel@alsa-project.org

On Mon, 2017-06-05 at 11:32 +0100, Lee Jones wrote:
> On Fri, 02 Jun 2017, Richard Fitzgerald wrote:
[]
> >  		if (IS_ERR(madera->reset_gpio))
> > +			ret = PTR_ERR(madera->reset_gpio);
> > +		else
> > +			ret = 0;
> 
> If you pre-initialise ret, you can drop the else.

Better to use:

		ret = PTR_ERR_OR_ZERO(madera->reset_gpio);
