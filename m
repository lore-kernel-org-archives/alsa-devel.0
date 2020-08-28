Return-Path: <SRS0=n32M=CG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD816C433E6
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:55:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 413952098B
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Z4bmqo/v";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1ib12pX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413952098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C5AAD1784;
	Fri, 28 Aug 2020 12:54:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C5AAD1784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598612135;
	bh=vkWbggIn31wkqWLMUw3SydvUtUZsXtxvZX4kmj+Pxpo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z4bmqo/vpRhqd7RG/pBG0mySr0vz9QOK20VO+lF9BCPTc7czbNJqzk/rYe/nMYTDt
	 imGjBWDIYIt25PlD9oYxedUfVCB0/bHYKmLgdITMO4+/nUtkWj0lwmcemzcWcrmzUP
	 8R9XVqG0nrz3VYiIyFNvgg9b/Yn6pNpLk93rhpzc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 37F61F80143;
	Fri, 28 Aug 2020 12:54:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2D05BF8016F; Fri, 28 Aug 2020 12:54:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 31BB1F800EB
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2020 12:54:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31BB1F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="1ib12pX1"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2C5A2208CA;
 Fri, 28 Aug 2020 10:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598612071;
 bh=vkWbggIn31wkqWLMUw3SydvUtUZsXtxvZX4kmj+Pxpo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1ib12pX1ptTPxRSYRHTBZVwFpAcMgaH3y9K3RlcNZ3FQORdQg3USQi54vkQo0YTJQ
 f8f/C3r8dty5qXFBcOXfHmy1WaH+xZh+FIuozjfoNdYf4RGmovGyg06TRhHCpuHC/9
 ab9Z1DoPz6biNrVErx3mLuH1MzipAtED9xNMV07o=
Date: Fri, 28 Aug 2020 11:53:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] ASoC: core: remove artificial component and DAI name
 constraint
Message-ID: <20200828105354.GD5566@sirena.org.uk>
References: <20200827205100.1479331-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline
In-Reply-To: <20200827205100.1479331-1-dmitry.baryshkov@linaro.org>
X-Cookie: Your fault -- core dumped
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
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


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 27, 2020 at 11:51:00PM +0300, Dmitry Baryshkov wrote:

> Current fmt_single_name code limits maximum name of a DAI or component
> to 32 bytes. On some systems corresponding device names might be longer
> than that (e.g.

Are you sure the name doesn't get exposed to userspace through a field
that's 32 bytes long?

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9I4kEACgkQJNaLcl1U
h9D2Ugf/VT5JT5y8pFJiJUbzmWL6aNxT5LIZ29DLnZp+/YjT0j5tkUbxQWBynllA
OHGcJvb2Zy3PugeTQajbMd4Y3cxwqsj/9+JSZh5f9dmbUzZv3qZtL5WWBydIshwf
pm5+3dhuglqUt7Sz2zg4FggLYa/75ME6WAoU3W+NE0ZEy4ugihWhbCeoajoKNHPi
het02DGVx8j8mF5MUlRsLvu4Cbu5yGDWOd5sVu9dzZyrTNEusQpuAC3gCJ1hk9T5
s6bgaTD7AlvJuVabXvFfUclQYCKwmFlzCLoo9e/1SKxrhjfRnl7hkd3gIxWHKiTe
DhbgLTkC+otqCG42ARZ4PahFJBDeIQ==
=hxSz
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
