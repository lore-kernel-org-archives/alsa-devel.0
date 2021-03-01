Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B089C433E9
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 14:23:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D9D64E22
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 14:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D9D64E22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 92768166C;
	Mon,  1 Mar 2021 15:22:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 92768166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614608626;
	bh=B1rsUPZZMrJCDAX8ICqDg3gybux1VKOF1jXfynGIiKs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gibnzz9nKfQRIjQB9aiwIRzba/DnGyuUa69FWbndT/g58P0dFuBq+XWoUxtEXQjuA
	 Yw8fWygkYepFlQbQEhsbjxlvGrw2xJVuckn0QAwviJn56Ynck9WiAaJnkGro+b3O6G
	 dp02Xpp84amLflaxBSouxaPvT4EhKw+sbn7BofyM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1C557F800E0;
	Mon,  1 Mar 2021 15:22:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F02D9F8025E; Mon,  1 Mar 2021 15:22:54 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DABBF800E0
 for <alsa-devel@alsa-project.org>; Mon,  1 Mar 2021 15:22:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9DABBF800E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PmSsT55H"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C56764DBA;
 Mon,  1 Mar 2021 14:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614608564;
 bh=B1rsUPZZMrJCDAX8ICqDg3gybux1VKOF1jXfynGIiKs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PmSsT55HiPJ8eQyPjRAA0TZeMrqfLPSbSH4IDpOIccciwFvG+BcARUgen0NzI8lQz
 cbBB1bqNW5/n9UBun4Nsdiq2G0BIo+UmoIlr0r0xDXc3eGwSfjR+sVSMSs+ZPnOzmL
 TFlKjUcfVUfoCiP573gpjLXpbrlaqW2f4poq/jJCIYK/UezY/tZNnHoqQejYrHq0iJ
 vrD+cqJ4BwX1Bvk9wM3/lxgsAfQErInO5ow8FeVShGZ60ZUlTZ9yQPMol4cKByANJJ
 BMTtwNoizSNdWSmaFyBlPx0otvmXMEKBFlo9QdkytSYI/Ghgb7W9VK3bGoeWyLcSMG
 H+EeLm4tSI/GQ==
Date: Mon, 1 Mar 2021 14:21:38 +0000
From: Mark Brown <broonie@kernel.org>
To: dingsenjie@163.com
Subject: Re: [PATCH] sound: soc/uniphier: Simplify the return expression of
 uniphier_aio_startup
Message-ID: <20210301142138.GA20200@sirena.org.uk>
References: <20210224085407.22120-1-dingsenjie@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20210224085407.22120-1-dingsenjie@163.com>
X-Cookie: Does not include installation.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com, tiwai@suse.com, dingsenjie <dingsenjie@yulong.com>
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


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 24, 2021 at 04:54:07PM +0800, dingsenjie@163.com wrote:
> From: dingsenjie <dingsenjie@yulong.com>
>=20
> Simplify the return expression in the aio-cpu.c.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmA8+HEACgkQJNaLcl1U
h9DI+wf+J7pwCNkiy3Tn63s9OgSsXF2YUMxFNLFzCKlrtjD9+V+TelztPZcxkM9E
Cn3fxKJNPjTBBL76ejhE4T3eJ2YWyHQg4TnRPKCHmsK4Rcnf7zN62RMNZPVgP64i
de/lI2SAjbsgGyIVgsx5hlemasp2/SdAqoa95nBRG9AKKH/SW3RPptph49X+TsBp
xauqATD4e2ZD7dvxKOAJo8IZ32WCU32o5+3IrV/iY23dKQZPfTFV78jfllliy0A3
pW7smM3KkSNrJLYiCKnbRUYSeys+CJLWd0oftGSV8ZE/2cQT1THdN0oFcD+SbUCr
l62kEdf9zGex3QNolb+PQz0EPgXsPQ==
=NNS3
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
