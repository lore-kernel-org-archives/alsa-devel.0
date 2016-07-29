From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5659: Add mclk controls
Date: Fri, 29 Jul 2016 16:32:42 -0500
Message-ID: <20160729213242.GA14201@rob-hp-laptop>
References: <1469743036-20034-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469743036-20034-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, mark.rutland@arm.com, bardliao@realtek.com, oder_chiou@realtek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 28, 2016 at 02:57:16PM -0700, Nicolin Chen wrote:
> The codec driver should control the mclk. So this patch adds this support.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
> Changlog:
> v1->v2
>  * Only set the mclk pointer to NULL when getting an ENOENT error code
>    (i.e. no clock is specified)  -- corrected by Lars-Peter
> 
>  Documentation/devicetree/bindings/sound/rt5659.txt |  3 +++

Acked-by: Rob Herring <robh@kernel.org>

>  sound/soc/codecs/rt5659.c                          | 24 ++++++++++++++++++++++
>  sound/soc/codecs/rt5659.h                          |  1 +
>  3 files changed, 28 insertions(+)
