From: Vinod <vkoul@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: core: add support to card
 re-bind/unbind using component framework
Date: Thu, 12 Jul 2018 22:13:50 +0530
Message-ID: <20180712164350.GW3219@vkoul-mobl>
References: <20180711084318.11786-1-srinivas.kandagatla@linaro.org>
 <68715fbc-9447-dfaf-3fe5-4200684c2cbc@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <68715fbc-9447-dfaf-3fe5-4200684c2cbc@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, rohitkr@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On 12-07-18, 10:26, Pierre-Louis Bossart wrote:
> On 7/11/18 3:43 AM, Srinivas Kandagatla wrote:
> > This patch aims at add achieving dynamic behaviour of audio card when
> > the dependent components disappear and reappear.
> > 
> > With this patch the card is removed if any of the dependent component
> > is removed and card is added back if the dependent component comes back.
> > All this is done using component framework and matching based on
> > component name.
> 
> Humm, no real comment on this patch proper but rather on how userspace would
> deal with this dynamic behavior?

As Takashi pointed out card disappearing and appearing should not be an
issue. On this machine, I typically run a BT headset which disappears
and keep appearing, haven't seen issue :)

> We had similar opens when we worked on the BYT/CHT HDMI stuff and ended-up
> with quite a few issues in userspace (PulseAudio mainly) related to dynamic
> behavior at the kernel level as a result of plug/unplug.

IIRC those had something to do with gfx callback, register, interrupt
racing on BYT HDMI. Ramesh/Jerome might have more details if they
remember now :)

> Also not sure how
> an Android HAL would deal with a card disappearing temporarily if DSP
> resources become unavailable or unresponsive. Any thoughts or guidance you
> might think of?

I have not see userspace HAL code but my guess is that it deals with
card not being there.

Btw this was handled/buried in the driver atm and asking realized that
this is better suited in core, so Srini pushed it up. Current QC stack
expects DSP to go off and card disappear as a result. Once DSP is back
it would appear again (DSP is handled thru remoteproc, I think you
should have a look at it and see if it would suit your DSP needs too)

-- 
~Vinod
