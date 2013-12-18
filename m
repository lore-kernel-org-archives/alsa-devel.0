From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v3] ASoC: fsl: imx-wm8962: Grant
 hw_params/free() permission to control FLL
Date: Wed, 18 Dec 2013 13:13:36 +0800
Message-ID: <20131218051334.GA7648@MrMyself>
References: <1386842368-19951-1-git-send-email-Guangyu.Chen@freescale.com>
 <20131217225002.GR28455@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 07BE62610B9
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 06:34:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131217225002.GR28455@sirena.org.uk>
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
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 17, 2013 at 10:50:02PM +0000, Mark Brown wrote:
> On Thu, Dec 12, 2013 at 05:59:28PM +0800, Nicolin Chen wrote:
> 
> > +	mask = WM8962_MIXINL_TO_HPMIXL_MASK | WM8962_MIXINR_TO_HPMIXL_MASK |
> > +		WM8962_IN4L_TO_HPMIXL_MASK | WM8962_IN4R_TO_HPMIXL_MASK;
> > +	bypass |= snd_soc_read(codec, WM8962_HEADPHONE_MIXER_1) & mask;
> > +	bypass |= snd_soc_read(codec, WM8962_HEADPHONE_MIXER_2) & mask;
> > +	bypass |= snd_soc_read(codec, WM8962_SPEAKER_MIXER_1) & mask;
> > +	bypass |= snd_soc_read(codec, WM8962_SPEAKER_MIXER_2) & mask;
> > +
> > +	/* Don't diable FLL if running multi-substreams or analogue bypass */
> > +	if (codec_dai->active != 1 || bypass)
> > +		return 0;
> 
> I don't think this works with the power down delay we do on playback -
> the DAI will go inactive when closed but we'll still have the CODEC
> active and using its clocks until the power down time has elapsed if
> it's a playback DAI.  Trying to reclock the device while active is at
> best risky, even if it's muted.
>
> I do think refcounting from both here and the bias level changes is
> going to be the most robust thing, that'd also avoid the need to peer
> into the CODEC register map.

I've tried count reference way to handle FLL enabler/disabler here before
I sent this version. But the result shows the FLL would be never disabled
in hw_free() because the refcount is accumulated to 2, one from hw_params()
and the other from set_bias_level(PREPARE), which just made this patch
meaningless to me.

So the reclocking with bypass checking seems to be the last resort I can
figure out right here as the playback flow for 'aplay -Dhw:0 44k16bit.wav
48k24bit.wav' does need to reprogram the FLL during CODEC active.

Thank you,
Nicolin Chen
