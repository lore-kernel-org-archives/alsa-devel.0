From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3 v4] sound/soc/lapis: add machine driver
 for ML7213 Carrier Board
Date: Tue, 20 Dec 2011 10:45:26 +0000
Message-ID: <20111220104525.GG2866@opensource.wolfsonmicro.com>
References: <1324349144-12784-1-git-send-email-tomoya.rohm@gmail.com>
	<1324349144-12784-2-git-send-email-tomoya.rohm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4EB5910390E
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 11:45:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1324349144-12784-2-git-send-email-tomoya.rohm@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 20, 2011 at 11:45:43AM +0900, Tomoya MORINAGA wrote:

> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +
> +	unsigned int clk = 0;
> +	int ret = 0;
> +	int bclkfs;
> +	int mclkfs;
> +	int rate = params_rate(hw_params);

The coding style here is really odd, looks like you're mixing
declarations and code.

> +	default:
> +		pr_err("%s: Failed not support format\n", __func__);
> +		return -1;
> +		break;

Return sensible error codes and there's no reason for the break after
the return.

> +	ret = snd_soc_dai_set_clkdiv(cpu_dai, ML7213IOH_BCLKFS0, bclkfs);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_dai_set_clkdiv(cpu_dai, ML7213IOH_BCLKFS1, bclkfs);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_dai_set_clkdiv(cpu_dai, ML7213IOH_BCLKFS2, bclkfs);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_dai_set_clkdiv(cpu_dai, ML7213IOH_BCLKFS3, bclkfs);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_dai_set_clkdiv(cpu_dai, ML7213IOH_BCLKFS4, bclkfs);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_dai_set_clkdiv(cpu_dai, ML7213IOH_BCLKFS5, bclkfs);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_dai_set_clkdiv(cpu_dai, ML7213IOH_MCLKFS0, mclkfs);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_dai_set_clkdiv(cpu_dai, ML7213IOH_MCLKFS1, mclkfs);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_dai_set_clkdiv(cpu_dai, ML7213IOH_MCLKFS2, mclkfs);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_dai_set_clkdiv(cpu_dai, ML7213IOH_MCLKFS3, mclkfs);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_dai_set_clkdiv(cpu_dai, ML7213IOH_MCLKFS4, mclkfs);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_dai_set_clkdiv(cpu_dai, ML7213IOH_MCLKFS5, mclkfs);
> +	if (ret < 0)
> +		return ret;

This looks like the CODEC driver ought to be working these things out
for itself rather than having every machine using the device know about
these dividers.

You're also still missing the drivers for the CPU...
