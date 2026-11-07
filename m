Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5867606A32C
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Nov 2026 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=gjvNQvdx;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iefJ9knp
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C41A6601DC;
	Sat,  7 Nov 2026 13:10:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C41A6601DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794053457;
	bh=YBhR0SBtg6KlCo1V3SMX7Tw913wF2A5AEc9Urwmx+Sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gjvNQvdxdOU/rfiMceYucaGm7uzIhJ9Y2c4D6JAwrBi+dvgSfRNs8tQBF2Eln6fRj
	 szlfqzbtnRVKunJ13t/nZNo/p4EZ4jgvQYuv+fqMFl0WwJU7gs3XwhUrXyhJqTGFkH
	 2l5SqSy8S+0mJHXT5SHvfCjSH23WFxJzZVu0zW/o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2CE25F805FF; Sat,  7 Nov 2026 13:10:23 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59F2EF805F4;
	Sat,  7 Nov 2026 13:10:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 49517F805A8; Sat,  7 Nov 2026 13:10:16 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794053415;
	b=cZGHL5cbvV1Xrx9j93ojOEAqhRaUuXupXX3M4dqAAQQPcIclYleL0MvxuNuHnG8+4POd
	 bUxuxXhIgmY/iUIEc/Vaz1byJa7EEE9C1hLiiZB3ndnJmH+F8Dd2ruuejZ9ZmMh3c1Q57
	 QxAptwWWx4xXQnQ4wasK/1NcT3XtMP9feGZFXm73PfA/mMNrlRfxi+K89jeVZoQ79GFPd
	 2g3l+Va9RPSwpqyGwCHGT/5dEvxF0VfQJBHX4vorXJuH1WadOmVEax/tCtyaxHsp8/+yF
	 PN/G36Fp14TAzcIpe1IOiYwBCnpnmrChnmxMjpveQVVzJanOMVkXB5wq/uF3G0JgT9A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794053415;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=YBhR0SBtg6KlCo1V3SMX7Tw913wF2A5AEc9Urwmx+Sk=;
	b=RitD1wLwWVEOh94Anja2z0B4854kxg6znS2ejPZkUhgOUJAjaeSiduH1Gl9sGUHKN8Ru
	 7l4sN/OEheQJd+Y3JpwpQMFN4iExoBRqbxoZoupFUlm8NHVi9NSaPSff963eWyQRlY2tC
	 OfIpoDah5BpQa53RSbO6/F0Q+KyUubEA4vrpU6FPMFLxmMPrZCliMRC7y93MESXsHC2qu
	 RQ49VRN6SeJ52j9Djk160cayQNlqzvOhMc2cA5MDLGCFqHuTvofuo5UZKJCO6AfHYD2uC
	 1ObpbqdXES1dT0MIDKYXFVINqAp7nr6V+a46o1hPMLEKWvduLyNZQp/5RZr9PsbtnOg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iefJ9knp;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3D98CF80124
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2026 13:10:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D98CF80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iefJ9knp
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5412340D75;
	Sat,  7 Nov 2026 12:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157D91F0089F;
	Sat,  7 Nov 2026 12:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794053411;
	bh=JPvnS4HnNvFpCdB+fLWvtdZpUVQP5c/sCfJFgiF3AnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iefJ9knp+iuKbO2lI82nX8yML6cOIyFEWoubEVzDdOi/WRBK8/oWQ0vWV5uaaEpIz
	 d7C3OQ7X1vvlnfrzZMCTKcXxyE12u4wNzro9kbFFS4lUZsS0pg7EWd3EqXtXcsQa3M
	 oU/4mEskx+BewbrtNN3Ugr+B38ybM9QbHjOHDpf8HuGQUWNIGTs5w2eqaXd4+ob35z
	 dvK8hWKUC5iWnmgKCOVfvdyS5+IHLFUanNJBKUpTHwziaQJbSycOlwf3Z3fhGrOTZZ
	 uarsXAV21eotxOURKdkT1RVaQhcYi6y4jMvqR+tq7XyvHV8KENj401GCGdwPKDxpvv
	 32PuizIjn6G+w==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 488B228F6C44; Sat, 07 Nov 2026 12:10:08 +0000 (GMT)
Date: Sat, 7 Nov 2026 12:10:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v7.4-rc1
Message-ID: <c40c4999-8eb1-4175-a2ec-d82afdf456f9@sirena.org.uk>
References: <20261107113234.7C6DB28F32EB@traversing.sirena.org.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LhsjUHfp/Oga+bJA"
Content-Disposition: inline
In-Reply-To: <20261107113234.7C6DB28F32EB@traversing.sirena.org.uk>
X-Cookie: Whoever dies with the most toys wins.
Message-ID-Hash: A5QCZLOO6UXNCLL2PQODT4NNMQD7CGGL
X-Message-ID-Hash: A5QCZLOO6UXNCLL2PQODT4NNMQD7CGGL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/A5QCZLOO6UXNCLL2PQODT4NNMQD7CGGL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>


--LhsjUHfp/Oga+bJA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 07, 2026 at 11:32:34AM +0000, Mark Brown wrote:
> The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7=
e4:
>=20
>   Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/=
asoc-fix-v7.4-rc1

Sorry, my scripts got confused - this is duplicated.

--LhsjUHfp/Oga+bJA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCau8VIAAKCRAv73Ows9A4
iSreAP0Tm44/1x5KzwiVsJUSyDT4IYYZHC9REQc9AZUVjCMIvAEAp4w8ec/Hwt5z
CpABLrIXlVAqp775rZ6dpmo0NBVlIQw=
=hAYN
-----END PGP SIGNATURE-----

--LhsjUHfp/Oga+bJA--
