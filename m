Return-Path: <SRS0=jBUr=5P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DE4C43331
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 10:34:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9304B20776
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 10:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fyScknKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9304B20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 931BF1616;
	Mon, 30 Mar 2020 12:33:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 931BF1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585564447;
	bh=uwe2tMxJYzFPt7th97p8QODeHdbH9I6fT/K5/tlZLPQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fyScknKzSaYQ3zKckmBNaQaJvw6U1cmyIxuoZ1HeUASTvQPsTOWtZ5ayv3og9JQB6
	 PibbwibZFr0kFlhdl0CHgilvGryFUDbFtHa0XEVTsR0uTaBK12F16FGnYKWVvDCzwr
	 efI455N9jGQk+3p6cCZcnm5MFV3mqfuCxLie9frA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52FF6F800EB;
	Mon, 30 Mar 2020 12:33:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3811F8014C; Mon, 30 Mar 2020 12:33:13 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 84160F800EB
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2020 12:33:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84160F800EB
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25EAA31B;
 Mon, 30 Mar 2020 03:33:09 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F1863F52E;
 Mon, 30 Mar 2020 03:33:08 -0700 (PDT)
Date: Mon, 30 Mar 2020 11:33:07 +0100
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?B?77+9zLDvv73vv73vv70=?= <gt82.lee@samsung.com>
Subject: Re: [PATCH 1/1] ASoC: soc-compress: lock pcm_mutex to resolve
 lockdep error
Message-ID: <20200330103307.GB4792@sirena.org.uk>
References: <CGME20200326084608epcas2p32239121f201613573e7dd86c3172a29f@epcas2p3.samsung.com>
 <000101d6034a$fe37c7a0$faa756e0$@samsung.com>
 <000f01d60631$a96b8b50$fc42a1f0$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <000f01d60631$a96b8b50$fc42a1f0$@samsung.com>
X-Cookie: Ahead warp factor one, Mr. Sulu.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.com
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


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 10:22:21AM +0900, =EF=BF=BD=CC=B0=EF=BF=BD=EF=BF=BD=
=EF=BF=BD wrote:

> >snd_soc_runtime_activate() and snd_soc_runtime_deactivate()
> >require pcm_mutex lock.
> >
> >Signed-off-by: Gyeongtaek Lee <gt82.lee@samsung.com>
> >---
> > sound/soc/soc-compress.c | 4 ++++
> > 1 file changed, 4 insertions(+)
> >
> >diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c

I can't do anything with this patch as it's quoted, please resend.
Please also remember to CC Vinod, the compressed audio maintainer.

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6ByuIACgkQJNaLcl1U
h9B6bwf8D53Qt+rvhzsjWpM9U8leN/XvcXLgBVOkJ055kelWngjtbbvk4EEuaM6X
glaC4HH3Uyd65onSFYvfzAYj7EHRrzb7Ewi+LTSRF979jYe/420TZId4rC9iT5OE
P1LLMRzV97YmzYkgrjAgykoQipHxWW0htOIETOMPZoUlAFxOVG5S/II7mvH+EoMB
DV+I4Y25dFVe6fr+F4SfojcnBLD9Md5dxvqJMjiP4njWqQ0TNGad0cdEwPdeknS+
QD+xbYTFlRs4cXSSbeN48PgZPCZgZ2y1jq7FJPE5eLyMwT4LvwYAOoDf8YWVJn7E
sY59D4SQhanzjTHLAX62qHVuW92Ygg==
=a5vQ
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
