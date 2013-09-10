From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: codecs: da9055: Update driver name
 to fix breakage due to pmic driver with same name
Date: Tue, 10 Sep 2013 13:05:54 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A033751E630F5@SW-EX-MBX01.diasemi.com>
References: <1375717898.29528.23.camel@matrix>
 <20130805162342.GS9858@sirena.org.uk> <1377778108.15438.6.camel@matrix>
 <2E89032DDAA8B9408CB92943514A033751E611AF@SW-EX-MBX01.diasemi.com>
 <20130902103843.GL3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E612F5@SW-EX-MBX01.diasemi.com>
 <20130902174121.GV3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E6157D@SW-EX-MBX01.diasemi.com>
 <20130904183405.GX3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E61991@SW-EX-MBX01.diasemi.com>
 <20130909112643.GX29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.144])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F991261A18
 for <alsa-devel@alsa-project.org>; Tue, 10 Sep 2013 15:06:03 +0200 (CEST)
In-Reply-To: <20130909112643.GX29403@sirena.org.uk>
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

On Mon, Sep 09, 2013 at 12:27, Mark Brown wrote:

> > Bringing this back to DA9055 though, the current method of initialisation, for
> > PMIC and Codec, isn't complicated or confusing nor does it require a lot of
> > effort. As well as this the implementation is logically sound. It should
> > remain that way in my opinion. The only thing that should be updated is the I2C
> > Id of the Codec to make it more meaningful, and preferably sooner rather than
> > later so the issue can be finally put to bed.
> 
> Well, the obvious approach would seem to be to just do the registration
> of the CODEC I2C device from the MFD...

Had we felt that was the obvious approach then we'd have taken it, as it's much
easier to 'fall in line'. However I believe the approach that we adopted was
the obvious and correct one for our chip. It is just a shame that you don't see
things the same way.

As it stands we have fully functional drivers integrated in the kernel, which
are tested and proven. What remains as far as I'm concerned is a simple ID
name change to make things cleaner, but you do not agree with this approach.
Your suggestion is to move initialisation of the Codec to the MFD core of the
PMIC driver which to me is unnecessary and limiting and is something I cannot
agree with. Basically we're at a bit of an impasse here...
