From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH 3/3] ASoC: wm8940: Do not left shift the div
 parameter in wm8940_set_dai_clkdiv
Date: Mon, 24 Oct 2011 12:10:21 +0200
Message-ID: <20111024101021.GC6148@opensource.wolfsonmicro.com>
References: <1319427161.5773.3.camel@phoenix>
 <1319427312.5773.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1319427312.5773.6.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 24, 2011 at 11:35:12AM +0800, Axel Lin wrote:
> Just check with other codec drivers, we do left shit div for
> the corresponding bits from the caller in all other drivers.
> I don't find the caller calling wm8940_set_dai_clkdiv now,
> just make the behavior consistent with other drivers.

The semantics for the clkdivs are entirely defined by the individual
drivers - there's no actual standard here and I guess this may break
some out of tree machines that people have.  If we're going to a cleanup
here it'd be better to improve the driver to figure out the divider
configurations automatically as far as possible.
