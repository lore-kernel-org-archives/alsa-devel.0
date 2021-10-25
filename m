Return-Path: <SRS0=4dkw=PN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC72DC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 11:53:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5B661027
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 11:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE5B661027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4B9B16CC;
	Mon, 25 Oct 2021 13:52:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4B9B16CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635162814;
	bh=McE0Md5cUR7f/vf9dUhpKd5afPO2IYd5qnBCVe07hNU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iH2Y920ripWRjTrxEfwfIecmTncDNEsGMAUkmJ3fOMTaQO2gu8GKf1Qr2s5QQeqbn
	 udWzDufGB2+X+ZTQFpnDsm2jnL1tTLXzrg0fYduGFHSYiqJIy0Clx/o/EimHzizwAf
	 1sKLNlwAVC0LgkuIiV5jQJiVKhyzPbJFErSfjKZA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4692AF80166;
	Mon, 25 Oct 2021 13:52:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D9099F8025A; Mon, 25 Oct 2021 13:52:42 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B206F80153
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 13:52:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B206F80153
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IQRWPZ6A"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AD8560E8C;
 Mon, 25 Oct 2021 11:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635162749;
 bh=McE0Md5cUR7f/vf9dUhpKd5afPO2IYd5qnBCVe07hNU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IQRWPZ6AttG9SL5GixqViye1T+kuZIF2O8g7jf5MT6Q/DMHH6zcnSyiprAfjEFbv0
 HADYR9gx0/OSmiFJzbouiwVHnG7+R9eFhMXfV6to42Aj3/sj7Y7cOyEMg3vCD2yuBn
 xUNzgQkT+l3yPZSl8XwN+3WcMnh8p0V2chTEQG9UjxiqKCO1iOAauYt98mUZMSL4At
 MfBelVGiyH+xXnaHujYwkticpdTA4r6vAgAd86N0GPiES/o4EjxdRjkObKGxElGx7i
 CRqlpjlHlGjIB64VU+Uw9t7mkKHuAxz79SRWW0i1dH4izvL9elM2G/Pg6MQ7yfSoDO
 kv2NLOyDJFBlQ==
Date: Mon, 25 Oct 2021 12:52:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Yunhao Tian <t123yh.xyz@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: rockchip: add support for spdifrx receiver
Message-ID: <YXaae+SnnZea1C2C@sirena.org.uk>
References: <20211024094317.1641949-1-t123yh@outlook.com>
 <20211024094317.1641949-2-t123yh@outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/PnUjWzrw+ydMtsz"
Content-Disposition: inline
In-Reply-To: <20211024094317.1641949-2-t123yh@outlook.com>
X-Cookie: From concentrate.
Cc: linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
 Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--/PnUjWzrw+ydMtsz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 24, 2021 at 05:43:15PM +0800, Yunhao Tian wrote:

> --- /dev/null
> +++ b/sound/soc/rockchip/rockchip_spdifrx.c
> @@ -0,0 +1,660 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ALSA SoC Audio Layer - Rockchip SPDIF_RX Controller driver
> + *

Please make the entire comment a C++ one so things look more
intentional.

> +static int rk_spdifrx_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *params,
> +				struct snd_soc_dai *dai)
> +{
> +	return 0;
> +}

Just remove empty callbacks, if it's safe to omit a callback the
framework will let you.

> +	spin_lock_irqsave(&spdifrx->irq_lock, flags);
> +
> +	/* the access property of controls don't have to
> +	 * be volatile, as it will be notified by interrupt handler
> +	 */
> +	spdifrx->dai = dai;
> +	control = (struct snd_kcontrol_new){
> +		/* Sample Rate Control */
> +		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
> +		.name = SNDRV_CTL_NAME_IEC958("", CAPTURE, NONE) "Rate",
> +		/* access don't have to be volatile, as it will be notified by intr */
> +		.access = SNDRV_CTL_ELEM_ACCESS_READ,
> +		.info = rk_spdifrx_rate_info,
> +		.get = rk_spdifrx_rate_get,
> +	};
> +	spdifrx->snd_kctl_rate = snd_ctl_new1(&control, dai);

You really shouldn't be calling snd_ctl_new1() with interrupts disabled,
nor can I see a reason why you'd want to do this.  I'd be surprised if
it doesn't do any allocations or other operations that are not permitted
while in atomic context.

I also don't understand why the control is declared in this way rather
than just being a normal const static struct, there's no variable data
in any of these structs that I can see.

> +static irqreturn_t rk_spdifrx_isr(int irq, void *dev_id)
> +{

> +	spin_lock_irqsave(&spdifrx->irq_lock, flags);
> +	if (spdifrx->dai) {

You're in the interrupt handler here so this should just be a regular
spin_lock().

> +MODULE_DESCRIPTION("ROCKCHIP SPDIF Receiver Interface");
> +MODULE_AUTHOR("Sugar Zhang <sugar.zhang@rock-chips.com>");

Given that Sugar is active upstream it would be good to keep them in the
CCs.

--/PnUjWzrw+ydMtsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmF2mnoACgkQJNaLcl1U
h9DSOwf+JNBLgPpAa7LDwRvv92YCK3c14xEWqLn7bUZ8+ePk8gwaiiTZWLi5ICDI
zKKpMqZ9iQQ0lpo3JmnFoDBqWZe5MKGUL5iMlAImFAu+XTDmzcZoLFTJaxLX389M
wcrrDByWnL9PChNnJ1HkmL2q+1ozpRLQGejb98+GgPmSEBgXQPeWcPzC8zUu95sg
AckOGVzA7mOThPkv1ZXEMNT6Efca1Fi3qPPAR2ZMSTYSCBTly8qW77VwX98U2u/L
b278E6Ii2t+tlDG+WR25sZP3eblj58+oUehF91q9CQ7gRV1GqJYaQeF5dEheCU24
3kvqqgtE0QQdLNVHGvVjoLP8ibWkFg==
=ePx5
-----END PGP SIGNATURE-----

--/PnUjWzrw+ydMtsz--
