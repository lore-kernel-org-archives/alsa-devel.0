Return-Path: <SRS0=f4/q=ES=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4466C2D0A3
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 15:08:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB35C22201
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 15:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Yajndt2Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaUO/9dn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB35C22201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 144921771;
	Thu, 12 Nov 2020 16:07:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 144921771
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605193698;
	bh=9SajqhozCmxPRcduXSh1o5cD2wX32wozUPv/nxW6kGU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yajndt2ZrUG+p0ba9Bzi03dWW0bsAUEx6oEc6GkBARzuOB5Bd56EZgvHl3p+Qhh/l
	 wTJ5GwI+/Fb5RgFSwwvrFEg7LyET7jxkwLEJmdhMB/gQoO8UeNphW6gcBLdyYftWkn
	 Re9saPulldi+1hZZrR4bJYJ22P9Scg8GZIRQBzE4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 982E5F80059;
	Thu, 12 Nov 2020 16:07:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0CE9AF800D1; Thu, 12 Nov 2020 16:07:26 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E1F5F800D1
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2020 16:07:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E1F5F800D1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JaUO/9dn"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6296922201;
 Thu, 12 Nov 2020 15:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605193637;
 bh=9SajqhozCmxPRcduXSh1o5cD2wX32wozUPv/nxW6kGU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JaUO/9dn9KC2ZPrDIpthxwYR4rdAqU2XXTSb6n6cUIxYfbYuBxuiUqQmiaEdoGv9V
 gyFGfCkqEMSsZoCwcjrfLF2tE1Wl8AcLsj6jE6nGXSWQRu5QJ0HFK5wpcVo41VaO8Q
 Z+mF1amXQkuq0u8RLubgYbICKpQYwUKPNdpRJ0pw=
Date: Thu, 12 Nov 2020 15:07:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 3/4] ASoC: SOF: Intel: fix Kconfig punctuation and wording
Message-ID: <20201112150700.GA15030@sirena.org.uk>
References: <20201111213533.149963-1-pierre-louis.bossart@linux.intel.com>
 <20201111213533.149963-4-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20201111213533.149963-4-pierre-louis.bossart@linux.intel.com>
X-Cookie: To add insult to injury.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, tiwai@suse.de,
 Randy Dunlap <rdunlap@infradead.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2020 at 03:35:32PM -0600, Pierre-Louis Bossart wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>=20
> Add periods at the end of sentences in help text.
> Insert a "not" in one place.
> Fix help text indentation.
> Remove a duplicate "Intel(R)" in one place.

This doesn't apply against current code, please check and resend.

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+tT5QACgkQJNaLcl1U
h9BOHwf+Iu83tvs0ppjTJ1bOGqMpqKLioNGFyj5tRKkc/iysZDG+byqOfBMz6igT
pKQGFzeT1x2YW52viQwqnb4xOmES30qt2sPrQDawIovnXP4+8bbMb5Jo5bG7FRfn
1AryBdlQjJc80GfpYuN8/gefOgx7zzMYbguJex0MTs872CzPVOXajF1vVrugXcJO
C97OBbumo+HCk+1Jm8V8aGZRoO/iq5qR1nfJqtpggg/u+QXRKBmPRY/A/4YWw2ru
ivSAt+BURcpdt8r9rKJpnE1xxNzthCBkI2vrUs0oOb9OzRyTy3obHb1XTZPEJM09
fs/rgKL0FjzFDhhVrb4/aNTlE6rxNQ==
=XMZ9
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
