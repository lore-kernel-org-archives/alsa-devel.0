From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH/RFC] gpio: add GPIOF_ values regardless on
 kconfig settings
Date: Tue, 24 May 2011 12:44:57 -0700
Message-ID: <20110524124457.c6c21bab.randy.dunlap@oracle.com>
References: <20110523154518.5e27cfb0.sfr@canb.auug.org.au>
	<20110523134815.fb87933a.randy.dunlap@oracle.com>
	<20110523224659.GB19533@opensource.wolfsonmicro.com>
	<20110523155343.2e68c265.randy.dunlap@oracle.com>
	<20110524000837.GA30515@opensource.wolfsonmicro.com>
	<4DDB082F.3010107@oracle.com>
	<20110524014959.GA27710@opensource.wolfsonmicro.com>
	<4DDB3AFF.9030006@oracle.com> <20110524052342.GA24918@rainbow>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet10.oracle.com (rcsinet10.oracle.com [148.87.113.121])
	by alsa0.perex.cz (Postfix) with ESMTP id DDD2210380D
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 21:45:14 +0200 (CEST)
In-Reply-To: <20110524052342.GA24918@rainbow>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Artamonow <mad_soft@inbox.ru>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, x86@kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, linux-next@vger.kernel.org, Harald@alsa-project.org, Welte <laforge@gnufiish.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 24 May 2011 09:23:42 +0400 Dmitry Artamonow wrote:

> On 21:58 Mon 23 May     , Randy Dunlap wrote:
> > From: Randy Dunlap <randy.dunlap@oracle.com>
> > 
> > Make GPIOF_ defined values available even when GPIOLIB nor GENERIC_GPIO
> > is enabled by moving them to <linux/gpio.h>.
> > 
> > Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Looks good.
> 
> We probably may also want to move definition of struct gpio into
> include/linux/gpio.h to make things like this work as well:
> 
> static struct gpio some_gpios[] = {
> 	{ GPIO_BLAH, GPIOF_IN, "BLAH"},
> 	{ GPIO_BLAH2, GPIOF_OUT_INIT_LOW, "BLAH2"},
> };
> 
> static int some_init_function(void)
> {
> 	/* ... */
> 
> 	gpio_request_array(some_gpios, ARRAY_SIZE(some_gpios));
> 
> 	/* ... */
> }
> 
> These gpio_request_one() and gpio_request_array() are quite handy, so I
> suppose more and more drivers will use it as we go...

That could help this one:

linux-next-20110524/include/linux/mfd/tps65910.h:774: error: field 'gpio' has incomplete type

and then add some way to handle (e.g.):

	struct tps65910 *tps65910 = container_of(gc, struct tps65910, gpio);
=>
linux-next-20110524/drivers/gpio/tps65910-gpio.c:25: warning: type defaults to 'int' in declaration of '__mptr'


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
