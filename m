From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC audio fabric OF bindings RFC. was: Re: ASoC
 MPC5xxx PSC AC97 audio driver
Date: Fri, 9 Sep 2011 17:37:14 +0100
Message-ID: <20110909163714.GA4302@sirena.org.uk>
References: <20110908121600.267dee07@archvile>
	<CAKON4OzsMd0T6KyDK_5P_pz8R5Pax+Bd+f5+00cO5E0OMCYQpQ@mail.gmail.com>
	<20110908124529.520c1388@archvile>
	<CAKON4OwvYy6Dy-MfHT90syPyAUcTVRXqXca-qAVjk-KWkak53A@mail.gmail.com>
	<20110908163231.4b721973@archvile> <20110908184441.GD16989@siel.b>
	<20110909082844.3dbf0e72@archvile>
	<20110909120216.263eeb54@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EDFFF24489
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 18:37:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110909120216.263eeb54@archvile>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Jander <david.jander@protonic.nl>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, lrg@ti.com, devicetree-discuss@lists.ozlabs.org, torbenh <torbenh@gmx.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 09, 2011 at 12:02:16PM +0200, David Jander wrote:

> Ok, I actually spent a while thinking about this. What about the following
> idea:

*Always* CC maintainers.

> 1: By adding compatible = "alsa,cpu-dai", this DAI is marked for binding.

This isn't really something that should go into device tree, ALSA is a
Linux specific concept.

> 3: Many ac97 codecs are compatible with the generic codec driver "ac97-codec".

All should be.  The only reason for specific drivers is to enable
additional non-standard functionality.

> 4: Don't know if this is the right way to work the codec DAI name in. See the
> next note:

What we should really be doing here is to autodiscover by reading the ID
registers in the device.  That needs generic AC'97 bus work which we
don't have right now.
