From: Dmitry Artamonow <mad_soft@inbox.ru>
Subject: Re: [PATCH/RFC] gpio: add GPIOF_ values regardless on
 kconfig settings
Date: Tue, 24 May 2011 09:23:42 +0400
Message-ID: <20110524052342.GA24918@rainbow>
References: <20110523154518.5e27cfb0.sfr@canb.auug.org.au>
	<20110523134815.fb87933a.randy.dunlap@oracle.com>
	<20110523224659.GB19533@opensource.wolfsonmicro.com>
	<20110523155343.2e68c265.randy.dunlap@oracle.com>
	<20110524000837.GA30515@opensource.wolfsonmicro.com>
	<4DDB082F.3010107@oracle.com>
	<20110524014959.GA27710@opensource.wolfsonmicro.com>
	<4DDB3AFF.9030006@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.mail.ru (smtp3.mail.ru [94.100.176.131])
	by alsa0.perex.cz (Postfix) with ESMTP id A10BA103854
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 07:23:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DDB3AFF.9030006@oracle.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, x86@kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, linux-next@vger.kernel.org, Harald Welte <laforge@gnufiish.org>
List-Id: alsa-devel@alsa-project.org

On 21:58 Mon 23 May     , Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Make GPIOF_ defined values available even when GPIOLIB nor GENERIC_GPIO
> is enabled by moving them to <linux/gpio.h>.
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

Looks good.

We probably may also want to move definition of struct gpio into
include/linux/gpio.h to make things like this work as well:

static struct gpio some_gpios[] = {
	{ GPIO_BLAH, GPIOF_IN, "BLAH"},
	{ GPIO_BLAH2, GPIOF_OUT_INIT_LOW, "BLAH2"},
};

static int some_init_function(void)
{
	/* ... */

	gpio_request_array(some_gpios, ARRAY_SIZE(some_gpios));

	/* ... */
}

These gpio_request_one() and gpio_request_array() are quite handy, so I
suppose more and more drivers will use it as we go...

-- 
Best regards,
Dmitry "MAD" Artamonow
