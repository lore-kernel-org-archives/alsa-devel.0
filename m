Return-Path: <SRS0=ChbS=AA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8BAC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:30:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1708620771
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HsXTcMHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1708620771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A13501684;
	Fri, 19 Jun 2020 15:29:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A13501684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592573415;
	bh=FlatgOiI92mzBuygghhmYIRwTVULyRdwLvB5mhTW5h4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HsXTcMHShHAAl00iF2ZLAGDKUITyNe+s0698dBlpRckcvg5FHJxRwgYvzhr6vKYfN
	 xg97UHeKRj+CFb0rjS2YbOUsMayA1LZuvpAiSGOAdUH2AIAqHqb3RxyE0ELrbLFwU+
	 7p1/ojNM84RlGC+oh3xdcXnE76nO4tbDs1gl8mEU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F315F8029B;
	Fri, 19 Jun 2020 15:28:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0C2E7F802A1; Fri, 19 Jun 2020 15:28:19 +0200 (CEST)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95C10F8028F
 for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2020 15:28:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95C10F8028F
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 863BA1C0BD2; Fri, 19 Jun 2020 15:28:10 +0200 (CEST)
Date: Fri, 19 Jun 2020 15:28:10 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.19 047/172] ASoC: meson: add missing free_irq()
 in error path
Message-ID: <20200619132810.GA1345@amd>
References: <20200618012218.607130-1-sashal@kernel.org>
 <20200618012218.607130-47-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20200618012218.607130-47-sashal@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Cc: alsa-devel@alsa-project.org, "Pavel Machek \(CIP\)" <pavel@denx.de>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
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


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: "Pavel Machek (CIP)" <pavel@denx.de>
>=20
> [ Upstream commit 3b8a299a58b2afce464ae11324b59dcf0f1d10a7 ]
>=20
> free_irq() is missing in case of error, fix that.
>=20
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
> Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
>=20
> Link: https://lore.kernel.org/r/20200606153103.GA17905@amd
> Signed-off-by: Mark Brown <broonie@kernel.org>

Notice that the bug this fixes is theoretical (found by code review)
and the fix itself was not tested by me as I don't have the hardware.

It may be good idea to for mainline to test the change a bit...

Best regards,
							Pavel
						=09
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7svWoACgkQMOfwapXb+vKgPwCfatdZSXBo7eyLKEUcWoN1nKrh
K8kAn2+x3sAUwlj/zrlpo9y3mh1nlBDY
=nSQo
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
