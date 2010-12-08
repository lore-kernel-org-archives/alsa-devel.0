From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: omap: Add hardware constraint
 for HDMI and ABE
Date: Wed, 08 Dec 2010 12:09:43 +0000
Message-ID: <1291810183.3260.185.camel@odin>
References: <1889FA7136B567478A67D4B0F85B0CCEA4C52E80@dlee06.ent.ti.com>
	<201012071057.24139.peter.ujfalusi@nokia.com>
	<201012081111.40323.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C7470103C14
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 13:09:46 +0100 (CET)
Received: by wyi11 with SMTP id 11so1005409wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 08 Dec 2010 04:09:46 -0800 (PST)
In-Reply-To: <201012081111.40323.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "ext Olaya, Margarita" <magi.olaya@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-12-08 at 11:11 +0200, Peter Ujfalusi wrote:
> On Tuesday 07 December 2010 10:57:24 Ujfalusi Peter (Nokia-MS/Tampere) wrote:
> > On Tuesday 07 December 2010 00:34:44 ext Olaya, Margarita wrote:
> > > From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> > > 
> > > The Audio Backend needs a step size of 24 * 4, while HDMI requires a
> > > step size of 32 * 4 bits to align the audio buffer.
> 
> ...
> 
> > Few things:
> > This only applicable for OMAP4, so please make it so that it only applies
> > to OMAP4.
> > We have the other constraints set in the
> > omap-mcbsp.c:omap_mcbsp_dai_startup. I think it would be better to keep
> > them in a same place.
> 
> One more thing:
> Since this is ABE/HDMI specific constraint, I would add this from the 
> corresponding codec driver rather than setting this for all McBSP ports 
> regardless if it is used with HDMI or not.
> 

I've spoken with Magi and this will be moved to the OAMP4 HDMI and ABE
DAI drivers only.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
