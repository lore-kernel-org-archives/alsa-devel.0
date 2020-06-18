Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA21DC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:02:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638E2204EA
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="E5tP3Bkn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xiT+CFT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638E2204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C752B175F;
	Thu, 18 Jun 2020 13:02:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C752B175F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592478176;
	bh=uojSHgSubx3hK7KyZszmKecAZ2fxoo+s+cuvPCxsTh0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E5tP3BknUo22NkFwNBY4AtEijZGb2kp4xM7r2ZpFWApIq+gXB+6Dow2MfAR2gwr/7
	 7X5gIGQ3MO3GLI7GVqOXpt/i0voZAsoRW8QpsfUyHPK4XDMuHW8nmYutlfKXA8M7TG
	 kvVIxDYQ/9nAwuk4xBiBT9EQ1Kk6n4OUx9c76Kao=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E12B8F801EB;
	Thu, 18 Jun 2020 13:01:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E7BEAF801ED; Thu, 18 Jun 2020 13:01:37 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9BB2F8010E;
 Thu, 18 Jun 2020 13:01:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9BB2F8010E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="xiT+CFT6"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B9E1320885;
 Thu, 18 Jun 2020 11:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592478089;
 bh=uojSHgSubx3hK7KyZszmKecAZ2fxoo+s+cuvPCxsTh0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xiT+CFT6qnWMSDWTrRxP5zxZwz+qHwawf9Z68AqKEb8vyy6mpLDoIONXlZP2WZ+d0
 0B92++CGCGimj0kBymBR2T5rHzkHJRTHZL+vpt6r2/0fnawrXeR//2Of43fk6WBmzX
 h9bOluaq26GXblSodft7tB5zFP40jK4xuUdpXS84=
Date: Thu, 18 Jun 2020 12:01:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.7 055/388] ASoC: SOF: Do nothing when DSP PM
 callbacks are not set
Message-ID: <20200618110126.GC5789@sirena.org.uk>
References: <20200618010805.600873-1-sashal@kernel.org>
 <20200618010805.600873-55-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <20200618010805.600873-55-sashal@kernel.org>
X-Cookie: Androphobia:
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
 sound-open-firmware@alsa-project.org
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


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2020 at 09:02:32PM -0400, Sasha Levin wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
>=20
> [ Upstream commit c26fde3b15ed41f5f452f1da727795f787833287 ]
>=20
> This provides a better separation between runtime and PM sleep
> callbacks.
>=20
> Only do nothing if given runtime flag is set and calback is not set.
>=20
> With the current implementation, if PM sleep callback is set but runtime
> callback is not set then at runtime resume we reload the firmware even
> if we do not support runtime resume callback.

This doesn't look like a bugfix, just an optimization?

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7rSYYACgkQJNaLcl1U
h9As0Af7BPVT1E+OmFZJ2fmGTIygx1ScRtYWAs0iknMEs/lkyrWtWtGAKCMxp3F+
yTbJiBrGj6KGCZvc02UISISUaxtSbHNPNMcjeGeBwM8li9rAjXMJMQcDmxjPB4nV
F+EeRtpZZ5uMhIQk5B3wU4/EgBU7nrCNJUwTMsuwoVWaTRdFPSFLt5EBCxWW8X88
sGadYKYd9aJzuRDce3mbLz88dlEb7OXG9we18xnl9Zy+umNwgRyGzdLTvXisbdGb
rADcI2b33lFMRkHH/ymVLXlvoQ1nISmwpkhxBU0pJspOpIIZ5gjuezx7aViPcTkw
Src3w3xN5i64dl5LQI1ssMAIZe2/LA==
=HpMZ
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
