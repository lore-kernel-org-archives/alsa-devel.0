From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8985: Remove unused pointer in wm8985_remove()
Date: Mon, 16 Jun 2014 10:06:49 +0100
Message-ID: <20140616090649.GC12074@opensource.wolfsonmicro.com>
References: <1402679968-5925-1-git-send-email-cengelma@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1402679968-5925-1-git-send-email-cengelma@gmx.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Engelmayer <cengelma@gmx.at>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Lars-Peter Clausen <lars@metafoo.de>, Xiubo Li <Li.Xiubo@freescale.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 13, 2014 at 07:19:28PM +0200, Christian Engelmayer wrote:
> Commit a0b148b4 (ASoC: wm8985: Use devm_regulator_bulk_get()) removed the last
> user of pointer wm8985 to struct wm8985_priv. Thus remove it. Detected by
> Coverity CID 1222150.
> 
> Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
