From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: Tree for May 23 (sound/soc/codecs)
Date: Mon, 23 May 2011 15:53:43 -0700
Message-ID: <20110523155343.2e68c265.randy.dunlap@oracle.com>
References: <20110523154518.5e27cfb0.sfr@canb.auug.org.au>
	<20110523134815.fb87933a.randy.dunlap@oracle.com>
	<20110523224659.GB19533@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet10.oracle.com (rcsinet10.oracle.com [148.87.113.121])
	by alsa0.perex.cz (Postfix) with ESMTP id 49F22244F9
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 00:53:59 +0200 (CEST)
In-Reply-To: <20110523224659.GB19533@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, x86@kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Dmitry Artamonow <mad_soft@inbox.ru>, LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, Harald@alsa-project.org, Welte <laforge@gnufiish.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 24 May 2011 06:47:28 +0800 Mark Brown wrote:

> On Mon, May 23, 2011 at 01:48:15PM -0700, Randy Dunlap wrote:
> > On Mon, 23 May 2011 15:45:18 +1000 Stephen Rothwell wrote:
> 
> > when CONFIG_GPIOLIB is not enabled
> > and CONFIG_GENERIC_GPIO is not enabled:
> 
> > sound/soc/codecs/ak4641.c:524: error: 'GPIOF_OUT_INIT_LOW' undeclared (first use in this function)
> > sound/soc/codecs/wm8915.c:2857: error: 'GPIOF_OUT_INIT_LOW' undeclared (first use in this function)
> 
> What architecture is this on (you should always include information like
> this anyway so people can try to reproduce what you're seeing)?  In any

on x86_64  [adding x86@kernel.org == arch maintainers]

> case, please talk to the architecture maintainers about this - it's an
> issue in the architecture GPIO support (or lack thereof) rather than a
> driver problem.

except that a driver should not assume that defines like
GPIOF_OUT_INIT_LOW are always available.

> Also adding Dmitry who submitted the driver - Randy, please try to
> remember to CC relevant people.

Which driver did Dmitry submit?  how would I know that?
I don't download every linux-next git tree -- just linux-next tarballs.


ak4641.c says:
MODULE_AUTHOR("Harald Welte <laforge@gnufiish.org>");
  [which bounces]

and wm8915.c says:
MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
