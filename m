From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v5 15/15] ASoC: sun4i-i2s: Adjust regmap settings
Date: Wed, 14 Aug 2019 13:31:04 +0200
Message-ID: <4005451.bVnTXbg3Co@jernej-laptop>
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-16-codekipper@gmail.com> <20190814072007.6tfvhzsw4oxbwpc2@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814072007.6tfvhzsw4oxbwpc2@flea>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-sunxi@googlegroups.com, maxime.ripard@bootlin.com
Cc: codekipper@gmail.com, wens@csie.org, linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, be17068@iperbole.bo.it
List-Id: alsa-devel@alsa-project.org

Dne sreda, 14. avgust 2019 ob 09:20:07 CEST je Maxime Ripard napisal(a):
> On Wed, Aug 14, 2019 at 08:08:54AM +0200, codekipper@gmail.com wrote:
> > From: Marcus Cooper <codekipper@gmail.com>
> > 
> > Bypass the regmap cache when flushing the i2s FIFOs and modify the tables
> > to reflect this.
> > 
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> 
> This patch looks like it's fixing something while the commit log
> doesn't mention what is being fixed.

Main issue addressed here is that SUN4I_I2S_FIFO_CTRL_REG has two self-clear 
registers (SUN4I_I2S_FIFO_CTRL_FLUSH_RX and SUN4I_I2S_FIFO_CTRL_FLUSH_TX) and 
thus it should be marked as volatile.

Best regards,
Jernej

> 
> Having some context here would be great.
> 
> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
