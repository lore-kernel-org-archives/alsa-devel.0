Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75879ECAAA1
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Sep 2022 17:02:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A7E091698;
	Fri,  9 Sep 2022 19:01:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A7E091698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662742958;
	bh=36he7tSKoMzM24RM5rt2Q1Aw1i6mCldN0UpKpwX535Q=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Aas5UoRtKiWp4YKdK7ontmb/2hobtzFyM5HzBhSkpp8NCKT17+cSWGU5eHtv+0vBw
	 m/xgSQ7L6kpMqlQ1rrTeeYPNXOI0Dq5X8E9LNP/HItofOF3M5hADA+Q49JVTN8FJ+q
	 UeS8v5fB764hVdZu5x7+fzOE93ufp40idkniKQBA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3073AF8016D;
	Fri,  9 Sep 2022 19:01:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 56E87F8023A; Fri,  9 Sep 2022 19:01:46 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30D99F80105
 for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2022 19:01:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30D99F80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="c4fiD2gF"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4CF55B82588;
 Fri,  9 Sep 2022 17:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B470C433D6;
 Fri,  9 Sep 2022 17:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1662742898;
 bh=36he7tSKoMzM24RM5rt2Q1Aw1i6mCldN0UpKpwX535Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c4fiD2gF6kGxW7QnOSEOk8EWAdzZgS8nk6iE/BOn9bBfOq3+mFXiu9eJGDVZMNdQi
 y/ttyqAeBWmy6SNvZZytBp5h/yi0OG+q6yT1PIl336EXrqBtmeUrkAcXdalCXUkJ4P
 xOpZqLqap7x+NbZNJWE9vqhcqNrXt/jRFscH+jM5xlj5xPejVs6idN/HxOjSo54X7y
 kkw0oGuaVFiMyEGJh6Rc4uKl199RQvPbbGRXnqlaBBSlje8ub2I3ixBZndLd1nsbtC
 VNC12CrMhac1BbNvwBG8kP7GEyc7tsKx8Tt/I0OmrFdpWrMFE833uHyUAjk1qUj4JL
 xTXuyBAkXS1Og==
Date: Fri, 9 Sep 2022 18:01:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: ak4458.c: move ak4458_reset() under CONFIG_PM
Message-ID: <YxtxbQh8x9o9qJgj@sirena.org.uk>
References: <871qslmf4m.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hlH2pKPYbH8vlKTi"
Content-Disposition: inline
In-Reply-To: <871qslmf4m.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: FORTH IF HONK THEN
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>
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


--hlH2pKPYbH8vlKTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 09, 2022 at 02:54:34AM +0000, Kuninori Morimoto wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> This patch fixup this warning
>=20
> linux/sound/soc/codecs/ak4458.c:631:13: error: 'ak4458_reset' defined but\
> 	not used [-Werror=3Dunused-function]
>   631 | static void ak4458_reset(struct ak4458_priv *ak4458, bool active)
>       |             ^~~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20
> Fixes: e9e7df88996d64 ("ASoC: ak4458: Remove component probe() and remove=
()")

Is this the best fix, or should we be adding _reset() calls into the
device level probe() and remove() functions?

Actually I'm not sure the driver works without CONFIG_PM since the probe
isn't powering on the device but then that's not a super realistic use
case anyway.

--hlH2pKPYbH8vlKTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMbcW0ACgkQJNaLcl1U
h9AWsgf/e+2s3rfKF2IH/06VvtB3CP0BRC/r2XLuBOESsOsaOQQiY4W5bPM9R598
sTY2wtHTeyOj/kjkfZl51GSzW9sqNvXIwibm7RkEB/h/p8tqm7VB+Lx9llzyfSaa
o2Pp34XIKglFihYisIym/5PPBaAubZUOa0qyhwYvunDaBQ8ztFVEBTvFapHNxBhr
I715g9i7WXosQrkxrkFr2xlLYmp6t7uIKXXVZCoPgSHc8MKW7ZYcho1E8Iat65tO
lMHH2HsZ7++Czd2wUZHFCza5MzBOz/kFRxPdWvt61bkq/hkORynzZbSZnA5eZYUG
D2SpN5ibJrUsbrmVrqlAfhzusdybIQ==
=z/2d
-----END PGP SIGNATURE-----

--hlH2pKPYbH8vlKTi--
