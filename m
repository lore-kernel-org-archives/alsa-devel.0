Return-Path: <SRS0=7kYh=DW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C7BC433E7
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:13:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632272222E
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Oct 2020 15:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nA/IkMuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632272222E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 87119177B;
	Thu, 15 Oct 2020 17:12:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 87119177B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602774820;
	bh=NRD123oRwVp/oFO3LLTCGduyvF6hvBl1xT+XkR0AU8w=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nA/IkMuJeExKwpQCjLVvSHb+HRH1ZxQhc90D4Q9f3FMPSMkwpwE7ASQ+B0WCHLNUx
	 oJ31GCsvd9dj44y7AMPDZB0hMBbcB0negNTIeJmGVJoQWSaLPXIG1m/6K7FklwqM7t
	 C8ez05ffF6ZraGJG7oMEApr5iYYmiy0hu6S8AuXU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2840F8012B;
	Thu, 15 Oct 2020 17:12:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28C08F80268; Thu, 15 Oct 2020 17:12:47 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97906F8012B
 for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2020 17:12:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97906F8012B
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C0DDAB215;
 Thu, 15 Oct 2020 15:12:43 +0000 (UTC)
Message-ID: <5d2587193f0e99996445d5fa507a8acf7854fed3.camel@suse.de>
Subject: Re: [PATCH 6/7] ARM: dts: Add dts for Raspberry Pi 4 + Cirrus Logic
 Lochnagar2
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org, 
 robh+dt@kernel.org
Date: Thu, 15 Oct 2020 17:12:42 +0200
In-Reply-To: <89913f8b-fe92-1a31-77ff-49ea3f3d3294@opensource.cirrus.com>
References: <20201014145418.31838-1-rf@opensource.cirrus.com>
 <20201014145418.31838-7-rf@opensource.cirrus.com>
 <e9db1a11519dce0938cef867179160a818ec4143.camel@suse.de>
 <89913f8b-fe92-1a31-77ff-49ea3f3d3294@opensource.cirrus.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-wR3GXQKBq2t5YgGG69As"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
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


--=-wR3GXQKBq2t5YgGG69As
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-10-15 at 12:14 +0100, Richard Fitzgerald wrote:
> > Sadly I don't think creating a new device tree is a good solution here.=
 If we
> > were to do so for every RPi hat/usage it'd become unmanageable very fas=
t. There
> > is a way to maintain this in the open nonetheless. I suggest you build =
a DT
> > overlay and submit it to https://github.com/raspberrypi/linux, see
> > 'arch/arm/boot/dts/overlays.' The Raspberry Pi engineers have a kernel =
branch
>=20
> We want something in mainline so that it can be used by people
> developing on mainline and taken as a starting point for configuring
> the codecs for other host platforms. The RPi is a convenient platform to
> use as the base because it is widely available and low-cost.

If what you want to convey is the proper way of configuring your specific
device the way to go is writing a devicetree binding. See
Documentation/devicetree. It's even possible to validate a given devicetree
against the bindings (given they are written in yaml format).

Regards,
Nicolas


--=-wR3GXQKBq2t5YgGG69As
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+IZuoACgkQlfZmHno8
x/6UGggAt9GsMB6HXXU+ftt+RxftKWleDKPspOiHmcX1jY7Xjr1MPqY/uGNypAHI
OeFqKdZgPo0/F7K6BRmpgOOkbrQ4yr09nbVSWafOur/q/FVa+zQiw6aqMoD8U2Ni
Q0aMoSKC086s6UG4bKw5KmoP9OVIuqGxFU+yqHS9ujotBHitTx0GHNY7IPpQvHwp
Mu8rvSyTrvYmG84IuF3SZs7mrIUltxGK1t3nqwkGr+XAFDKAQwQKFD2FWtduPYeA
0Ii/t4Fdf85iplTGIrgWh+qm25+hB6hWZkS/zbgVkdrj3Crfx/Wwq0a7P5DiPb18
qInpkyS6QUxic82H6FOQ9HTy/M/Kog==
=L34X
-----END PGP SIGNATURE-----

--=-wR3GXQKBq2t5YgGG69As--

