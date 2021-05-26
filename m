Return-Path: <SRS0=tEYa=KV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E17C2B9F7
	for <alsa-devel@archiver.kernel.org>; Wed, 26 May 2021 10:29:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81B94613B4
	for <alsa-devel@archiver.kernel.org>; Wed, 26 May 2021 10:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B94613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCF641740;
	Wed, 26 May 2021 12:28:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCF641740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622024941;
	bh=mVhY2zrOCTQ7rwrJSQSxXGaCaMx7JRKmVJUoE3G6wG4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rR2Law/aJ+Jc545822Rnb1GykiKn6O2ee3+KnABgUN86oJBJ2qemlpMkEU4M1lAQZ
	 kphT4eaMjG1BRYaZIxGGWmF/K5ZlA05bk1wD1sbhK+LW1nCJ+kjzr83ToEk5Ucs8xY
	 cLcZJYCOb7LgHjHzuMSvrkHDD6NBLAb7xsHFkHNY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 23FDFF8024E;
	Wed, 26 May 2021 12:28:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A1021F8025C; Wed, 26 May 2021 12:28:07 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D84BF80212
 for <alsa-devel@alsa-project.org>; Wed, 26 May 2021 12:27:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D84BF80212
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="kmeIv1LG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cZwwLrwCegHrLx5GKTnmoyVo0Tv+Y7Dud5Ty5poKbYU=; b=kmeIv1LGbHDCxb8Mjo2hY0snwo
 sEDrTwLDila2cu+dT0o8E009Z2OaWRYWAKhZxQVPDmY9tB2h+FnTg0lOXCcRMGi00dnZXkrIhxc5k
 MrUSK5Y9EAAG97ePlsUdCfk0bcyo+J/zeadqYYEwmJ5Wi6JN5yRi3/XdGsqaKq4y6Viw=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140]
 helo=fitzroy.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <broonie@sirena.org.uk>)
 id 1llqla-005xcI-Qm; Wed, 26 May 2021 10:27:58 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 75837D00386; Wed, 26 May 2021 11:28:33 +0100 (BST)
Date: Wed, 26 May 2021 11:28:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Phillip Potter <phil@philpotter.co.uk>
Subject: Re: [PATCH AUTOSEL 5.10 30/62] ASoC: rt5645: add error checking to
 rt5645_probe function
Message-ID: <YK4i0e6M6lEIP6rj@sirena.org.uk>
References: <20210524144744.2497894-1-sashal@kernel.org>
 <20210524144744.2497894-30-sashal@kernel.org>
 <YK1w+H70aqLGDaDl@sirena.org.uk> <YK129caVtNBthNDG@equinox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cHefsDBJIH1f4L8H"
Content-Disposition: inline
In-Reply-To: <YK129caVtNBthNDG@equinox>
X-Cookie: Ahead warp factor one, Mr. Sulu.
Cc: Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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


--cHefsDBJIH1f4L8H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 25, 2021 at 11:15:17PM +0100, Phillip Potter wrote:
> On Tue, May 25, 2021 at 10:49:44PM +0100, Mark Brown wrote:

> > Now I've looked at the patch I don't think it's appropriate for
> > stable, it's essentially equivalent to a patch that adds -Werror

> So I frankly don't have the experience to disagree with you :-) Your
> reasoning certainly seems sound to me. My original motivation for the
> patch (after discussion with others within the mentorship process) was
> that some other sound SoC drivers do this, an example being the Ux500. I
> defer to the decision of the community as a whole of course, and am
> happy with whatever is decided.

Right, so there's multiple bits here - there's checking at all,
there's adding the checks to mainline and there's backporting
them to stable.  For stable we want to be fairly conservative
about what we're backporting since we want people to be able to
just update without worrying about things breaking on them so
something that increases the severity of existing checks is
particularly risky, if the code were already there and people
would've seen any issues it causes when integrating the kernel
it's a different story since the risks are different.

--cHefsDBJIH1f4L8H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCuIs0ACgkQJNaLcl1U
h9ANlgf/YvtO5pFfMXUqJYLeaHKLC1Xsohk8h5NtPTRN/fESqo0ZfEQdP/M2ejpN
7oDLiALRDp5c4f9ygaJT9QpG/EJE5WaGqUGXXxeVYzGPabt02h/vi0i5ezzAE2W4
sje35kkEZp+i/jWIhumEyaTi/agjBUMxKNvqMFi0iBxB0KMvU2sDAkIhOtWF+J6y
J8xSFDr2JX+S/6Ce/VPfsXk78gK6KIbTGC6m69Yztu/tmmyXFP0y61ZyoumBsLYo
7JU0tzNiF83jQ0WwqMJGtlTrqDTx/jQX7SE1J/edA9YxgkPPMGswTGTXb9Tstitn
+B7giMv5oQf05+amDyayED62WKtgHQ==
=Rqpb
-----END PGP SIGNATURE-----

--cHefsDBJIH1f4L8H--
