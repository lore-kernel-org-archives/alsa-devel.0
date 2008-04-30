From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc tlv320aic3x: set power bits correctly
Date: Wed, 30 Apr 2008 14:41:17 +0100
Message-ID: <20080430134116.GA27364@rakim.wolfsonmicro.main>
References: <20080430093719.GA13740@buzzloop.caiaq.de>
	<20080430095747.GA28593@sirena.org.uk>
	<bd7b27490804300450sc6c69d1v2edf2a8dca44bda@mail.gmail.com>
	<80ACB17D-E7D2-4A4C-81F8-620C2D661781@caiaq.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 143C324580
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Apr 2008 15:41:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <80ACB17D-E7D2-4A4C-81F8-620C2D661781@caiaq.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 30, 2008 at 03:11:06PM +0200, Daniel Mack wrote:

> Hmm, ok - I might have a lack of knowledge here. All I was seeing with  
> an I2C hardware analyzer is that those registers in question were  
> written without the power bit set which makes them remain muted.  
> What's the way to power up this entity properly?

You need to ensure that the entire DAPM path from the DAC to the output
is powered by ensuring that the final output endpoint is marked as
active.  Your machine driver should be using snd_soc_dapm_set_endpoint()
to mark either the output pin of the codec or any external device (eg, a
jack) that you've told DAPM about as enabled.  If you do not do this
then DAPM will notice that none output paths are connected and not power
on any of the components in the output path in order to save power.

This should be integrated with any jack detection you are doing so that,
for example, the headphone output will be marked as disabled when there
is no headphone present.  The core will automatically manage the power
state for DACs and ADCs but the machine driver needs to manage the power
state for everything else.

> And as we're on it - aic3x_dapm_event(SNDRV_CTL_POWER_D3cold) is  
> called shortly after PCM playback has finished which clears the power  
> bits of many registers. This in turn also makes the current PGA mixer  
> setting become unfunctional as the outputs are switched off. Is there  
> a proper way of preventing the glue layer to power down the chip in  
> this case?

Are you sure about that?  The chip should only be being placed into
D3cold when the system is being suspended or powered off.  The chip will
be placed into D3hot when the DACs and ADCs go idle but not D3cold.
You will see similar behaviour if you haven't marked appropriate
endpoints as active (since DAPM will power off anything it thinks is not
in use, triggered when the DAC or ADC goes idle) but it shouldn't be
done by the driver D3cold.
