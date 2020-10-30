Return-Path: <SRS0=7OoL=EF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCE3C4363A
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:57:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBFCC206ED
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 12:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mFfy+iZk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kboj3aEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBFCC206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 105EE1612;
	Fri, 30 Oct 2020 13:56:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 105EE1612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604062645;
	bh=whFF71jZUTnRYPXkB6eceEsBjByTBCubFDxsTAc06cw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mFfy+iZk4DuGB3pV4hYwExK+Rdl2zRlpwnMD78JR0PG5w18+BBjZSOYYcU9Mpyl58
	 hB1M/hEyuYxaGkSuZCvCFrNkBazmm5lBG9cCv3bIwhmqHbgCpVcxPtBtvSK99LNcDE
	 2SDUiMDa4FP73HkP5rAl25Cr9wdQa8IVg1oK28UQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E8E3F801D5;
	Fri, 30 Oct 2020 13:56:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5DB49F80212; Fri, 30 Oct 2020 13:56:33 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7EB9F800FF
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 13:56:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7EB9F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Kboj3aEo"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 391C7206ED;
 Fri, 30 Oct 2020 12:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604062586;
 bh=whFF71jZUTnRYPXkB6eceEsBjByTBCubFDxsTAc06cw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Kboj3aEonZgykKpj/jDT/yw4nEbNUlwrLh1fhYFb8h4Gno59hGdO5SOeJIpJg7cAE
 iZ0epG4nseyg4RAvL6IIZS+IOxaqK5ZREgl2seXUwLvlgAcTxA0CkxpmyFP1uYVdsq
 bNdCr+SGlLyRbaWHdvsY8Tmw96NQxenA2LEFoHWA=
Date: Fri, 30 Oct 2020 12:56:18 +0000
From: Mark Brown <broonie@kernel.org>
To: CTLIN0 <CTLIN0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8315: add codec driver
Message-ID: <20201030125618.GA4405@sirena.org.uk>
References: <20201029113311.495413-1-CTLIN0@nuvoton.com>
 <20201029124642.GA56515@sirena.org.uk>
 <3273d5fe-7e07-549f-1217-d24264a2e937@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <3273d5fe-7e07-549f-1217-d24264a2e937@nuvoton.com>
X-Cookie: Blow it out your ear.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: WTLI@nuvoton.com, YHCHuang@nuvoton.com, alsa-devel@alsa-project.org,
 KCHSU0@nuvoton.com, lgirdwood@gmail.com
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


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 01:00:25PM +0800, CTLIN0 wrote:
> On 2020/10/29 =E4=B8=8B=E5=8D=88 08:46, Mark Brown wrote:

> > error: sound/soc/codecs/Makefile: patch does not apply
> > error: Did you hand edit your patch?
> > It does not apply to blobs recorded in its index.
> > Patch failed at 0002 ASoC: nau8315: add codec driver

> Sorry. I feel a strange because of I can still git apply this patch to
> the latest branch even I create a new branch track to for-next.

> Anyway, I will resend. If it doesn't still apply, maybe I will confirm
> with internal mail server whether the format is changed.

I seem to recall that some of your colleagues had problems with your
mail server corrupting their patches in the past - I'm not sure how they
resolved that, but it might be worth asking around.

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+cDXEACgkQJNaLcl1U
h9BWgQf/Tm2dmSNPP6QB/R9hL8X23VzEQETHrk0J7qBRW6hJt78JP/rC0AtbdUGr
7sCEESVGGBEH/J+tKeSOj13OJWpK3wdIFSgpWoZDVgVw6nEwbmdT6WRj4aYoXtCw
AOHyxFinlZCFyPLYlSqrWjs9YsnLKtkOqBMkHCMzmygyvVwsUSdpHAzI+GA4Mfjr
Y2vBjv7uv4rcMucqloq7oEnoEqhd6+n+BLSn/UaMqqC2GnqIMxh1qVfitW+gemkl
qojOQA76wy/ACJ+4ufl7bZ9mbVUtnSB9MX88lmASqoAjropx8gc0AASVBRWOb9nC
cgV9ZtR5jDI/QhuZYImIShe9xkS3gQ==
=BQf0
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
