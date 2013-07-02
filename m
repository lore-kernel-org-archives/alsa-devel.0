From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: Multiple DA9055 chips
Date: Tue, 2 Jul 2013 15:01:53 +0530
Message-ID: <1372757513.28415.2.camel@matrix>
References: <20130701164833.GL27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F76B2652FC
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2013 11:06:19 +0200 (CEST)
In-Reply-To: <20130701164833.GL27646@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, linux-kernel@vger.kernel.org, David Dajun Chen <david.chen@diasemi.com>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2013-07-01 at 17:48 +0100, Mark Brown wrote:
> It seems we have two drivers in mainline for da9055 on I2C.  We've got
> one in sound/soc/codecs/da9055.c and one in drivers/mfd/da9055-i2c.c,
> both registering themselves identically.  What's going on here?  Is this
> a combined CODEC and PMIC, has someone decided to release two chips with
> the same name or is one of the drivers misnamed?

Yes, this is a combined CODEC and PMIC.
