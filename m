From: Johannes Stezenbach <js@sig21.net>
Subject: Re: [PATCH] ASoC: sta32x: Optimize the array work to
 find rate_min and rate_max
Date: Tue, 3 Jan 2012 11:42:50 +0100
Message-ID: <20120103104250.GA6037@sig21.net>
References: <1325414174.4978.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
	by alsa0.perex.cz (Postfix) with ESMTP id B501724780
	for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2012 11:42:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1325414174.4978.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@ti.com>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 01, 2012 at 06:36:14PM +0800, Axel Lin wrote:
> For a given ir and fs, there is at most one possible match for the case
> mclk_ratios[ir][j].ratio * fs == freq.
> Thus we can break from the inner loop once a match is found.

Yes, I think this is correct.

Acked-by: Johannes Stezenbach <js@sig21.net>


Thanks
Johannes


> --- a/sound/soc/codecs/sta32x.c
> +++ b/sound/soc/codecs/sta32x.c
> @@ -522,6 +522,7 @@ static int sta32x_set_dai_sysclk(struct snd_soc_dai *codec_dai,
>  						rate_min = fs;
>  					if (fs > rate_max)
>  						rate_max = fs;
> +					break;
>  				}
>  			}
>  		}
