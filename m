From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] ASoC: sgtl5000: add device tree probe
	support
Date: Fri, 29 Jul 2011 10:00:48 -0600
Message-ID: <20110729160048.GG11164@ponder.secretlab.ca>
References: <1311265731-23318-1-git-send-email-shawn.guo@linaro.org>
	<20110726195511.GA9956@opensource.wolfsonmicro.com>
	<20110729024050.GD1946@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F7C910383D
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jul 2011 18:00:51 +0200 (CEST)
Received: by pzk1 with SMTP id 1so5206472pzk.2
	for <alsa-devel@alsa-project.org>; Fri, 29 Jul 2011 09:00:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110729024050.GD1946@S2100-06.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: alsa-devel@alsa-project.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Zeng Zhaoming <zhaoming.zeng@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 29, 2011 at 10:40:51AM +0800, Shawn Guo wrote:
> On Tue, Jul 26, 2011 at 08:55:11PM +0100, Mark Brown wrote:
> > On Fri, Jul 22, 2011 at 12:28:51AM +0800, Shawn Guo wrote:
> > 
> > > It adds device tree probe support for sgtl5000 driver.
> > 
> > Kind of waiting for the device tree people to comment on this...
> > 
> 
> Grant, please?

Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> Regards,
> Shawn
> 
> > >  .../bindings/sound/soc/codecs/fsl-sgtl5000.txt     |   11 +++++++++++
> > 
> > I'd expect this can just be put directly under the sound directory.
> > 
> > > +++ b/Documentation/devicetree/bindings/sound/soc/codecs/fsl-sgtl5000.txt
> > > @@ -0,0 +1,11 @@
> > > +* Freescale SGTL5000 Stereo Codec
> > > +
> > > +Required properties:
> > > +- compatible : "fsl,sgtl5000".
> > > +
> > > +Example:
> > > +
> > > +codec: sgtl5000@0a {
> > > +	compatible = "fsl,sgtl5000";
> > > +	reg = <0x0a>;
> > > +};
> > 
> > This might get a tiny bit verbose...  I wonder if it makes sense to have
> > some central file for devices with trivial bindings?  But possibly more
> > trouble than it's worth.
> > _______________________________________________
> > devicetree-discuss mailing list
> > devicetree-discuss@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/devicetree-discuss
> > 
> 
