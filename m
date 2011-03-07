From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/7] ASoC: neo1973_wm8753: Move lm4857
 specefic code to its own module
Date: Mon, 7 Mar 2011 12:24:08 +0000
Message-ID: <20110307122407.GH13471@opensource.wolfsonmicro.com>
References: <1299481500-5481-1-git-send-email-lars@metafoo.de>
	<1299481500-5481-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 325AB10386B
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 13:24:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1299481500-5481-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 07, 2011 at 08:04:55AM +0100, Lars-Peter Clausen wrote:

> index 82a4630..37035e6 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -347,6 +347,9 @@ config SND_SOC_WM9713
>  	tristate
>  
>  # Amp
> +config SND_SOC_LM4857
> +	tristate
> +
>  config SND_SOC_MAX9877
>  	tristate

This should also add LM4857 to SND_SOC_ALL_CODECS.  I'll fix that
incrementally.
