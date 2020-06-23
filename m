Return-Path: <SRS0=bSXK=AE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E15C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:24:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0038620774
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZjqbXc4J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d71fcBD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0038620774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 835941791;
	Tue, 23 Jun 2020 17:23:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 835941791
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592925854;
	bh=Xpc8KvATFqBYDgCSk0yIokzxteKHYSh9Cdeg7Wx+uMk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZjqbXc4J/XbacY6OForHx8GH99MXP4qpiaJp5KHDNecT24kkR0foHTr7PGNPtBBQI
	 j7czsxatjVUQ6BbqvIBQ2CJ0Z5JN9XuMCmeJ7SwpFDa+z1vVkuqr3pLqyQaG6PDFHz
	 4x99uCOwBws5GEsgt6MkP8N0CobEb52mIIiHA8K0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18D8FF80218;
	Tue, 23 Jun 2020 17:23:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26589F80234; Tue, 23 Jun 2020 17:23:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6053CF800B2
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2020 17:23:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6053CF800B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="d71fcBD5"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 600792070E;
 Tue, 23 Jun 2020 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592925794;
 bh=Xpc8KvATFqBYDgCSk0yIokzxteKHYSh9Cdeg7Wx+uMk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d71fcBD5ptMdyBc47SnxJG41qCT1EmRofON7My7Rk1nvwssZrrdMgCYy6iflMBkfJ
 SDvF6Br9YnyM7JayLHtif8uhgdWq33LRFQGvReNFe5lKsZ3PzDIepv4qbJjdkXCw24
 izjUOY/2KzdDMj1Ig2uAMpRfnXZuisAUQC9OMk4E=
Date: Tue, 23 Jun 2020 16:23:12 +0100
From: Mark Brown <broonie@kernel.org>
To: "Schulman, James" <James.Schulman@cirrus.com>
Subject: Re: [PATCH 16/19] ASoC: codecs: cs*: merge .digital_mute() into
 .mute_stream()
Message-ID: <20200623152312.GG5582@sirena.org.uk>
References: <alpine.DEB.2.21.2006231019470.21024@james-tower>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iJXiJc/TAIT2rh2r"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2006231019470.21024@james-tower>
X-Cookie: No motorized vehicles allowed.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Jonas Karlman <jonas@kwiboo.se>, David Airlie <airlied@linux.ie>,
 Sandy Huang <hjc@rock-chips.com>, Neil Armstrong <narmstrong@baylibre.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Jernej Skrabec <jernej.skrabec@siol.net>,
 Krzysztof Kozlowski <krzk@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
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


--iJXiJc/TAIT2rh2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 23, 2020 at 03:20:28PM +0000, Schulman, James wrote:
> On Mon, 23 Jun 2020, Kuninori Morimoto wrote:

> > snd_soc_dai_digital_mute() is internally using both
> > mute_stream() (1) or digital_mute() (2), but the difference between
> > these 2 are only handling direction.
> > We can merge digital_mute() into mute_stream

> Acked-by: James Schulman <james.schulman@cirrus.com>

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--iJXiJc/TAIT2rh2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7yHl8ACgkQJNaLcl1U
h9DbKwf+OwE7ZBriPYcYQHF4NNpoeGg/TcoS52XojcdM99JqzdCCoA2UANXiSEA/
4+hQxGeG45GPCo1qAefk1DHUJjP8PxRHwQegVLtBhaBezN3XSRaCk1FzOj8Xsrzg
f0mx1q4CmYZVVPGAueVey9a7ypmCcDmcCYy9J2m/gI+aurJEhv8qFxqybPZg6Q9+
cWlpTJshYwPGIvpNcLNih8+huEffiapnrJ+k24mmP5xYvdCEAc/cJl8iX2f/Lmkm
1hSsGDBMPNYdtPPLcsUQSvxfVufXLr7NYTM8sU6yA7ursoND1jVz23SUlRmGIjyv
0UeIShZcGLo4McZDK+PcRVD5kZ2qFQ==
=967i
-----END PGP SIGNATURE-----

--iJXiJc/TAIT2rh2r--
