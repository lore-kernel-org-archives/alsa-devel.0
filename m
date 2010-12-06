From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: dapm: Add speaker driver widget.
Date: Mon, 06 Dec 2010 22:55:32 +0000
Message-ID: <1291676132.3281.116.camel@odin>
References: <1889FA7136B567478A67D4B0F85B0CCEA4C52E7E@dlee06.ent.ti.com>
	<20101206224359.GB2862@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 07F1E10391A
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 23:55:36 +0100 (CET)
Received: by wwe15 with SMTP id 15so255977wwe.20
	for <alsa-devel@alsa-project.org>; Mon, 06 Dec 2010 14:55:36 -0800 (PST)
In-Reply-To: <20101206224359.GB2862@opensource.wolfsonmicro.com>
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

On Mon, 2010-12-06 at 22:43 +0000, Mark Brown wrote:
> On Mon, Dec 06, 2010 at 04:34:37PM -0600, Olaya, Margarita wrote:
> 
> > In some cases it was not possible to follow the appropiate power
> > ON/OFF sequence.
> > Add a widget to support speaker drivers where power ON/OFF
> > ordering is important.
> 
> Why not use the existing speaker widget?  It's at pretty much the same
> point in the sequence and is intended for use with external GPIO
> controlled speaker drivers.  It'd be good to discuss this in the
> changelog.
> 

In this case the driver block is on the CODEC IC and after the PGA in
the audio output path, hence this version is better suited than the
external GPIO version.

> > +#define SND_SOC_DAPM_DRV(wname, wreg, wshift, winvert,\
> > +	 wcontrols, wncontrols) \
> > +{	.id = snd_soc_dapm_drv, .name = wname, .reg = wreg, .shift = wshift, \
> > +	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = wncontrols}
> 
> The _DRV name seems rather opaque - I'd suggest _SPK as a name but
> obviously that's in use.  If we do want this I guess _SPK_DRV or
> sommething.

I was thinking this too, but then I thought we may want to drive other
loads than just speakers here. e.g. haptic, vibra

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
