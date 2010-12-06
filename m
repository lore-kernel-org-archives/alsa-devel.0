From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: dapm: Add speaker driver widget.
Date: Mon, 06 Dec 2010 23:30:07 +0000
Message-ID: <1291678207.3281.152.camel@odin>
References: <1889FA7136B567478A67D4B0F85B0CCEA4C52E7E@dlee06.ent.ti.com>
	<20101206224359.GB2862@opensource.wolfsonmicro.com>
	<1291676132.3281.116.camel@odin>
	<20101206230948.GH2862@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 25CB3103941
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 00:30:10 +0100 (CET)
Received: by wyi11 with SMTP id 11so12714225wyi.38
	for <alsa-devel@alsa-project.org>; Mon, 06 Dec 2010 15:30:09 -0800 (PST)
In-Reply-To: <20101206230948.GH2862@opensource.wolfsonmicro.com>
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
Cc: "Olaya, Margarita" <magi.olaya@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-12-06 at 23:09 +0000, Mark Brown wrote:
> On Mon, Dec 06, 2010 at 10:55:32PM +0000, Liam Girdwood wrote:
> > On Mon, 2010-12-06 at 22:43 +0000, Mark Brown wrote:
> 
> > > Why not use the existing speaker widget?  It's at pretty much the same
> > > point in the sequence and is intended for use with external GPIO
> > > controlled speaker drivers.  It'd be good to discuss this in the
> > > changelog.
> 
> > In this case the driver block is on the CODEC IC and after the PGA in
> > the audio output path, hence this version is better suited than the
> > external GPIO version.
> 
> Sure, but it's fulfiling the same role in the system - it's just that
> these days a lot more CODECs are pulling speaker drivers directly into
> the CODEC die.  Mostly these have worked well handled as PGAs so it's
> not been an issue.
> 

In this case as we need to enable the PGA before the driver and disable
the driver before the PGA for pop reduction. Hence the current ordering
needs an addition/refactoring to deal with the newer generation of
CODECs here.

> I'd certainly expect to see it handled the same way from a DAPM
> sequencing point of view as it's fulfilling the same role in the system
> (so in the same slot rather than separately as the patch was doing).  Do
> we just need to refactor the existing external widgets to be able to
> exist in either register or GPIO based versions?
> 
> > > > +#define SND_SOC_DAPM_DRV(wname, wreg, wshift, winvert,\
> > > > +	 wcontrols, wncontrols) \
> > > > +{	.id = snd_soc_dapm_drv, .name = wname, .reg = wreg, .shift = wshift, \
> > > > +	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols}
> 
> > > The _DRV name seems rather opaque - I'd suggest _SPK as a name but
> > > obviously that's in use.  If we do want this I guess _SPK_DRV or
> > > sommething.
> 
> > I was thinking this too, but then I thought we may want to drive other
> > loads than just speakers here. e.g. haptic, vibra
> 
> My main thing here is _DRV - it's not just that it's undescriptive, it's
> also that calling something a driver in a context like this is confusing.
> _OUT_DRV is another idea?  

Ok, lets go for OUT_DRV.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
