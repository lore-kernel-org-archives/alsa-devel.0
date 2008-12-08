From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/8] ASoC: TWL4030: Add Analog PGA control
	switch to DAPM
Date: Mon, 8 Dec 2008 12:35:03 +0000
Message-ID: <20081208123502.GH5159@sirena.org.uk>
References: <1228723748-22911-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228723748-22911-3-git-send-email-peter.ujfalusi@nokia.com>
	<20081208112336.GC5159@sirena.org.uk>
	<200812081406.08116.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D8E8A103836
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 13:35:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200812081406.08116.peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 08, 2008 at 02:06:08PM +0200, Peter Ujfalusi wrote:
> On Monday 08 December 2008 13:23:37 ext Mark Brown wrote:

> > The PGA should be standard SND_SOC_DAPM_PGA()s with the digital to
> > analogue switches used to implement mute controls for them.

> Should I 'chain' these switches, like this:

> /* Digital to analog enable/disable */
> SND_SOC_DAPM_PGA("ARXR1_APGA", TWL4030_REG_ARXR1_APGA_CTL,
> 		1, 0, NULL, 0),
> /* APGA enable/disable */
> SND_SOC_DAPM_PGA("ARXR1_APGA Enable", TWL4030_REG_ARXR1_APGA_CTL,
> 		0, 0, NULL, 0),

I'd expect to see user control here...

> Or should I use the wcontrols, wncontrols to implement the DA enable/disable:

You can do that, or just do it as a normal control (which allows you to
make the control a stereo control).  This lets the user control the
switch which is generally more useful.

> If the later is preferred, than probably it would be better to move the 
> "DAC1 Analog Playback Volume" and "DAC2 Analog Playback Volume" from the 
> twl4030_snd_controls to twl4030_dapm_widgets, separate the four paths and use 
> SOC_DAPM_SINGLE_TLV("ARXR1_APGA Playback Volume" ?
> Hmm, in this case the SOC_DAPM_SINGLE_TLV can be also part of the 
> arxr1_apga_controls...

Indeed, and if you do that DAPM will try to ramp up and down the volume
using the first control after and before changing the power.  This
feature is rarely used since it's not normally needed for performance.
