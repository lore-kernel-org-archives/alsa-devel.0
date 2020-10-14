Return-Path: <SRS0=7Yh/=DV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E82C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:57:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B462222C
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ifDuk8Gx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1IGhGhQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B462222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED0FD174B;
	Wed, 14 Oct 2020 20:56:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED0FD174B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602701857;
	bh=+ltEREMql2yyINqmA9gqQrQYDWKSt6A5cI/39B9w9tw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ifDuk8Gx5hOIsuH4mwNfdCKz+gJsR3hJQe6iOnOccjt+COpUdM5wTTfBcCNiGqWJk
	 c0d06hLLmWt5nN6s9tmtNepT9asdLunzqmAylmqVmnXX8LF4vlq3bnRSDMx0h1a2Gl
	 ixS7u2KWXcvYdUJa2KatvOhxVZcKs/FAkuKJJ6gk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B9E0F8012B;
	Wed, 14 Oct 2020 20:56:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F018CF80217; Wed, 14 Oct 2020 20:56:44 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C892F8012B
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2020 20:56:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C892F8012B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="1IGhGhQG"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6C5BF20691;
 Wed, 14 Oct 2020 18:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602701799;
 bh=+ltEREMql2yyINqmA9gqQrQYDWKSt6A5cI/39B9w9tw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1IGhGhQGkU4HC1se8IgwwQ9G/D32skpp7hFVvKoxNFcqc9F292xSNWZc5K4/FuBJj
 iDe5KB8fbE2IiyPlQhyo7NmVyI7FGo1Omh4EavqGS2JsLz/+59wbWDTDQ9rkGWeu98
 mmeoYq3TBmfA+YVfcSwqRuZI98uhh7oLXuncxpDo=
Date: Wed, 14 Oct 2020 19:56:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/7] Add dts for Rpi4 + Cirrus Lochnagar and codecs
Message-ID: <20201014185632.GD4580@sirena.org.uk>
References: <20201014145418.31838-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
In-Reply-To: <20201014145418.31838-1-rf@opensource.cirrus.com>
X-Cookie: Take an astronaut to launch.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 nsaenzjulienne@suse.de, linux-rpi-kernel@lists.infradead.org
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


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 14, 2020 at 03:54:11PM +0100, Richard Fitzgerald wrote:
> This set of patches provides support for using the Cirrus Logic
> Lochnagar audio development platform plus Cirrus Logic Madera/Arizona
> codecs with the simple-card machine driver and a Raspberry Pi4. The
> ultimate aim is to provide the dts file but some updates are needed to
> the simple-card machine driver.

Why extend simple-card and not the more modern and flexible
audio-graph-card?

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+HSd8ACgkQJNaLcl1U
h9Dd+gf9H9W9GnnZzIpKoLpRNV0tJouG88erTYHIDCw6oummw/+zMd0A/LMkyf6i
uocPRbZ0ZILdTnLxbhFAvsXwFg7NsBJf4PsmHkcixBmA1wCw66DE2aQn4lPZnXNE
2dkwmDVhNYwxq7UBqREr64XgpGGQlnGW19J3F3Vf1bYwS061BuEmGx7aEumoKfL+
0MyUkBA1Yi3x+/v77XNmg3WD0DWYhP938ljNBXxRmhGB5zH20ieUxKrZV6c4lS+0
MlFwMfPhV12NQnZYiynma+gILfHmU/JDE4qLsaCKhaVtHUCydSmfoPuFTazNZ2hR
xvHC2xLmqY3aNKT97MW1sgKRPdO8iA==
=ej9C
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
