From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] ASoC: sgtl5000: add device tree probe
	support
Date: Fri, 29 Jul 2011 10:00:33 -0600
Message-ID: <20110729160033.GF11164@ponder.secretlab.ca>
References: <1311265731-23318-1-git-send-email-shawn.guo@linaro.org>
	<20110726195511.GA9956@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C9A4010381D
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jul 2011 18:00:36 +0200 (CEST)
Received: by yib2 with SMTP id 2so2820452yib.38
	for <alsa-devel@alsa-project.org>; Fri, 29 Jul 2011 09:00:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110726195511.GA9956@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, Zeng Zhaoming <zhaoming.zeng@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 26, 2011 at 08:55:11PM +0100, Mark Brown wrote:
> On Fri, Jul 22, 2011 at 12:28:51AM +0800, Shawn Guo wrote:
> 
> > It adds device tree probe support for sgtl5000 driver.
> 
> Kind of waiting for the device tree people to comment on this...
> 
> >  .../bindings/sound/soc/codecs/fsl-sgtl5000.txt     |   11 +++++++++++
> 
> I'd expect this can just be put directly under the sound directory.
> 
> > +++ b/Documentation/devicetree/bindings/sound/soc/codecs/fsl-sgtl5000.txt
> > @@ -0,0 +1,11 @@
> > +* Freescale SGTL5000 Stereo Codec
> > +
> > +Required properties:
> > +- compatible : "fsl,sgtl5000".
> > +
> > +Example:
> > +
> > +codec: sgtl5000@0a {
> > +	compatible = "fsl,sgtl5000";
> > +	reg = <0x0a>;
> > +};
> 
> This might get a tiny bit verbose...  I wonder if it makes sense to have
> some central file for devices with trivial bindings?  But possibly more
> trouble than it's worth.

Yes, I think it would be valuable.  I've been thinking a lot about how
to make binding documentation less verbose and have much better cross
referencing so that binding documentation doesn't need to include all
kinds of common property definitions. I've had no time to work on
it though... I need an intern student.  :-)

g.
