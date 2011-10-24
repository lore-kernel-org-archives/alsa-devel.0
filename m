From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: wm8940: Fix setting PLL Output clock division
 ratio
Date: Mon, 24 Oct 2011 14:09:07 +0200
Message-ID: <20111024120907.GG6148@opensource.wolfsonmicro.com>
References: <1319427161.5773.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1319427161.5773.3.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 24, 2011 at 11:32:41AM +0800, Axel Lin wrote:
> According to the datasheet:
> The PLL Output clock division ratio is controlled by BIT[5:4] of
> WM8940_GPIO register(08h).
> Current code read/write the WM8940_ADDCNTRL(07h) register which is wrong.

Applied this and patch 2, thanks.
