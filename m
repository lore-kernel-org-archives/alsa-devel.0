From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: ADAU1761 default register value problem
Date: Mon, 16 May 2016 13:07:09 +0200
Message-ID: <alpine.DEB.2.02.1605161150530.31333@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1604211547540.31333@lnxricardw1.se.axis.com>
 <571F2513.1020005@metafoo.de>
 <alpine.DEB.2.02.1605111440510.31333@lnxricardw1.se.axis.com>
 <57358E51.7020000@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 609742619BE
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 13:07:17 +0200 (CEST)
In-Reply-To: <57358E51.7020000@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Fri, 13 May 2016, Lars-Peter Clausen wrote:

> > Having researched this further, it appears that commit
> > =

> > 27d6e7d1c96c9f51379e0feb972fec26029098bc
> > =

> > ASoC: adau17x1: Cache writes when core clock is disabled
> =

> I think it is also related to commit 1c79771a7270 ("regmap: Use
> regcache_mark_dirty() to indicate power loss or reset"). This changes the
> regmap code to sync all registers under certain conditions.

Yes, that commit seems to be the key, although I must admit that I can't =

get my head around the logic of that commit. The commit message says: "HW =

was not reset (maybe it was just clock-gated), so if we cached any writes, =

they should be sent to the hardware regardless of whether they match the =

HW default.". But if the device was indeed gated off, rather than reset, =

why should this make a difference when writing out the cache after gating =

the chip on again? If it were gated off and then on, doesn't this imply =

that the register settings won't change? Or is the idea that the chip =

might loose all its state while gated off and hence essentially needs to =

be reinitialized?

Regardless of the commit message, the code indeed does cause all the =

cached data to be written out when regcache_sync() is called in this case.

> We still have the issue though that the CODEC is in an undefined state un=
til
> the first OFF to STANDBY transitions happens. Usually this will happen ea=
rly
> on when the CODEC is bound to the sound card, but if it is not bound
> immediately it might stay there for a bit longer. So depending on the set=
up
> this may or may not be a problem.

So that means that in the probe function we should really write out the =

default values, by enabling SYSCLK_EN in the ADAU clock control register, =

and then calling regcache_sync() before disabling SYSCLK_EN again, and =

going to regcache_cache_only(..,true) ?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
