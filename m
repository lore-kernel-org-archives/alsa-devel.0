From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Add pm runtime function
Date: Thu, 18 Apr 2019 02:00:12 -0700
Message-ID: <20190418090011.GA4028@Asurada>
References: <1555558152-32196-1-git-send-email-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555558152-32196-1-git-send-email-shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 18, 2019 at 03:29:09AM +0000, S.j. Wang wrote:
> In imx8 when systerm enter suspend state, the power of subsystem will
> be off, the clock enable state will be lost and register configuration

Just for curiosity, we had similar situation on imx6sx, so we
added suspend/resume with regcache. Why will the clock enable
state be lost too? Does CCM on imx8 (might not be called CCM
though) have any difference? What about clock rate settings?

> will be lost. So the driver need to enter runtime suspend state in
> suspend.

> With this implementation the suspend function almost same as runtime
> suspend function, so remove the suspend function, just use
> pm_runtime_force_suspend instead, and same for the resume function.
> 
> And also need to move clock enablement to runtime resume and clock
> disablement to runtime suspend.


> -static int fsl_esai_suspend(struct device *dev)
> -	regcache_cache_only(esai->regmap, true);
> -	regcache_mark_dirty(esai->regmap);

> +static int fsl_esai_runtime_resume(struct device *dev)
>  	regcache_cache_only(esai->regmap, false);
> +	regcache_mark_dirty(esai->regmap);

Why move the regcache_mark_dirty from suspend to resume?
(I am not saying it's wrong but wondering if this is the
 preferable way.)
