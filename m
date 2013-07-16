From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: imx-sgtl5000: fix error return code in
 imx_sgtl5000_probe()
Date: Tue, 16 Jul 2013 20:27:57 +0800
Message-ID: <20130716122755.GL28375@S2101-09.ap.freescale.net>
References: <CAPgLHd-cXmWwMq8DMhXbOhykZvnMzxb4HHZ-5ayNnkPU1fqfQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd-cXmWwMq8DMhXbOhykZvnMzxb4HHZ-5ayNnkPU1fqfQQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, rob.herring@calxeda.com, fabio.estevam@freescale.com, wfp5p@virginia.edu, LW@KARO-electronics.de, yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 16, 2013 at 08:05:07PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
