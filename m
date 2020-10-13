Return-Path: <SRS0=Nc9k=DU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABB8C433E7
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:16:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE8D24900
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2020 15:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uYhU3std";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLfoZ6Wq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE8D24900
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 447551690;
	Tue, 13 Oct 2020 17:15:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 447551690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602602178;
	bh=VQiYIkv8JxDfMCqXetCvnsQqRv/qB9MbycuOck8T+Ao=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uYhU3stdxZ/Mu5fcB2booVe5ZWg074y0od+alSTznfIywj0QWOnQFSZixrkcF+2CM
	 RPER32fey7ym8av2e/ngJGbkVADIvBYr40V9pmdG0RBKUkUaUrFVeGHR1T4PDPo7sH
	 9ndJ+LtFztFcq5XnfSOLEB6CCF+Z81vf/qhpMXSA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1D3CF8012C;
	Tue, 13 Oct 2020 17:15:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7670F801A3; Tue, 13 Oct 2020 17:15:25 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B36AEF8012C
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2020 17:15:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B36AEF8012C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jLfoZ6Wq"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 95D1B22280;
 Tue, 13 Oct 2020 15:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602602111;
 bh=VQiYIkv8JxDfMCqXetCvnsQqRv/qB9MbycuOck8T+Ao=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jLfoZ6WqFkBvsSOi2DL42qgNuMVnWoeJJ1W684kMk61N+vmj/UKCQMqrOU+Aa+ht/
 D9uxHx9VrdLIDlJ2+r49BP3AUDyCtc0Zq3fTpLvyJEdSVB55hzVfiZ4nuDBBVsO5um
 ROs0AY2Z/8Gkt3m6S/l8/N5NgNjE25qvwsLVQTNw=
Date: Tue, 13 Oct 2020 16:15:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: Re: [PATCH 1/2] Asoc: qcom: lpass-cpu: Fix clock disable failure
Message-ID: <20201013151505.GA7913@sirena.org.uk>
References: <1602596386-9886-1-git-send-email-srivasam@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <1602596386-9886-1-git-send-email-srivasam@codeaurora.org>
X-Cookie: Great minds run in great circles.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, V Sujith Kumar Reddy <vsujithk@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, bjorn.andersson@linaro.org,
 agross@kernel.org, srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
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


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2020 at 07:09:46PM +0530, Srinivasa Rao Mandadapu wrote:
> From: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
>=20
> Disable MI2S bit clock from PAUSE/STOP/SUSPEND usecase
> instead of shutdown time. Acheive this by invoking
> clk_disable_unprepare API from cpu daiops shutdown to
> cpu daiops trigger.

I'm missing patch 2 here?

> This Fix is update to the below patch.
> https://lore.kernel.org/patchwork/patch/1308101/

Fixes should be specified using tags like this:

  Fixes: commit 30fb9454ab23 ("selftests/vm: hmm-tests: remove the libhuget=
lbfs dependency")

in the changelog.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+FxHgACgkQJNaLcl1U
h9CSsQf6AgNY/ragXX+c9/6OMzAPmShAvnTqYcTGy6bV8AK+nCQjYvWCS789YO1q
bUzkSCTOMLQHtcHiUKSGB+mpn8djofZCg+rSsC1thvIzpcuTZKutgDOT36/EyCCV
u81NfxpjYVAajwjwfm010VLi2FaA5duXh8jsi3COrIO3z81ySMxK4ZTAo4BAAZDl
Glh8soX7WO3aE26ei4zrfPUYsq1ZR4eEzFJ7AVip3mvLeMajeOg8FLXJ8lPPgr1K
nd32a6EXpZEZGPYA6W0uyByMajSokRh4uXMQdT2NmdXVRuhnz4UyQsE3bEiGsuAe
2AhG0/MJQMi6amyafwZfTOpLHdfubQ==
=hBwr
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
