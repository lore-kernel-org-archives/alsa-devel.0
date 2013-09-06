From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: codecs: da9055: Update driver name
 to fix breakage due to pmic driver with same name
Date: Fri, 6 Sep 2013 14:17:48 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A033751E61991@SW-EX-MBX01.diasemi.com>
References: <1375689331.28910.5.camel@matrix>
 <20130805144201.GF9858@sirena.org.uk> <1375717898.29528.23.camel@matrix>
 <20130805162342.GS9858@sirena.org.uk> <1377778108.15438.6.camel@matrix>
 <2E89032DDAA8B9408CB92943514A033751E611AF@SW-EX-MBX01.diasemi.com>
 <20130902103843.GL3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E612F5@SW-EX-MBX01.diasemi.com>
 <20130902174121.GV3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E6157D@SW-EX-MBX01.diasemi.com>
 <20130904183405.GX3084@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.107])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FB46261A78
 for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2013 16:17:52 +0200 (CEST)
In-Reply-To: <20130904183405.GX3084@sirena.org.uk>
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

On Wed, Sep 04, 2013 at 19:34, Mark Brown wrote:

> > Personally I don't see the issue in having two I2C clients defined for the one
> > chip, in the machine bindings. Logically it's absolutely correct for the chip,
> > and as long as the I2C IDs for the devices make sense (which wasn't the case for
> > DA9055, and is something I want to rectify), then it should be obvious
> > to anyone who comes across that code. Actually having them as two separate
> > entries in machine code helps to highlight that they are individual I2C devices
> > in one package rather than somehow linked internally and requiring ordered
> > initialisation. That seems right to me, and would tally with the associated
> > datasheet for the device.
> 
> The goal is that users shouldn't even need to have to think about how
> the chip is constructed, they should just be able to use it with minimal
> thought or effort.  Anything that can be encapsulated within the drivers
> should be.

I agree with your ideas and it's something that should be enforced, but only if
it makes sense to the scenario. Taking away flexibility, functionality and
logical correctness just to make things 'easier' seems a bit wrong. Also, there
are many chip drivers which 'encapsulate' as you say, but they're not
necessarily effortless to work with. I have spotted examples which require
chunks of platform data to configure the device correctly, thus needing at least
some understanding of the chip itself. But I wouldn't say that's wrong because
it's needed to allow for complete usage of the device in question.

Bringing this back to DA9055 though, the current method of initialisation, for
PMIC and Codec, isn't complicated or confusing nor does it require a lot of
effort. As well as this the implementation is logically sound. It should
remain that way in my opinion. The only thing that should be updated is the I2C
Id of the Codec to make it more meaningful, and preferably sooner rather than
later so the issue can be finally put to bed.
