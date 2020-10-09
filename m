Return-Path: <SRS0=04K1=DQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6A0C433DF
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:53:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD94222B9
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eTixrb75";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xYHb+/dd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD94222B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7CCC1850;
	Fri,  9 Oct 2020 15:52:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7CCC1850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602251613;
	bh=cwk9i4KBau0qPm27KzJl3XXeYfNbSm1YHxXTzmMkdOY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eTixrb75tWSn6t6YsJDrZVqEH/s2wnc9MF8F7BiQPD3uMntZj8YjN8cy3XhuSnQEi
	 ECCe/1wDr74UB3XuIlHWGZF+ihRimj/MtvOG6F5nZqouu4nDYX1dkpOW+1p22rUI98
	 vrZcQ9JIu9sScoWoxiKg1D0TR1h/9kQvsjgGwTRw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 136FAF8014D;
	Fri,  9 Oct 2020 15:52:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC9E4F8015B; Fri,  9 Oct 2020 15:52:40 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4F6D4F800BF
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2020 15:52:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F6D4F800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="xYHb+/dd"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 06B14222B9;
 Fri,  9 Oct 2020 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602251554;
 bh=cwk9i4KBau0qPm27KzJl3XXeYfNbSm1YHxXTzmMkdOY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xYHb+/ddD3CKObc4tAlrPj2U8OIa+LavQ5ml/H3KzlNFr+FetR8wU/W4lEzql2ywb
 9FTBXAY7aE7Ao54UCKQmnoTgMN2Gmd8ov1Xin4z8z1b3MJG7D7bVTD8f6VU63uo5K0
 86m35/V0p1MGv251jWFKJei8tgsXP2s9qeP1ITQc=
Date: Fri, 9 Oct 2020 14:52:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Ajye Huang <ajye.huang@gmail.com>
Subject: Re: [PATCH v1 1/2] ASoC: qcom: dt-bindings: Modify sc7180 machine
 bindings
Message-ID: <20201009135231.GA6655@sirena.org.uk>
References: <20200928063744.525700-1-ajye_huang@compal.corp-partner.google.com>
 <20200928063744.525700-2-ajye_huang@compal.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20200928063744.525700-2-ajye_huang@compal.corp-partner.google.com>
X-Cookie: Please take note:
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org,
 Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, dianders@chromium.org,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>,
 Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
 linux-arm-kernel@lists.infradead.org, cychiang@chromium.org
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


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 28, 2020 at 02:37:43PM +0800, Ajye Huang wrote:
> Add compatible "qcom,sc7180-sndcard-rt5682-m98357-2mic"
> for 2mic case.

This doesn't apply against current code, please check and resend.

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+Aax8ACgkQJNaLcl1U
h9BLUgf/bL/7/DLssH7LN6HzEKNltT4ltao9sKdRmjuIPgTA9rwYf3cazWimkZoo
ZbecRbpOKAPZ5ymsnWo1QAq9pNJ+ll5EwgqwiOmYPavfKpfNwULh10oE+wokLdJl
+1SuMACMFIHvnKzcwSydpEupP7uFfO01XLpGNoMOvvHITC3vuAETk9AthXKTSD02
N1TpmZdSCEbtfy81kvCk4NFFaTjmm4wB2MT93+uRKbwHVf/Xnv/hpXFsWo1glTfN
1p1K3dQ8V2G2tjq7E7+nKFC5DObjE7wSG0HQHH+8wTt3F2axIuPX6P2Vhjy9ZjSR
NEC32HzNHukUPp0j5dlyUr6izyD8Hg==
=HyGA
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
