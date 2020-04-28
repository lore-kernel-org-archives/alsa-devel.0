Return-Path: <SRS0=jEei=6M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B7BC83000
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:58:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B9D20757
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UOzEn6mq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vraqZ0wE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B9D20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9999E1666;
	Tue, 28 Apr 2020 18:58:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9999E1666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588093130;
	bh=QaFdvwQtNCzuxJiiAPZ3ZOFvDXcpwjoLKDRZlvc+JTU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UOzEn6mqrrhG6ytwqw5u4N3uFxfXF+nIEY2RrJ0MVFITSZ/0nyM93zf5i7w5mKv2w
	 uPJ5+jfj19MdT9SdxDg/SegJ9DYPrlSXADFmyBkV91CvEOunghc5H36X/9QTAWBIER
	 wml1AAuFBfYuzYilOmdJzFNrH69oyQ7goZnW4YgQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 180F1F80136;
	Tue, 28 Apr 2020 18:57:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1D9DF801DB; Tue, 28 Apr 2020 18:57:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0483AF800D2
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2020 18:57:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0483AF800D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="vraqZ0wE"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DE42320757;
 Tue, 28 Apr 2020 16:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588093068;
 bh=QaFdvwQtNCzuxJiiAPZ3ZOFvDXcpwjoLKDRZlvc+JTU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vraqZ0wEcRphTU3lPtLyXChwnLcRHayEWGgLHdrwesblGo/42zUJF4jLqaKz47xEb
 ORmefUppK8xFN675aFR0gcO4VVqr2YyuuyxKCpPYfzSeapY4vntKXugE6AbXyEFfgo
 yJ+sGuNxbqA2Hi26mqqt5ODXt97n7b9DRXqC2cRI=
Date: Tue, 28 Apr 2020 17:57:45 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Subject: Re: Audio sound card name [was [PATCH 4/7] arm64: dts: allwinner:
 a64: Add HDMI audio]
Message-ID: <20200428165745.GM5677@sirena.org.uk>
References: <20200426120442.11560-1-peron.clem@gmail.com>
 <20200426120442.11560-5-peron.clem@gmail.com>
 <20200428080020.35qcuylwq2ylmubu@gilmour.lan>
 <CAJiuCcc2LQ4L36KSfO8iLVFBUO6k+zsZFX+_Ovm_10PoWO4AsA@mail.gmail.com>
 <20200428160417.6q5oab2guaumhhwi@gilmour.lan>
 <CAJiuCccFFUJJzXwygLQbDK4fGJ61p72Hv7vj3WVP-=z=J1Yj0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="x38akuY2VS0PywU3"
Content-Disposition: inline
In-Reply-To: <CAJiuCccFFUJJzXwygLQbDK4fGJ61p72Hv7vj3WVP-=z=J1Yj0Q@mail.gmail.com>
X-Cookie: Eschew obfuscation.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree <devicetree@vger.kernel.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Jernej Skrabec <jernej.skrabec@siol.net>, Takashi Iwai <tiwai@suse.com>,
 Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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


--x38akuY2VS0PywU3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2020 at 06:49:10PM +0200, Cl=E9ment P=E9ron wrote:

> I have a question regarding the simple-audio-card,name.
> In this patch, I would like to introduce a simple-audio-card for the
> Allwinner A64 HDMI.

> What should be the preferred name for this sound card?
> "sun50i-a64-hdmi" ? "allwinner, sun50i-a64-hdmi" ?

The former is more idiomatic for ALSA.

--x38akuY2VS0PywU3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6oYIkACgkQJNaLcl1U
h9CxAgf7BWIci8LznrR1sMDBntaJK2/0G/U8xmAKYRllkCNU+ygWiMh4kJP0s8Xt
kwdFyZZIgLgcsjFiKBtUmSOtJtQklUyVMyYfN4Fuxspk0tuoZ55f7XfLkZelcMin
pDhjmgvcSRMfLrcLovinmN0tAR6rWlNzUbDEs2J1bkxyoBsp1+9JbIadgU0+HVwC
7/EYkpQG5niUXnDqe5puy9aeR9ml20pg8+DYnjTjgTUqGQTBbvdrd9PIwjsh7R0t
RK9k8vuWd94brTyA0W4z8PbDHCIVpz/noDHFOBeUUjR2tP0sPAfYZkh5TlpDM/pG
9CbD0IlbKTXi0BXgBg1H8zN+XLKCyA==
=5lUy
-----END PGP SIGNATURE-----

--x38akuY2VS0PywU3--
