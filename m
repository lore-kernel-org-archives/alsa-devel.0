From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl: imx-wm8962: Do FLL
 configuration in hw_params() and hw_free()
Date: Thu, 5 Dec 2013 10:56:31 +0800
Message-ID: <20131205025630.GG8609@MrMyself>
References: <1386176048-6960-1-git-send-email-b42378@freescale.com>
 <20131204190211.GD29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 by alsa0.perex.cz (Postfix) with ESMTP id B09532654DA
 for <alsa-devel@alsa-project.org>; Thu,  5 Dec 2013 04:17:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131204190211.GD29268@sirena.org.uk>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 04, 2013 at 07:02:11PM +0000, Mark Brown wrote:
> On Thu, Dec 05, 2013 at 12:54:08AM +0800, Nicolin Chen wrote:
> 
> > Previously, we couldn't use hw_params() and hw_free() to open and close FLL
> > becuase there might be race between two simmultaneous substreams and cause
> > FLL configuration being changed and accordingly mulfunction. So we adopted
> > DAPM to control it since there won't be any race in DAPM. However, if we
> > want to playback a different sample rate file, we need to wait for DAPM to
> > change its bias_level to reconfigure FLL.
> > 
> > But after we introduced full symmetry protection in the soc-pcm, we don't
> > need to worry about the race any more. And the instance by using hw_params()
> > and hw_free() to control FLL would allow us to support flexible use cases,
> > 'aplay -Dhw:0 44k16bit.wav 48k24bit.wav 32k32bit.wav' for example.
> > 
> > Thus this patch mainly moves FLL configuration from set_bias_level() to
> > hw_params() and hw_free() so as to enchance the sound card's capability.
> 
> That's not the only reason for using set_bias_level(), it's also used so
> that bypass paths from the CODEC inputs to outputs get the FLL started
> - all the outputs need the device to be clocked.

Thank you for reminding me of this case. And I still have a concern.

As far as I can understand, the point that all the outputs needs the device
to be clocked is undeniably true, but the external MCLK should be sufficient
to source the SYSCLK of WM8962. Does the bypass mode also need to set FLL
to get an accurate frequency?

Sorry I am not so familiar with the bypass path. So what I can imagine is
WM8962 just bypass input (DAC) to outputs (DAC) via MIXER or some routes
else, then there's no need for WM8962 to generate accurate BCLK and LRCLK.
Sir, could you please also shed some light on this point if it's not a
comprehensive one?

Thank you,
Nicolin Chen
