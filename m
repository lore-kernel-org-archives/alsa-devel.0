Return-Path: <SRS0=ks7i=26=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BCCC282DD
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jan 2020 20:39:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C812073A
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jan 2020 20:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jIfKMIrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C812073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD4281775;
	Thu,  9 Jan 2020 21:38:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD4281775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578602357;
	bh=s6v+aZoTtUf34wug+DWwfP0hl0U7/kZWWoNpWTMSuXo=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jIfKMIrHrxM8NONrZAuziFNolEGXSQmb48nNth+Zdr4+i3LDIW4og0qdatjjFNMCK
	 jdpPLLqx3g2Gb7h7ZvP8FwnPn4V+hxCrr/t43zDtqfoRPbb+h9pZUuo70sF4656x1r
	 +NRe2siE2S0b7ksx+C3NGKhjaZnr6Wxev+yT5frk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 457EEF8014E;
	Thu,  9 Jan 2020 21:38:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05DF4F8015B; Thu,  9 Jan 2020 21:38:26 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 9B01AF800E4
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2020 21:38:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B01AF800E4
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9236331B;
 Thu,  9 Jan 2020 12:38:21 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 188F03F534;
 Thu,  9 Jan 2020 12:38:20 -0800 (PST)
Date: Thu, 9 Jan 2020 20:38:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Message-ID: <20200109203819.GG3702@sirena.org.uk>
References: <20191227152056.9903-1-ps.report@gmx.net>
MIME-Version: 1.0
In-Reply-To: <20191227152056.9903-1-ps.report@gmx.net>
X-Cookie: Killing turkeys causes winter.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Annaliese McDermond <nh6z@nh6z.net>
Subject: Re: [alsa-devel] [PATCH v1] ASoC: tlv320aic32x4: handle regmap_read
 error gracefully
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
Content-Type: multipart/mixed; boundary="===============5340220036409612527=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============5340220036409612527==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Content-Disposition: inline


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 27, 2019 at 04:20:56PM +0100, Peter Seiderer wrote:
> @@ -338,7 +338,8 @@ static unsigned long clk_aic32x4_div_recalc_rate(struct clk_hw *hw,

>  	unsigned int val;

> -	regmap_read(div->regmap, div->reg, &val);
> +	if (regmap_read(div->regmap, div->reg, &val))
> +		return 0;

Is this the best fix - shouldn't we be returning an error here?  We
don't know what the value programmed into the device actually is so zero
might be wrong, and we still have the risk that the value we read from
the device may be zero if the device is misprogrammed.

--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4XjzoACgkQJNaLcl1U
h9BsYwf9FFgKoSbL5lC50mSEVqCPZLbUHO3dBKRJnmTHcEUvNS5eWPVNpH+cT04y
JmhyR9UvkDd0uD8uGILu33O7WQB2p+0vL++3ZNHxmiuPahdDQIsU4LSOd1KxECjK
0CUOK7TRBEhrsDtzGRJASf+1DO8GRqs5abAjTRAkFPBG4mVUtDmPrIaaqxdrS8IG
QX2WU53Ee3PidUrDbmVFC7LOxN93YlujLBKhuWwVuD2IvIfzYGmDPIsmUAvKX8wD
/+cVC0PrjVec5we3himey5e5o1BwfO8IUK6Fshea6548M90d/oQCioPjxKvLjvNc
B/udO2IZjDYCm1uIFshxEGTtGtQlQw==
=A/xb
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--

--===============5340220036409612527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5340220036409612527==--
