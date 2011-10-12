From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: Remove impossible case from wm8994_hw_params
Date: Wed, 12 Oct 2011 11:25:31 +0100
Message-ID: <20111012102530.GE3647@opensource.wolfsonmicro.com>
References: <1318374189.6115.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1318374189.6115.3.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 12, 2011 at 07:03:09AM +0800, Axel Lin wrote:
> We set hw_params callback for wm8994_aif3_dai_ops to wm8994_aif3_hw_params.
> Thus no need to check wm8994-aif3 in wm8994_hw_params.

Applied, thanks.
