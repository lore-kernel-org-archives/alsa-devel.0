From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/9] ASoC: da7210: Add support for line
 input and mic
Date: Wed, 12 Oct 2011 15:53:10 +0100
Message-ID: <20111012145310.GO3647@opensource.wolfsonmicro.com>
References: <1318431492.12107.403.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 77C73103815
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 16:53:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318431492.12107.403.camel@matrix>
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

On Wed, Oct 12, 2011 at 08:28:12PM +0530, Ashish Chavan wrote:

> +static const char *da7210_mic_bias_voltage_txt[] = {
> +	"1.5", "1.6", "2.2", "2.3"
> +};
> +
> +static const struct soc_enum da7210_mic_bias =
> +	SOC_ENUM_SINGLE(DA7210_MIC_L, 4, 4, da7210_mic_bias_voltage_txt);
> +

This shouldn't be application controllable, it's a board property and if
it needs to be managed it's likely to be by in kernel things like
accessory detection.  We do have some older drivers that do this but
they're not good.  Use platform data.
