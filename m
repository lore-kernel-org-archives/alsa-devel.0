Return-Path: <SRS0=puNT=PR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88B6C433FE
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 17:04:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC6B60E78
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 17:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EAC6B60E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D17F1690;
	Fri, 29 Oct 2021 19:03:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D17F1690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635527072;
	bh=+aEPyNOmqtbPjDTbpU+vjv4p0Wjy/OBh9cRtgzsckiQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QnaJSmSGNGaYKH9pRIHIIkjYFyuekSoVO5FAdfkGr9v1QIz6Z36UNZ3gZKTVsJAFs
	 oDqbhp7CKclqQpp5BzpJY5AKeSqRe1AT1tkIWXEn/QDcdvNxAG8vUGUxJBTXRe+ZCt
	 /o7Aol3+BXl6S+qxEX1dSMSkFyBwhtPx4R3FUMdA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C88F7F801EC;
	Fri, 29 Oct 2021 19:03:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9A0CF8025A; Fri, 29 Oct 2021 19:03:40 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30BCEF800F4
 for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2021 19:03:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30BCEF800F4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cvOMzC+W"
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA8AB60C4D;
 Fri, 29 Oct 2021 17:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635527010;
 bh=+aEPyNOmqtbPjDTbpU+vjv4p0Wjy/OBh9cRtgzsckiQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cvOMzC+WvvRbbBbN3bcKsocHcYUYD296bxbwkfDAqgipXFA8t0/0Rud1wqyxZRZlD
 YwXLkt3Jqv4dgpHfWxT6MWiTn9C4YuZalm5PFBiFuEjmOF7z0ILCXahlvjdCB9n3a+
 NJpZ+5K+IE4iQNqLLnwG4yobUavshW3i7I6KMF7WSA/Rb66sv7+W1w+PzVDvblUefO
 dvuF6+qwlHCQVWRzPv1Pg72a1LomqpUw2qTLNiYttY7fHG8dfTGDEN47zRtqYCEb/S
 SbAOZwgsnAHIjPfWhsj3Z+ISEoU2lEfk7/pG7yTVHQQ8cdNjC0Pd0aBpSpmOAuhF4t
 GHdfAsVEYeXgQ==
Date: Fri, 29 Oct 2021 18:03:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l42: Add control for audio slow-start switch
Message-ID: <YXwpXedltzt1ykfc@sirena.org.uk>
References: <20211029161305.12714-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hL5c6N7Mka1PL2FS"
Content-Disposition: inline
In-Reply-To: <20211029161305.12714-1-rf@opensource.cirrus.com>
X-Cookie: Dr. Jekyll had something to Hyde.
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
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


--hL5c6N7Mka1PL2FS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 29, 2021 at 05:13:05PM +0100, Richard Fitzgerald wrote:
> +static int cs42l42_slow_start_put(struct snd_kcontrol *kcontrol,
> +				  struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	u8 val;
> +
> +	/* all bits of SLOW_START_EN much change together */
> +	switch (ucontrol->value.integer.value[0]) {
> +	case 0:
> +		val = 0;
> +		break;
> +	case 1:
> +		val = CS42L42_SLOW_START_EN_MASK;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	snd_soc_component_update_bits(component, CS42L42_SLOW_START_ENABLE,
> +				      CS42L42_SLOW_START_EN_MASK, val);
> +
> +	return 0;

This should return 1 if the value changed.

--hL5c6N7Mka1PL2FS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmF8KVwACgkQJNaLcl1U
h9BpCwf/QA87MrTLPKUg4QokHNEUHtqN8OkGgKlM2g2Tk77vRbYrRuVkpcVx679G
cY/zSKPSgPpU7p+PDv/FNHmZSg4g5NKpql2/qsXEW2EmUR4CTBK4NOmB8mwKekmE
3in6/AaUFQeWFroY7KT2c/GeFB2MSaBpV+h7qMZcMxqOR7tbgX/tPgnzwJU+NK0i
ZUFii+COSLgIwSUzRUIeKSeCYBoexY81Ry60B0R16R2uZtPHh99zw0NfBsT+55Jn
T/nlnZsQBhr66FJm/pSMVuip+7dFrcoS/Bc4cfiWtWUvNodnJaYxNRufwlKD4UBm
ZG2IExXYAEIzJsQ7m3xanTIyIudmPQ==
=xpuZ
-----END PGP SIGNATURE-----

--hL5c6N7Mka1PL2FS--
