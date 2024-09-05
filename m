Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023AFCD5BAE
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Sep 2024 12:30:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 31B4B846;
	Thu,  5 Sep 2024 14:29:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 31B4B846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1725539401;
	bh=H4+96Rs0eZGJHC+ieItiYQcb8B7fTyz/Z/h9kUoQfKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=co8w4tunjuW+LJ5CUlrO0CgKbj1VJNE+uDeJIzgyMP0OKW+lhxBLZtIBGSf+lB+ts
	 979XexkO5ANy8DjNt/NOFD660A8UAI3shi8OfIwXkgV6fuT7B5u7ijROYGIOMPaIxX
	 BNsTvj+pSQAWU/RUjVKUk3Q2GbileBisSBgYwAv4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0C21F80527; Thu,  5 Sep 2024 14:29:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E724F804FC;
	Thu,  5 Sep 2024 14:29:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A991EF8016C; Thu,  5 Sep 2024 14:29:23 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5FEE3F80027
	for <alsa-devel@alsa-project.org>; Thu,  5 Sep 2024 14:29:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5FEE3F80027
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Et9JOb8u
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 854245C5BC3;
	Thu,  5 Sep 2024 12:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08282C4CEC3;
	Thu,  5 Sep 2024 12:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725539358;
	bh=H4+96Rs0eZGJHC+ieItiYQcb8B7fTyz/Z/h9kUoQfKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Et9JOb8uHz92o1V0Q7JKvfzdl3Cnb+0JtjEWNuB9iBp+TkMewkG2DFtplUhydYJ/F
	 6OHRkmm2lnfQjJvzb6Do1Tp6gXZ0gPHToRxQB43UV3pNbtS7qmBch88HSo0YrhkO6K
	 uYvb9MuIXVC0+QFBcgCYMkQdytaeFnekqwnldKUzTntV4L99bX0uJa+0AS9AnGrhR+
	 5RyBMtZDQIp6NQOvR5OlvJtKrxVjHajIhYK3+zFeWWbAmDeDD7JgLSfVnz1JFjPl52
	 g8NLQ92GCyIRF7vEPYQqQaopYd1t+ruGGFLLcRJUQCC0T5vfM9lWPckoX5SN0gIXWe
	 OkXyV2SZsfVWw==
Date: Thu, 5 Sep 2024 13:29:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: How to handle complex Codec2Codec
Message-ID: <aeb9d0e9-ac50-40c4-88dd-30cfa164d7c8@sirena.org.uk>
References: <8734moq6ca.wl-kuninori.morimoto.gx@renesas.com>
 <31fb2975-4a27-43e5-b9cb-37db3206f5f3@sirena.org.uk>
 <87ed62ogvp.wl-kuninori.morimoto.gx@renesas.com>
 <fe428f02-3eca-4dce-9eef-675cf3e56831@sirena.org.uk>
 <87plpikfgv.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="paIqaaTk5VDTngLO"
Content-Disposition: inline
In-Reply-To: <87plpikfgv.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: The horror... the horror!
Message-ID-Hash: HA7KTBEEMHJVHO4QPGMSFM7EXLCGLMOW
X-Message-ID-Hash: HA7KTBEEMHJVHO4QPGMSFM7EXLCGLMOW
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HA7KTBEEMHJVHO4QPGMSFM7EXLCGLMOW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--paIqaaTk5VDTngLO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 02:21:37AM +0000, Kuninori Morimoto wrote:

> We want to have new style connection which is more flexible, and is
> possible to handle all connection in same way ?
> ... that may be an exaggeration.

Yeah, at a super high level we want to be able to handle digital audio
with DAPM like analog audio, the main thing is we'd need to propagate
digital parameters along as well as just on/off status, and support
conversions.

--paIqaaTk5VDTngLO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbZpBoACgkQJNaLcl1U
h9Bccgf/f2lLuEtHnyWy98y0oSopPNg4B0CLE3FW5qFPyVSfBe/O7aH/KORWMJYG
5nG511twglZjGgzfflMe8tksXqOIAJ5crittJri2uKqssc43EYQjcRDEpeGQ8ruG
+ykt+VEuYqaLL/lQUvbtkaqBtwLpO43YpHRLJFLanYtL2vD21nqQDdO0dKwt7D3a
RE0stMYPhCZ5Ul2nDgwS64S3yw224Jiu21w4/pb0HIw6DA1GqpSgA4hZzu2BkSk3
xiR+aLjVBPwEBP+EnPST4NIckKLUCgMVCOgtL9KN5wAWvRlgzmHl7/hZOaKj3GPf
jIdEPdRN7DQF7l02OpyCzL+EiTeaTQ==
=2wJs
-----END PGP SIGNATURE-----

--paIqaaTk5VDTngLO--
