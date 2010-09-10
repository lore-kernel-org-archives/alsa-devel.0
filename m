From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASoC: tlv320aic3x: Use regulator
 notifiers for optimizing the cache sync
Date: Fri, 10 Sep 2010 12:58:08 +0100
Message-ID: <20100910115808.GK7259@rakim.wolfsonmicro.main>
References: <1284117812-8618-1-git-send-email-jhnikula@gmail.com>
	<1284117812-8618-3-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7F2671039BC
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 13:58:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1284117812-8618-3-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 10, 2010 at 02:23:31PM +0300, Jarkko Nikula wrote:

> Mark, struct aic3x_disable_nb was created for getting pointer to aic3x easily.
> Probably same idea could be applied to wm8962 as well?

Probably.  TBH I'd rather fix this in the notifier API - either way it's
pretty nasty.

> @@ -153,7 +161,7 @@ static int aic3x_write(struct snd_soc_codec *codec, unsigned int reg,
>  	data[1] = value & 0xff;
>  
>  	aic3x_write_reg_cache(codec, data[0], data[1]);
> -	if (!aic3x->power ||
> +	if (codec->cache_sync ||
>  	    codec->hw_write(codec->control_data, data, 2) == 2)
>  		return 0;
>  	else

This isn't the expected use of cache_sync, the idea is that it is a flag
indicating that a cache sync is required - this will happen when writes
are held while the regulators are disabled but the regualators haven't
actually been powered down.  This can be nice since we end up not
needing to do I2C I/O during bulk configuration at startup, I'm hoping
that we may be able to exploit this even more in the future.
