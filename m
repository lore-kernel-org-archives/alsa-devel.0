Return-Path: <SRS0=Jhnj=L7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6B2C07E95
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 16:57:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 241F361CCA
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 16:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241F361CCA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF40082B;
	Wed,  7 Jul 2021 18:56:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF40082B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625677022;
	bh=yCYwvoTdXzMiWqruf7VQogXxinrECldvmRO8q7DVEJk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cqD8Spgnp2HSnb5v9BA3PZGYoW9a91cUChLmsR+QD237eO5Rgn5fZ9OqxMjClExw0
	 us8/61UPsxTB0wo2WmnaH/B8OPczte2GNhfoal/TUO+jGr5oa5QRcWlpyK5pnvCaC1
	 VXchg21XEUxc/Pw9JR21DIOYGYAkUtMX24wwwGh4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7ACBBF8016C;
	Wed,  7 Jul 2021 18:56:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3039F80224; Wed,  7 Jul 2021 18:56:09 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB9E9F8012A
 for <alsa-devel@alsa-project.org>; Wed,  7 Jul 2021 18:56:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB9E9F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="h8nltpkl"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8479861CC9;
 Wed,  7 Jul 2021 16:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625676963;
 bh=yCYwvoTdXzMiWqruf7VQogXxinrECldvmRO8q7DVEJk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=h8nltpklvBakqZgPQz22JuZhs4dGOBKShWmf/nSTmsAmgBtQS+OwyaCVS7ztUmQWh
 NWDMs5rXmw4r1mBulE4m7lSccgkzfYJeGVQ3Uj6FFDM87USiDIoriPr/WWt7nZ8YNU
 cbWvicOBduv4tHa0HkJGuSGBh0pp+g/i1TQDggnb43V+O/tUkwSuNInIplFrMVquuH
 sGAtlxjpSooiI/t5OAy1sn4e3ZFx7xLt3JzuBFUoECrWQDYTHY/jyLYH3FOxVMMwY2
 yTQrKctzvYbydNvSI5CoFwlhnb+Pl80HHs3P+8oQbwg9XnQimpjo0TX7RXHVSqRB9b
 jJtR9pdjQIXSw==
Date: Wed, 7 Jul 2021 17:55:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <vijendar.mukunda@amd.com>
Subject: Re: [PATCH 00/12] Add Vangogh ACP ASoC driver
Message-ID: <20210707165531.GJ4394@sirena.org.uk>
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nzri8VXeXB/g5ayr"
Content-Disposition: inline
In-Reply-To: <20210707055623.27371-1-vijendar.mukunda@amd.com>
X-Cookie: I will never lie to you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Alexander.Deucher@amd.com, alsa-devel@alsa-project.org,
 Sunil-kumar.Dommati@amd.com
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


--nzri8VXeXB/g5ayr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 07, 2021 at 11:26:11AM +0530, Vijendar Mukunda wrote:
> This adds an ASoC driver for the ACP (Audio CoProcessor)
> block on AMD Vangogh APU.

Big picture this looks pretty good - I've sent a bunch of mails with
comments/queries, and I see that Pierre's done so too but it's all
relatively minor stuff.

--nzri8VXeXB/g5ayr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDl3IIACgkQJNaLcl1U
h9A5OQf8C/Jm6oUHVrpRiJ1s8wFUWv/uOaP1N7HRLbTrYRqtwW/u1ORJ2hwqKKQR
5YpdanUNEUP/dj+6Zur9cGKUQcSoMvQW2JmMTkQuuTY6p2rLUfRiPNsYSWQ3akvV
t5zbR68lNmEbUX1zbubT7sbrEUVMtCUhLQgerynJ2Sgjo5Q1gvfiBCq67dlV+APR
slPK2Zn8rpdPLe2oDbGr8gBm4W2Xzo9Yt3jFJjhB+YxxC+nwB8Njey9izLh8twOZ
c3j4i/WLZBIczOB2vceA1EvWv6UkgjxUe45AVKZnMV5CuUPFeuYNkRTaMc0hnAcp
K29x/XY8AKrnjrwA7b03SFNzktAnng==
=fO5x
-----END PGP SIGNATURE-----

--nzri8VXeXB/g5ayr--
