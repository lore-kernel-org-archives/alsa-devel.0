Return-Path: <SRS0=iQjD=KU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6916EC4707F
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 22:18:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91F6D6140B
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 22:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F6D6140B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DEEE1761;
	Wed, 26 May 2021 00:17:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DEEE1761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621981092;
	bh=0P23WbC9ePHHq3BD5qc0LJwj7HsYi12emRFtPq68sSQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PNo8JkSj5GnUgn9Nzni898qikI+zLELXgfYK0NIFYY1ay0rm6+qZC/CS9J1Kh94O5
	 Z9yWGtF3DZFna1S09Vp8DU4n9Dx+NXhcXFLh3FQXUGu8gANp9BWYvZVkiJ1waUZ3j2
	 WEP6zCK65O8zkEpFDinJAP6E5BHUFKIAmMlG3WhI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00B6AF800B6;
	Wed, 26 May 2021 00:17:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 031C8F800CB; Wed, 26 May 2021 00:17:21 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 40462F800B6
 for <alsa-devel@alsa-project.org>; Wed, 26 May 2021 00:17:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40462F800B6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="tkzF5wfy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/DeFT2HLidyQbXDuaVmFykWKq/MpnW4f5fNeEVzpKdA=; b=tkzF5wfyREHRumRxhFPrceDafN
 jc3i4ac/hZ8buUshdLBA8YBjiQQq+iOiyASbxNdjW2VnlHyTWWYr5rGHI3uEtO4Gzf345zCLrtCBk
 gbRBttoscX5TdXiQgke3vUVz3nYD0B/HBfbE3OpiBpOv1yxdzWlT8BAxeh61VH955dN8=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140]
 helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <broonie@sirena.org.uk>)
 id 1llfMP-005qca-LW; Tue, 25 May 2021 22:17:13 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id A0F5AD0E9A6; Tue, 25 May 2021 23:17:47 +0100 (BST)
Date: Tue, 25 May 2021 23:17:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH AUTOSEL 5.12 32/63] ASoC: cs43130: handle errors in
 cs43130_probe() properly
Message-ID: <YK13izCA4E8Vey2h@sirena.org.uk>
References: <20210524144620.2497249-1-sashal@kernel.org>
 <20210524144620.2497249-32-sashal@kernel.org>
 <YK0C/HLiQtt/vyqV@sirena.org.uk> <YK0NKG0l3a5vjO8K@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2zQRsZ/VOzDiO4Cs"
Content-Disposition: inline
In-Reply-To: <YK0NKG0l3a5vjO8K@kroah.com>
X-Cookie: The wages of sin are unreported.
Cc: Sasha Levin <sashal@kernel.org>, patches@opensource.cirrus.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
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


--2zQRsZ/VOzDiO4Cs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 25, 2021 at 04:43:52PM +0200, Greg Kroah-Hartman wrote:
> On Tue, May 25, 2021 at 03:00:28PM +0100, Mark Brown wrote:
> > On Mon, May 24, 2021 at 10:45:49AM -0400, Sasha Levin wrote:
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

> > > [ Upstream commit 2da441a6491d93eff8ffff523837fd621dc80389 ]

> This is now in 5.13-rc3.

> You should have been cc:ed on it a few times already.

Hrm, I've managed to find a *single* copy mixed in with a revert
as part of a huge series (it was almost 70 patches) with no cover
letter that got copied to me - I think what happened here is that
this looked like this was something where you'd done a revert and
then dropped that revert (which was what things I'd heard from
other sources suggested was what was going on with that series).
I'd certainly have expected to get a standalone patch submission
or other communication for something that was entirely new code,
and if you're not getting review for new code like this that
isn't super urgent I'd expect some attempts to get it before
bypassing.

This sort of stuff is not great, especially when half of what you
were doing was to address bad practice on the part of the UMN
people - I would have really expected any completely new changes
like these that came up to be sent as new patches through the
normal process rather than mixed in with what look like
mechanical, treewide changes.  It's a recipe for things getting
missed, as I said in followup to the copy of the patch I found
there's some issues with the rt5645 changes.  On rechecking
everything the only issue I actually spotted with any of that
code (use of devm at the component level, which realistically is
at worst very minor) is not fixed by the additional patch.

--2zQRsZ/VOzDiO4Cs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCtd4oACgkQJNaLcl1U
h9DRrAf/WK05Ortty9YhRe38JHzFKvlvKqrbOUwp/6bQJqD4MyPVvHUwZ+sUhUmR
7l/KL3tjrib58Rmviv8doIWMe2+B2u2014JMFSTIS6S/9jfE2KAlcWzh4dRT6Usn
SoIL02uNhXqefqSMZ8gxZZ6iQ+4FJlRQim2OPrRPAm9JIHyIECeY5eZsKLrUkAPR
/ZzuI1FWvjFRZ7GYkpIJg0wTsYypGk5lTqAhq8d2dupmqeaGJjCoPGjBzIb7F6LS
Q+/mratq1nP4vDyxilrp+tqRDJnkSrZL4R9QE6rQ9REQshSLG94YowNAraRB0ecr
KSHZGzI58SDDkqoo7wBT0N6koeHqDA==
=tmJz
-----END PGP SIGNATURE-----

--2zQRsZ/VOzDiO4Cs--
