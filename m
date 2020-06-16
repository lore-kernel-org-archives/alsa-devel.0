Return-Path: <SRS0=xZai=75=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D6EC433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 08:41:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEBE120644
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 08:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PV37yB4L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HazHfm8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEBE120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2EB9C1615;
	Tue, 16 Jun 2020 10:40:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2EB9C1615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592296878;
	bh=D1KwiAUn88OiFtooJuIFB9Zn8vRKLnDTMmkrIkmjR68=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PV37yB4L+YtJFbPg3WApXN6W7h92GnMFvoyO/0vqWoP21Kh/kWliKTI5885YZj5Kz
	 7ASQYP4qSdzMsWE8nHyyezmRunzmO7aHgBbONk+xP1EenekQK0CQS3EyNHGrwd6hDf
	 l2dCobXbQ8S9nrNJDk0KzwzV9BhCIdk5oaqaao3s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 83B7EF80217;
	Tue, 16 Jun 2020 10:40:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D10FF8022B; Tue, 16 Jun 2020 10:40:25 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03D97F800EF
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 10:40:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03D97F800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HazHfm8g"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E192420644;
 Tue, 16 Jun 2020 08:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592296820;
 bh=D1KwiAUn88OiFtooJuIFB9Zn8vRKLnDTMmkrIkmjR68=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HazHfm8g0gLHALwKVq750TzWuy7RqLiX0smxtYtjtVfko6XGESlHQCoOs8goiDKkq
 EpoRnJTVHsSxL6L1H2MaeEjfekr5wZaV9oTu+/w+FeM/yaswesWBB4Yix1DGvFvpKZ
 9+Xle8tSpVtpevk2sfkSO859zMKwJpPGKpXNMTzA=
Date: Tue, 16 Jun 2020 09:40:18 +0100
From: Mark Brown <broonie@kernel.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [RESENDx2][PATCH] sound: qcom: Kconfig: Tweak dependencies on
 SND_SOC_SDM845
Message-ID: <20200616084018.GG4447@sirena.org.uk>
References: <20200616063417.110263-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pVF9EYSGkiif4dMH"
Content-Disposition: inline
In-Reply-To: <20200616063417.110263-1-john.stultz@linaro.org>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>,
 lkml <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rohit kumar <rohitkr@codeaurora.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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


--pVF9EYSGkiif4dMH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2020 at 06:34:17AM +0000, John Stultz wrote:
> CROS_EC isn't strictly required for audio to work
> on other SDM845 platforms (like the Dragonboard 845c).

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--pVF9EYSGkiif4dMH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7ohXEACgkQJNaLcl1U
h9CG/Af/ceDDlITCWmAjvFYAY2eZevnFHCVPhH4Dw7Thfl049807+vh11NAvv2+F
2gcw0B2MUXD57nlvkIYGpJp/MbrUj05+jYjHCifVcLDOVDWgaVUTnqKOCN2t7wmT
Sri8WAslYCAw37pUN1++DMpYII8v8ROfqO0MhKsq3dgqiWGkEIyZuaJAeH0q/u4P
d1/C6JiRSxjx+7KidvRfkAu8eov4fCZUxqn6XMuvvMcTJTqVuWnjqHmEpZw5s8Jd
Er4RwfxpT95g+wGjdAdGMWJCdm1GRkcPus0zlExMHwQDZMESKcdq3jPxV5H8fVh9
Ccl1xk7tkLSC5p/mnsXeulMh0M2g/g==
=Gwvo
-----END PGP SIGNATURE-----

--pVF9EYSGkiif4dMH--
