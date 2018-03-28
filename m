From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH][RFC] ASoC: wm8350: remove snd_soc_codec
Date: Wed, 28 Mar 2018 10:48:35 +0100
Message-ID: <20180328094835.hzthjeoq6vpdgjgm@localhost.localdomain>
References: <87tvt13psj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id E5F0C266E07
 for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2018 11:48:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87tvt13psj.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 28, 2018 at 02:22:07AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> codec is replace to component.
> It seems no-one is using it, Let's remove it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> Hi Mark, Liam
> 
> I think no-one is using snd_soc_codec, but please double-check it.
> I added [RFC] on this patch
> 

Looks to me like there are still users in
drivers/mfd/cwm8350-core.c:

wm8350_client_dev_register(wm8350, "wm8350-codec",
			   &(wm8350->codec.pdev));

And arch/arm/mach-imx/mach-mx31ads.c:

wm8350->codec.platform_data = &imx32ads_wm8350_setup;

Also it should be simple enough to build test drivers for patches
like this, you don't need to have the hardware to build the driver.

Thanks,
Charles
