From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-core: Simplify compress_type
 overriding functionality
Date: Tue, 11 Jan 2011 11:35:41 +0000
Message-ID: <20110111113541.GD13429@opensource.wolfsonmicro.com>
References: <1294745773-5123-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 045DF103A05
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 12:37:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294745773-5123-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 11, 2011 at 11:36:13AM +0000, Dimitris Papastamos wrote:

>  		if (i == card->num_configs) {
>  			/* no need to override the compress_type so
>  			 * go ahead and do the standard thing */
> -			ret = snd_soc_init_codec_cache(codec, 0);
> -			if (ret < 0) {
> -				mutex_unlock(&card->mutex);
> -				return;
> -			}
> -			continue;
> +			compress_type = 0;
>  		}

Even simpler would be to init compress_type to zero and remove the
check.
