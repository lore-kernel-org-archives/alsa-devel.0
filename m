From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: codecs: da9055: Update driver name
 to fix breakage due to pmic driver with same name
Date: Mon, 2 Sep 2013 15:38:18 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A033751E612F5@SW-EX-MBX01.diasemi.com>
References: <1374482594.13726.11.camel@matrix>
 <20130722100211.GP9858@sirena.org.uk> <1375110386.21326.6.camel@matrix>
 <20130729160157.GZ9858@sirena.org.uk> <1375689331.28910.5.camel@matrix>
 <20130805144201.GF9858@sirena.org.uk> <1375717898.29528.23.camel@matrix>
 <20130805162342.GS9858@sirena.org.uk> <1377778108.15438.6.camel@matrix>
 <2E89032DDAA8B9408CB92943514A033751E611AF@SW-EX-MBX01.diasemi.com>
 <20130902103843.GL3084@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.107])
 by alsa0.perex.cz (Postfix) with ESMTP id AC40D2651A0
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2013 17:38:21 +0200 (CEST)
In-Reply-To: <20130902103843.GL3084@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, "kiran.padwal" <kiran.padwal@kpitcummins.com>, David Dajun Chen <david.chen@diasemi.com>, Ashish Chavan <ashish.chavan@kpitcummins.com>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 02, 2013 at 11:39, Mark Brown wrote:

> Please fix your mailer to wrap within 80 columns, it makes your mails
> very hard to read if you don't do this.

Yeah, sorry for that. Having to use Outlook and of course it doesn't seem to
have that feature (at least not that I could find), so trying to do it
manually.

> They are not separate, they are soldered to the board as part of the
> same package - quite a few other devices use a similar scheme and are
> also handled in this fashion (the TI TWL devices are one example).

The difference here is that our combined devices can also be separate chips,
not just one HW package containing logically separate devices. I don't believe
that's the case with say the TI devices.
 
> This is roughly what ends up happening, you do need to instantiate
> another I2C client no matter what.  The important thing here is that the
> CODEC does not need to be separately registered by the user, if it
> really is only the I2C client that needs creating that's probably OK so
> long as the user doesn't need to worry about that implementation detail.

The only thing that would need populating is some small platform data for the
codec (MIC bias voltages, and such). You'd still have to do this, combined or
separate, as this is platform specific. Other than this, the I2C client
initialisation for the codec is simple, which is a reason why I don't think
the PMIC needs to initialise it, and you can just as simply do it from machine
code.

> The reasoning is simply that if the chip design solders a single device
> to the board then the software system integration should register a
> single device with the system.

Ok, but what about the scenario where the devices start life as separate chips
and are then later also packaged together as one chip but still with no
internal connection, like DA9055. The drivers were already written and accepted
as separate entities in the kernel, without chained initialisation. What would
be the approach there? To me, logically it makes sense to leave them separate.
