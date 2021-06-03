Return-Path: <SRS0=JknX=K5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FA8C47082
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 12:46:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA934613AA
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 12:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA934613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5DF701700;
	Thu,  3 Jun 2021 14:45:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5DF701700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622724366;
	bh=/0PErPiivKve18T5PWrNZSDblM4Yr8THdIMojDFkKIY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oYCxDP1dzlnIarDTTcNReFNfMuW3GRPza0XzWt+7+k+vrWCPhRK8aFMPgh3BenJEC
	 RJRYxdNYCuR0iWciouUjTxBVnhUuxcNkrvgs30hqqd9G7ZSFEKM1HLPxTLkFYFUQTd
	 UZOs6qipkGqRrDpAuVly1/zQMPpAR/WS2YirGWhg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BBFF0F80253;
	Thu,  3 Jun 2021 14:45:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6CDECF80254; Thu,  3 Jun 2021 14:45:13 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03B63F80100
 for <alsa-devel@alsa-project.org>; Thu,  3 Jun 2021 14:45:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03B63F80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SfNLIlaH"
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA11B61359;
 Thu,  3 Jun 2021 12:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622724307;
 bh=/0PErPiivKve18T5PWrNZSDblM4Yr8THdIMojDFkKIY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SfNLIlaHMkXy6z2Nwq1e62IgDvqFsiO17qMHNj+BAuK2eBbID038FOpOVRQg+VmnD
 gmLsesbPwihI4Y/q1165NFrTqwMWmXUeK56e/fiyQXTNL7RiuoG0YJjJiFyNgKqjnt
 ZsZYJZGbapXCve5ek6JvhtPxuHy4kZqQA6z5NAK9ou5R+n6M+aqxW17tR4VD2Azc9m
 4MRRnNhNo/pEngG66YpM4ar12j3QrXpHPNzabijjh2g66ra2vas1ZIFTxdQR41m1a6
 7RFq/PLwuk6oL+9eLZXZpBnbllg0qzBx+7yLE11RrgkubbjjFVf30Lp2cGf+ZQmUXs
 fT278QpB+0Rog==
Date: Thu, 3 Jun 2021 13:44:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 2/4] ASoC: codecs: wcd: add multi button Headset
 detection support
Message-ID: <20210603124455.GE4257@sirena.org.uk>
References: <20210524110700.27077-1-srinivas.kandagatla@linaro.org>
 <20210524110700.27077-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Content-Disposition: inline
In-Reply-To: <20210524110700.27077-3-srinivas.kandagatla@linaro.org>
X-Cookie: Where am I?  Who am I?  Am I?  I
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com
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


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 24, 2021 at 12:06:58PM +0100, Srinivas Kandagatla wrote:

> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL(wcd_mbhc_event_notify);

Why is this not EXPORT_SYMBOL_GPL?  Same for the other symbols that are
exported, between ASoC and regmap I'm not clear that there's anything
useful that is usable from non-GPL code...

> +	/* Report insertion */
> +	if (jack_type == SND_JACK_HEADPHONE)
> +		mbhc->current_plug = MBHC_PLUG_TYPE_HEADPHONE;
> +	else if (jack_type == SND_JACK_HEADSET) {
> +		mbhc->current_plug = MBHC_PLUG_TYPE_HEADSET;
> +		mbhc->jiffies_atreport = jiffies;
> +	} else if (jack_type == SND_JACK_LINEOUT)
> +		mbhc->current_plug = MBHC_PLUG_TYPE_HIGH_HPH;

This would be more idiomatically written as a switch statement.

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC4zsYACgkQJNaLcl1U
h9AHcAf+MAkcShDyOY9iT0Adnp0ijXBX3S6aae7O09/0QaNOvBIWj8b14Iokai81
8r5zFAdH/G8zkVmTIsqEZBZL/3qOWFKUy9mmOIuNkiAAUvoDUZr+Bsk/qcca+SNu
kdlOcue5k8z2We9SBIvF6kxV9LXH4eSw5Le0mJCqEP+/Bj9gViF/EWiOBaJZNJPl
f41hiDlJuG1PyKpDw6OFsulvOtOdgVrBPC+eJThbgi0Ox+gL8BPil5iznwVOuMd1
ca31v0Us5t8lF/GoFCmUgM+7J8k5JKk/LPvSph2oIPXWucW2xsyPLN0va5BPM7/7
y8OCKNeIUnX5pIRwldewtdbEaKa4YA==
=46e+
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
