Return-Path: <SRS0=ZYEx=2B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F877C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:35:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF53214AF
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Z53AvH8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF53214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64F051616;
	Wed, 11 Dec 2019 17:34:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64F051616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576082118;
	bh=FjSXaaeIfEQTuby2YP63T39o8tIFAigRoF/PSW9iw3A=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z53AvH8zdHjoqgTS/tCorSJ9R8nZ0RqR/4JeDjhr3NM11uqfvzRsM+WUiCHXT/vCK
	 aldFKqjuA1KlNsv0tEW+Nt99O1YfUhX/SJBt3i9lFKj3JvCeioR5vOa9QNsZMt9nP+
	 aLjy3rwNL6xgPUQplWgNYwPFF/Dld3b8fTGU7z2s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D98C4F8019B;
	Wed, 11 Dec 2019 17:34:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76671F801F4; Wed, 11 Dec 2019 17:34:25 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 0FF19F800EC
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2019 17:34:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FF19F800EC
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D55130E;
 Wed, 11 Dec 2019 08:34:21 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FA2F3F52E;
 Wed, 11 Dec 2019 08:34:20 -0800 (PST)
Date: Wed, 11 Dec 2019 16:34:18 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Message-ID: <20191211163418.GE3870@sirena.org.uk>
References: <20191210145406.21419-1-tiwai@suse.de>
 <20191210145406.21419-15-tiwai@suse.de>
MIME-Version: 1.0
In-Reply-To: <20191210145406.21419-15-tiwai@suse.de>
X-Cookie: NOBODY EXPECTS THE SPANISH INQUISITION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH for-5.6 14/23] ASoC: sh: Drop superfluous
	ioctl PCM ops
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
Content-Type: multipart/mixed; boundary="===============1446543630741484510=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============1446543630741484510==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GxcwvYAGnODwn7V8"
Content-Disposition: inline


--GxcwvYAGnODwn7V8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2019 at 03:53:57PM +0100, Takashi Iwai wrote:
> ASoC PCM core deals the empty ioctl field now as default.
> Let's kill the redundant lines.

This doesn't apply against current code.

--GxcwvYAGnODwn7V8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3xGooACgkQJNaLcl1U
h9CDsAf/QtmvYz9S1zv1JrjEr81AuUj1XuqOcNkNjYXYTx3iYFMwB0p9qA/+q+Su
fXftuGbCtOgscUfpm3i+YrbibhaIoKr49t+jcIRql+3KqNm0Ptps44nB6Yjrd0LD
iADlQD7y3Aha9lmKXN+w5eb9mfQ46cj4Xv0VSpWVj+F1U8boHAExXdyXcplg9jZq
8RykRyYIYQXoN86pY17D4hCK2e4rIcypoM3xqhu3YIdtPoJ/8aaY0/req2ARXetj
62RXCUwILSYpTJa0FVxLEu75kf2hIjYz4iVAOZIpkPg+O6BwwFBLmbJgX7LZ7Wfm
oyAMuO3HGvAm15C7ijK2tfV1EoaKKw==
=u6hv
-----END PGP SIGNATURE-----

--GxcwvYAGnODwn7V8--

--===============1446543630741484510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1446543630741484510==--
