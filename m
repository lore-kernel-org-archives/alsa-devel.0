From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: codecs: da9055: Update driver name
 to fix breakage due to pmic driver with same name
Date: Thu, 12 Sep 2013 17:11:06 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A033751E634EF@SW-EX-MBX01.diasemi.com>
References: <1377778108.15438.6.camel@matrix>
 <2E89032DDAA8B9408CB92943514A033751E611AF@SW-EX-MBX01.diasemi.com>
 <20130902103843.GL3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E612F5@SW-EX-MBX01.diasemi.com>
 <20130902174121.GV3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E6157D@SW-EX-MBX01.diasemi.com>
 <20130904183405.GX3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E61991@SW-EX-MBX01.diasemi.com>
 <20130909112643.GX29403@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E630F5@SW-EX-MBX01.diasemi.com>
 <20130910170724.GU29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.115])
 by alsa0.perex.cz (Postfix) with ESMTP id ACEFE2654DD
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 19:11:08 +0200 (CEST)
In-Reply-To: <20130910170724.GU29403@sirena.org.uk>
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

On Tue, Sep 10, 2013 at 08:07, Mark Brown wrote:

> > Your suggestion is to move initialisation of the Codec to the MFD core of the
> > PMIC driver which to me is unnecessary and limiting and is something I cannot
> > agree with. Basically we're at a bit of an impasse here...
> 
> What limitations do you see?  I don't see any substantial issues and you
> haven't mentioned any.

It's limiting in as much as it's insisting on a required order for
initialisation which shouldn't be there. As said previously they're 2 separate
devices in one package, with no internal connection, so either could be
instantiated first. It should be open to the user to decide on this based on
their platform and needs.

With your approach, it is more work for no gain here, and holds us to a
logical representation which doesn't fit with the device in question (which is
not really an MFD, it's two devices, one of which is an MFD, the PMIC).
