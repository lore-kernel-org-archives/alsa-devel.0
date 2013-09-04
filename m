From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: codecs: da9055: Update driver name
 to fix breakage due to pmic driver with same name
Date: Wed, 4 Sep 2013 16:13:25 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A033751E6157D@SW-EX-MBX01.diasemi.com>
References: <1375110386.21326.6.camel@matrix>
 <20130729160157.GZ9858@sirena.org.uk> <1375689331.28910.5.camel@matrix>
 <20130805144201.GF9858@sirena.org.uk> <1375717898.29528.23.camel@matrix>
 <20130805162342.GS9858@sirena.org.uk> <1377778108.15438.6.camel@matrix>
 <2E89032DDAA8B9408CB92943514A033751E611AF@SW-EX-MBX01.diasemi.com>
 <20130902103843.GL3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E612F5@SW-EX-MBX01.diasemi.com>
 <20130902174121.GV3084@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C48026552A
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2013 18:13:27 +0200 (CEST)
In-Reply-To: <20130902174121.GV3084@sirena.org.uk>
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

On Mon, Sep 02, 2013 at 18:14, Mark Brown wrote:

> It's always been in there, can't remember where exactly and I don't have
> access to Outlook any more.

Wish I was that lucky :-) There is an option for word wrap at a certain number
of characters but that just seems to do nothing, at least for plain text e-mails
like this. Will have to find another solution when I have some spare time.

> > The difference here is that our combined devices can also be separate chips,
> > not just one HW package containing logically separate devices. I don't believe
> > that's the case with say the TI devices.
> 
> That doesn't seem like a unique feature.

It may not be unique. To be honest I don't know. However, in terms of existing
drivers in the kernel for MFD and Codec, I don't believe there's an example
of something exactly like this in place already.

> It's the bit where the board has to register the CODEC separately at all
> that's the thing.  Think about it from the point of view of people
> writing and reviewing the machine bindings - they end up with this odd
> chip that appears twice with two names and registration schemas.

Personally I don't see the issue in having two I2C clients defined for the one
chip, in the machine bindings. Logically it's absolutely correct for the chip,
and as long as the I2C IDs for the devices make sense (which wasn't the case for
DA9055, and is something I want to rectify), then it should be obvious
to anyone who comes across that code. Actually having them as two separate
entries in machine code helps to highlight that they are individual I2C devices
in one package rather than somehow linked internally and requiring ordered
initialisation. That seems right to me, and would tally with the associated
datasheet for the device.

> > Ok, but what about the scenario where the devices start life as separate chips
> > and are then later also packaged together as one chip but still with no
> > internal connection, like DA9055. The drivers were already written and accepted
> > as separate entities in the kernel, without chained initialisation. What would
> > be the approach there? To me, logically it makes sense to leave them separate.
> 
> It doesn't seem to make much difference what order the drivers are added
> in here?  You're going to need to add a new device IDs for the SIP anyway
> since it'd presumably be badged as something new - if it wasn't then
> that's a bit different.

Yes you would add new device IDs to the drivers in question, to align with a new
device number for the combined chip, but I wouldn't expect anything more than
that as the functionality remains identical. It would simply be to document
which devices each driver supports.
