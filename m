Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B0FC3F68F
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:44:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345E220848
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 11:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fusrruUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345E220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B392166D;
	Tue, 11 Feb 2020 12:43:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B392166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581421473;
	bh=lFUi3K7vg4/U+PsBI6FzUBVeJ7QCgx5008qtl3yFArQ=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fusrruUHUM4YIj1O4m1zOLXKLeWb1rOYdP6Hp53g+JkoSE2DhoQqXdUzL6AA+CJe7
	 Xn2CTe+OKE7xXB01qZcMUrqli/uNUp9FgGN/4lt5QYqnpCoh9RtM8Wpw6FWiXuGe9G
	 ZjGekP1DlaZmAYtZ5h2p7qQRwf0tzc6HrbqfxztA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 533D8F800E7;
	Tue, 11 Feb 2020 12:43:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2B09F801DA; Tue, 11 Feb 2020 12:43:02 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 6E107F80145
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 12:42:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E107F80145
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F48231B;
 Tue, 11 Feb 2020 03:42:58 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C78C33F6CF;
 Tue, 11 Feb 2020 03:42:57 -0800 (PST)
Date: Tue, 11 Feb 2020 11:42:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Adam Serbinski <adam@serbinski.com>
Message-ID: <20200211114256.GC4543@sirena.org.uk>
References: <20200207205013.12274-1-adam@serbinski.com>
 <20200209154748.3015-1-adam@serbinski.com>
 <20200209154748.3015-9-adam@serbinski.com>
 <20200210133636.GJ7685@sirena.org.uk>
 <18057b47c76d350f8380f277713e0936@serbinski.com>
 <20200210182609.GA14166@sirena.org.uk>
 <f88d21773f47f5a543a17ad07d66f9b7@serbinski.com>
 <20200210200839.GG14166@sirena.org.uk>
 <7c57801d8f671c40d4c6094e5ce89681@serbinski.com>
MIME-Version: 1.0
In-Reply-To: <7c57801d8f671c40d4c6094e5ce89681@serbinski.com>
X-Cookie: Hire the morally handicapped.
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
Content-Type: multipart/mixed; boundary="===============0426781921403778823=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============0426781921403778823==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 10, 2020 at 04:13:52PM -0500, Adam Serbinski wrote:

> I am not aware of how this could be done for bluetooth, since the value
> still has to originate from userspace. The driver you referred to supports
> only a single sample rate, whereas for bluetooth, 2 sample rates are
> required, and nothing in the kernel is aware of the appropriate rate, at
> least in the case of the qca6174a I'm working with right now, or for that
> matter, TI Wilink 8, which I've also worked with.

There's generic support in the CODEC<->CODEC link code for setting the
DAI configuration from userspace.

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5Ckz8ACgkQJNaLcl1U
h9ALGQf/Ss3ZIdJmQ7t1NLJpgkPvfgCHptgk+NO5wYCwd0pQJbzaflRdG45mcDPG
bQRKfEaZEqvPWxASdTQTiFdmJg6zLqlvkQYPcor4DCPcB1bCkPS9hkeOSUxXSsOa
ICLmJPQyoUqNyb6pHa6ghgfdVRPIr+GWPn0Zob/QpwybzWKBA7VHKmTEnxGDIq0z
pLzYVaV03fmVkJUowVTUdZ40LP8mjTWVcXnk/NzM1qEs3T39Q6DmAUyR7IemHBBf
wJr/MPk4Nr/9nPsmtD+5eJIG6m68tUximFPFeYIfid+WrHlY68RVcpgOBUG4LuvT
ENG+UsqfuA8Olmmq+tnZG3Imx6tmzg==
=pysG
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--

--===============0426781921403778823==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0426781921403778823==--
