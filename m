Return-Path: <SRS0=rMx/=I6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC58C433B4
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 10:47:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB3B60FEF
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 10:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB3B60FEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C43EA1689;
	Thu,  1 Apr 2021 12:46:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C43EA1689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617274055;
	bh=VM/1BtdrqiCYvndnqAM1TBfzpUWum/Zl6gqVp+AhKME=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fyuw5tlF8TayoMjEBWGAaOo6t2xH4YjreMxnaPp4kM85axtFv5q0kFLgFDMALZVLz
	 k3IZlEmsCi5dPoVHci0jBWcaVh7CVleI1HeOv9+Sy5+YgFvWbnyg6x4okQvrWFs27p
	 KEcasm/OFBsBPOe645TovIlEPj+XvfF0yKwUvHR4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4DAF3F80117;
	Thu,  1 Apr 2021 12:46:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82885F8026B; Thu,  1 Apr 2021 12:46:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B5BAF80117
 for <alsa-devel@alsa-project.org>; Thu,  1 Apr 2021 12:46:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B5BAF80117
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="V5h60PQc"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A42160FED;
 Thu,  1 Apr 2021 10:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617273986;
 bh=VM/1BtdrqiCYvndnqAM1TBfzpUWum/Zl6gqVp+AhKME=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V5h60PQcyZJxt2nQy6D2dothfqcdpAvvTDoaRV3yJ2vzB1svAfkedzcMeUgIaoMQm
 WGZPeJcy7AqSo9G52H7itdy/hpQc+oyFviPFgrJmQj/yvqp0FKNJW8cJ4FhIFvwIS6
 ne1PmQxRZF46VDFOOiySxb3FEXEDdijIspevg5Dz6ejZTTE75VnHjKPGAMQpxIn+NN
 raicTkuYZX3MU/4jpcJ2e7+Y9tK/y3UlKCtOWzCQvRX95spXun7CY5DhMA3tVmSz3C
 pXNV/gn2z5WuqAmeWlP7shTwwRDN6Lc0v1xCY8UZTtGSEivzhpjmSd4zGF8gz+elya
 YErfeV6Qj5wxQ==
Date: Thu, 1 Apr 2021 11:46:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Wan Jiabing <wanjiabing@vivo.com>
Subject: Re: [PATCH] rcar/rsnd.h: Remove repeated struct declaration
Message-ID: <20210401104613.GG4758@sirena.org.uk>
References: <20210401103758.1007908-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XaUbO9McV5wPQijU"
Content-Disposition: inline
In-Reply-To: <20210401103758.1007908-1-wanjiabing@vivo.com>
X-Cookie: You can't take damsel here now.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kael_w@yeah.net, vkoul@kernel.org, lars@metafoo.de,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com
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


--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 01, 2021 at 06:37:58PM +0800, Wan Jiabing wrote:
> struct rsnd_dai_stream is declared twice. One is declared
> at 254th line. The blew one is not needed. Remove the duplicate.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--XaUbO9McV5wPQijU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBlpHQACgkQJNaLcl1U
h9Aktwf5ARCpLq7fOzP5ak60w1A3E957HOzKTX7ZWXzi8BdFMVzpWc33VW8unqhW
atZZY9I0KKEZAAZeLP2wEmbxq+7C/v+e+xi44lshoeeYxIW4Vt1s7zYp3FjqXGQi
fCpWL/VcjLO1pYXGbGRmlWYvrdnKKRhJYxyzYH7hS5VcoYnntM0WF0hRm9fCqNy1
sc+vxNS8nCcsvx6P3dzslG6j0zgxUgJV+STK52D+R1JLqzUSuuzmW+V1VBg7Hmxp
rumiLXncqA3xbwmJpv891n0KHnuSzwQ7LJpM1pb0mvbLM1aY+y9ArHb+LPnAdxJ/
yE4oSjfW9Nxw5uX8m2JKrhdyDi9W3A==
=RhcD
-----END PGP SIGNATURE-----

--XaUbO9McV5wPQijU--
