Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F3FC5DF67
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:29:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B9FF60211;
	Thu, 13 Aug 2026 18:28:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B9FF60211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786638544;
	bh=UsMJ3yY+QPgM99pLz3TPTSsu5+PMdtgKPgm75C9BmVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JioHwTGOridIV9B6HLRV0y9tOsGRFFLinUvg/5ShkpcYZ9UEED2RQhCHebL2+HlrZ
	 w7f/2I/hreohyiPPh8dbCepmJCxwE0nk+oe9sJqifHrgW7DLj38fJZ/XhWXeLUAvEC
	 5qGcKfERrURtKqx13QtpHs1hy8Q2GzXsMzUGubGQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E859FF80600; Thu, 13 Aug 2026 18:28:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EB70F805F5;
	Thu, 13 Aug 2026 18:28:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B3E63F80553; Thu, 13 Aug 2026 18:28:24 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786638504;
	b=CWpEMKqqslaYzlFCutGtZPBFEH73XdhDT0u/KdDROpZj0AnIYHdLLBvbSkFT7l6Nvncv
	 eyk145vBBnm4uQH1Bf3iFzlVGKd7uF5uHTHAVb7OyLul+NVd4UqVx/ePP6FtT9ue3xScN
	 Oi0ibzIBzVcEpPjUHTsEESeLsliyfBVEm5AcjIX9hNR4JDL8qhoJBLQwGJMei6GHzgWIF
	 XdKVuNqMb0mV2Zcd2VUchY0HKXnCeoXTVnhfsYocrw4XZZvSjzTQLjPkat7+CiNrUsxcU
	 8w7y+t17E7PH35jshMcpmWfxrgIC4ZFr0gFtmZ6gu+1IONzHmdmz3OrKYszaDIYOK/Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786638504;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=UsMJ3yY+QPgM99pLz3TPTSsu5+PMdtgKPgm75C9BmVc=;
	b=Y/3ampRUDU5LWCfI6KocRaAZJx/hNlJoqb0pN5FMWB0KqNPdvrjRMl2cvIv/7hf6zPcm
	 3cyCOjCqaOakMiUAQXaNrlGUOB4/2YBvTAH0GgEr0zjR7LiTlDxwzW0Ifn77Go4ZgG/6T
	 gIUBymrGcoJvaJ8LU9KXOMjltIMxPx1GXkMw5eSt24CmHckdA74hOeoJLkqz/4dRGMoL1
	 KPaIqM417u6fm+eqMp09a1oLx2uH5R6Jg4/m/EQ+GahyLwr2IgVJ053XjNt8mZxsf1kNH
	 GVd+WMNPd3VhsHxgIWnuAKyM2Op//hogH2gYH7M1CAmXzCsW2xfFM0mfichw4yUum0Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dJxejWaI;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 140BFF8010B
	for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2026 18:28:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 140BFF8010B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dJxejWaI
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BBA424083B;
	Thu, 13 Aug 2026 16:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7191F00A3D;
	Thu, 13 Aug 2026 16:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786638500;
	bh=umxgShHsVwQIhIWNmBuBmf4BTCa624i2jO91NDXXGso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dJxejWaICUkMHlnm6xvf6Hynqj5irdgzSqf0/YH7SYzK96JOBGuRLDm1tgK0iOjG4
	 M0KAEQU9OncNL9KEg3PiniI1M5xdNkuUU/rmxlqQ6iVb1dC9f+CgQQL4QTUY/sIOJu
	 jKHjR4bBmGttys6oFBRwNF/qfVyaRkqbFeFv/Pq40jjvLcEf4xgUJb5Rcb+WgpjNVs
	 6lvXq4wqMW1MssvQL+DTKz9u4hH2LYa+nZw6l2bUk85wYS1buwMV8iFfYPIS3y2bEd
	 WpZ4qJeKwab/FOlwud6KmAzsVaDBvQeEy/cQXGVJDfmSr1OnhPBwlxU86ExVCzHmov
	 pV27oiUGU5LjA==
Date: Thu, 13 Aug 2026 17:28:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.2-rc7
Message-ID: <8b0c9a2a-26f1-4b88-a280-2575c21540cd@sirena.org.uk>
References: <317e8543ff401f09ccc2e93c8cd70e71@kernel.org>
 <87cxvmxf4p.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BceiNQbBszafb4b4"
Content-Disposition: inline
In-Reply-To: <87cxvmxf4p.wl-tiwai@suse.de>
X-Cookie: Trouble always comes at the wrong time.
Message-ID-Hash: 442TK67HPP7JTRGRQ66ADH47OOWSK3NC
X-Message-ID-Hash: 442TK67HPP7JTRGRQ66ADH47OOWSK3NC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/442TK67HPP7JTRGRQ66ADH47OOWSK3NC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--BceiNQbBszafb4b4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 13, 2026 at 04:35:18PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > This set of fixes is bulked out quite a bit by the inclusion of a lot of
> > quirks for various x86 platforms, though there are a few driver specific
> > fixes in here too.  Nothing here is terribly critical, we should be fine
> > waiting for the merge window if it's too much.

> Pulled now.  Thanks.

I'll have one more fix from Richard hopefully later today:

   https://lore.kernel.org/r/4bb97547-4145-4afa-8014-71faa594bd36@opensource.cirrus.com

which looks like it'd be good to get in, especially with v7.2 looking
like a LTS.

--BceiNQbBszafb4b4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp98KAACgkQJNaLcl1U
h9BsGAf+ORNIrytaeFH1E2xTa/Gzgbym0S51UukQJD/xPQ3cF6OMRZzo+2Vblf0G
K2FOe+uQ/PHZh+jA/6XvP2dJY5eiSoGfl3pZcYp3+HvOgMtyahlLds84qEhGHP2z
MydcLHYRT93YR0kYRA6QUITGaOA785S1Tv3Kh63/p3tJ5OKNCPAsdiLQ3WdorPfk
Wv4T+IA2AlIZlVRQb5JhHdA9/CaG97BvHaT10xArRibmS+9L+D5DBGMCT67yVxd/
w85gPJ3Mh0rMAB75LxH29re52iFTfTUJ6g83e7OAmyJrK6TlnebJ/vhH0sEmqWyW
HBrwqpkyLaRLdFoo51e5m2sbl7QTuA==
=jb9m
-----END PGP SIGNATURE-----

--BceiNQbBszafb4b4--
