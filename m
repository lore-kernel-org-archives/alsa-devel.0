From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v5 5/7] clk: at91: clk-generated: make gclk determine
 audio_pll rate
Date: Fri, 1 Sep 2017 15:55:20 -0700
Message-ID: <20170901225520.GG21656@codeaurora.org>
References: <cover.ada7bc60e0b3a0f7429afc6ea9e4869131d1b757.1502346448.git-series.quentin.schulz@free-electrons.com>
 <600ed1e3623477c8083c6c4fa16299e33f7b76a9.1502346448.git-series.quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <600ed1e3623477c8083c6c4fa16299e33f7b76a9.1502346448.git-series.quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux@armlinux.org.uk, boris.brezillon@free-electrons.com, perex@perex.cz, tiwai@suse.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, cyrille.pitchen@wedev4u.fr, thomas.petazzoni@free-electrons.com
List-Id: alsa-devel@alsa-project.org

On 08/10, Quentin Schulz wrote:
> This allows gclk to determine audio_pll rate and set the parent rate
> accordingly.
> 
> However, there are multiple children clocks that could technically
> change the rate of audio_pll (via gck). With the rate locking, the first
> consumer to enable the clock will be the one definitely setting the rate
> of the clock.
> 
> Since audio IPs are most likely to request the same rate, we enforce
> that the only clks able to modify gck rate are those of audio IPs.
> 
> To remain consistent, we deny other clocks to be children of audio_pll.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
