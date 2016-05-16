From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3] ASoC: MAX9860: new driver
Date: Mon, 16 May 2016 11:22:54 -0500
Message-ID: <20160516162254.GA15499@rob-hp-laptop>
References: <1463124333-9489-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463124333-9489-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Misbah Ullah Khan <Misbahk@danlawinc.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 13, 2016 at 09:25:33AM +0200, Peter Rosin wrote:
> This is a driver for the MAX9860 Mono Audio Voice Codec.
> 
> https://datasheets.maximintegrated.com/en/ds/MAX9860.pdf
> 
> This driver does not support sidetone since the DVST register field is
> backwards with the mute near the maximum level instead of the minimum.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../devicetree/bindings/sound/max9860.txt          |  28 +

Acked-by: Rob Herring <robh@kernel.org>

>  MAINTAINERS                                        |   7 +
>  sound/soc/codecs/Kconfig                           |   6 +
>  sound/soc/codecs/Makefile                          |   2 +
>  sound/soc/codecs/max9860.c                         | 761 +++++++++++++++++++++
>  sound/soc/codecs/max9860.h                         | 162 +++++
>  6 files changed, 966 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/max9860.txt
>  create mode 100644 sound/soc/codecs/max9860.c
>  create mode 100644 sound/soc/codecs/max9860.h
