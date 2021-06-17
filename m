Return-Path: <SRS0=NYZN=LL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD38C2B9F4
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 12:40:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12A4A610A5
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 12:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A4A610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A09F16F1;
	Thu, 17 Jun 2021 14:39:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A09F16F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623933635;
	bh=fw6PYBpF+coIFXTlzJ9LjDC8fhF/lb8QsrJqeE6MVuU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E9yx88PibrU7z38FWBya0H03X4Nz7L/JiGLz9xjF7+b5Rva+Doyr9qgjJDQFWAXQZ
	 7XrX1HQgcfsZwOWxITTOyS3lS46Wt+tgXtDGPcvB10Z0eO7yVZiZvSiEdxPo2zkXUl
	 K06WC6dHRd1RogghnD8p4J4g97K1lzi6f+Rk5k58=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39EA3F8025E;
	Thu, 17 Jun 2021 14:39:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1841F8028B; Thu, 17 Jun 2021 14:39:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5BAABF80171
 for <alsa-devel@alsa-project.org>; Thu, 17 Jun 2021 14:39:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5BAABF80171
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="b4ynQstr"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2E9A6113E;
 Thu, 17 Jun 2021 12:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623933574;
 bh=fw6PYBpF+coIFXTlzJ9LjDC8fhF/lb8QsrJqeE6MVuU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=b4ynQstrSw8a0W588jTlyA6Y7h3yO8apLfqgvaYBhLTIZAMY7sIIaru044v+cL0gb
 3XVrPjlRVVtX2tnIeNj1XS2EbqkQEdW//hQRqQRnYEFkUw4f42oeOWV4ufq1bulLkh
 ysUYv10cBkJugR0oZa2l6QsP+da3IhyuC8LXt1FfXuT5Ghe2q3k4UVo+FN07W/7hFE
 l36FLtuRnHR0sseoVkMla0ysQwBb3LPabfF0hLxBt18shhy02Kti5BdDmUgYpn/pmy
 YtGE1t3zTkUssHjZZEF6aPeThAYRZ372DlzrcImVhcXDMJ3g0J72EyeKCDrXYW9YPR
 I6PLhoI9tq7CA==
Date: Thu, 17 Jun 2021 13:39:14 +0100
From: Mark Brown <broonie@kernel.org>
To: shumingf@realtek.com
Subject: Re: [PATCH 1/2] ASoC: rt711: remap buttons
Message-ID: <20210617123914.GD5067@sirena.org.uk>
References: <20210617090809.16901-1-shumingf@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EY/WZ/HvNxOox07X"
Content-Disposition: inline
In-Reply-To: <20210617090809.16901-1-shumingf@realtek.com>
X-Cookie: But it does move!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, lgirdwood@gmail.com, jairaj.arava@intel.com,
 derek.fang@realtek.com, bard.liao@intel.com, sathya.prakash.m.r@intel.com,
 flove@realtek.com
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


--EY/WZ/HvNxOox07X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 17, 2021 at 05:08:09PM +0800, shumingf@realtek.com wrote:
> From: Shuming Fan <shumingf@realtek.com>
>=20
> This patch uses the same mapping as the machine driver:
> BTN_0 : KEY_PLAYPAUSE
> BTN_1 : KEY_VOICECOMMAND
> BTN_2 : KEY_VOLUMEUP
> BTN_3 : KEY_VOLUMEDOWN

Which machine driver?  Can't there be multiple machine drivers, and if
they're already overriding things why do this?

--EY/WZ/HvNxOox07X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDLQnEACgkQJNaLcl1U
h9C8pAf/f9zfeIz22Ls1UeyVWK+hsVY2NnvyLo5QmLBqMPeecXOOdRVoQ02L0AJK
MJGsFW3y8BDZQd3c4MaCGci6WhTIlhcN8/m80ed9YnWN3LJsbGuqcp4tZY2rzb/H
nTyLR2QuAivZXqkxRjDa2KwkojwyNfTB1MhYjBTdZXWpz2yuoYd4WaeUIOVKL2tj
goH9uJJ5SbrGRdIYP8nnFYfY+hqTceWR3Mb1PU0/wyM7PgVeaFlcFOlIfumC1PmN
7gMQPSSLPZD6U7JF/e3QkdYznwElRLW0NTKAwHMdzmlqd57hR2pOUatKhNFL93+e
OEoHbYLahmscs9QuhjJWPZfwMHJhgQ==
=qdGG
-----END PGP SIGNATURE-----

--EY/WZ/HvNxOox07X--
