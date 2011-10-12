From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/9] ASoC: da7210: Add support for ALC and
 Noise suppression
Date: Wed, 12 Oct 2011 16:04:04 +0100
Message-ID: <20111012150404.GT3647@opensource.wolfsonmicro.com>
References: <1318432070.12107.426.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F1C1A245A9
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 17:04:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318432070.12107.426.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg@ti.com, kuninori.morimoto.gx@renesas.com, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 12, 2011 at 08:37:50PM +0530, Ashish Chavan wrote:

> +	if (ucontrol->value.integer.value[0]) {
> +		/* Check if noise suppression is enabled */
> +		if (reg_cache[DA7210_CONTROL] & DA7210_NOISE_SUP_EN) {

No, don't go peering directly into the register cache.  This is going to
explode if the board configures a different cache style and means you
can't change the cache type later.  Just read the register and trust
that the cache will do something sane.

> +			dev_dbg(codec->dev, "Failed to enable ALC\n");
> +			return -EPERM;
> +		}

Either drop the debug print or make it say what the problem is.

similar problems in the rest of the patch.

> +	SOC_SINGLE("ALC Capture Max Gain", DA7210_ALC_MAX, 0, 0x3F, 0),
> +	SOC_SINGLE("ALC Capture Min Gain", DA7210_ALC_MIN, 0, 0x3F, 0),
> +	SOC_SINGLE("ALC Capture Noise Gain", DA7210_ALC_NOIS, 0, 0x3F, 0),

Volume.
