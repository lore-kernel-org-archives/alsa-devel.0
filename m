From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH] ASoC: codecs: da9055: Update driver name
 to fix breakage due to pmic driver with same name
Date: Fri, 5 Jul 2013 19:05:06 +0530
Message-ID: <1373031306.3233.131.camel@matrix>
References: <1373024862.3233.63.camel@matrix>
 <20130705114456.GV27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 by alsa0.perex.cz (Postfix) with ESMTP id D90F7262629
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2013 15:08:16 +0200 (CEST)
In-Reply-To: <20130705114456.GV27646@sirena.org.uk>
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, "kiran.padwal" <kiran.padwal@kpitcummins.com>, lrg <lrg@ti.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2013-07-05 at 12:44 +0100, Mark Brown wrote:
> On Fri, Jul 05, 2013 at 05:17:42PM +0530, Ashish Chavan wrote:
> > This patch updates i2c driver name and device id of da9055 codec driver.
> > DA9055 is a PMIC + CODEC and currently, the corresponding PMIC driver
> > also registers itself with the same name as codec, i.e. "da9055".
> > Because of this the codec driver was broken. Now codec driver uses
> > "da9055-codec" as driver name instead of "da9055".
> 
> >  static const struct i2c_device_id da9055_i2c_id[] = {
> > -	{ "da9055", 0 },
> > +	{ "da9055-codec", 0 },
> >  	{ }
> >  };
> 
> I can't believe that you've tested this.

Yes, I have tested this today only. But with 3.6.0-rc4 kernel. That is
the newest kernel for which I have board and other required support
available.
