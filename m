Return-Path: <SRS0=J9ZO=6P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B4FC47253
	for <alsa-devel@archiver.kernel.org>; Fri,  1 May 2020 12:26:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3C5206F0
	for <alsa-devel@archiver.kernel.org>; Fri,  1 May 2020 12:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ieD0/2rD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zrF3lGKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3C5206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CEF11696;
	Fri,  1 May 2020 14:25:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CEF11696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588335995;
	bh=lbHm2sZNgmp3xDR80ZjBmeiaApE7ajQoqCcVAqDgfgg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ieD0/2rDgyy5acQ2yFwLogisoDr8tuPHgWuKJLF4cyoWuNign2Fja3ci40rYEumH4
	 i8BzR+HaZCbLb6fVcX1DEcB8T0RLZccCKZqzQzUObg3t5qbROni8yyDFm76ucQxFty
	 Y1QFVLAH8NotHI7EDfYaKefOixSAVDv3IF7tQt/U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B3DEF80217;
	Fri,  1 May 2020 14:25:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1869F8022B; Fri,  1 May 2020 14:25:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B56AF800B9
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2020 14:25:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B56AF800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="zrF3lGKQ"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A8D7F206F0;
 Fri,  1 May 2020 12:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588335939;
 bh=lbHm2sZNgmp3xDR80ZjBmeiaApE7ajQoqCcVAqDgfgg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zrF3lGKQPpXX6JTIbE+Knz2sn0YQPnyc4YtbdPh/DiS+5mS6DF5Ygk3fQa42tDBwa
 cVHsrt1i8wqi82NsuS5SeRrh7UeZNVimqtdPm4ZsFNrYs3iBiMmljn+uUma2PTRrpg
 7PuEpijuzm3s3AMAP+01cNeMfLDGfysSqJsKwzzg=
Date: Fri, 1 May 2020 13:25:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Guillaume Tucker <guillaume.tucker@collabora.com>
Subject: Re: stable-rc/linux-5.4.y bisection: baseline.dmesg.alert on
 meson-g12a-x96-max
Message-ID: <20200501122536.GA38314@sirena.org.uk>
References: <5eabecbf.1c69fb81.2c617.628f@mx.google.com>
 <cc10812b-19bd-6bd1-75da-32082241640a@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <cc10812b-19bd-6bd1-75da-32082241640a@collabora.com>
X-Cookie: Androphobia:
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org,
 kernelci@groups.io, Kevin Hilman <khilman@baylibre.com>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
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


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 01, 2020 at 12:57:27PM +0100, Guillaume Tucker wrote:

> The call stack is not the same as in the commit message found by
> the bisection, so maybe it only fixed part of the problem:

No, it is a backport which was fixing an issue that wasn't present in
v5.4.

> >   Result:     09f4294793bd3 ASoC: meson: axg-card: fix codec-to-codec link setup

As I said in reply to the AUTOSEL mail:

| > Since the addition of commit 9b5db059366a ("ASoC: soc-pcm: dpcm: Only allow
| > playback/capture if supported"), meson-axg cards which have codec-to-codec
| > links fail to init and Oops:

| This clearly describes the issue as only being present after the above
| commit which is not in v5.6.

Probably best that this not be backported.

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6sFT8ACgkQJNaLcl1U
h9CjCwf6A/KP149/7ilTWJylUigNvyI1cVIskzDBGQREGWK0VI2Z8qGOKkNgLzZw
F8H2cYXmeDRb0MJRqgNwV0mDl3iHd7l2lqtIUd4kQdvL7id2OlZV2NEso/o28AwF
x5GDVyl5E9rRto72Krs/X1R1V2+ACbNJORJiargnx7mv7QlmY5L0axZKbifhjP/C
aEA5DlAD6eZXLpOCh++yPZYuatnik0c5uSao+TKsurFgxfC2+xdUnFC9QTYRd7NA
jchP5RvU86y4V7yzhlBcndg+msHZ9/EjcJj1zdbJuaeDX2y895T3jCtgLzlhHVAM
bCa8P2t5jxwaaDQxCLHjRE+uFUbt+w==
=Ue/C
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
