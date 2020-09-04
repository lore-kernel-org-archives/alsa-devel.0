Return-Path: <SRS0=A1sP=CN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC24C43461
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:25:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2182065E
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ru1skF+u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYBhS4JD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2182065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 276671EE1;
	Fri,  4 Sep 2020 18:24:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 276671EE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599236736;
	bh=NAOttNi68dxtCKh5TVKg8sTqUmu57wOh79f7YPBx69A=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ru1skF+ud7go8nLR+q/6xGJul+PWJdwwqGoe0H39qUseGxCgDeVviGxs/xVE6IqQM
	 UF7rx8Y6lKzkSF3VUuPhjQeooiSWEsgA+vPzni1yYMH27BHqHs3FV6SxqJgEqaxp6o
	 jpJPC+3LHE7gmlTdJOrt4Yhyb/4G/XK9wYSbBdZc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BC6BCF80212;
	Fri,  4 Sep 2020 18:24:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D55DAF8024A; Fri,  4 Sep 2020 18:24:44 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C65F9F801DA
 for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2020 18:24:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C65F9F801DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="CYBhS4JD"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C209D2067C;
 Fri,  4 Sep 2020 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599236677;
 bh=NAOttNi68dxtCKh5TVKg8sTqUmu57wOh79f7YPBx69A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CYBhS4JDiuXs0mCoO/vaMRF73YWXpersz+FpF0smRVDdj7C9Ct+RwCWCL3X2yFNpp
 7RuUQEAMeqFGccOyhwlo/nsrxfWtbcHDQIrarHS1M3nKpBWnXBaE8LuoBBGgKq6XxP
 NCq1YqJ3YwJNIFyhB0NyeT4pw3aHQdww+TdLgZFw=
Date: Fri, 4 Sep 2020 17:23:55 +0100
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [linux-sunxi] [PATCH 05/16] ASoc: sun4i-i2s: Add 20 and 24 bit
 support
Message-ID: <20200904162355.GA49830@sirena.org.uk>
References: <20200704113902.336911-1-peron.clem@gmail.com>
 <20200704113902.336911-6-peron.clem@gmail.com>
 <1e320dfd-9388-54b2-dba9-7def0bf4bbad@sholland.org>
 <9148679.oVN3Z7rve9@kista>
 <fd714cb6-3650-1eb9-616d-33c00f1442eb@sholland.org>
 <20200903074023.jccqp45br3er4h3g@gilmour.lan>
 <20200904161649.GL10899@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <20200904161649.GL10899@ediswmail.ad.cirrus.com>
X-Cookie: Restaurant package, not for resale.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org,
 Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, Samuel Holland <samuel@sholland.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Marcus Cooper <codekipper@gmail.com>,
 linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
 peron.clem@gmail.com, Maxime Ripard <maxime@cerno.tech>,
 Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
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


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2020 at 04:16:49PM +0000, Charles Keepax wrote:

> My understanding is physical_width refers to the in memory
> representation, but shouldn't be used to control the slot width
> on the bus. If not specified otherwise (say through the set_tdm
> callback), and if the appropriate BCLK is supported, then the slot
> should be just large enough to hold the data.

Indeed.  The framework isn't great here in tying the memory and wire
formats together, ideally there would be more support for them being
unrelated without DPCM.

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9SahoACgkQJNaLcl1U
h9Aivgf9FE+zKg/2HauJXtYNKTV6F5tpg9YlM9zZm1mgrfejgquDBl3k34Y9d14k
4p2wjhqoKPTGoY7Y33weRBkyBmk9KcLMfQaZRO84B1W0h1/AgaTVY8hgUbucsDld
X0x3qA/ejP71NUBv1yNuMVVmhwISIg7WLJONku57+1KvdsciUFLgqcK1lesXV/hO
lpemO67BlytBjZKc71yFEQtFEelOOdZmbe1GGDQtDP6wEtlzzbuJuyw9qLQBAfwC
Ron6ds5hgj+K0tk7jdrtOzoW5GGN2U3d+cXn0gmQax72PwEefzjIBAR7n0TAAPcV
Mh3pFSi3xyQSRAv64SY2qiJFAt8TBw==
=ZBOH
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
