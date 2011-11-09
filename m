From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sta32x: add workaround for ESD reset
	issue
Date: Wed, 9 Nov 2011 14:36:47 +0000
Message-ID: <20111109143647.GB587@opensource.wolfsonmicro.com>
References: <20111109133001.GA7394@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3F2FD103857
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 15:36:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111109133001.GA7394@sig21.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Johannes Stezenbach <js@sig21.net>
Cc: alsa-devel@alsa-project.org, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@ti.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 09, 2011 at 02:30:01PM +0100, Johannes Stezenbach wrote:
> sta32x resets and loses all configuration during ESD test.
> Work around by preserving coefficient RAM in a shadow,
> poll once a second on the CONFA register and restore
> all coeffcients and registers when CONFA changes unexpectedly.

So, clearly a constant poll isn't going to do power consumption or
anything any favours so we shouldn't be doing this by default.  The most
obvious idea is to only check while audio is active (since it doesn't
really matter if the device is reset while not playing audio anyway)
which would get rid of most of the problem.

Given that the driver already supports powering the device down it may
also be sufficient to simply enable idle_bias_off and assume that if the
device resets the application will get sufficiently upset to restart
things anyway.

If we do need to poll or anything else invasive I'd also expect this to
be optional as if the device has ESD weaknesses then it'd be likely that
boards would add external ESD protection which 

>  	snd_soc_write(codec, STA32X_CFADDR2, index);
> +	for (i = 0; i < numcoef && (index + (i + 1) * 3 < STA32X_COEF_COUNT); i++)
> +		sta32x->coef_shadow[index + i] =
> +			  (ucontrol->value.bytes.data[3 * i    ] << 16)
> +			| (ucontrol->value.bytes.data[3 * i + 1] << 8)
> +			| (ucontrol->value.bytes.data[3 * i + 2]);

Does this need to be done when restoring to _STANDBY as well?

> +	/* check if sta32x has reset itself */
> +	snd_soc_cache_read(codec, STA32X_CONFA, &confa);
> +	if (confa == codec->hw_read(codec, STA32X_CONFA))
> +		goto ok;

Don't call hw_read() directly, use cache_bypass if you need to.

> +	/* mute during restore */
> +	snd_soc_cache_read(codec, STA32X_MMUTE, &mute);
> +	snd_soc_write(codec, STA32X_MMUTE, mute | STA32X_MMUTE_MMUTE);

Just use snd_soc_read() and let the cache do the right thing.

> +	for (i = 0; i < STA32X_REGISTER_COUNT; i++) {
> +		if (snd_soc_codec_volatile_register(codec, i))
> +			continue;
> +		snd_soc_cache_read(codec, i, &value);
> +		snd_soc_write(codec, i, value);
> +	}

Use cache_sync().
