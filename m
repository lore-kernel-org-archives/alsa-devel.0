Return-Path: <SRS0=JTem=5M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664B0C43331
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 13:25:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D2E2082E
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 13:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LT4LUnkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D2E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 425B31674;
	Fri, 27 Mar 2020 14:24:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 425B31674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585315545;
	bh=ZO8cnyuK4uE8hYX1SN5VGhV4AdbiYRJNV+hhPjRz3HU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LT4LUnkI4OR4ufLq7Wk568GqI24jC9N1PRk67yG+0Ahaj8wzQG24e8naFi3i7JiIp
	 QimaCg0QLszrVF033klpLXdKNqE/ZIm8AT7pmL8zLLogkcokk4hLMpIvvbUouQ/w64
	 TQzk+kxJbb4ffTZPP0F7XYbkIfP2zIFNloIFtXQ8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF98EF80299;
	Fri, 27 Mar 2020 14:24:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C85BF8029B; Fri, 27 Mar 2020 14:24:53 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 2E138F80290
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 14:24:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E138F80290
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D069F1FB;
 Fri, 27 Mar 2020 06:24:45 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F3813F71F;
 Fri, 27 Mar 2020 06:24:45 -0700 (PDT)
Date: Fri, 27 Mar 2020 13:24:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 33/36] ASoC: soc: use asoc_rtd_to_cpu() /
 asoc_rtd_to_codec() macro for DAI pointer
Message-ID: <20200327132443.GC4437@sirena.org.uk>
References: <877dzbk5wm.wl-kuninori.morimoto.gx@renesas.com>
 <87v9mvhchv.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <87v9mvhchv.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Drop in any mailbox.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2020 at 02:22:04PM +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  include/sound/soc.h                   | 12 ++++-----
>  sound/soc/soc-compress.c              | 36 +++++++++++++--------------
>  sound/soc/soc-core.c                  | 16 ++++++------
>  sound/soc/soc-dapm.c                  |  4 +--
>  sound/soc/soc-generic-dmaengine-pcm.c |  6 ++---
>  sound/soc/soc-pcm.c                   | 30 +++++++++++-----------
>  6 files changed, 52 insertions(+), 52 deletions(-)

This doesn't apply against current code, it'll need a rebase.

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl59/psACgkQJNaLcl1U
h9DU6Af9FKY+hKAamidqqkynGxynwkxO6vKICtIKrLHu4GeYUIfWTIeb5GaUGjJN
madNQzUIUcOcHF6UdC0skvUBLnnMl6SBIsC2Qh/0gfREHqn0aRac17IcW+ncx+/B
nF7OWeR7qqZHdBWlSopblvlmt4ne+KF2V8cUOk2NdUnHM8e8ukojznUm/esX8cFS
5IY3z0tWJv7lyZmUIZCiEMqXBMNv4Q94H1wWFMLMun6k24nNM4bTxxgv/ZpCuC5t
QsS+opMUbMrXcheEjKKmQJrFD17JcmAhR3BHfgv9lgCuK8UFKhdxSSL+ov93VXuz
SJRG5/Ofsg2KxCrScIc579obT1T2yg==
=fwLL
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
