Return-Path: <SRS0=wMTJ=I5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12C8C433ED
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 15:07:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57DC46100C
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 15:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DC46100C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6CC771657;
	Wed, 31 Mar 2021 17:06:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6CC771657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617203259;
	bh=kgMkIf8lTh9ax8ZsdBACxqXix3KA+LEHPX+FQL8R3C8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tzJrcOTmR7M5EjE1JyXOZgq72OBqFY2cSVPKWq/yjDrvGd7APsaTu5iMYEzkILKF0
	 avOjEiCup5wUvCGbWqHGsG4VdGlXEoH/UInStr11T/egUqEx06nPo0hlndSeSQ09l8
	 oHGDX3OzmeaOdTYeKABubhrgmhY5XrayKqKO78+I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E335CF8013F;
	Wed, 31 Mar 2021 17:06:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DAAE7F80166; Wed, 31 Mar 2021 17:06:46 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DCB9F8013F
 for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2021 17:06:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DCB9F8013F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Q+v3bc99"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BD7561008;
 Wed, 31 Mar 2021 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617203195;
 bh=kgMkIf8lTh9ax8ZsdBACxqXix3KA+LEHPX+FQL8R3C8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q+v3bc99d3UyDL8jer8px5JHxpHS3NcQqbV8SR+Whrnm0dyyM5WI2m7fxW1jSZqu/
 sfBHyXIltnDeNxBYSdIQGFJR6RfZc+CyElgFMwaGtkOFRHsGN8g1tXU+sry5XqfufI
 aoS6fOw17rlrQflC/rVbzJSe25qrPfKtI56TWH0c4uugMPaopfgY4j4dSbAv7cNpeO
 S/lGShIC8mOSbeRyxm1/E6cBwnU5S9AZet+TMdfy1ySVlkCF3IvWnqNSQgkyoCT2ia
 FR0byYT57PsFYAUYnyX3kCHTAbqwLTpt5nxesJ3O8efGxyJSIRtORXuBO/BVet6I9t
 9KuKKiShF1rDg==
Date: Wed, 31 Mar 2021 16:06:22 +0100
From: Mark Brown <broonie@kernel.org>
To: bage@linutronix.de
Subject: Re: [PATCH] ASoC: sunxi: sun4i-codec: fill ASoC card owner
Message-ID: <20210331150622.GE4758@sirena.org.uk>
References: <20210331145915.12545-1-bage@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Content-Disposition: inline
In-Reply-To: <20210331145915.12545-1-bage@linutronix.de>
X-Cookie: You can't take damsel here now.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org,
 linux-arm-kernel@lists.infradead.org, Maxime Ripard <mripard@kernel.org>
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


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 31, 2021 at 04:59:15PM +0200, bage@linutronix.de wrote:
> From: Bastian Germann <bage@linutronix.de>
>=20
> card->owner is a required property and since commit 81033c6b584b ("ALSA:
> core: Warn on empty module") a warning is issued if it is empty. Add it.
> This fixes following warning observed on Lamobo R1:
>=20
> WARNING: CPU: 1 PID: 190 at sound/core/init.c:207 snd_card_new+0x430/0x48=
0 [snd]
> Modules linked in: sun4i_codec(E+) sun4i_backend(E+) snd_soc_core(E) ...
> CPU: 1 PID: 190 Comm: systemd-udevd Tainted: G         C  E     5.10.0-1-=
armmp #1 Debian 5.10.4-1
> Hardware name: Allwinner sun7i (A20) Family
> [<c0ce8544>] (dump_backtrace) from [<c0ce88f0>] (show_stack+0x20/0x24)
> [<c0ce88d0>] (show_stack) from [<c0ceda20>] (dump_stack+0xc8/0xdc)
> [<c0ced958>] (dump_stack) from [<c034d49c>] (__warn+0xfc/0x158)
> [<c034d3a0>] (__warn) from [<c0ce966c>] (warn_slowpath_fmt+0x70/0xe4)

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBkj+0ACgkQJNaLcl1U
h9Bb5Qf+Jb5wWAY65jR2jFy6bDc8yXmtUqqNiKKR02o3uaxzCZWwwbTW5gRMpPZz
FzvlCzKziDZONVAfSSLqavUzW5A0nkauH6/ZInpfKaT2wOc8fDq+KMSluRuIgKjA
CMy8A2QVRjWWWHGMMo7I64vg9zwg8yTBwurN4WHLkVZ3x6LQjd1UKgaOLuv+lIkj
Vltya2tsrddxg9d2WYOfx7PhoshNpeueRkGXZ62Rv8w2m4FxjvGxP2roT01mAGAe
xCDvRhZIrcyU3nTFHyxYJwO0mXbbXx9gvvAtPTGL+2+z3xQlocQs3IyP13YFCmRJ
ch0nebsWpbOHKRRVcsR+SeY9TdZl4Q==
=ywtn
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--
