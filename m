Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53044CD6E43
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2026 11:58:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC7966026D;
	Fri, 29 May 2026 13:58:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC7966026D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780055900;
	bh=XFsgrsCjGSjstVa6RvszBDjXsctRxLUF7p0mxc2muI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NO+Kv0RMD7TYGp+4dobFC8tSwPbTWUegYzrKHLLZ5KzH2JBrm/d9naxthn27llE2B
	 anSQeakeFtzu4+Fk/RWOCuo44j5DQsDtMs1E+iF1JUh5IeQjx3acuSanDmT/1jDnXr
	 gyZScImkzYSXyfquGWR/It5/lMol4PH5HbBaNHSI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2C1B7F805F6; Fri, 29 May 2026 13:57:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E5A2FF805F2;
	Fri, 29 May 2026 13:57:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E611CF804D6; Fri, 29 May 2026 13:57:39 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9360DF801F5
	for <alsa-devel@alsa-project.org>; Fri, 29 May 2026 13:57:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9360DF801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=k/v7zWyu
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8843560103;
	Fri, 29 May 2026 11:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32861F00893;
	Fri, 29 May 2026 11:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780055852;
	bh=sItfJ0cb+MWD2HBd0NIc4WI19pJetbDoSxn5IZKyj6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k/v7zWyuc9EOSppNop7KG6a3jeHgDERG7u5x2jcoHtdnxhcqG7+MTQBSdeyRk6Cfr
	 8LmpDNxBYawAf/kaF65MMeu90vUFcr9gKTkU+sYNY3uYa4aMEHg5haOX+aMs3oXbfy
	 g8jQrG558iBOsfLwHTAmqg1O8z7hsVxoa/fq76k6NOFJG2TUeyBRKklbwrXz5q8ub6
	 szDp0DU/DPTmOk3a2wfum0qBUl9iYr1+ieyzyfvyiphgemJkNf4GwheVu7jfw3r7wW
	 yfhNoxIlZREH9Cr3yHDVTWnBY2Re6UsOALkohuzQsV6mX8XGTcDrPiL7NUUpysYMQA
	 wV2VC8DFSifhQ==
Date: Fri, 29 May 2026 12:57:27 +0100
From: Mark Brown <broonie@kernel.org>
To: YLCHANG2 <neo.chang70@gmail.com>
Cc: Neo Chang <YLCHANG2@nuvoton.com>, lgirdwood@gmail.com, perex@perex.cz,
	robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	kchsu0@nuvoton.com, sjlin0@nuvoton.com
Subject: Re: [PATCH v3 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Message-ID: <cad71e89-ce31-4ed9-837c-9395e020f34d@sirena.org.uk>
References: <20260526015826.440769-1-YLCHANG2@nuvoton.com>
 <20260526015826.440769-3-YLCHANG2@nuvoton.com>
 <d4cf4ad9-82fb-4beb-be5b-b3687f822fcf@sirena.org.uk>
 <1d7a01aa-dd65-129a-c9ac-e24e9b474f8e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tdZd9ctACY54NNcc"
Content-Disposition: inline
In-Reply-To: <1d7a01aa-dd65-129a-c9ac-e24e9b474f8e@gmail.com>
X-Cookie: Equal bytes for women.
Message-ID-Hash: S764U2CFKWDTXK5UWTTSRM36DOAWYIPR
X-Message-ID-Hash: S764U2CFKWDTXK5UWTTSRM36DOAWYIPR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S764U2CFKWDTXK5UWTTSRM36DOAWYIPR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--tdZd9ctACY54NNcc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2026 at 04:49:11PM +0800, YLCHANG2 wrote:
> On 5/27/26 21:43, Mark Brown wrote:
> > On Tue, May 26, 2026 at 09:58:26AM +0800, Neo Chang wrote:

> >     https://sashiko.dev/#/patchset/20260526015826.440769-1-YLCHANG2%40nuvoton.com
> Regarding the sashiko report, I have a few questions:
> Are we required to address every issue caught by sashiko? We found that some
> of them are actually false positives.
> If we need to explain our code regarding sashiko's findings, who should we
> send the reply to?

Just address anything that looks legitimate and ignore the rest.  Part
of the reason I only linked to the review is that I didn't have time to
verify what was accurate in there.

> Additionally, is there a way to run the sashiko checks locally before
> submitting our patches?

You can install it locally, the code for the service itself is
available, but these things being what they are you can't rely on the
output being exactly the same.

--tdZd9ctACY54NNcc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoZfyYACgkQJNaLcl1U
h9Dw/wf/SkgXf8IGxg4KAoclYOkN8Wtjlo+8RpQ79pg0XPSoj92+E09CqQOaW28S
4JRXCkA7YKwsDEpldMqAiCajCafVnlprnH6FrRyhOBUGyeWEyVD5NdV166gl9rRp
YSKXy1AxWE025Eib+QfR5CL1GXTlPLSl44mNok1lpaBW4VHPT2jDY9i1Md6tlKUC
6NPYtuYXeyBSgafHPtH1c1OJX09JyWsraRqMN6cFc2YQqpTAU9FR1SeBDmK/7CxC
4IO7WSR5B/10EkDAIBLSPFqDsnwO2EFu2jOGlletvES9QWgo+vyJcrkkI+9wYfut
g/99OTYNG0sf0eLH9Lk5e8majrOoUA==
=jpYX
-----END PGP SIGNATURE-----

--tdZd9ctACY54NNcc--
