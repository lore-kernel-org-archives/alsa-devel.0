Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A436C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 14:46:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA9C62078D
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 14:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ob09SkgY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8p1ggFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9C62078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 77974166E;
	Wed,  8 Jul 2020 16:45:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 77974166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594219602;
	bh=cP+F+wz6n3hVoP8aNvSk5AWUDQcuCoNcjaP+vD3mi0c=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ob09SkgYTF1tp5SfhqLXmlp1Kco/fBNAcXev5UBkr1l2ad0B2wI6mCmnZXQUzm5I5
	 48kLYFg8tYC0QorwJMKwz6psxxiz33fp7Q+1So/CbWE97Jp4pugckljA1bCQ2Y05J/
	 m3Z15gc7soTGU06tFb6QFrNJnWSsXU9KCk5Jn5eU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE8ACF8015D;
	Wed,  8 Jul 2020 16:45:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F384BF80161; Wed,  8 Jul 2020 16:45:41 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EE533F8015C
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 16:45:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE533F8015C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="p8p1ggFG"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9595820786;
 Wed,  8 Jul 2020 14:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594219534;
 bh=cP+F+wz6n3hVoP8aNvSk5AWUDQcuCoNcjaP+vD3mi0c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p8p1ggFGPnEJteeBB95WXlg92wIy14eUukTWMJ98rTrbqwYdZcJBZGUYN+pWuCINt
 XKR5p/f/qA4r7A8X87MfvonfgMpiHzjS6QYwHMdhNYNt4sQzTkKwBnR2ZBo6G1r8c6
 /yDXSsapFaQp6Elc81pa5Frm12+eTa/cFMtCgq50=
Date: Wed, 8 Jul 2020 15:45:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v3 4/8] include: dt-bindings: sound: Add sc7180-lpass
 bindings header
Message-ID: <20200708144528.GT4655@sirena.org.uk>
References: <1594184896-10629-1-git-send-email-rohitkr@codeaurora.org>
 <1594184896-10629-5-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e7jIye1Ygp5H0AIi"
Content-Disposition: inline
In-Reply-To: <1594184896-10629-5-git-send-email-rohitkr@codeaurora.org>
X-Cookie: Oh Dad!  We're ALL Devo!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, plai@codeaurora.org,
 tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org,
 bjorn.andersson@linaro.org, agross@kernel.org, srinivas.kandagatla@linaro.org,
 Ajit Pandey <ajitp@codeaurora.org>, linux-kernel@vger.kernel.org
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


--e7jIye1Ygp5H0AIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2020 at 10:38:12AM +0530, Rohit kumar wrote:
> From: Ajit Pandey <ajitp@codeaurora.org>
>=20
> Add header defining dai-id and mclk id for SC7180 lpass soc.
>=20
> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
> ---

This one is missing a signoff as well, and I can't seem to see any
reference to this header in the bindings document patches?

--e7jIye1Ygp5H0AIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8F3AgACgkQJNaLcl1U
h9CXIwf/dPOevjBguwkthEqzY8waDrI4Vr76oqQ/VwaDcPs5ms8WZBlIduTiQwHe
LvggZGwuNjq49n6Yx7+vu+/uOJaTTRf99NF8bJ4FuS4aJK0VaCdUwLwwYE6xuSPq
tGc5B3e4rzdzrs+FJMmRZZ+a55RNU8MXP3j5LuecI7xlxRMifHIx8Nmn52GSI4RD
7YtEODCmd4xSh4KAEIydg9yzn8o/zMPqwv/jL8MNOEUol5x20FU4tnD2iRJ6E5Fx
n+yak8arDbKsLRjZH4xtGxhTrl4pKyeGOVrN12XcbiZupG2dDzmJi6LOR9P3HXQ9
ElQHfFZxIRiHgX9scCPEWtn0DlKV6Q==
=qOBi
-----END PGP SIGNATURE-----

--e7jIye1Ygp5H0AIi--
