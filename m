From: Peter Rosin <peda@axentia.se>
Subject: RE: [alsa-devel] [PATCH] ASoC: atmel_ssc_dai: Track playback and
 capture CMR dividers separately.
Date: Wed, 22 Oct 2014 11:42:18 +0000
Message-ID: <a983ea457a56451a96e377d64f861a9d@EMAIL.axentia.se>
References: <a541333cf46b4c61b790df927d4b315d@EMAIL.axentia.se>
 <5445BCBF.5090002@atmel.com>
 <dc4461593ddb4d539f2db74b69bab98c@EMAIL.axentia.se>
 <544620C8.4040001@atmel.com>
 <8559eca320324092be82f7d942606102@EMAIL.axentia.se>
 <544707F3.1020505@atmel.com>
 <c61abc1ef0f341c2be04e3d7b07d97de@EMAIL.axentia.se>
 <54476640.5050603@atmel.com>
 <05f8e371e0ac40949bfc01b8d86d3c6e@EMAIL.axentia.se>
 <54477775.7070401@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54477775.7070401@atmel.com>
Content-Language: sv-SE
Sender: linux-kernel-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Bo Chen wrote:
> with this piece of code, I reproduce your issue.
> 
> Now, I know the reason of this issue, work in oss mode, it will set the default
> clock to 8KHz, and then if change to other sample rate, for example 48KHz,
> the div is different, then it reports -EBUSY.

Indeed.

> So, I think we won't change the ATMEL_SSC_CMR_DIV to
> ATMEL_SSC_TCMR_DIV and ATMEL_SSC_RCMR_DIV, as it will affect other
> users. We just deal with this situation in ATMEL_SSC_CMR_DIV block, check
> the direction, if the same direction change the div, then accept the change,
> otherwise, return -EBUSY.

Ok.

But I'm not sure it is possible to dig out the current direction in the
.set_clkdiv callback? Perhaps the correct fix is to set the bits
.symmetric_rates, .symmetric_channels and .symmetric_samplebits
in the atmel_ssc_dai struct when the ssc dai is master? Then I
expect that other mechanisms will kick in that will render the current
CMR_DIV check pointless?

Is a dai driver allowed to change these symmetry bits after registration?
Can they be set in the .set_sysclk callback? Perhaps in the
ATMEL_SSC_CMR_DIV block itself? That callback should only be
called when the dai is master, so that would be perfect...

Yes, the limitation would be a little bit more strict than today, but is it
really common to require different modes on playback and capture?

Cheers,
Peter
