Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D999D39413
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Apr 2026 11:15:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E2AE601F9;
	Thu,  2 Apr 2026 13:14:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E2AE601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775128508;
	bh=vyJMYLjdFlH+0xfoWjq++mQc6Ket/fKbPjZQRk+zEas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=agSnfigzV0+WhQE2mWSWOX+sbTM+qCeCxZlbewPQESwi4L0jOUoOpx19DoH3OjW3S
	 2QcAkERCHwvJ4n8ivGvnozEYaD2f9aMAtXRhdL2PJRImZsb5nMdFqLbcqBLJGbh4yx
	 yJBe/uy2JkKabmhp1AR2KJ8wtHXO2fmSnQ+O4Ock=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D4B3F805E5; Thu,  2 Apr 2026 13:14:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 527E8F805F4;
	Thu,  2 Apr 2026 13:14:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 80A0BF80496; Thu,  2 Apr 2026 13:14:23 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8E812F800EE
	for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2026 13:14:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E812F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=pNtJ9MWa
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 393C86012B;
	Thu,  2 Apr 2026 11:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BC5C2BC9E;
	Thu,  2 Apr 2026 11:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775128458;
	bh=vyJMYLjdFlH+0xfoWjq++mQc6Ket/fKbPjZQRk+zEas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pNtJ9MWaNaZ50wgbuoGu8tH8boZYa0KJwU0oxdW3GduBWOXNXF4ldplaptS3bG95J
	 xejVWoTlYZgvADDXosTGCzrMNh/KIid0U+vDKPLVe3D/M9oNJz81VSiXZCNqor2fsq
	 oUBlKOJz0qpXGx91chDtLhgon5uZ8JXlySiAfJ8kgcdN3FLkQBpPfMSGMwxZsZP46G
	 LSTRmZ1eCvrHvSxPXwULUv8NQ1y4xg1tdpJm0IGS9gY4oKNZHo3ylbJKolCh0yR4Hj
	 n9XVvFQb1CKVYnIO6nV7L3LFzTOJENlCAOMchJ8IFRmoOAE1PFeK0x+MVOrYq3YL5T
	 9Bb17Xp+tDwyA==
Date: Thu, 2 Apr 2026 12:14:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Jack Yu <jack.yu@realtek.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"Flove(HsinFu)" <flove@realtek.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>,
	Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>
Subject: Re: [PATCH] ASoC: rt1320-sdw: kcontrol for brown-out feature switch
Message-ID: <4b7c98da-63ef-43bf-83f5-dd00ad45d81f@sirena.org.uk>
References: <20260401093107.632673-1-jack.yu@realtek.com>
 <e5623b92-fe3a-4c3d-a93f-a9acb1fd8181@sirena.org.uk>
 <9aff5474398c4ac79f18f356512b5181@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FJVjbN+JxY2cLYwG"
Content-Disposition: inline
In-Reply-To: <9aff5474398c4ac79f18f356512b5181@realtek.com>
X-Cookie: <doogie> dpkg has bugs?  no way!
Message-ID-Hash: LPVITX77FGQDWQK542LZ76X2C3NTGQY5
X-Message-ID-Hash: LPVITX77FGQDWQK542LZ76X2C3NTGQY5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LPVITX77FGQDWQK542LZ76X2C3NTGQY5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--FJVjbN+JxY2cLYwG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 02, 2026 at 04:37:53AM +0000, Jack Yu wrote:

> > > +static const char * const rt1320_brown_out_mode[] = {
> > > +	"On",
> > > +	"Off",
> > > +};

> > > +static SOC_ENUM_SINGLE_DECL(rt1320_brown_out_enum, 0, 0,
> > > +	rt1320_brown_out_mode);

> > On/off switches should be a Switch control, not an enum.

> Maybe the name of kcontrol leads to misunderstand, it's just an effect setting for amplifier.
> I'll update this and use another control type but not enum.

Turning effects on and off are still things being turned on and off.

--FJVjbN+JxY2cLYwG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnOT4UACgkQJNaLcl1U
h9BgEQf/XDCevFJaxs1nzAVG2xV2v2BXz7zHXmvuXRt6A673uch0e6OSL1xDoryx
UYYQCs7L5JAWCM9VDol3qox3npuctDCPWJP8Cni9sjfTrmTSVOxvyUM1UY0/QFcr
3nGl3FTQCdLfBklhWcE+gaG2mrPFn6Af/hR+3mgd85debFlE9ByIRptqlY4iuR+L
azg/HzTEMHpS7Q0HVUtXrCrB82gef7Ffyv5AovIJK8rJN6n4WYLBxfHqKwmlpGwR
jdz6mzC1+Y4EQqSD/eYrJf2IMUMSK3JC7eEgErkM/nCaQ7m4dcUQfMUrItzlW58s
8dszQVPXICPbphdm64Z1KJKW/QKMtA==
=TiiV
-----END PGP SIGNATURE-----

--FJVjbN+JxY2cLYwG--
