Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65CAC433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 14:01:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CAFA64E07
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 14:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAFA64E07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B99B81672;
	Mon,  1 Mar 2021 15:00:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B99B81672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614607277;
	bh=OmpZzXM86SCw6KvwZBFkal/KrHkDjOkOhMSXg23gA1A=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qR0q6WayfdGko7esLU1GILunrCiY3nTHZIdXXXayL8SNyMWAs6MPHYWZOLopJGLoz
	 bNEJ/mTKhxuW4fBpVIjayJboM5BkG6jYmWu93Dm8SIjw7mWMBslkIgnLjTEF4knJ2A
	 Ie9otNf9FGsj7L22NXwC5dH40yMe+wyVhmsaylaE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55EEAF804CF;
	Mon,  1 Mar 2021 15:00:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BF4FAF804D1; Mon,  1 Mar 2021 15:00:25 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5269DF8049C
 for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2021 15:00:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5269DF8049C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rz+RIQqE"
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCF2664DBA;
 Mon,  1 Mar 2021 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614607219;
 bh=OmpZzXM86SCw6KvwZBFkal/KrHkDjOkOhMSXg23gA1A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rz+RIQqEcKcabTnYefP2KyzutZ9gwtDnxjOXrUUKm1dVtHesShkQb4cLE1tPISt99
 el7uumkcEbXj6D4KVRyiBAbEuBibG2CVw0id3u9GM8HN7WVK3IaZ4tS8u5Ia5k0+QT
 bLodgT48Iz8f2dWonQ2r/3mq8rCy55xJfS3BJ/fj5x98x6zzRDCLsdJL7JwXxy0bin
 WNy7eZCDjuOM+sSgLAjnaNTRYB09ri28Q5Y6ZtHzAL0ZP9lrZUxkWTCJnZrTLJ5opn
 PL2KLX5bBYDRxzNGB3EUfVSsyqb8w9omlbnniVK7rXNA7zDH5u1YPmIa7tqIjm/IBD
 n1kg852kZGhqg==
Date: Mon, 1 Mar 2021 13:59:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH 1/7] ASoC: convert Microchip I2SMCC binding to yaml
Message-ID: <20210301135913.GD4628@sirena.org.uk>
References: <20210223181929.444640-1-codrin.ciubotariu@microchip.com>
 <20210223181929.444640-2-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
Content-Disposition: inline
In-Reply-To: <20210223181929.444640-2-codrin.ciubotariu@microchip.com>
X-Cookie: Body by Nautilus, Brain by Mattel.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 alexandre.belloni@bootlin.com, tiwai@suse.com, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com, ludovic.desroches@microchip.com, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com
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


--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 23, 2021 at 08:19:23PM +0200, Codrin Ciubotariu wrote:
> This patch converts the Microchip I2SMCC bindings to DT schema format
> using json-schema.

Please place any DT binding conversion patches at the end of patch
serieses, there is a frequent backlog in reviews of those which can
result in everything else getting held up.

--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA88zAACgkQJNaLcl1U
h9B+qgf/TOlF0xRZSjua7srE7OysMc4fe8jYg7NVzdr2jr8nGIb83dJvgNXcBEO6
CQ+qYQhNsNw37nXAwN+OxgmLUudoM5MkTgKK3bs0KHHh+Pbkr6Ayznv3jOf2fKRF
gwR7oKGPR+rHVvzErYf3mMKeKtiJ9i6rmbCDk2h6UaQzRxYKpl9Fju6nXniK/IaS
fQcjxFdc7af5EteVjJETYasx0Uz2rsAqZUesXGj4QWTnawdNwNkb+IN223R3/fX5
oolLe3p2hSWMNB7kA5Wmc7/VtLW5GfvQ50KfmlYweeFB2mxn/PaZsorTEI+Atuf3
ZPI2gPeaZjGTcY02x7idYxqyfbZQrw==
=RV3G
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--
