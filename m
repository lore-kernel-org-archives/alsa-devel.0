From: Johannes Stezenbach <js@sig21.net>
Subject: Re: [PATCH] ASoC: sta32x: add workaround for ESD reset
	issue
Date: Thu, 10 Nov 2011 15:27:08 +0100
Message-ID: <20111110142708.GA12808@sig21.net>
References: <20111109133001.GA7394@sig21.net>
	<20111109143647.GB587@opensource.wolfsonmicro.com>
	<20111109173419.GA10174@sig21.net>
	<20111109233256.GA5010@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C5952436F
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 15:27:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111109233256.GA5010@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@ti.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 09, 2011 at 11:32:57PM +0000, Mark Brown wrote:
> On Wed, Nov 09, 2011 at 06:34:19PM +0100, Johannes Stezenbach wrote:
> > On Wed, Nov 09, 2011 at 02:36:47PM +0000, Mark Brown wrote:
> 
> > > Given that the driver already supports powering the device down it may
> > > also be sufficient to simply enable idle_bias_off and assume that if the
> > > device resets the application will get sufficiently upset to restart
> > > things anyway.
> 
> > Unfortunately the app won't notice, the PXA I2S interface will
> > happily push the audio data to the codec which will be muted
> > without the app knowing it since the register cache will tell
> > something different.
> 
> Yeah, but if it suddenly stops in the middle of playback then that'll
> tend to register with users and if you keep it powered off at all other
> times.

Hm, the goal is to fix the issue without user interaction.
The app will keep the device open and will play back
without noticing the problem.

> > > > +	for (i = 0; i < numcoef && (index + (i + 1) * 3 < STA32X_COEF_COUNT); i++)
> > > > +		sta32x->coef_shadow[index + i] =
> > > > +			  (ucontrol->value.bytes.data[3 * i    ] << 16)
> > > > +			| (ucontrol->value.bytes.data[3 * i + 1] << 8)
> > > > +			| (ucontrol->value.bytes.data[3 * i + 2]);
> 
> > > Does this need to be done when restoring to _STANDBY as well?
> 
> > No, all registers and coefs are preserved until hw reset or power loss.
> 
> Right, but the bias level management is disabling the regulators for the
> device so power loss may happen then and _STANDBY is also used to resume
> the device after suspend when power loss may also occur.

Ah, you're right, if the system cuts power to the sta32x during
standby we need to restore the coef RAM after resume.  How I
see where my code is buggy.  I also see what you mean about
using idle_bias_off to restore the settings, namely

	level = codec->dapm.bias_level;
	BUG_ON(level == SND_SOC_BIAS_OFF);
	sta32x_set_bias_level(codec, SND_SOC_BIAS_OFF);
	sta32x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
	if (level > SND_SOC_BIAS_STANDBY);
		sta32x_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
	if (level > SND_SOC_BIAS_PREPARE);
		sta32x_set_bias_level(codec, SND_SOC_BIAS_ON);

Right?

I'll work on a new version of the patch and send it after
it's been put through testing by Sven.


Thanks for the review!

Johannes
