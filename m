Return-Path: <SRS0=wAKr=HN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690B2C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Feb 2021 13:02:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF2FF64E95
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Feb 2021 13:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2FF64E95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF2E716F0;
	Thu, 11 Feb 2021 14:01:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF2E716F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613048529;
	bh=WnyGBvukUkLqPxdNkfpak87sM7oXRCrIkT9BS5tTt3I=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PmfQDUgp9ix/8gPr4CRgKkNGmN+C04RlCbNYNmu+kbzBq+Cgt/dVS9SNS3QODoDqy
	 Lh4AkWdEwTXDEkGhHOU0JH6Ybt/D+0euLdXgcYN77oi0gxyqDvoTHLVEbNoxCm50p2
	 Ev56+PcW4G1bs+fxHHl/qaFkRL+jNtHcqP06ps4A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 441EEF8016B;
	Thu, 11 Feb 2021 14:01:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05451F801D5; Thu, 11 Feb 2021 14:01:17 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8791EF80165
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2021 14:01:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8791EF80165
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dMLfKjEp"
Received: by mail.kernel.org (Postfix) with ESMTPSA id F35A564E2E;
 Thu, 11 Feb 2021 13:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613048471;
 bh=WnyGBvukUkLqPxdNkfpak87sM7oXRCrIkT9BS5tTt3I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dMLfKjEpazSyrsLUGmSOTD7Y6xG8Xx9++lGFL0JkZwLMAskDhuywP1IXGdhMo/edT
 TMJ4qR1p2L/bUB7vBJXB9dx6d6PYvcuoEA5/cKpD3v56/X1tLgr+xjov/1izDzungN
 yNL7TVil1i82hO8iam3C01PT+NhGhvQ3w8mSB9KQaifMdEzvtvPQUeW98kXLmwMEdk
 mLmAZ6jsTym8ilmR7UdjATvdtxcZLTCyoPYjaOetv/RncW+gU+o3dxaIxsi3HJE6WP
 JWm8QEseg0zhLYK5toOUR07c72i+Jv1PflXK42A6DADuo7laMpCvF6VlGi7V1mbqtQ
 2phajwNgHslOw==
Date: Thu, 11 Feb 2021 13:00:18 +0000
From: Mark Brown <broonie@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH 2/3] Revert "ASoC: audio-graph-card: Add clocks property
 to endpoint node"
Message-ID: <20210211130018.GB5217@sirena.org.uk>
References: <1612939421-19900-1-git-send-email-spujar@nvidia.com>
 <1612939421-19900-3-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <1612939421-19900-3-git-send-email-spujar@nvidia.com>
X-Cookie: Do not pick the flowers.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, robh@kernel.org,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com, sharadg@nvidia.com,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org
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


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 10, 2021 at 12:13:40PM +0530, Sameer Pujar wrote:
> An endpoint is not a device and it is recommended to use clocks property
> in the device node. Hence reverting the original change.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAlKmEACgkQJNaLcl1U
h9AqpggAgl/pYTDMcCSFre1v3IzW62gDhJyT5/i75NSiBoD9gGhTSyWoEguV0Iy3
CR8KieeeZYDCNBlnXqFh7el6vB7flEfJZrJLcOFxIcOfios3ijLes48HFcQlkIEx
/Iqz9w76tw6tEj5ZXqD+D7SecR/E94+Wun2AbxbtY4gDizqGCxGJGgCLoQ3NklGL
6KSCuOsX/njb9vvBfl1Kk2U7IdMc0EuRdAobYB0hWKKri8m0RGmVxWGVXb/3yec7
KAShGbuZfcnmIWi9SycNi7uoq5KIwOQql5A9FkgQ1cp/8nUz1NCKc1bQlp6noLOM
iiD03c83baYnzjduuuDbuKRsL3b9hQ==
=K+NY
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
