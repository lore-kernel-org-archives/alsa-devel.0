Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8CBC352A3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:18:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF2920842
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mLIieN7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF2920842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1913115E5;
	Mon, 10 Feb 2020 13:17:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1913115E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581337126;
	bh=mVTkRGr89pLZl3sPAAK1+2aSEe0yPBXWpkuHD1eG8Pw=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mLIieN7bwFtrDSCHC5TiLbp/pto71HDBmiX+GVep4HFT4HxjmM52v6jGpaIcLnAud
	 Uw7mHfYn9ev/7NqhPMhBCYYIhR7MZM9aD9TGLVZu0gylqSYneVD7jo3UeqtuMAEkJy
	 704WkvOIXj9qCgCI07fDMJH6qxjQnYhGGy6kFg9s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8FA22F8014F;
	Mon, 10 Feb 2020 13:17:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08E2EF80157; Mon, 10 Feb 2020 13:17:54 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id BFEFDF800E7
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 13:17:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BFEFDF800E7
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F32D1FB;
 Mon, 10 Feb 2020 04:17:49 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2383B3F6CF;
 Mon, 10 Feb 2020 04:17:48 -0800 (PST)
Date: Mon, 10 Feb 2020 12:17:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Adam Serbinski <adam@serbinski.com>
Message-ID: <20200210121747.GB7685@sirena.org.uk>
References: <20200207205013.12274-1-adam@serbinski.com>
 <20200209154748.3015-1-adam@serbinski.com>
MIME-Version: 1.0
In-Reply-To: <20200209154748.3015-1-adam@serbinski.com>
X-Cookie: Avoid gunfire in the bathroom tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v2 0/8] ASoC: qdsp6: db820c: Add support
 for external and bluetooth audio
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
Content-Type: multipart/mixed; boundary="===============3093734434877352859=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============3093734434877352859==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2020 at 10:47:40AM -0500, Adam Serbinski wrote:
> Changes from V1:
>=20
> 	Rename patch:
> 		from: dts: msm8996/db820c: enable primary pcm and quaternary i2s

Please don't send new serieses in reply to old ones, it can make it
confusing what's going on and what the current version is.

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5BSeoACgkQJNaLcl1U
h9AXcwf+JotBidwYRMp5BFxzyJd8AsD5K/bwUTlXwbhHdclwaupF2z3h0gGO18p0
tWogxstUFEdCAZVVYrkvF/+ft2+uTGq97dzwYNvmElu+aVxxCTpVFcPqmmupQs2Q
fbOxU0/JFCUjSeZtMd38eqINLOYZw2sAYdeBPpVA131kMdj4fG2G6Xc488cjr2Im
NijwBF7pTlc8patTM6m7FSMtfSHu9w9S7OEMC4TVA2rpdOCkINXatLaW8rMcf4WF
EnrKOYYrkNAb72uiwyhWDqVUcneFDq/dooPTA2pT3SZdV+FFW0eZ6XpLTYXepk1v
u9vqNNjvnMKE2W46nfIEdkuTS8D17A==
=uHcF
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--

--===============3093734434877352859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3093734434877352859==--
