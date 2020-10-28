Return-Path: <SRS0=HcWj=ED=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EB4C4363A
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 21:26:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC61024840
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 21:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qaKYHf+M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrHWrlJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC61024840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 31E81828;
	Wed, 28 Oct 2020 22:25:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 31E81828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603920368;
	bh=GJYr0kQ5tQclKFUAWNHS/HPkX2rE4VXTuAgt6K8K3sU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qaKYHf+MWvm9aiz69VmcstbK0+1+FmcMvnFjebONXmyUwxk+PoBBJCFhglcqWxSJS
	 U1uRgykkL8vaASWuOTV1m7ptKSSovWRQVqHB2AF2DHaBG3IABkw5RAmLb/vpAL0vCZ
	 FeOlV2i/LG7ouqBvlZVd5QYmmOh/dSZLUifVho0A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B7923F801D5;
	Wed, 28 Oct 2020 22:25:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51C3BF80212; Wed, 28 Oct 2020 22:25:16 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16988F80134
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2020 22:25:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16988F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="NrHWrlJZ"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9B73A2483C;
 Wed, 28 Oct 2020 21:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603920312;
 bh=GJYr0kQ5tQclKFUAWNHS/HPkX2rE4VXTuAgt6K8K3sU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NrHWrlJZKlc5ihemz0VmfxNgxWCyJN5iXcB5ZTjHBIWIo+VoffwEF90ALfUJtbmFt
 9kfSYka9iSSe8f2tj+hDXjWCo+UHps1QG6MmhLdZy7MMy30tjcKoCgWePeL06uPz21
 cHvSw+v9Wch4ogLxrKprt3tVCVIFBzdYeOxZNgnM=
Date: Wed, 28 Oct 2020 21:25:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: Re: [PATCH v2] Asoc: qcom: lpass-sc7180: Fix MI2S bitwidth field bit
 positions
Message-ID: <20201028212506.GB6302@sirena.org.uk>
References: <1603798474-4897-1-git-send-email-srivasam@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
In-Reply-To: <1603798474-4897-1-git-send-email-srivasam@codeaurora.org>
X-Cookie: Allow 6 to 8 weeks for delivery.
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


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2020 at 05:04:34PM +0530, Srinivasa Rao Mandadapu wrote:

> Update SC7180 lpass_variant structure with proper I2S bitwidth
> field bit positions, as bitwidth denotes 0 to 1 bits,
> but previously used only 0 bit.

To repeat my previous feedback:

| Please submit patches using subject lines reflecting the style for the
| subsystem, this makes it easier for people to identify relevant patches.
| Look at what existing commits in the area you're changing are doing and
| make sure your subject lines visually resemble what they're doing.

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+Z4bEACgkQJNaLcl1U
h9AvIQf8DyFuw//44sZKS76tGkYUI5e63r0TFIgniukPLkySfUIpx+onvitdbnoF
d5kB+XFMTSPLebTNF3+bdb3fzWLYlhWL0zr5UPL/P9+is6DwLji3NOT2Qlh9oMLQ
WGcBl/NaliM2uxVnPB7eByEOpZAuPd61K+lhM6Mg8nlKroMZqJFUpN/D0asYhS4z
r4Grz87b4Ncgtwq0EZ9pOA9Y1AVPN7w2YUh9qLEAf10i99Z0gXDwBZusY76Ffn3g
ExRlnD73EUQPf4YX97Ey7B9vWjmGxZL6a3HnHHwU4YItA7Dio7CX7NDak0mQYWBs
C10XnhMfKVhxDsy5nhtTnYQI81Y60A==
=mqF7
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
