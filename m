Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25553C79F9E
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2026 21:32:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96A95601E6;
	Mon,  7 Sep 2026 23:32:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96A95601E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788816756;
	bh=4S7fviH+Av5ebG9iaMlURIJ082WOCez5DHKCBEw4a/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qczaPV3Oz1SmttM7QUf4FK9HM5XHrUMtQbFWZJT/nFJNHlc4Ia7TKvapAqbVlxodb
	 E3CArFhK/9b8QrKvVYvf/mjIOUDxC1YDQ+ItR2ON/CJcpxjrAgTMNK4OFw6843iNva
	 VfXF7a2n5ukJf8G2YBp1WUUr5I4jqbNktGyHx6zI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 85832F805FF; Mon,  7 Sep 2026 23:32:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59B8AF80600;
	Mon,  7 Sep 2026 23:32:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6C9C4F80571; Mon,  7 Sep 2026 23:31:57 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788816714;
	b=VQFVS7HEs8GB1c8pvszXimmkkIsmST2GD+MhWsz7dAfqrhpOPT5d/nxXUFRTWSylNg1L
	 0IEf/M20hvibQYbKj/KLgrA4F5c57M8h54BF+8ZsWy7SXjy+YitAx4rw1Gy1FlLwHhraf
	 Ejd8zoXmtrlDmBXJHiztiN/ZwOLsNMqdrGx87omMZr0YCL3rHRsivTo66Pdou94WX1amL
	 xXniqv1827uD6LOlflfRBcIdf++8L6e0lPsidn0W3k3gO97CXYCiwc6GeSSIeyUQ/HxyQ
	 KLhArtxfxfJaYEnJyhD+SpKw+5uML/3PsHQsLbbUVuN0ZBe0RP//CoQ8PZ9wwZmiT4Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788816714;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=4S7fviH+Av5ebG9iaMlURIJ082WOCez5DHKCBEw4a/w=;
	b=AfgMLjx5R4kmqZkOBvsf+e8p/L9YLPYSEV0p8zI/fbK/qf3jRIv+uxgq4u78LLQtsKXb
	 8xOrR8Z+faGz6aF+LHaQpSP9/EK7yNCu6FK5IypB+ypmWY9myZPa5YXSl1PgjMMxGfJhm
	 pFy5EwHHRBrj+c/Lhdg8GmCGVmDJKrl8vrXTrxtVEBwxX5tQwkAvRnu0WxA+VzA8QUFil
	 RA5EZ0ByUFqkkBo+EYamcYWuhzOAoFG71xEegom+tZ/EXzRBEAM7skAB/PMdMjNDBUnM+
	 1RDF27FIHM0A0DusYAw6+QW3mzE9x/RtJLBAWeptt85jdwRjeoycA6bHmwYX00oE/CQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="kQCDB/vG";
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D17E7F80088
	for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2026 23:31:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D17E7F80088
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kQCDB/vG
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0D36440DDA;
	Mon,  7 Sep 2026 21:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275001F00A3A;
	Mon,  7 Sep 2026 21:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788816708;
	bh=GuVmcKVUXrbX7V4K/5mlgvKk0J/cmEXGNDsOzISHKQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kQCDB/vGwzgUC651+ncx9fyS+Kfl/uJYhFD32o8BYy3QriMh9j2rzWGY+JGYPWMFX
	 0C809lHTZTIuWqGMtYB/hMqrjyCa9+S2M4rL7BUbUC5UhaO5cn081W9Cn4seRIoltk
	 kkNZxnJEUKVDIWFuSFRqG/kVXepMLMJjaZAtkD6LOiw2DwVCGh6rmJOpAmEH1XU+4U
	 7XbKpD9DQCVEtkkN6VRDUYP88ozjYWaxHPfl7thv1oznQ+lz7dcpPVtxfzrCHVPj50
	 gBCV8YXbTTq9x8XWbQ/ud2cMq3JfD2CS/XgM5NZjx+oY/SGUJ4XPdCcbZHc0pVKo3J
	 pEsKHtwJkJaHw==
Date: Mon, 7 Sep 2026 22:31:44 +0100
From: Mark Brown <broonie@kernel.org>
To: jack.yu@realtek.com
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, lars@metafoo.de,
	flove@realtek.com, oder_chiou@realtek.com, shumingf@realtek.com,
	derek.fang@realtek.com, Trevor.Wu@mediatek.com
Subject: Re: [PATCH] ASoC: rt712-sdca: reconfigure PLL2 to fix calibration
 time-out
Message-ID: <9f563c50-e18f-421a-8325-e70e7d482b51@sirena.org.uk>
References: <20260907064114.435697-1-jack.yu@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MPlj4J/wTXJXAJ6H"
Content-Disposition: inline
In-Reply-To: <20260907064114.435697-1-jack.yu@realtek.com>
X-Cookie: Who's on first?
Message-ID-Hash: D63CPAF3NTE5NTTRVVZRM2TKK4466IYR
X-Message-ID-Hash: D63CPAF3NTE5NTTRVVZRM2TKK4466IYR
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D63CPAF3NTE5NTTRVVZRM2TKK4466IYR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--MPlj4J/wTXJXAJ6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2026 at 02:41:14PM +0800, jack.yu@realtek.com wrote:
> From: Jack Yu <jack.yu@realtek.com>
>=20
> Add pll2 reconfiguration sequence in order to fix calibration
> time-out issue and to support 24.576MHz MCLK on specific platforms.

> +static void rt712_sdca_clk_patch2(struct rt712_sdca_priv *rt712)
> +{


> +	regmap_write(rt712->regmap, RT712_SDW_SCALE_CLK0, 0x03);
> +	regmap_write(rt712->regmap, RT712_SDW_SCALE_CLK1, 0x03);

This looks like it collides with sdw_slave_set_frequency()?

> +	if (loop_dc =3D=3D chk_cnt) {
> +		if (clk_base =3D=3D RT712_CLK_FREQ_24_576MHZ) {
> +			rt712_sdca_clk_patch(rt712);
> +			rt712_sdca_clk_patch2(rt712);
> +		}

Perhaps the patching should be checking that the scaling registers are
the ones written above and only kicking in if that's the case, or have
more cases that work with other scaling setups?  Or restore whatever the
core set if that's possible?

--MPlj4J/wTXJXAJ6H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqfLT8ACgkQJNaLcl1U
h9Bt2Qf/fBiy7Y2H0H0kci1NGBxB0ZapgWFDPrRp7MG/JQpZN0xbJ4QRWwr+RkUO
O/EIGFqUAtBDejDZXZHQI9Q7yNc3unICVsAB4Lw5o64si5OJugiMjHne/pazQ4JB
DclrJKim32XT63CZz5esLoUPKo0tgWio8NYc9s5xtVi7jOKZQEDnVelZmue2Lu9v
ya6AsAdKfBHqc6r/179pCeZEUI3IdMMT/wP4gFAi7hsfiCCx3dxSSmbriR0xXWzA
fyPJSgYMIU7GSMpotgZbXIAwtVqfuNlSYpMUb7+xQ96J+nyVoaXWyp9+iT6xkA7r
jY1KvFRQMyJk9E3n4fRAbtFGP2kUtA==
=Nh2k
-----END PGP SIGNATURE-----

--MPlj4J/wTXJXAJ6H--
