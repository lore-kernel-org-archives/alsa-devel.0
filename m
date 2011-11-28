From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ASoC: Convert WM8903 MICBIAS to a supply
	widget
Date: Mon, 28 Nov 2011 08:58:32 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174FDAF7D1@HQMAIL01.nvidia.com>
References: <1322396517-7122-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id C68F12440E
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 17:58:40 +0100 (CET)
In-Reply-To: <1322396517-7122-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote at Sunday, November 27, 2011 5:22 AM:
> Also rename it to MICBIAS to reflect the pin name and help any out of tree
> users notice the change.
...
> diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
...
> -SND_SOC_DAPM_MICBIAS("Mic Bias", WM8903_MIC_BIAS_CONTROL_0, 0, 0),
> +SND_SOC_DAPM_SUPPLY("MICBIAS", WM8903_MIC_BIAS_CONTROL_0, 0, 0, NULL, 0),

Acked-by: Stephen Warren <swarren@nvidia.com>

For my education, why is this better modeled as a supply instead of a
mic bias? Thanks.

-- 
nvpublic
