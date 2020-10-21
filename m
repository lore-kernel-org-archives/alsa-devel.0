Return-Path: <SRS0=H+KG=D4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481BEC55178
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:24:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0492224E
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2020 13:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZKH/Cgzu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8GMHKrL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0492224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42A6C174A;
	Wed, 21 Oct 2020 15:24:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42A6C174A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603286693;
	bh=b3cPCH2ChrkOo+0On+GCFaxbYKBDb2R2dmjWrh01th8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZKH/CgzusPAi1DPT4pTtlsRlhHvsLwJ6vFZO9T6EnCt0OToTEj24i6tGviA+mG6af
	 1rv5otC4+fcERMV58G0tXaehORUiKHUbdMkHpbCR9dwGCcIyWUXxU9lefr1sN95F2H
	 tk4GMMlnUQhcpOUavHZQGGubQ3pAGXv1oxjnxTI8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6999FF80111;
	Wed, 21 Oct 2020 15:24:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7F1CF80264; Wed, 21 Oct 2020 15:24:00 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E7F4FF80111
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2020 15:23:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7F4FF80111
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="C8GMHKrL"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 783C2221FC;
 Wed, 21 Oct 2020 13:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603286631;
 bh=b3cPCH2ChrkOo+0On+GCFaxbYKBDb2R2dmjWrh01th8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C8GMHKrLxbXtok127CPq0GuZB0QXEqO6wvjYff7dT8f+cwsco4b+i5UzG+DMV6/Hh
 3LstP0uMgqsEhjIy5mJi53BTEJx9CMxb+d2XH2ni4s5Cj/AT/PKQvMtJaSnCHbXhRT
 A8HZn3KJOuhf/QzBL6w+/Hllt4uEfx6lChajJMF0=
Date: Wed, 21 Oct 2020 14:23:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [PATCH v2 2/5] ASoC: mediatek: mt8192: add platform driver
Message-ID: <20201021132339.GF4497@sirena.org.uk>
References: <1603270435-3548-1-git-send-email-jiaxin.yu@mediatek.com>
 <1603270435-3548-3-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xaMk4Io5JJdpkLEb"
Content-Disposition: inline
In-Reply-To: <1603270435-3548-3-git-send-email-jiaxin.yu@mediatek.com>
X-Cookie: That does not compute.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, shane.chien@mediatek.com, tiwai@suse.com,
 tzungbi@google.com, robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 p.zabel@pengutronix.de, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org
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


--xaMk4Io5JJdpkLEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2020 at 04:53:52PM +0800, Jiaxin Yu wrote:
> This patch adds mt8192 platform and affiliated drivers.
>=20
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  sound/soc/mediatek/Kconfig                    |   10 +
>  sound/soc/mediatek/Makefile                   |    1 +
>  sound/soc/mediatek/common/mtk-afe-fe-dai.c    |   13 +-
>  sound/soc/mediatek/common/mtk-base-afe.h      |    1 +
>  sound/soc/mediatek/mt8192/Makefile            |   14 +
>  sound/soc/mediatek/mt8192/mt8192-afe-clk.c    |  669 ++++
>  sound/soc/mediatek/mt8192/mt8192-afe-clk.h    |  244 ++
>  sound/soc/mediatek/mt8192/mt8192-afe-common.h |  170 +
>  .../soc/mediatek/mt8192/mt8192-afe-control.c  |  163 +
>  sound/soc/mediatek/mt8192/mt8192-afe-gpio.c   |  306 ++
>  sound/soc/mediatek/mt8192/mt8192-afe-gpio.h   |   19 +
>  sound/soc/mediatek/mt8192/mt8192-afe-pcm.c    | 2389 +++++++++++++
>  sound/soc/mediatek/mt8192/mt8192-dai-adda.c   | 1489 ++++++++
>  sound/soc/mediatek/mt8192/mt8192-dai-i2s.c    | 2139 +++++++++++
>  sound/soc/mediatek/mt8192/mt8192-dai-pcm.c    |  409 +++
>  sound/soc/mediatek/mt8192/mt8192-dai-tdm.c    |  778 ++++
>  .../mediatek/mt8192/mt8192-interconnection.h  |   65 +
>  sound/soc/mediatek/mt8192/mt8192-reg.h        | 3131 +++++++++++++++++
>  18 files changed, 12006 insertions(+), 4 deletions(-)

This is *way* too big to be a single patch, please split it up - it's
over 600K.

--xaMk4Io5JJdpkLEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+QNlsACgkQJNaLcl1U
h9AabAf/Q9TXeXUMIPn9NWo9v/L9LDjOuG3v6YsvGz0dOKzOGAaBjfvSbd9Wtxla
FGAFsK52ABH7Au6Gm6lKAGgRYY1iP+bG0Pfy0Ow4XdHrPLv/WND+qgFgnaqOZ2Cd
fb7IpP2f57dbOFvFttnhJW132G3wv50HM3TGcX3ZIMdL0x6becq28d3tg05RUJUn
8I0581pbZ9NOiux3Z0qAYsI0j9I8GQLgYmOTXg2v+FivJ5mrRctnxPSy7fhsi9xQ
+k1rpv8+jY/NDbOVPenM/f/EoT2WAynU3KNQbW4oEgTX0z62TDV7A9SX6dO5ncBd
t5HhufaFXlQn1FBV84GrEXTq9ObMsw==
=JxKv
-----END PGP SIGNATURE-----

--xaMk4Io5JJdpkLEb--
