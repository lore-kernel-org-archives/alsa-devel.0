Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD16C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:51:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4362063A
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Fa3K2j6z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+siRc6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4362063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D68015E5;
	Wed,  8 Jul 2020 18:51:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D68015E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594227115;
	bh=AqMKtqS/OXQk+rhorj+lXzo8EwOOu2YsoGozE3DRg5U=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fa3K2j6zz/2PyLb7+A8ZCA0C7sb3uPVzc2pWJ4ex34ONcDg5NEd/12DVUXSwiomwl
	 EuGB9u7Iz70l0jVDP4dpxchb27EtEWD08cRFMTkSP0sn87EGwTTvsfStXnlj5qwet9
	 ROHFwcs3uu9ubMabIdg8hiOhv1/pVuQMVOuPW/xA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29894F80150;
	Wed,  8 Jul 2020 18:51:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9A499F8015C; Wed,  8 Jul 2020 18:50:58 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7379BF8011F
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 18:50:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7379BF8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="g+siRc6b"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 800802063A;
 Wed,  8 Jul 2020 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594227047;
 bh=AqMKtqS/OXQk+rhorj+lXzo8EwOOu2YsoGozE3DRg5U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g+siRc6bJy6ezH6ZeNdz2UGNlovQfefe94DX3Ol9cFvhEvJwUWscErEJuSZWseQZS
 esTenErVulATOMRJI3KaxHGJEZgA7pGTm/tJE0yl+fLtEBEDoedT1KdWyg5i+z02jA
 31gZNcFQy7WDA+YJFJGBMkhp39cfu1zw3ooqG5XE=
Date: Wed, 8 Jul 2020 17:50:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v3 5/8] ASoC: qcom: lpass-platform: Replace card->dev
 with component->dev
Message-ID: <20200708165041.GX4655@sirena.org.uk>
References: <1594184896-10629-1-git-send-email-rohitkr@codeaurora.org>
 <1594184896-10629-6-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aBaYPhOdNx+t7mr3"
Content-Disposition: inline
In-Reply-To: <1594184896-10629-6-git-send-email-rohitkr@codeaurora.org>
X-Cookie: Oh Dad!  We're ALL Devo!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, plai@codeaurora.org,
 tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org,
 bjorn.andersson@linaro.org, agross@kernel.org, srinivas.kandagatla@linaro.org,
 Ajit Pandey <ajitp@codeaurora.org>, linux-kernel@vger.kernel.org
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


--aBaYPhOdNx+t7mr3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2020 at 10:38:13AM +0530, Rohit kumar wrote:
> From: Ajit Pandey <ajitp@codeaurora.org>
>=20
> We are allocating dma memory for component->dev but trying to mmap
> such memory for substream->pcm->card->dev. Replace device argument
> in mmap with component->dev to fix this.

This is a bug fix and should've been at the start of the series (or sent
separately) so that it can be applied without the rest of the series.

--aBaYPhOdNx+t7mr3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8F+WAACgkQJNaLcl1U
h9DYdwf/TP/V9rRaqchmnuoLr81D+iZWagfBza40aZnj6L9DmzYz9ujUAXhBwLE3
m0qzU/Y80YabOhh+GByaGdPSPAT+34xYOcFVym6e2Iqq6iJHSIY9OWeChI+ieCKv
1JxhQzQgOBoHjSLmCG/IM6/DaP8Gcab0uEakRbI6wzuhKbZtQ8TmCLD90Igv2Y36
bFNfao34+aQxdmGpe1lLqScooepCZzYeL47nFGlVoXFSG9phR0h+Qwj/ed/5alhn
ntxODL3WdwurRO+1L/TZrPhfrmMolsda9pU0G6Mm4vO2NwXK/bZuYixvckCT7H3S
5frOF/gMTdki5Wl3SDrE8GDvOrX9/w==
=exLA
-----END PGP SIGNATURE-----

--aBaYPhOdNx+t7mr3--
