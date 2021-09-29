Return-Path: <SRS0=CfAr=OT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750C3C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 20:37:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1136136A
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 20:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE1136136A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E18016E0;
	Wed, 29 Sep 2021 22:36:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E18016E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632947834;
	bh=3lllaYs+S6Ey09XkIhSNMU+u/KeAbgR4JlFyct3EyMc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=avt9KXtj3GHNsXsW9jrWrTkhWx/uSMweHVCVJQ5Cl4SRyrgiqdbp5Rb0g8VN0++aN
	 NghLSV28DaDOivRPCCFK2Ep2HVZRF/lc40Sq7/L/TdORQkmVm46CpOYYE3P5dQCCWT
	 7icunauLP8PNBNpD4BLpcoEKaZ37X9GDzjnlNJtY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86E33F80113;
	Wed, 29 Sep 2021 22:36:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E323F80227; Wed, 29 Sep 2021 22:36:21 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2CEAF80161
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 22:36:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2CEAF80161
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="iEh3fKbf"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6BB261159;
 Wed, 29 Sep 2021 20:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632947770;
 bh=3lllaYs+S6Ey09XkIhSNMU+u/KeAbgR4JlFyct3EyMc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iEh3fKbfFwZaC46YzBr4VbejltCE5sWcEokQFoQ8JRQ7ZfUkHPRAo62l2NHzlmDfn
 PWadAGZ7pxuVyGpQ9+3eJT4uO7AhL3QzFomxZrBQDt2EPdHKDETSAv0AJK5uAH5IVf
 5deud42kP9EBbABaH64DcP4OBC3Yq0Vyx3uQm0mv9kbBXEKli+o+xXn1HfGwCmWJGg
 CHGFQwOuUe0RsB6IPn3CKbQrqDq5/OmwcN3op81/ohvYFKf+5iJ9JPoMmxvZW+XbPK
 +Q1IcuenlJ+o8kQ5iyEry2f1SmXzSvMWjQaIjRhWpy2IMtGOcPaBYUpr1MjyiWYxFq
 9tIfQr5X0QK4Q==
Date: Wed, 29 Sep 2021 21:35:20 +0100
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Fix compilation when debugfs is disabled
Message-ID: <20210929203520.GV4199@sirena.org.uk>
References: <20210929145040.793252-1-simont@opensource.cirrus.com>
 <20210929145222.GR4199@sirena.org.uk>
 <003301d7b546$7e33c860$7a9b5920$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="22hJjvOmZW2O/jbw"
Content-Disposition: inline
In-Reply-To: <003301d7b546$7e33c860$7a9b5920$@opensource.cirrus.com>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 'kernel test robot' <lkp@intel.com>, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org
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


--22hJjvOmZW2O/jbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 29, 2021 at 04:27:19PM +0100, Simon Trimmer wrote:

> Yes there is one for the cs_dsp_init_debugfs function though the compilation
> failure the bot
> detected is with the parameter dereferencing the disappearing
> snd_soc_component member.

At that point just remove the conditional definition in the struct, it's
not like a single pointer in a struct we are likely to have well under
10 of in the system is going to make an appreciable difference to memory
consumption.

--22hJjvOmZW2O/jbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFUzgcACgkQJNaLcl1U
h9BIigf/XIh8MnRPfBjtHh63Awrd2Rw/P/IQoyYPxJPTrgwoK04ilK4fnuHAL1Fh
4ZblmurDm7b/3Q95k/T/Ip3Cb6GjF4uSdUxkCfPoezHLfTMMztmiEqwvVOdJ/bOn
AIs74ei31AYNh01OIIB6NgGlNOI14MNnqjaa5fCYy7XTrt4xxa/iKDKYMVZmLvD4
OeXYXf8pOvZ3hXtZoJ6GEsbMLkYifX3X9Hx/5En1WLSd550zM9kV3oswuajmET49
uoByxHrsXfUayHNFVxi9P3qv39FyY/qpy7UTZ1+F+8qFCyDls5N0jEGlSt6/+NMX
ST5JORCK8oDJs+Gh9JnqlYEdIsWB/g==
=pGRN
-----END PGP SIGNATURE-----

--22hJjvOmZW2O/jbw--
