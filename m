From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: Re: [PATCH] ASoC: mc13783: add mixer controls
Date: Thu, 10 Oct 2013 09:34:11 +0200
Message-ID: <20131010073411.GF14042@pengutronix.de>
References: <1381330904-26389-1-git-send-email-s.trumtrar@pengutronix.de>
 <20131009151336.GO21581@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 7C32A2619D7
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 09:34:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20131009151336.GO21581@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi!

On Wed, Oct 09, 2013 at 04:13:36PM +0100, Mark Brown wrote:
> On Wed, Oct 09, 2013 at 05:01:44PM +0200, Steffen Trumtrar wrote:
> 
> > +static const char * const mc13783_alsp[] = {"Off", "Codec", "Right"};
> > +
> > +static const char * const mc13783_ahs[] = {"Codec", "Mixer"};
> 
> What are these - these look like they might be DAPM rather than regular
> controls?
> 

Looks like you are right. Will fix.

> > +	SOC_SINGLE("Headset Amp Right Switch", MC13783_AUDIO_RX0, 9, 1, 0),
> > +	SOC_SINGLE("Headset Amp Left Switch", MC13783_AUDIO_RX0, 10, 1, 0),
> 
> I would expect these to be stereo controls rather than two mono
> controls?
> 

Okay.

> > +	SOC_ENUM("Line out Amp Switch", mc13783_enum_arxout),
> 
> Switches shouldn't be enums.
> 

Hm, would "Line out Amp Source" be correct then? Or just "Line out Amp"?
I'm not really getting the documentation in that regard.

> > +	SOC_SINGLE("Codec Capture Mix Switch", MC13783_AUDIO_RX0, 21, 1, 0),
> 
> CODEC and Codec seem to be getting mixed in the file.

Okay. I will fix that.

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
