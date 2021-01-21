Return-Path: <SRS0=oBR+=GY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6183C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 12:31:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0740E239EB
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 12:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0740E239EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38D6516B4;
	Thu, 21 Jan 2021 13:30:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38D6516B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611232292;
	bh=7bGSxVwCt6R9lN37iL/5CUJ5ovzlI7BXQidFJHMM7lo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CjGQ6fAR2ASm9UDZhXPcV5upgLbqglyXiyzoowr1ilAeyph+4lEtI9D2E1JSXsmZt
	 e/xye0hC4+sh9Zq3EUlZSsPnaaRDG9Qi6e4X40+ihYnT808WfochSom/8Eaewvl8FX
	 xNmUdfqKOKIM1hzeIAjK9s4MAl18qT3HwFn5YWl0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BCCA7F80164;
	Thu, 21 Jan 2021 13:30:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 75E9DF80257; Thu, 21 Jan 2021 13:30:20 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19A9AF80162
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2021 13:30:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19A9AF80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rzsR9agW"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B16C5239EF;
 Thu, 21 Jan 2021 12:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611232197;
 bh=7bGSxVwCt6R9lN37iL/5CUJ5ovzlI7BXQidFJHMM7lo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rzsR9agWQ/4c3CEBsqt3rv4Zskh+QaMjmsrn2zVKDUJYgr38RLFDnemkSNMsqA8sW
 ec6uVMa/gSVaxVl5wl4cX9Mo7KKVttP6OSV9fdqsuk7bDV7wqWVnIfwWWT62SpinfL
 hDkyrXtBNceokkWxTaE/my2wLLBgrU1zbZcSWGPNyIfb6obr88Ri9NXeAIKByFLuOe
 e1noewF0XHK1iM339vJSdCkGT9lWL36Xfof/AxZsE528tyX/E89BJ/WD0SEmQ6TH1Y
 R17ResVGGCf8xFPI/E7fsfCrOXGNq/c19NP86Mbg3frNo9UzC9mUdsNcLDxmCy8LI0
 1ETJam/tgOf4g==
Date: Thu, 21 Jan 2021 12:29:18 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: duplicate line at samsung speyside driver
Message-ID: <20210121122918.GA4588@sirena.org.uk>
References: <87h7nb9buz.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <87h7nb9buz.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Generic Fortune.
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


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 21, 2021 at 01:09:18PM +0900, Kuninori Morimoto wrote:

> I noticed samsung speyside driver has duplicate line on audio_paths.
> I think it is typo or something...

Yes, that looks like a mistake.

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAJc50ACgkQJNaLcl1U
h9AADQf/aptj6upcNMF8UUT9iPspFUAt69AhtWHgL7M8zr44ImXauL+PNG+N4vaX
ZrxLuAVnEfwMvrcX0yOemIFhccIM1xqlZfTq5UgqF/kVpvFJhA60T5qz0udw1IWN
cahqd9oOqhoJ/Pz3MeD3VQUDde4KUOEWaPBLcuceYjpenBD/p5Z+ooRp6/rv22aK
AJAHpGCoRY5R4Gj1pzBzHOxlL47uYZFL3BQx0y91RAL2a81jYZGC04ACT0ggoqVF
49MocOG4UHIs+1IziEc3abeL6Ax8KXm2FbgVJJxND9XKTGU9Mo+i95ee+OxPGYAl
iiacSMOuYhseOqOziM30kK02mCrosw==
=HiGb
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
