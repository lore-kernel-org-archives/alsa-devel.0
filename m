Return-Path: <SRS0=JTem=5M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677DCC43331
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:57:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A33E2074A
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PoYDBkAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A33E2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8EEB1168A;
	Fri, 27 Mar 2020 17:19:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8EEB1168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585326034;
	bh=ZKRODaUv0tqqLQqz2Uw4OZfLiQ2JR71Kv5HoiGHp7ig=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PoYDBkAZInMVwYIC8VbGW1YFa/RsU0bc+Ahunxg4GXI+XWw4CkSHtUe2c00SCKw2G
	 QPcZ1r48uynwspbxhAZn2KFmyN1cFedNh5fBpCioNUxfpBYqhvfqhbgeQBnz4ZcpSJ
	 beoAeKfJzBz8SKu4zsglQAxngitvsjAY5etutIX0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B10DF80147;
	Fri, 27 Mar 2020 17:19:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B12BEF80158; Fri, 27 Mar 2020 17:19:42 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 43666F8011E
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 17:19:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43666F8011E
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B920C1FB;
 Fri, 27 Mar 2020 09:19:38 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D2663F71F;
 Fri, 27 Mar 2020 09:19:38 -0700 (PDT)
Date: Fri, 27 Mar 2020 16:19:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/4] ASoC: Intel: add SoundWire machine driver
Message-ID: <20200327161936.GH4437@sirena.org.uk>
References: <20200325220746.29601-1-pierre-louis.bossart@linux.intel.com>
 <20200327160515.GG4437@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="82evfD9Ogz2JrdWZ"
Content-Disposition: inline
In-Reply-To: <20200327160515.GG4437@sirena.org.uk>
X-Cookie: Drop in any mailbox.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
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


--82evfD9Ogz2JrdWZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2020 at 04:05:15PM +0000, Mark Brown wrote:
> On Wed, Mar 25, 2020 at 05:07:42PM -0500, Pierre-Louis Bossart wrote:
> > To handle multiple hardware combinations, this patchset suggests a
> > single machine driver which will create and initialize dailinks
> > dynamically. This allows us to support new configurations easily, as
> > shown with the TigerLake rt5682 example.
>=20
> This doesn't apply against current code, please check and resend.

Oh, never mind - aiaiai seems to have some interesting ideas about what
commit it's testing against.

--82evfD9Ogz2JrdWZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5+J5cACgkQJNaLcl1U
h9ABHQf+ONn8sOwM4vCUD22aoWy8LTMPb658j8vBtUMxqy+IgxZ5c5ZZjZBt09nx
LMp5CnxZ07PJHOTNCKKMgweli3h0fD95i13Phe8cMu2e2wnSrZljkxtsJWi+uXAt
z7J9wEsyEFdqFpj2LCEI8D8+4EbZiYdvRtKwfMq7Q4kxI2TgHdvmK0AQioU9sw+l
B2RFsqderz73n5Mgna8bSVs75WLXpkIZ9JCobhoZ1rAvHJu+fnJF3OHAUcY62QC4
NGaiQ3i9gJypJQtfr+9WkVTIhOL9pTFLO/FVWSD2WiagxwnEB92FUK3ZCRb2mGrB
5+xGtvbYBaSO5N7A1Iudk8FHSc0xTw==
=a0yU
-----END PGP SIGNATURE-----

--82evfD9Ogz2JrdWZ--
