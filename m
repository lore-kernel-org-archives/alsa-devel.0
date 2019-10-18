Return-Path: <SRS0=bEgE=YL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB13CA9EA0
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:43:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB5AA222C3
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WSm4V/Hq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Tnve+d6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5AA222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D7DA582B;
	Fri, 18 Oct 2019 20:42:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D7DA582B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571424214;
	bh=Xj21xOHfx4dxkvCd1Nyd2lMO/qrJ5yDSn4ANc9rkRXE=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WSm4V/HqRREdnbM61cPt8Z+bbvqepslnURCDKl8kP+lrl5+V92ZAsgB9G5zcjD/5Z
	 cVgvmgUuOOcJsnGeSwArIrX5PN22VExnnGGwyHDOnvCxyJ48eKTwUUDSQeWZwyIpjc
	 avwI8GHDh/F50unBbeKHKEjy2Y8dNkLB6lk5b8CI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63B8AF80323;
	Fri, 18 Oct 2019 20:42:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 43B7DF80362; Fri, 18 Oct 2019 20:42:42 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BBAC3F800D0
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2019 20:42:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BBAC3F800D0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="Tnve+d6c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vL9H+9/RLGnQWWp4nUhHSA5PaWdyyUffShvgM8LDMQw=; b=Tnve+d6cDI8Zt/OhjcmA2pC2B
 tDtWgw88wNUXyjYVd3LYnu0U71Y3EnSrRuF/UzSDHC3Mkz15H34vWrDv0I1dRWhPNKQTJyVvs6d5L
 DtrIdEn68Ti7JG5oSfiFIH38nY42D5by6mMstgXo44qp2u3FrqLVFyhq0rNoPJxMmDN4A=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iLXCx-0004NN-21; Fri, 18 Oct 2019 18:42:39 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 4A2D42741DEA; Fri, 18 Oct 2019 19:42:38 +0100 (BST)
Date: Fri, 18 Oct 2019 19:42:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Message-ID: <20191018184238.GD4828@sirena.co.uk>
References: <20191017213539.00-tzungbi@google.com>
 <20191017213539.07.I5388b69a7a9c551078fed216a77440cee6dedf49@changeid>
 <20191018172220.GC4828@sirena.co.uk>
 <CA+Px+wXCjaP1uktHLffRCe2C1P_D21f2+A=HDdhutoGv-BVzZQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+Px+wXCjaP1uktHLffRCe2C1P_D21f2+A=HDdhutoGv-BVzZQ@mail.gmail.com>
X-Cookie: Smear the road with a runner!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Gwendal Grignou <gwendal@google.com>, devicetree@vger.kernel.org,
 ALSA development <alsa-devel@alsa-project.org>,
 Jimmy Cheng-Yi Chiang <cychiang@google.com>,
 Nicolas Boichat <drinkcat@google.com>, robh+dt@kernel.org,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Benson Leung <bleung@google.com>, Dylan Reid <dgreid@google.com>
Subject: Re: [alsa-devel] [PATCH v4 07/10] ASoC: cros_ec_codec: support WoV
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
Content-Type: multipart/mixed; boundary="===============0167169865725762606=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============0167169865725762606==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Content-Disposition: inline


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 19, 2019 at 02:39:20AM +0800, Tzung-Bi Shih wrote:

> Could you tell me how you get the .config (to enhance my local build
> tests next time)?  I tried randconfig several times but it seems not
> easy to hit the case (i.e. CROS_EC_CODEC=y but CRYPTO_*=n).

That one was caught using merge_config.sh to merge in the config below
then have a script that turns on all options in my subsystems and MFD.

CONFIG_COMPILE_TEST=y
CONFIG_OF=y
CONFIG_I2C=y
CONFIG_SPI=y
CONFIG_REGULATOR=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SOC=y
CONFIG_SND_SOC_ALL_CODECS=y
CONFIG_SPMI=y
CONFIG_NLS=y
CONFIG_SLIMBUS=y
CONFIG_CLK=y
CONFIG_DMADEVICES=y
CONFIG_PCI=y
CONFIG_ACPI=y

--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2qB50ACgkQJNaLcl1U
h9CgCAf+PKAGMjGbyNjrM3ul2W9lHj8LB2sFoTtX/ynPK4k9veA707e4TUD9jhK4
H/W7IVj6OgtizWbeQPgFvW2bHyZoc8KBqnrbvyWRf17KEwnuErupBw75uCRlP/S9
n/eh/YzFhgHNvUNfzwWAjmgCA4iw5pVf6lBWooDbbeDx2KVPl38Z//+1PgWP+cNy
1ZEdHTidjKewTdQoy8cqrRX0oQXzs2V05oYdvZssWklyTywANvANzsDS+/aapKCj
LbXwhygk2xImXq9XVHIPGmQmRCbLimEwWzhcMkykfmMF0NcJFUXmLMtr0lF3+PBa
WHyuO3Z/gbo293M87rP57al0ZXxkCQ==
=GT10
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--

--===============0167169865725762606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0167169865725762606==--
