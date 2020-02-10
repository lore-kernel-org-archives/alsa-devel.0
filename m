Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC41CC352A3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:32:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4561A20714
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NXLbWwPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4561A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B1A315F2;
	Mon, 10 Feb 2020 14:31:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B1A315F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581341562;
	bh=AtNX7j12Da8v3uVthx+Nr+iXL2LEMgINtMVbuy+FqPE=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NXLbWwPoJmvkq58SsfzUbFKmMaZD1LX+3+Lg4C7YE+uss/jnBFGMln4OtEkTBQScL
	 Yh3jPit2Sv3hvLKXHpVyiMzW/1lfLu2tXZyfzzbEf4XewPe2+C3afgu3eyi8HdVJTA
	 99rkNHFll27TPKBiH4WAhAJpb/4GzNILw5nbY/Uc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28557F80157;
	Mon, 10 Feb 2020 14:31:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF9B8F80158; Mon, 10 Feb 2020 14:31:49 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 9F90EF80118
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 14:31:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F90EF80118
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1FB71FB;
 Mon, 10 Feb 2020 05:31:45 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 467A93F68E;
 Mon, 10 Feb 2020 05:31:45 -0800 (PST)
Date: Mon, 10 Feb 2020 13:31:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Adam Serbinski <adam@serbinski.com>
Message-ID: <20200210133143.GG7685@sirena.org.uk>
References: <20200207205013.12274-1-adam@serbinski.com>
 <20200209154748.3015-1-adam@serbinski.com>
 <20200209154748.3015-3-adam@serbinski.com>
MIME-Version: 1.0
In-Reply-To: <20200209154748.3015-3-adam@serbinski.com>
X-Cookie: Avoid gunfire in the bathroom tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v2 2/8] ASoC: qdsp6: q6afe: add support to
	pcm ports
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
Content-Type: multipart/mixed; boundary="===============4540241206460804238=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============4540241206460804238==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JkW1gnuWHDypiMFO"
Content-Disposition: inline


--JkW1gnuWHDypiMFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2020 at 10:47:42AM -0500, Adam Serbinski wrote:

> =20
> +#define AFE_API_VERSION_PCM_CONFIG	0x1
> +/* Enumeration for the auxiliary PCM synchronization signal
> + * provided by an external source.
> + */
> +
> +#define AFE_PORT_PCM_SYNC_SRC_EXTERNAL 0x0
> +/*	Enumeration for the auxiliary PCM synchronization signal
> + * provided by an internal source.
> + */

This is a *weird* commenting style for these #defines and it's not
consistent within the block, I'm seeing at least 3 different styles.

> +/*  Payload of the #AFE_PARAM_ID_PCM_CONFIG command's
> + * (PCM configuration parameter).
> + */
> +
> +struct afe_param_id_pcm_cfg {

Similar weird commenting here, please follow coding-style.rst.

> +	switch (cfg->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		pcfg->pcm_cfg.sync_src =3D AFE_PORT_PCM_SYNC_SRC_INTERNAL;
> +		break;
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		/* CPU is slave */
> +		pcfg->pcm_cfg.sync_src =3D AFE_PORT_PCM_SYNC_SRC_EXTERNAL;
> +		break;
> +	default:
> +		break;
> +	}

Why is this not returning an error on unsupported values?

> +
> +	switch (cfg->sample_rate) {
> +	case 8000:
> +		pcfg->pcm_cfg.frame_setting =3D AFE_PORT_PCM_BITS_PER_FRAME_128;
> +		break;
> +	case 16000:
> +		pcfg->pcm_cfg.frame_setting =3D AFE_PORT_PCM_BITS_PER_FRAME_64;
> +		break;
> +	}

Same here.

--JkW1gnuWHDypiMFO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5BWz8ACgkQJNaLcl1U
h9COgAf/dQvwNK7v2nSAj2+698541KzAw+rU1oHMPrfL47b7+8WMLtY8dn2B7TiM
1dBCzYpTotvmbnXSoGQMztG89ws70Csele03jew7S8MfRuwnrbAEbp3mR8KW+ylI
GkjNxUGHH97SWdkJ92q3bH4wkRJVAtS6nAudxv7So3vi1WNmGGLgwCODlKzLII1j
7mmUkvhMwjqGBxqOrIifT7yTlnqCZyIHKqUQk7xIPO+on5jZ0QVvB9HZ5xISM1HV
/3it4Gmoc3P5bGf+N9Y0UF3Bc11Wgaq7+XXSMccyUv7Ze5h3ZtTGUidbeWsYNfGf
vBl163xXITHNtKVJSYgNX1CAKUV9OQ==
=kiNx
-----END PGP SIGNATURE-----

--JkW1gnuWHDypiMFO--

--===============4540241206460804238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4540241206460804238==--
