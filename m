From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: add master clock handling for rt5640
Date: Tue, 23 Feb 2016 16:00:00 -0600
Message-ID: <20160223220000.GA31506@rob-hp-laptop>
References: <1456190782-18865-1-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456190782-18865-1-git-send-email-sugar.zhang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: broonie@kernel.org, heiko@sntech.de, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 23, 2016 at 09:26:22AM +0800, Sugar Zhang wrote:
> enable/disable master clock when codec is active or not.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
>  Documentation/devicetree/bindings/sound/rt5640.txt |  3 +++

Acked-by: Rob Herring <robh@kernel.org>

>  sound/soc/codecs/rt5640.c                          | 31 ++++++++++++++++++++++
>  sound/soc/codecs/rt5640.h                          |  2 ++
>  3 files changed, 36 insertions(+)
> 
