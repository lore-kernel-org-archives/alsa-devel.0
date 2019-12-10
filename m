Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D51BC43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 12:18:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FF0B2073D
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 12:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cqGT3UI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF0B2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 123A285D;
	Tue, 10 Dec 2019 13:17:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 123A285D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575980290;
	bh=ZJN+9whpFgE1YfOzXslqKSmayhMTeW8QkZLaDh+KEWQ=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cqGT3UI84J0lqhnPj3+OduWO2fGKienHBA4UZBxzZgpIInvVIgvBf2ktUvDcPjvTW
	 bvVHd7a/xOHpz/jPkynHWTbwCBrg55QGA1xPJl0CT9l+zS6/cFMef2mANexVowuLtf
	 VNCDuqdJwir3ID9zzNqm+hUZG3u9a1TR1kQHSzAU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F390F801D8;
	Tue, 10 Dec 2019 13:17:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4B88F8020C; Tue, 10 Dec 2019 13:17:16 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 42992F800B4
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 13:17:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42992F800B4
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD0051FB;
 Tue, 10 Dec 2019 04:17:11 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 578DD3F6CF;
 Tue, 10 Dec 2019 04:17:11 -0800 (PST)
Date: Tue, 10 Dec 2019 12:17:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Chuhong Yuan <hslester96@gmail.com>
Message-ID: <20191210121709.GC6110@sirena.org.uk>
References: <20191206075209.18068-1-hslester96@gmail.com>
 <20191209162417.GD5483@sirena.org.uk>
 <CANhBUQ0zwQG-=C12v02cf5kfvJba=5_=0JkZA45DDhxOzTBY6A@mail.gmail.com>
 <20191209170030.GH5483@sirena.org.uk>
 <CANhBUQ0-jEG2W=sby1SyPphxK3CSPinFF5zkLq9jsKCZM5hYjw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANhBUQ0-jEG2W=sby1SyPphxK3CSPinFF5zkLq9jsKCZM5hYjw@mail.gmail.com>
X-Cookie: We have ears, earther...FOUR OF THEM!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>,
 James Schulman <james.schulman@cirrus.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: cs42l42: add missed
 regulator_bulk_disable in remove and fix probe failure
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
Content-Type: multipart/mixed; boundary="===============5612104762686011565=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============5612104762686011565==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Content-Disposition: inline


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2019 at 09:32:12AM +0800, Chuhong Yuan wrote:
> On Tue, Dec 10, 2019 at 1:00 AM Mark Brown <broonie@kernel.org> wrote:

> > There's also the case where runtime PM is there and the device is active
> > at suspend - it's not that there isn't a problem, it's that we can't
> > unconditionally do a disable because we don't know if there was a
> > matching enable.  It'll need to be conditional on the runtime PM state.

> How about adding a check like #ifndef CONFIG_PM?
> I use this in an old version of the mentioned patch.

That won't handle the runtime PM problem, the state will vary depending
on what the system is doing at the time.

> However, that is not accepted since it seems not symmetric with enable
> in the probe.
> But I don't find an explicit runtime PM call in the probe here so the
> revision pattern of

It's got runtime PM ops though so that's clearly a bug that needs to be
fixed itself.

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3vjMUACgkQJNaLcl1U
h9AAoAf+K6J1r4btG9IR3em9HyPA3E/jMnx1YBRDo2CJwTZfUe8rMyqJPl98cYs8
OJMbc+4U2Q2aJjjYNvLzFWwGJAA48tf4BitK3hxGRwQDK3rolg1Xb+eVEqVToLOi
CQyZj5j5lvH3ZS6fSJitXTZYcgSN4jbVCoPRiG4aK7IKUMeXgcLEOb6WJIN3RDvz
oJzATwyxtvjIIHiM9DpKVkAuoltOtdM1ofmMpRTbqyN/s42Oa1BgFf3tgXp/l5GY
zqOLaz+1BsiADE2Yhs2q5PbzgBpeG5QfWWXykKAtByqTgau9StyQHGBG8eYt1YW1
E4y4Eguf5CGRV+9Kwxl6KsgFnycxTQ==
=EXTv
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--

--===============5612104762686011565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5612104762686011565==--
