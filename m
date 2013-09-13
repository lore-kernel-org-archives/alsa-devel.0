From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: codecs: da9055: Update driver name
 to fix breakage due to pmic driver with same name
Date: Fri, 13 Sep 2013 15:05:47 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A033751E63CDD@SW-EX-MBX01.diasemi.com>
References: <20130902103843.GL3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E612F5@SW-EX-MBX01.diasemi.com>
 <20130902174121.GV3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E6157D@SW-EX-MBX01.diasemi.com>
 <20130904183405.GX3084@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E61991@SW-EX-MBX01.diasemi.com>
 <20130909112643.GX29403@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E630F5@SW-EX-MBX01.diasemi.com>
 <20130910170724.GU29403@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A033751E634EF@SW-EX-MBX01.diasemi.com>
 <20130912215810.GX29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.176])
 by alsa0.perex.cz (Postfix) with ESMTP id BD9322610A8
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 17:05:49 +0200 (CEST)
In-Reply-To: <20130912215810.GX29403@sirena.org.uk>
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

On Thu, Sep 12, 2013 at 22:58, Mark Brown wrote:

> > It's limiting in as much as it's insisting on a required order for
> > initialisation which shouldn't be there. As said previously they're 2 separate
> > devices in one package, with no internal connection, so either could be
> > instantiated first. It should be open to the user to decide on this based on
> > their platform and needs.
> 
> > With your approach, it is more work for no gain here, and holds us to a
> > logical representation which doesn't fit with the device in question (which is
> > not really an MFD, it's two devices, one of which is an MFD, the PMIC).
> 
> I'm having a hard time understanding this as a practical limitation, can
> you be more specific about the cases where this would present a noticable
> problem?  It'd at least ensure that the configuration where the whole
> device is present gets tested to some extent, though that doesn't seem
> likely to break again.

If I'm honest I didn't have anything specific in mind here. There is the
possibility that the Codec needn't be powered from the packaged PMIC (unlikely
but technically possible in HW), in the same way as if it were a standalone
chip, so I didn't want to unnecessarily imply or force any kind of link or
required ordering in Software, to leave it flexible for the future should some
need arise.

I understand your concern over testing, given the issue that was found with
these drivers, and I can only apologise that it wasn't caught. This is not
something that will occur again as we certainly don't want a repeat scenario. It
should be noted though that the drivers were thoroughly tested individually for
each device and proven fully functional, and I maintain the approach taken for
driver development was the correct one here. It will make it easier in the
future with standalone versions, and where these devices themselves are paired
with a different devices, in the same manor.
