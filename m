From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ad193x: add set_pll entry to support
 different clock input
Date: Fri, 23 Apr 2010 16:06:59 +0100
Message-ID: <20100423150659.GC27232@rakim.wolfsonmicro.main>
References: <1271842609-18276-1-git-send-email-21cnbao@gmail.com>
	<1271842609-18276-2-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B75162463C
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Apr 2010 17:07:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1271842609-18276-2-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 21, 2010 at 05:36:47PM +0800, Barry Song wrote:
> Signed-off-by: Barry Song <21cnbao@gmail.com>

> +static int ad193x_set_dai_pll(struct snd_soc_dai *codec_dai,
> +		int pll_id, int source, unsigned int freq_in, unsigned int freq_out)
> +{
> +	struct snd_soc_codec *codec = codec_dai->codec;
> +	int reg;
> +
> +	reg = snd_soc_read(codec, AD193X_PLL_CLK_CTRL0);
> +
> +	switch (freq_in) {
> +	case 12288000:
> +		reg = (reg & AD193X_PLL_INPUT_MASK) | AD193X_PLL_INPUT_256;
> +		break;

This all looks like you should just implement set_sysclk() not set_pll()
- from the user point of view the fact that a PLL ends up getting tuned
is immaterial here, they can't control the output frequency at all.
>From their point of view they just specify the clock going into the
CODEC and the driver works out everything else for them.
