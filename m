From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: PATCH[1/1] Add I2S common driver for Intel MID
 platform
Date: Wed, 20 Oct 2010 00:01:47 +0100
Message-ID: <1287529307.3272.579.camel@odin>
References: <2A84145621092446B6659B8A0F28E26F46FE77084A@irsmsx501.ger.corp.intel.com>
	<20101019213212.GB29234@sirena.org.uk>
	<AANLkTim8uEuSYhHyedLn3gbaPQLvwo7Gu+eo-Vo23KvC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id C8F5E244AC
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Oct 2010 01:01:47 +0200 (CEST)
Received: by wyb32 with SMTP id 32so3145024wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 19 Oct 2010 16:01:47 -0700 (PDT)
In-Reply-To: <AANLkTim8uEuSYhHyedLn3gbaPQLvwo7Gu+eo-Vo23KvC@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Le Gall,
	Louis" <louis.le.gall@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-10-19 at 17:48 -0500, pl bossart wrote:
> >>         As this is used to transfer speech frames from/to cellular modem that have specific timing constraints (and modem also uses the I2S path to send some side-info), the Alsa SoC interface cannot be used.
> >
> > What makes you say this?  You have provided no detail on what problems
> > you believe exist and since ASoC is a *very* thin wrapper around the
> > core ALSA for DMA stuff it is very surprising that you would see any
> > issues here that don't also affect plain ALSA.  If there are any issues
> > then it would seem better to resolve these within the current framework
> > rather than completely discarding the entire existing infrastructure.
> 
> Louis meant ALSA rather than ASOC. We use burst transfers to reduce
> round-trip delay, the whole notion of periods/period elapsed/ring
> buffer doesn't make sense here and there is in-band signalling that
> should not be interpreted as samples. If ALSA had a simplified API for
> byte streams sent over a serial output, we would have no problems
> using it and of course ASOC would be used then.

Is the inband signaling here done in software ? I'd expect this to be
multiplexed in the DAI by the hardware leaving the software to send PCM
bursts to the CODEC/MODEM/whatever like Peter's DAC33 driver.

Liam 
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
