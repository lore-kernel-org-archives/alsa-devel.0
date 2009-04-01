From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH v2 2/2] alsa: s6105 IP camera machine
	specific ASoC code
Date: Wed, 1 Apr 2009 14:29:05 +0100
Message-ID: <20090401132904.GB21294@sirena.org.uk>
References: <1238266022-27893-1-git-send-email-dg@emlix.com>
	<1238266022-27893-2-git-send-email-dg@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FAE6243B6
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Apr 2009 15:29:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1238266022-27893-2-git-send-email-dg@emlix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Gl??ckner <dg@emlix.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 28, 2009 at 07:47:02PM +0100, Daniel Gl??ckner wrote:

> +	/* set codec DAI configuration */
> +	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
> +					     SND_SOC_DAIFMT_CBM_CFM);
> +	if (ret < 0)
> +		return ret;

> +	/* set cpu DAI configuration */
> +	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_CBM_CFM |
> +					   SND_SOC_DAIFMT_IB_IF);
> +	if (ret < 0)
> +		return ret;

Why do these two differ?  It's very unusual to see different formats and
generally indicates a bug in one of the drivers involved that's being
worked around.  The omission of I2S is understandable since the CPU only
does I2S (though ideally it'd be specified) but the inversion of the bit
and frame clocks for the CPU only looks like the CPU is generating
inverted clocks by default.
