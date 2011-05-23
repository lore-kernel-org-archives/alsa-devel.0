From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: linux-next: Tree for May 23 (sound/soc/codecs)
Date: Tue, 24 May 2011 06:47:28 +0800
Message-ID: <20110523224659.GB19533@opensource.wolfsonmicro.com>
References: <20110523154518.5e27cfb0.sfr@canb.auug.org.au>
 <20110523134815.fb87933a.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110523134815.fb87933a.randy.dunlap@oracle.com>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Harald Welte <laforge@gnufiish.org>, Dmitry Artamonow <mad_soft@inbox.ru>
List-Id: alsa-devel@alsa-project.org

On Mon, May 23, 2011 at 01:48:15PM -0700, Randy Dunlap wrote:
> On Mon, 23 May 2011 15:45:18 +1000 Stephen Rothwell wrote:

> when CONFIG_GPIOLIB is not enabled
> and CONFIG_GENERIC_GPIO is not enabled:

> sound/soc/codecs/ak4641.c:524: error: 'GPIOF_OUT_INIT_LOW' undeclared (first use in this function)
> sound/soc/codecs/wm8915.c:2857: error: 'GPIOF_OUT_INIT_LOW' undeclared (first use in this function)

What architecture is this on (you should always include information like
this anyway so people can try to reproduce what you're seeing)?  In any
case, please talk to the architecture maintainers about this - it's an
issue in the architecture GPIO support (or lack thereof) rather than a
driver problem.

Also adding Dmitry who submitted the driver - Randy, please try to
remember to CC relevant people.
