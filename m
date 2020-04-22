Return-Path: <SRS0=We8V=6G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FD2C55186
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:28:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6AD20735
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 09:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fhGG4zmx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUYROwYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6AD20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9213D16B5;
	Wed, 22 Apr 2020 11:27:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9213D16B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587547685;
	bh=Ci4JF1NHPJ0yO0zqX5/6pxnEG3LL0hLpPBCaXrYTTY4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fhGG4zmxm5y+/2j6SDofDH6Iv9oCyVJKivCzXeKY+AMxXUTsn/1KaWCiYKFskwTp7
	 QMT/eb4Jfzr3WgiozQaRRFAZwEYbShk8ldywnruIFoJPEjpr9FPCRj9YeO+W8OCqE1
	 +Lt6CxwN/EV71MMGjLymHe/Deov4/u52cnGwRaHg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 200C5F80142;
	Wed, 22 Apr 2020 11:27:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B8E1F801D9; Wed, 22 Apr 2020 11:27:13 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E79CF80108
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 11:27:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E79CF80108
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="eUYROwYS"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4EC6E20735;
 Wed, 22 Apr 2020 09:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587547624;
 bh=Ci4JF1NHPJ0yO0zqX5/6pxnEG3LL0hLpPBCaXrYTTY4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eUYROwYS0Wer3r94OOt6gI8KJmZYeDDFgn4Wwuo+qVAELkm6EZw3U+BZuYdiPKLY1
 wpSAw0wf/Xtddx6oxPos/SpElp3L7VNqRSvoh6nBj3FPUFlDa24GQAQ0HjrYL6EMWP
 wUlOXnjzqcnDLecsJSj4RTOHxQ5hNfnMAQrLj5z8=
Date: Wed, 22 Apr 2020 10:27:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH] ASoC: dmic: Allow GPIO operations to sleep
Message-ID: <20200422092702.GC4898@sirena.org.uk>
References: <20200422083550.50711-1-broonie@kernel.org>
 <CA+Px+wUFgz0MP0vwkJ+5L5V5G6AK7-6iDbRuUerFBmwnm-CYFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Content-Disposition: inline
In-Reply-To: <CA+Px+wUFgz0MP0vwkJ+5L5V5G6AK7-6iDbRuUerFBmwnm-CYFA@mail.gmail.com>
X-Cookie: A stitch in time saves nine.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>
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


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 22, 2020 at 05:24:54PM +0800, Tzung-Bi Shih wrote:

> Wondering about:
> - Did you get any warning message to inspire you to use _cansleep() version?

No, pure code inspection.  I don't know that I've got any systems that
can run this driver.

> - Does that imply in any _can sleep_ context, it is more encouraged to
> call _cansleep() version?  (e.g.
> https://elixir.bootlin.com/linux/v5.7-rc2/source/sound/soc/codecs/max98357a.c#L41)

Yes, it's better.

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6gDeUACgkQJNaLcl1U
h9Arfgf7BLMy3BY4Q7Uguyk9KcMhn3e6DT8wkv5vV4KzjAGQCbB+Wyh87hQJqkNk
utF8W6c5Zy7pxNq1NvZP1xPb34ac4+bM8JgbG5YJHpId7HsYpmlPEWjTWYV0yGmA
ioMI1xvEGhegBWgrdjGvcrWs4pf5CPT7QPsJOuYR99vYrNpqdUekrtoTRN8nVWrT
zckJEgLJoKxhgxc8Goz6yFy2LppdWWiLBXKMW5ZTYVLHRDYXrCnbEqSFNWFnjaUD
hF1gAUdtN53qvrwCgfvCC+GwO/+vL0khtIrNS88JEp+AXS6AAGMy0ZW8G9Cjni1v
pAr12C4JW2kaRNeqE88T/3yQGKzXZw==
=5cly
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
