From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] new board driver to connect bfin-5xx
 with ad1836 codec
Date: Wed, 12 Aug 2009 17:10:20 +0100
Message-ID: <20090812161020.GE11898@rakim.wolfsonmicro.main>
References: <1250051574-25119-1-git-send-email-21cnbao@gmail.com>
	<1250051574-25119-2-git-send-email-21cnbao@gmail.com>
	<1250051574-25119-3-git-send-email-21cnbao@gmail.com>
	<1250051574-25119-4-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 595ED24573
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Aug 2009 18:10:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1250051574-25119-4-git-send-email-21cnbao@gmail.com>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 12, 2009 at 12:32:54PM +0800, Barry Song wrote:

This is OK but...

> +	/* set cpu DAI slots, 8 channels, mask is defined as slot seq */
> +	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 0x73625140, 8);
> +	if (ret < 0)
> +		return ret;

This suggests that there's something really odd going on with your
set_tdm_slot() for the CPU which is likely to make it incompatible with
other implementations and with any core support to handle things like
multi-drop DAIs.  The DAI driver side could certainly use more
documenation explaining what's going on if nothing else...
