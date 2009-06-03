From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] ASoC: Blackfin: tweak how
	we	initialize the SPORT
Date: Wed, 3 Jun 2009 11:29:18 +0100
Message-ID: <20090603102918.GA32595@rakim.wolfsonmicro.main>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<1243916337-29953-3-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 76A2A243B9
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 12:29:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1243916337-29953-3-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 02, 2009 at 12:18:55AM -0400, Mike Frysinger wrote:

> @@ -199,7 +190,7 @@ static void bf5xx_i2s_shutdown(struct snd_pcm_substream *substream,
>  			       struct snd_soc_dai *dai)
>  {
>  	pr_debug("%s enter\n", __func__);
> -	bf5xx_i2s.counter--;
> +	bf5xx_i2s.configured = 0;
>  }

Are you sure this works properly with simultaneous record and playback?
If one stops while the other is running then the configured flag will be
cleared, meaning that the stopped stream can be restarted and used to
reconfigure the DAI which appears to be what the code is trying to
prevent.

This should be using constraints to stop applications trying to
reconfigure active streams - for the sample rate you just need to set
symmetric_rates in the DAI.
