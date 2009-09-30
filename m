From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] sound: Don't assume i2c device probing
	always succeeds
Date: Wed, 30 Sep 2009 18:55:05 +0200
Message-ID: <20090930185505.1261e183@hyperion.delvare>
References: <20090930152542.3ef753ee@hyperion.delvare>
	<s5hbpksy0yq.wl%tiwai@suse.de>
	<20090930170006.76e145ca@hyperion.delvare>
	<s5h4oqkxy3e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from poutre.nerim.net (poutre.nerim.net [62.4.16.124])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BDE110380A
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 18:55:08 +0200 (CEST)
In-Reply-To: <s5h4oqkxy3e.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>, Tim Shepard <shep@alum.mit.edu>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 30 Sep 2009 17:15:49 +0200, Takashi Iwai wrote:
> Yes, indeed I prefer NULL check because the user can know the error
> at the right place.  I share your concern about the code addition,
> though :)
> 
> I already made a patch below, but it's totally untested.
> It'd be helpful if someone can do review and build-test it.
> 
> 
> thanks,
> 
> Takashi
> 
> ---
> diff --git a/sound/aoa/codecs/tas.c b/sound/aoa/codecs/tas.c
> index f0ebc97..0f810c8 100644
> --- a/sound/aoa/codecs/tas.c
> +++ b/sound/aoa/codecs/tas.c
> @@ -897,6 +897,10 @@ static int tas_create(struct i2c_adapter *adapter,
>  	client = i2c_new_device(adapter, &info);
>  	if (!client)
>  		return -ENODEV;
> +	if (!client->driver) {
> +		i2c_unregister_device(client);
> +		return -ENODEV;
> +	}
>  
>  	/*
>  	 * Let i2c-core delete that device on driver removal.
> diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
> index 835fa19..473c5a6 100644
> --- a/sound/ppc/keywest.c
> +++ b/sound/ppc/keywest.c
> @@ -59,6 +59,13 @@ static int keywest_attach_adapter(struct i2c_adapter *adapter)
>  	strlcpy(info.type, "keywest", I2C_NAME_SIZE);
>  	info.addr = keywest_ctx->addr;
>  	keywest_ctx->client = i2c_new_device(adapter, &info);
> +	if (!keywest_ctx->client)
> +		return -ENODEV;
> +	if (!keywest_ctx->client->driver) {
> +		i2c_unregister_device(keywest_ctx->client);
> +		keywest_ctx->client = NULL;
> +		return -ENODEV;
> +	}
>  	
>  	/*
>  	 * Let i2c-core delete that device on driver removal.

This looks good to me. Please add the following comment before the
client->driver check in both drivers:

	/*
	 * We know the driver is already loaded, so the device should be
	 * already bound. If not it means binding failed, and then there
	 * is no point in keeping the device instantiated.
	 */

Otherwise it's a little difficult to understand why the check is there.

-- 
Jean Delvare
