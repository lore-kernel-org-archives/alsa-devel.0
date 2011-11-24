From: Johannes Stezenbach <js@sig21.net>
Subject: Re: [PATCH] ASoC: Staticise non-exported symbols in
	sta32x
Date: Thu, 24 Nov 2011 19:05:00 +0100
Message-ID: <20111124180500.GB26006@sig21.net>
References: <1322156006-32065-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
	by alsa0.perex.cz (Postfix) with ESMTP id 9ACD6103BEB
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 19:05:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322156006-32065-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 24, 2011 at 05:33:26PM +0000, Mark Brown wrote:
> -int sta32x_sync_coef_shadow(struct snd_soc_codec *codec)
> +static int sta32x_sync_coef_shadow(struct snd_soc_codec *codec)
...
> -int sta32x_cache_sync(struct snd_soc_codec *codec)
> +static int sta32x_cache_sync(struct snd_soc_codec *codec)

Oooh, thanks for spotting and fixing!

Acked-by: Johannes Stezenbach <js@sig21.net>


Johanens
