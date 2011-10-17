From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: wm8900: Fix wrong mask for setting
 DAC_CLKDIV/ADC_CLKDIV/LRCLK_MODE
Date: Mon, 17 Oct 2011 22:49:40 +0100
Message-ID: <20111017214939.GJ5200@opensource.wolfsonmicro.com>
References: <1318778876.3106.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1318778876.3106.3.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 16, 2011 at 11:27:55PM +0800, Axel Lin wrote:
> After checking the datasheet, I think what we want to do here is to
> clear the WM8900_REG_CLOCKING2_DAC_CLKDIV/WM8900_REG_CLOCKING2_ADC_CLKDIV/
> WM8900_REG_DACCTRL_AIF_LRCLKRATE bits and then OR with div value.

Applied all, thanks.
