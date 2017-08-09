From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: Re: [PATCH v3 3/5] ASoC: codecs: msm8916-wcd-analog: add MBHC support
Date: Wed, 9 Aug 2017 17:10:54 -0400
Message-ID: <20170809211054.4owecfeoxxud5evh@workotop.localdomain>
References: <20170809164927.19663-1-srinivas.kandagatla@linaro.org>
 <20170809164927.19663-4-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170809164927.19663-4-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Srinivas,

On Wed, Aug 09, 2017 at 06:49:25PM +0200, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> MBHC (MultiButton Headset Control) support is available in pm8921 in two
> blocks, one to detect mechanical headset insertion and removal and other
> block to support headset type detection and 5 button detection and othe
> features like impedance calculation.
> 
> This patch adds support to:
> 1> Support to NC and NO type of headset Jacks.
> 2> Mechanical insertion and detection of headset jack.
> 3> Detect a 3 pole Headphone and a 4 pole Headset.
> 4> Detect 5 buttons.
> 
> Tested it on DB410c with Audio Mezz board with 4 pole and 3 pole
> headset/headphones.

I have the same issue with this patchset, KEY_MEDIA is being reported
when unplugging a headset. I added a few traces and what I observe is
that the "button pressed" irq is fired when unplugging, but no "button
released" irq follows. To get a "button released" irq, I need to either
plug a headset, or plug-and-unplug headphones.

So basically, detection fails because we don't get the "button pressed"
irq prior to the mechanical switch irq. Do you know what could explain
the MBHC not firing the "button released" irq when unplugging headset?


Thanks,
-- 
Damien
