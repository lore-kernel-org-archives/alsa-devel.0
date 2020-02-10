Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DC1C352A3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:26:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D26E20863
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JVBCvAM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D26E20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DB2815F8;
	Mon, 10 Feb 2020 13:25:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DB2815F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581337599;
	bh=c7w3FPt5NyYNs1FbQIqGW/Ve64f5DqUTS8LBRXL52cU=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JVBCvAM6RfpPxWYt44Dx/i/qUnonLHd8duxeBfXDHzz0GOIm0Toj9aswLy8yjX7Qw
	 C+jnUW9UrnzMv7jnPRykb6ImMeUu+KNFQlxF5Se1JNcVg/ApBroK5nLT/m0Lr+kQOG
	 cPbqKAKKPj8itpsN/Ly0vamjTQaRYWDXbVmfwPXE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14ECAF80118;
	Mon, 10 Feb 2020 13:25:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE086F80157; Mon, 10 Feb 2020 13:25:47 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id EC9B2F80118;
 Mon, 10 Feb 2020 13:25:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC9B2F80118
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F976328;
 Mon, 10 Feb 2020 04:25:38 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93B453F6CF;
 Mon, 10 Feb 2020 04:25:37 -0800 (PST)
Date: Mon, 10 Feb 2020 12:25:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Message-ID: <20200210122536.GC7685@sirena.org.uk>
References: <20200131114355.17301-1-guennadi.liakhovetski@linux.intel.com>
 <20200210083300.GA20345@ubuntu>
MIME-Version: 1.0
In-Reply-To: <20200210083300.GA20345@ubuntu>
X-Cookie: Avoid gunfire in the bathroom tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
 sound-open-firmware@alsa-project.org
Subject: Re: [alsa-devel] [Sound-open-firmware] [PATCH 0/3] ASoC: SOF:
 VirtIO: preparatory patches
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
Content-Type: multipart/mixed; boundary="===============8545765884818136393=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============8545765884818136393==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2020 at 09:33:00AM +0100, Guennadi Liakhovetski wrote:
> Hi,
>=20
> Any comment on this?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5BS78ACgkQJNaLcl1U
h9A2QQf+Kk0Yt1GBxwyb8S6b+qgV7GesnuIqEHLA+6LCd9gnQtJFN5YxAjgYNNhu
TEDMZJUp2R9Z+qG4/5c7KRsYNaMqqf4YZWqnTy99Iyfc4/1aK83jQsGMuBEqkbWe
1TjflksIu9ZKdfj4zS4xtrMpCxIwfydRcPt+EkEOXrH+d5kU/CAVdB2v2jRW4FB8
5qouz4sJtQ+Zgufw6VEIU7XdeN4RZVw+betvVAWlVtcLpL2yK9JUT19ZMlweAIGq
FjkxxkntqPcgdPWG9RU0nqF3LA6idKe9h93zMn9LqDO4pem+3pfVD9opTwBepv8g
/TdddHAcfVCbGFn1ceI3V0Uqd3L3tQ==
=MhbC
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--

--===============8545765884818136393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8545765884818136393==--
