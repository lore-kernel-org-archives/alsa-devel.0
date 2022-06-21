Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A8EC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jun 2022 13:12:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 544FD2069;
	Tue, 21 Jun 2022 15:11:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 544FD2069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655817158;
	bh=4xEME0PJkdFrWYpmGq18CjMHFdjMkxkM8iVMwtol8e0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o1SRQfIjLcvxVYI8BBR+JYIeq6B8Tc+B09iI4F3KYZ7AEc4XnwtU6r7NlW2JtBjGK
	 dmhCuCzA1j5CbbfU3hN5JBT0WfeWHYexKMaHIi0Idbt6wsEocp0uTx4fKhbzNPtIkL
	 9hxA6vsp+23puLfKbPrH1rY58mV5ggvEXqLOmRD8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D715EF80152;
	Tue, 21 Jun 2022 15:11:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3399F80155; Tue, 21 Jun 2022 15:11:46 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E3F9F800E3
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2022 15:11:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E3F9F800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="eUVPXq0o"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6E9C9B817F4;
 Tue, 21 Jun 2022 13:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA18C341C4;
 Tue, 21 Jun 2022 13:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655817102;
 bh=4xEME0PJkdFrWYpmGq18CjMHFdjMkxkM8iVMwtol8e0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eUVPXq0oGf0ynQ+mmppKszQbX0ExCvwwwyzClTkcVE2WThQMGV7mvgtdtLwZi9kpe
 dDtkTM9jnjSnDNtlRJewWC2apC09nfHB0duGnIXX0vqBCDd2TgvrAQUuRzZP/zIVMI
 Qpxjuj6zkn5CTumFR0+GSS6TqhPfsPduG/ILTsZ028IBm564m0B90BDHOesyPEfIDJ
 lgcjqomPUoKP17Xs6KIlERtTK2y7LLH3NVb06Zrn7GoO6wqzZKmX5zptHYXZ/71NYW
 AIei+ef2lro1GS4HLIqKo7DmO+D52U9EVKbAKnLXvmtcoi3VNenn9OmHeZRQM95nvV
 l6dTKpR7L08qQ==
Date: Tue, 21 Jun 2022 14:11:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierluigi Passaro <pierluigi.p@variscite.com>
Subject: Re: [PATCH 4/4] ASoC: wm8904: add DMIC support
Message-ID: <YrHDh6lzdZXj7HcQ@sirena.org.uk>
References: <20220307141041.27538-1-alifer.m@variscite.com>
 <20220307141041.27538-4-alifer.m@variscite.com>
 <AM6PR08MB4376411B180D8860E2AD3AE0FFB09@AM6PR08MB4376.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zPDn0Yp+KJI2UZco"
Content-Disposition: inline
In-Reply-To: <AM6PR08MB4376411B180D8860E2AD3AE0FFB09@AM6PR08MB4376.eurprd08.prod.outlook.com>
X-Cookie: Edited for television.
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
 "tiwai@suse.com" <tiwai@suse.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 Eran Matityahu <eran.m@variscite.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 Alifer Willians de Moraes <alifer.m@variscite.com>,
 "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
 "festevam@gmail.com" <festevam@gmail.com>
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


--zPDn0Yp+KJI2UZco
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 20, 2022 at 07:53:56PM +0000, Pierluigi Passaro wrote:

> > This means that DMICDAT2 is not usefully selectable at runtime, you've
> > got IN1 as digital and IN2 as analogue, so while the DMIC/ADC switch is
> > useful the DMIC1/2 switch is not.

> A customer could have the following working configuration
> - pin 1: DMIC_CLK
> - pin 24: LINEIN2R
> - pin 25: DMICDAT2
> - pin 26: LINEIN2L
> - pin 27: DMICDAT1

> with no shared pins: here there's the chance to select DMIC1, DMIC2 and
> LINEIN2 at runtime: I can't find a reason for a fixed behavior.
> Can you please elaborate ?

So in that case the driver should offer the DMIC1/2 selection.  The
driver should be looking at which pins are wired up as DMICs and only
registering controls that can actually be used in the system based on
the pins that are wired up.

--zPDn0Yp+KJI2UZco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKxw4YACgkQJNaLcl1U
h9BfeAf/UZDQPNisaKHZIdpACSlbsSETLopyOjBB/groSLMQsNWcxbfkFhXkhdZS
mASQEVcOrYDiXD7yh6dcIeBAys+tfFZkrbX5YVBy+3sMm9jufXa7k3gbcJ6fA5rx
ARo7N0DMY9I2YqAkQ6dtTOxIicnYMxWJibPLagGEc6WiGGbi1CfnlZJ8UmHKTy7T
CFIAQes0bK4R26y7dZW7ogoSAClxlwImn9pLvrkwEh9VppUsP7XR/SauygBUsl3g
8gR9o1PjcVI3heKldnX1mQrzN13oJfBm2Vjd+7VGl8cLs3ZaQ8cx4dAgt+zj1JTF
7EXAU2zpt9gbnFQhQXfk+PuFpldzwA==
=5L+0
-----END PGP SIGNATURE-----

--zPDn0Yp+KJI2UZco--
