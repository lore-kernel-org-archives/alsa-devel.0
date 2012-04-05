From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: set idle_bias_off=1 for all platform
 DAPM contexts
Date: Thu, 05 Apr 2012 12:34:22 -0600
Message-ID: <4F7DE5AE.3060805@wwwdotorg.org>
References: <1333650481-19469-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 832F424825
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Apr 2012 20:34:29 +0200 (CEST)
In-Reply-To: <1333650481-19469-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/05/2012 12:28 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The ASoC core currently defaults to using STANDBY rather than OFF for
> idle ASoC platform devices, which causes a permanent pm_runtime_get() on
> them. This keeps the device active unnecessarily. This can be especially
> problematic when the ASoC platform device and DAI device are the same
> device.
> 
> The distinction between OFF and STANDBY is likely not relevant for ASoC
> platform drivers, since they aren't analog devices. So, solve this issue
> by hard-coding idle_bias_off = 1 for all ASoC platform devices. If this
> turns out to be a problem, this value could be sourced from the
> snd_soc_platform_driver, similarly to soc_probe_codec().

Sorry, I forgot to mention that future Tegra ASoC changes will depend on
this change at runtime for correct operation.
