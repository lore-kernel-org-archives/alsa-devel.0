From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 4/5] ARM: DaVinci: ASoC: Add dummy
	codec	support
Date: Thu, 2 Apr 2009 16:30:20 +0100
Message-ID: <20090402153020.GK4527@sirena.org.uk>
References: <1238723407-27479-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DED010386A
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 17:30:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1238723407-27479-1-git-send-email-naresh@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Naresh Medisetty <naresh@ti.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 02, 2009 at 09:50:07PM -0400, Naresh Medisetty wrote:
> McASP on DM646x can operate in DIT (S/PDIF) where no codec is needed.
> This patch provides stub codec that can be used in these configurations.
> On DM646x EVM the McASP1 is connected to the S/PDIF out.

This looks pretty good apart from the small issues below but it occurs
to me that this would probably work for any S/PDIF transciever - perhaps
the driver should be renamed to something more generic like
spdif_transciever?

> +static struct platform_driver davinci_dit_driver = {
> +	.probe		= davinci_dit_probe,
> +	.remove		= davici_dit_remove,

Spelling mistake?

> +#ifdef CONFIG_SND_SOC_CODEC_STUBS
> +extern struct snd_soc_dai dit_stub_dai[];
> +extern struct snd_soc_dai dir_stub_dai[];
> +#else
> +#define dit_stub_dai	NULL
> +#define dir_stub_dai	NULL
> +#endif

No need to do the ifdefs here.
