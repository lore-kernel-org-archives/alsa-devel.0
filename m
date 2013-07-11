From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH] ASoC: codecs: da9055: Update driver name
 to fix breakage due to pmic driver with same name
Date: Thu, 11 Jul 2013 17:06:16 +0530
Message-ID: <1373542576.9286.101.camel@matrix>
References: <1373024862.3233.63.camel@matrix>
 <20130705114456.GV27646@sirena.org.uk> <1373031306.3233.131.camel@matrix>
 <20130705133752.GX27646@sirena.org.uk> <1373270091.11222.12.camel@matrix>
 <20130708112613.GQ27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 by alsa0.perex.cz (Postfix) with ESMTP id D45352657FF
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 13:21:07 +0200 (CEST)
In-Reply-To: <20130708112613.GQ27646@sirena.org.uk>
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


> > I feel that some info is missing from your view. DA9055 is CODEC + PMIC
> > but with two different I2C addresses. Actually it is a case of two
> > different chips enclosed in a single die. There is NO interconnection
> > between CODEC and PMIC inside DA9055. To me, this seems enough reason to
> > make two drivers independent from each other and not let one part know
> > about the existence of other. Actually in near future, there may be
> > three variants of this chip,
> 
> This is very similar to things like the TI palmas chips - they have
> multiple functions on different I2C addresses.  The chip still gets
> instantiated a single time and then the subdevices are instantiated
> like a MFD by the core device.

I have had a look at palmas implementation. It seems to me that a
significant change to both PMIC and CODEC drivers is required to make
them inline with palmas structure. It will also need a thorough testing
cycle for both. I am afraid that we may not have immediate bandwidth to
accommodate this level of change. Is it possible that in first go we
just fix the breakage due to name collision so that both drivers remain
usable. And in second iteration, we restructure both of them as you
suggested?
