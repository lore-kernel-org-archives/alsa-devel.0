Return-Path: <SRS0=OCx8=ZZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BDAC432C0
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:40:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E4F9206EC
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 14:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HQKRJUfF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="SVtk5WFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4F9206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28FE084A;
	Tue,  3 Dec 2019 15:39:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28FE084A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575384014;
	bh=75HFbY7DyFJRTzE/NLGtuM4lSKWXStDhwqAMB2NRv2w=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HQKRJUfFjyjmvkOVvSd+Hfr9z35fgj2y+H8a1Ds1tF3vnqIbMW6BQbo1ROdn3Wlwx
	 iSxhoW2lLYSc4IdoaLKdPPa2QwK2VdZwY5yZu2u2POnk5KgRdSWeS9hcjrEC79mzGY
	 8EhwB2t0Gf22fkBygb20r2+NRXOhp+HMmdfMvBOE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A416FF8015A;
	Tue,  3 Dec 2019 15:39:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D18BFF80227; Tue,  3 Dec 2019 15:39:21 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63E11F800B4
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2019 15:39:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63E11F800B4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="SVtk5WFR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Fp1zIL2SAEar9dlKMYM/RfsmIkwJExCTW8u8xALWSC4=; b=SVtk5WFRlwEs+eVTFb0dxpn/a
 +g7p4XXuEkIrnH0632RPHUvw2hjP1m+sPepNvWNLcm3CfleuHd95OCxIO5RnaEgCeHgWjVhcQR29g
 14ZZZhbHLQvrHxt+snCURi55qiO4J1T/wTKzvL/UZ4nHok/xkXdTqC5Rro5rT270VGApE=;
Received: from fw-tnat-cam1.arm.com ([217.140.106.49]
 helo=fitzroy.sirena.org.uk) by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.org.uk>)
 id 1ic9KY-0002mV-9f; Tue, 03 Dec 2019 14:39:10 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
 id 03672D003B4; Tue,  3 Dec 2019 14:39:10 +0000 (GMT)
Date: Tue, 3 Dec 2019 14:39:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Olivier Moysan <olivier.moysan@st.com>
Message-ID: <20191203143909.GL1998@sirena.org.uk>
References: <20191203141627.29471-1-olivier.moysan@st.com>
MIME-Version: 1.0
In-Reply-To: <20191203141627.29471-1-olivier.moysan@st.com>
X-Cookie: Cleanliness is next to impossible.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, alexandre.torgue@st.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
 mcoquelin.stm32@gmail.com, apatard@mandriva.com,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH] ASoC: cs42l51: add dac mux widget in codec
	routes
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
Content-Type: multipart/mixed; boundary="===============0054128262200613474=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============0054128262200613474==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kaF1vgn83Aa7CiXN"
Content-Disposition: inline


--kaF1vgn83Aa7CiXN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2019 at 03:16:27PM +0100, Olivier Moysan wrote:

> -	SND_SOC_DAPM_DAC_E("Left DAC", "Left HiFi Playback",
> -		CS42L51_POWER_CTL1, 5, 1,
> -		cs42l51_pdn_event, SND_SOC_DAPM_PRE_POST_PMD),
> -	SND_SOC_DAPM_DAC_E("Right DAC", "Right HiFi Playback",
> -		CS42L51_POWER_CTL1, 6, 1,
> -		cs42l51_pdn_event, SND_SOC_DAPM_PRE_POST_PMD),
> +	SND_SOC_DAPM_DAC_E("Left DAC", NULL, CS42L51_POWER_CTL1, 5, 1,
> +			   cs42l51_pdn_event, SND_SOC_DAPM_PRE_POST_PMD),
> +	SND_SOC_DAPM_DAC_E("Right DAC", NULL, CS42L51_POWER_CTL1, 6, 1,
> +			   cs42l51_pdn_event, SND_SOC_DAPM_PRE_POST_PMD),

This looks like an unrelated formatting change?

--kaF1vgn83Aa7CiXN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3mc40ACgkQJNaLcl1U
h9CUawf9E5BprJC3A8QmnT0q77HnN92qqStvFvpZ7Q+v1APD/Orb+E4kskU/mHiN
B5qpYUUgoYUGyeTSG4nlSpBOG6nG2O7cpuaGz0ObLfybVJRGI7UgTIU+OtMm34DL
HzyhFvaYhg7xYbtj0m2LNLEgUWTwY2L7ktbZachaCpAjDs9IRSE/Eint/DSKl5SN
2X+nFXeDTl7Ig0vE26pukGume2hbhrnozhZIU1P4r4F965QBd4T2/490LXOWandk
xTCSMOJIkL7SBsXSlu2nwY6vYn9QBsuF/OMSfC1VqY05lxeqCcg/RJZLJj2aKizM
kPKMYjCzJLneVYT+7IsywZGFeIfH2Q==
=Bvzr
-----END PGP SIGNATURE-----

--kaF1vgn83Aa7CiXN--

--===============0054128262200613474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0054128262200613474==--
