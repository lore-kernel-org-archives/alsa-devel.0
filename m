From: David Jander <david.jander@protonic.nl>
Subject: Re: ASoC audio fabric OF bindings RFC. was: Re: ASoC
 MPC5xxx PSC AC97 audio driver
Date: Mon, 12 Sep 2011 15:59:05 +0200
Message-ID: <20110912155905.35cda85b@archvile>
References: <20110908124529.520c1388@archvile>
	<CAKON4OwvYy6Dy-MfHT90syPyAUcTVRXqXca-qAVjk-KWkak53A@mail.gmail.com>
	<20110908163231.4b721973@archvile> <20110908184441.GD16989@siel.b>
	<20110909082844.3dbf0e72@archvile>
	<20110909120216.263eeb54@archvile>
	<20110909163714.GA4302@sirena.org.uk>
	<20110912083158.29d9e1fe@archvile>
	<20110912110950.GD2953@opensource.wolfsonmicro.com>
	<20110912145507.4ac0d56f@archvile>
	<20110912131924.GB5887@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from protonic.xs4all.nl (protonic.xs4all.nl [213.84.116.84])
	by alsa0.perex.cz (Postfix) with ESMTP id B0ACA10380C
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 15:58:53 +0200 (CEST)
In-Reply-To: <20110912131924.GB5887@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, lrg@ti.com, devicetree-discuss@lists.ozlabs.org, torbenh <torbenh@gmx.de>
List-Id: alsa-devel@alsa-project.org

On Mon, 12 Sep 2011 14:19:24 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Mon, Sep 12, 2011 at 02:55:07PM +0200, David Jander wrote:
> > Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> 
> > > Other OSs are actively using device tree.
> 
> > Interesting. I wasn't aware of "actively using". Sure, there's MacOS-X-ppc,
> > IBM AIX, Oracle Solaris.... and I just discovered that Free-/OpenBSD also
> > use them.
> 
> *BSD are the main ones to consider here.
> 
> > > Eliminating board specific code for audio is not a realistic goal, the
> > > configuration of modern audio subsystems is too complex and dynamic.  
> 
> > Why not? How complex could it be in order to not be able to describe it in
> > a Device-Tree in some OS-agnostic way?
> 
> Note the "dynamic" bit - the configuration changes at runtime.
> Describing the hardware for something like a modern smartphone isn't
> particularly useful due to the flexibility, there are too many different
> ways of configuring the system and we need code to acutally take those
> decision.

Ok, but you could still describe the hardwired part of it (Audio muxes,
codecs, busses and physical interfaces). Isn't that what OF is all about?
In our case, its just a simple AC97 codec connected to a simple AC97 bus.
Sounds like total overkill having to write a "fabric driver" for this....
while there are already quite a few that are all 99% the same!

> > > The plan is to push the device trees out of the kernel into a separate
> > > repository.
> 
> > Good idea.... but where should such a repository be hosted?
> 
> Still an open issue.

Seems like its hard to find a vendor- and OS-neutral entity to host this?
OpenBIOS maybe?

Best regards,

-- 
David Jander
Protonic Holland.
