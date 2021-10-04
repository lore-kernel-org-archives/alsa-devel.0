Return-Path: <SRS0=RGWB=OY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C15C433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 12:51:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D8E6120D
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 12:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 11D8E6120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3081D1689;
	Mon,  4 Oct 2021 14:51:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3081D1689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633351916;
	bh=DEPXcUSwkuLvKTygrBe4+mBiRWgvdY/Y44xGRtMf2bg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NN2pcmsGV8eGb6JLAlkGmk3fPzImWaiJq6DyunbByJpnobdacgAhF6T9FMAAbgWlV
	 2xo+7BzTgp8xxmK24ZUFr49HhyQyMnNEpsv4wgG2R9b+z40Sy9zeRXqLh3x0OjW25/
	 wrRLgS5aJKqge+Zdc7XNTjpm8m+uz4dT1PFulYao=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D5F0F80229;
	Mon,  4 Oct 2021 14:51:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4387BF80240; Mon,  4 Oct 2021 14:51:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 891AAF800BA
 for <alsa-devel@alsa-project.org>; Mon,  4 Oct 2021 14:50:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 891AAF800BA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="i/lAB4Nx"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 406E46103B;
 Mon,  4 Oct 2021 12:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633351854;
 bh=DEPXcUSwkuLvKTygrBe4+mBiRWgvdY/Y44xGRtMf2bg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i/lAB4Nxk794gnkR+a90qgK3LEiKjd12Aka1uL4kohj9qPLfYiRlpqOUWC66yUIXN
 +bywrc7QRJB9zbaCA7CDVrT0k4ub6MkrIBHh33vrTrelp5BgsZhWui4ctH47Fxh6oL
 e/SbulhfwqhZhbkPimdNnC9TFgDIctMXOeV0P4MwMAnMsXh/6Fclp8EJEbDE3J3ddo
 4B+CjbdbHybFlYMpkQVRoQtcvHdhtlvuAOPQwmESQVdyptJUAwA0WmId0YrZCU/P/F
 Xg3xNI3uQJ+fbj1brN/VDai97pYqukkm7sjeuBOEWhIJFblRZjU9O83tCAx0k3DI7k
 +5ZvpJurMMvVA==
Date: Mon, 4 Oct 2021 13:50:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Chien-Yu Lin <Chien-Yu.Lin@mediatek.com>
Subject: Re: [PATCH] ASoc: fix ASoC driver to support ops to register
 get_time_info
Message-ID: <YVr4rAbfS220ucDr@sirena.org.uk>
References: <20210820130210.3321-1-chien-yu.lin@mediatek.com>
 <a6336289dcf0009f2fc900c74f480b3c5fc0e8be.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HwyruTVZFZxRCbxq"
Content-Disposition: inline
In-Reply-To: <a6336289dcf0009f2fc900c74f480b3c5fc0e8be.camel@mediatek.com>
X-Cookie: If it heals good, say it.
Cc: yichin.huang@mediatek.com, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 hungjung.hsu@mediatek.com, Takashi Iwai <tiwai@suse.com>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 allen-hw.hsu@mediatek.com, linux-arm-kernel@lists.infradead.org
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


--HwyruTVZFZxRCbxq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 04, 2021 at 07:38:22PM +0800, Chien-Yu Lin wrote:
> Dear Sir,
>=20
> Sorry for bothering you.
>=20
> Does it have any status updated, please?

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--HwyruTVZFZxRCbxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFa+KsACgkQJNaLcl1U
h9B44gf/fUMPWu+biAIQkH3GN1XQANoRFWcvCfbt7GluF29wUwCmTWWNbE+pOnbC
OIAiltjgUkizwDO5UqxK+geASqmI24BRHOFxgb+0MLsEkcrV+oQXfq1ysba61lvR
ATwkOnFC9x/QQA1h9bAf7On6ma6w4nRKdXiJm8HwzlS2oNuiG3Q8yt2FM6MbrnYb
HSc/8lWwFnyB68zIZgpOV9boN8mxC1q/QW4QaYa5eVfsreRm+qGVLsL+ZQYcxv4Y
NznJUih2U3JDc+4vXZSm9uta360+wMLE6q9wsuBin6SOUdQlE0+k9RKTG0UTVB2+
dzSebepqIS215S5s9gGIE0/xHYCRZw==
=r+iv
-----END PGP SIGNATURE-----

--HwyruTVZFZxRCbxq--
