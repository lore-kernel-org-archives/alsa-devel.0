From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4720: use
 snd_soc_cache_sync()
Date: Tue, 22 Nov 2011 14:02:10 +0000
Message-ID: <20111122140210.GD6624@sirena.org.uk>
References: <1321969516-21174-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2812024482
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 15:02:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1321969516-21174-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, timur@freescale.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 22, 2011 at 02:45:16PM +0100, Daniel Mack wrote:
> Replace the manual register restore mechanism in cs4270.c and call
> snd_soc_cache_sync() instead. The current is also wrong, as it doesn't
> update the internal cache, leading to cache inconsitency after suspend.

I don't understand why this is a bug fix - the code is writing the
values from the internal cache to the hardware and what's there doesn't
look obviously wrong...

>  	/* first restore the entire register cache ... */
> -	for (reg = CS4270_FIRSTREG; reg <= CS4270_LASTREG; reg++) {
> -		u8 val = snd_soc_read(codec, reg);
> -

This reads from the cache.

> -		if (i2c_smbus_write_byte_data(i2c_client, reg, val)) {
> -			dev_err(codec->dev, "i2c write failed\n");
> -			return -EIO;
> -		}

This writes the cached value to the hardware.
