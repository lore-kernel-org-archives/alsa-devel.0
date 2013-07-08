From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH] ASoC: codecs: da9055: Update driver name
 to fix breakage due to pmic driver with same name
Date: Mon, 8 Jul 2013 13:24:51 +0530
Message-ID: <1373270091.11222.12.camel@matrix>
References: <1373024862.3233.63.camel@matrix>
 <20130705114456.GV27646@sirena.org.uk> <1373031306.3233.131.camel@matrix>
 <20130705133752.GX27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 by alsa0.perex.cz (Postfix) with ESMTP id A3E3C265230
 for <alsa-devel@alsa-project.org>; Mon,  8 Jul 2013 09:28:24 +0200 (CEST)
In-Reply-To: <20130705133752.GX27646@sirena.org.uk>
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

On Fri, 2013-07-05 at 14:37 +0100, Mark Brown wrote:
> On Fri, Jul 05, 2013 at 07:05:06PM +0530, Ashish Chavan wrote:
> > On Fri, 2013-07-05 at 12:44 +0100, Mark Brown wrote:
> 
> > > >  static const struct i2c_device_id da9055_i2c_id[] = {
> > > > -	{ "da9055", 0 },
> > > > +	{ "da9055-codec", 0 },
> > > >  	{ }
> > > >  };
> 
> > > I can't believe that you've tested this.
> 
> > Yes, I have tested this today only. But with 3.6.0-rc4 kernel. That is
> > the newest kernel for which I have board and other required support
> > available.
> 
> Your testing seems like it's not very good then - you do undersand that
> the problem that this is supposed to be fixing is that this is a multi
> function device?  Please look at how other MFDs in the kernel work.

I feel that some info is missing from your view. DA9055 is CODEC + PMIC
but with two different I2C addresses. Actually it is a case of two
different chips enclosed in a single die. There is NO interconnection
between CODEC and PMIC inside DA9055. To me, this seems enough reason to
make two drivers independent from each other and not let one part know
about the existence of other. Actually in near future, there may be
three variants of this chip,

DA9055 - PMIC + CODEC
DA9055 - PMIC only
DA9055 - CODEC only

In my opinion, keeping the drivers independent will also help in
re-using existing drivers "as it is" for any of the above combination.

Let me know if you have a different opinion.
