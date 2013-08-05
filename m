From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH] ASoC: codecs: da9055: Update driver name
 to fix breakage due to pmic driver with same name
Date: Mon, 5 Aug 2013 21:21:37 +0530
Message-ID: <1375717898.29528.23.camel@matrix>
References: <20130705133752.GX27646@sirena.org.uk>
 <1373270091.11222.12.camel@matrix> <20130708112613.GQ27646@sirena.org.uk>
 <1373542576.9286.101.camel@matrix> <20130717103651.GP22506@sirena.org.uk>
 <1374482594.13726.11.camel@matrix> <20130722100211.GP9858@sirena.org.uk>
 <1375110386.21326.6.camel@matrix> <20130729160157.GZ9858@sirena.org.uk>
 <1375689331.28910.5.camel@matrix>  <20130805144201.GF9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1lp0020.outbound.protection.outlook.com [213.199.154.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E82A0265020
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 17:15:19 +0200 (CEST)
In-Reply-To: <20130805144201.GF9858@sirena.org.uk>
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

On Mon, 2013-08-05 at 15:42 +0100, Mark Brown wrote:
> On Mon, Aug 05, 2013 at 01:25:31PM +0530, Ashish Chavan wrote:
> > On Mon, 2013-07-29 at 17:01 +0100, Mark Brown wrote:
>
> > > Well, it's a very unusual hardware design choice to have multiple I2C
> > > endpoints in a single physical chip.
>
> > I hope to see more of such devices in near future.
>
> There's probably a reason why it's not a common hardware design...
>
> > > With regmap it should be very straightforward to reuse the same driver
> > > for both standalone and non-standalone versions, just a small amount of
> > > glue code in the CODEC driver I'd expect.  Usually the bus level code is
> > > tiny.
>
> > The glue code that you are talking about is for the same virtual MFD
> > component that you proposed initially, right? I mean the glue code in
> > CODEC will help it to get attached to the MFD. In this case, in addition
> > to the glue code inside CODEC we will also need additional MFD
> > component. Or I am completely misinterpreting you here?
>
> No, I'm talking about the same thing I was talking about originally.

Thanks for confirming it. From our view point, we still feel that it's
not a good design which requires an additional MFD component even to
support a stand alone CODEC chip. The way we look at it is, there are so
many stand alone CODEC drivers in kernel and most of them are fine
without the MFD stub. We wish that our DA9055 CODEC driver should also
be treated in the same way. Just placing it in a different hardware
package (together with PMIC, in this case) shouldn't necessitate any
changes in software. e.g. whether any chip is produced as a BGA
component or through hole component, has no effect on it's software.

If you still feel that having additional MFD component is THE correct
way to move forward, then I would like to propose another way which
seems more logical to us. i.e. changing name of the CODEC driver. We
will rename the codec to "da9055c" or something similar to resolve the
name collision with PMIC. BTW this is not our preferred way and should
be considered as last option.


This message contains information that may be privileged or confidential and is the property of the KPIT Cummins Infosystems Ltd. It is intended only for the person to whom it is addressed. If you are not the intended recipient, you are not authorized to read, print, retain copy, disseminate, distribute, or use this message or any part thereof. If you receive this message in error, please notify the sender immediately and delete all copies of this message. KPIT Cummins Infosystems Ltd. does not accept any liability for virus infected mails.
