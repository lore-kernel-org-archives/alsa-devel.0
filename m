Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A643C47409
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:37:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1A220842
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ItQ5FXxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1A220842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A2741671;
	Mon, 10 Feb 2020 14:36:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A2741671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581341856;
	bh=4E6Zpi5Zpnpb8hQDNHM/8pJuFSDNh8SKqRVVpb8+tCs=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ItQ5FXxKurnIbFC50wO3skuNexTtw40v/U8Lqr+qJ7NvlQlYUoBX6g9XEvT36cB/x
	 FT+Azz7v6VG7AEz3iPdXczPG7MQsrod+sSOHtUQw0OTvLgFTrHppbQQsEW7U4+SHt2
	 dS4rMa+U53Nwo+Gnm8mPSeiNzG/Rs9rfsXUcxdpg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3134F80158;
	Mon, 10 Feb 2020 14:36:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 44363F8020B; Mon, 10 Feb 2020 14:36:44 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 2C3B4F8014F
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 14:36:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C3B4F8014F
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAAE41FB;
 Mon, 10 Feb 2020 05:36:38 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FC653F68E;
 Mon, 10 Feb 2020 05:36:38 -0800 (PST)
Date: Mon, 10 Feb 2020 13:36:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Adam Serbinski <adam@serbinski.com>
Message-ID: <20200210133636.GJ7685@sirena.org.uk>
References: <20200207205013.12274-1-adam@serbinski.com>
 <20200209154748.3015-1-adam@serbinski.com>
 <20200209154748.3015-9-adam@serbinski.com>
MIME-Version: 1.0
In-Reply-To: <20200209154748.3015-9-adam@serbinski.com>
X-Cookie: Avoid gunfire in the bathroom tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v2 8/8] ASoC: qcom: apq8096: add kcontrols
	to set PCM rate
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
Content-Type: multipart/mixed; boundary="===============9073066257494648059=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============9073066257494648059==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wRtZRu2mMGBZ6YQ7"
Content-Disposition: inline


--wRtZRu2mMGBZ6YQ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 09, 2020 at 10:47:48AM -0500, Adam Serbinski wrote:
> This makes it possible for the backend sample rate to be
> set to 8000 or 16000 Hz, depending on the needs of the HFP
> call being set up.

This would seem like an excellent thing to put in the driver for the
baseband or bluetooth.

--wRtZRu2mMGBZ6YQ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5BXGQACgkQJNaLcl1U
h9AaBgf/S2n2UV3JEObzW9MyD7j/N5w4SvGvTVxS91cgeKu1rLXmmHjuWYZSkaf3
F5GLSWxp+xnfPHW3I1PioBN+E7uXVrbl4yioIysIumaqNFaSEfLvtmGZwCqY0jsd
n8bC+RS7QHYba/2TIGEBgKM2EsXYq+wzmbkh3Yck0VsV6N1JdXtqppOkL9uaLfU1
QesTdj6bYw+Ul7pRm4/whPeJP+Qot4l/Yc0vM1waMQ4/YCgWzPwH4/+lbO1hoZou
fe6kJPWTXV0sCG71B7xIeGnUnsrI53fPAk0ojiFY4EOvEGdFN7yvgMnjsn8cSsBY
9IE7v0TTt++29YGCUuAYhGAFqAw/2Q==
=LG8v
-----END PGP SIGNATURE-----

--wRtZRu2mMGBZ6YQ7--

--===============9073066257494648059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============9073066257494648059==--
