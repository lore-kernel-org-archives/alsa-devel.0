From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] board driver to connect bf5xx
	with	ad1938
Date: Sat, 18 Jul 2009 11:15:04 +0100
Message-ID: <20090718101503.GB19473@sirena.org.uk>
References: <1247731207-26743-1-git-send-email-21cnbao@gmail.com>
	<1247731207-26743-4-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E55452452A
	for <alsa-devel@alsa-project.org>;
	Sat, 18 Jul 2009 12:15:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1247731207-26743-4-git-send-email-21cnbao@gmail.com>
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

On Thu, Jul 16, 2009 at 04:00:07PM +0800, Barry Song wrote:

> +	/* set codec DAI slots */
> +	ret = snd_soc_dai_set_tdm_slot(codec_dai, 0, 8);
> +	if (ret < 0)
> +		return ret;

That mask looks wrong - it's saying not to use any slots at all.

Otherwise this looks good.
