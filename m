Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B90EE7FF4
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Sep 2023 14:30:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4EED11E2;
	Mon, 11 Sep 2023 16:29:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4EED11E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694442642;
	bh=AigyTmddvwvr5mfoNvzt6guQgCiVr/QlkeCPzes3DpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=LTGJr+kCOtLCzBFGXPUoFl9svdD3YGcq+gsbgZdG/WGZZCVIWYzjv/h8L9au1yMeV
	 9pVigs5b+t/INLpBskcIXoYR8tb8D6oE4wgbeGeQZ2qidvaQreBGtTsrjlcF7X7Lk7
	 LL/EeWQvFkpZciTFYB865ukD9Atf4p9GnfSFecgA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7B1A4F8007C; Mon, 11 Sep 2023 16:29:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 05396F80425;
	Mon, 11 Sep 2023 16:29:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4DD3FF80425; Mon, 11 Sep 2023 16:29:17 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EBB41F8007C
	for <alsa-devel@alsa-project.org>; Mon, 11 Sep 2023 16:29:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EBB41F8007C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XLI6T+Pp
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 03E22CE16F9;
	Mon, 11 Sep 2023 14:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4D1C433CB;
	Mon, 11 Sep 2023 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694442544;
	bh=AigyTmddvwvr5mfoNvzt6guQgCiVr/QlkeCPzes3DpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLI6T+Pp+fXc6eZt4Rlqy8LMVXTEOollEM8Ic8DUPtv5m5HijnH7t2DTBjAO32w6q
	 VVhhOd05/0L6qET6YIoB+rzt/mnqUZF6H6yQ2ylqmKbtvSUTcyKuvRh3R3BesS9qEr
	 Cgn+8FFSCeMyQfj3qnRcURWBTYSbRABZ4AKHqWKGSaRZoMDO8zne5qTHKG2aidDeBF
	 q6bH3iA798CQr4f6nTMh1SFXk+Zi0qIcviqrpkLkiBHoHEOSjN9ieLLifj3Xy/PSA2
	 bCq1o4NOgH31hEaVOnUflk77kd0PkpKdjNuFcGsnV0jm5j7axwkUn2A26u4aXea4SZ
	 McvPpsjB4m1vQ==
Date: Mon, 11 Sep 2023 15:29:00 +0100
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: Takashi Iwai <tiwai@suse.com>, kernel@collabora.com,
	Jaroslav Kysela <perex@perex.cz>, Shuah Khan <shuah@kernel.org>,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] kselftest/alsa: Mark test plan as skipped when no cards
 are available
Message-ID: <ZP8kLM5ln2YBCHap@finisterre.sirena.org.uk>
References: <20230908181242.95714-1-nfraprado@collabora.com>
 <0fa0901e-d271-438d-bc2b-11399ad3b07c@sirena.org.uk>
 <868a8f08-ba39-4550-8e7b-0572ea03c4e7@notapiano>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="upLhFwPGUAS0CWZq"
Content-Disposition: inline
In-Reply-To: <868a8f08-ba39-4550-8e7b-0572ea03c4e7@notapiano>
X-Cookie: Save energy:  Drive a smaller shell.
Message-ID-Hash: CLQR5DYQXC4S3DZOARCQ5XKT7EX4D3X3
X-Message-ID-Hash: CLQR5DYQXC4S3DZOARCQ5XKT7EX4D3X3
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CLQR5DYQXC4S3DZOARCQ5XKT7EX4D3X3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--upLhFwPGUAS0CWZq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 08:35:37AM -0400, N=EDcolas F. R. A. Prado wrote:
> On Sat, Sep 09, 2023 at 12:08:22AM +0100, Mark Brown wrote:

> > Why?

> To better reflect the actual test plan status. If 0 tests were run, it do=
esn't
> really make sense to say that the test plan passed, rather it was skipped=
 since
> nothing was run. So with this change, if there's a regression that preven=
ts the
> soundcard driver from even probing, the result won't be "pass", but "skip=
", and
> the reason 'No soundcard available' will be in the logs.

So, I would interpret the overall result for the suite as being "No
errors were found in any of the cards discovered" if there is no
configuration file specified which enumerates the set of cards that are
expected (if there is a config file that's a different matter, we know
what we're expecting).  I'm not sure that the different behaviour for 0
cards is super useful.

--upLhFwPGUAS0CWZq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT/JCsACgkQJNaLcl1U
h9BPVAf/RSFHSOlUvU0zkBcxBW+G0eqxamHxmKQmBzKhecWQfBvToFYzyPMTI8hj
1nkjmK70vMjHhjLZZri+srrnWwBLzVknDtJbaMFXkzFQibRN3P/60ChXGtg9WC1X
5YzCyo+Na071zvmceag5yoyC55RoWZiMknKj89Y4DjL6cnExT7MEHuBGlwioUjjP
1NApQduQGNWL8TNDcUkbDRa+ZPAkB6LspNVY4J7+S+R8jCqIINtX/YlKK+1oz60a
50FFhWVNgjGigFqy/yGMaAocWDhSkTrf5xqHb5CjlaleQlhSW1Lh/TVaClZNPI9E
0F0Aj163sUBtchAoz9QUWSmzw0qWDg==
=bHB7
-----END PGP SIGNATURE-----

--upLhFwPGUAS0CWZq--
