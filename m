Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9148FEDB7EF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2026 10:57:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1903F601F4;
	Tue,  7 Apr 2026 12:57:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1903F601F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775559463;
	bh=tK6nJLV94KE8Ah7j5c3+NuOdwMBeRIKUyvjlX7hT9dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ntTcFmCb2+u8h05kH1TjON7tAdpyLvQJctditGKhsdnGfKq+H2HHBDcQXxz5QnBXC
	 nRMX3dPG+O8n2RPGO2WNyJNq2wk5wRrZb1qz+O4VH2eslhM4uGiTtWXibZxfaMHrGj
	 PYzl1TIadpsKr2owCzvCx+YxRAAcrVQj/JXFASiU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E708DF805F1; Tue,  7 Apr 2026 12:57:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 88F9BF805E6;
	Tue,  7 Apr 2026 12:57:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6978DF80548; Tue,  7 Apr 2026 12:56:58 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4BF83F8016D
	for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2026 12:56:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4BF83F8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=DvzgR1Pu
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 25B6C43B24;
	Tue,  7 Apr 2026 10:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8F0C19421;
	Tue,  7 Apr 2026 10:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775559413;
	bh=tK6nJLV94KE8Ah7j5c3+NuOdwMBeRIKUyvjlX7hT9dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DvzgR1PuHFRZmerjyBeCJktzraK46/2ele0hmTjbYUugSsk24IM0t7qK3upbHpZfU
	 zIYIfY20xVtOJrkspc3GY16bnIlZOp3kfdJ1L7NPUFOvqJVygN+QLqoR8HMFwILtDN
	 kMAt03KXJJVji4PAyuJ6bxM54M3nsfrheBBDSFZBKvBr5IGTjjS5v7kAP9SIXho0cq
	 N72gBYTjaRo6S3cbIEAD/dyFrBVcLPBLu1hBvi3O/m3SgGwzXWFdC7P1AK19lfCF1z
	 3lVpkmWu8DNfLz/827c9RdZ89EVFn/RsiGCVva3m2qCr1fDB51wWaA2ch0usAekh9l
	 dxzta2tZ4SOUw==
Date: Tue, 7 Apr 2026 11:56:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Jack Yu <jack.yu@realtek.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"Flove(HsinFu)" <flove@realtek.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>,
	Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>
Subject: Re: [PATCH 1/2] ASoC: rt1320-sdw: kcontrol for brown-out feature
 update
Message-ID: <3d65dc81-24f6-446b-82cd-2748e6f798be@sirena.org.uk>
References: <20260402054716.1795350-1-jack.yu@realtek.com>
 <55886bf3-5837-4f37-b60d-333fdc5f5f70@sirena.org.uk>
 <b58acdb490524d22a229914a7b63f03a@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4WAfkIJiKM4DUYLg"
Content-Disposition: inline
In-Reply-To: <b58acdb490524d22a229914a7b63f03a@realtek.com>
X-Cookie: Now, let's SEND OUT for QUICHE!!
Message-ID-Hash: S7NJBQYJ4PRN5IODYEXE6EPJZF2JHEGC
X-Message-ID-Hash: S7NJBQYJ4PRN5IODYEXE6EPJZF2JHEGC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S7NJBQYJ4PRN5IODYEXE6EPJZF2JHEGC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--4WAfkIJiKM4DUYLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 07, 2026 at 09:08:33AM +0000, Jack Yu wrote:

> > > +	SOC_SINGLE_EXT("Brown Out Update", SND_SOC_NOPM, 0, 1, 0,
> > > +		rt1320_brown_out_get, rt1320_brown_out_put),

> > Like I say this should be a Switch - it's an on/off control, even if it's for an
> > algorithm.
i
> Do you mean I should use "Brown Out Switch" instead of "Brown Out Update"?
> And still use SOC_SINGLE_EXT for declaration, like below
>  SOC_SINGLE_EXT("Brown Out Switch", SND_SOC_NOPM, 0, 1, 0,
> 		 rt1320_brown_out_get, rt1320_brown_out_put)

Yes, something like that.

--4WAfkIJiKM4DUYLg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnU4vAACgkQJNaLcl1U
h9CGIwgAhQPUwrriQhaSCltTOINEQz6hw9DTthgDfQz0surB9njfrEUEQ/Uop3aW
i576199mshrOEOopCpcQf6vM+JYyM52cdeu2V6XB5thl0ts9LPBNm3LIMy8b25jY
yLIqGhTfY+JfMXkw2XuDFEH0Bb/xxlbuKXRM4ZjK2aSCxes01MV/HWb5EusSmWc8
tJjH8VSMgS6lpJXOslIxttJ5nABnUUSt45lF6sHnBLKHrm8xADielIizXZJDXXbA
bmEre076R4+NxdZ0sllGZDWSqfKZoCEv7cOG1a2EM5vkJmG1J1LMInMnryeji4Mi
DvGF0fBCF2nwyi06IEp5kJ3PF/617A==
=KfeW
-----END PGP SIGNATURE-----

--4WAfkIJiKM4DUYLg--
