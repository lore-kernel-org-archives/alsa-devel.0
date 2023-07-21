Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F7EEB64DC
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Jul 2023 14:54:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC81B204;
	Fri, 21 Jul 2023 16:53:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC81B204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689951269;
	bh=vtVnGZ2RXU7NehUk7NlLf6nLv5bc76kKbS+lg0mNhAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JaIcgcsAWFLSuzWQQc6nnsm3muQK4BbjiYqpWkZNWahz45BaPFybmI9pnY+4D7KOl
	 JfUt3B+apzv2Ifk6v5uAPGHEsomlRshIiTb9qswjvDeeeajgOp4v5HfRLOK8bm81df
	 84ybdRWQtfZw3JCiXkFrp7oMnUcfSVoANGJUaouI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B60C3F80494; Fri, 21 Jul 2023 16:53:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3515AF8047D;
	Fri, 21 Jul 2023 16:53:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 98CACF8047D; Fri, 21 Jul 2023 16:53:03 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5C919F800D2
	for <alsa-devel@alsa-project.org>; Fri, 21 Jul 2023 16:52:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C919F800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=E4MCcDGu
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 43DE861B41;
	Fri, 21 Jul 2023 14:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194B3C433C8;
	Fri, 21 Jul 2023 14:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689951176;
	bh=vtVnGZ2RXU7NehUk7NlLf6nLv5bc76kKbS+lg0mNhAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E4MCcDGu+tle/EKitSAd6aNWqwdiFz5TnRVkvMjCjiic6g1O1LfXvWXYyIRY8U3Hr
	 xrhLZydTd65mnGz5ZcdDSgrVDHjDuGlsY04T+k3dpTTjT040IA03dHZg+zxDD0u7zv
	 IkneHQ0WfLmoF3kF2opepCA83Own+drVh6+LqDKce+SOeoi6SVo7ytVnv3ZYTQap/a
	 0GPD0qu3eLtWvsCCb8NUjvJfZ0BEtMXhnu/xQwbMjpAQ1xROuXFlBhoa2dYbEgdoBK
	 7fDzhnzQiQpXzXmkXsEr3PPNhjjEnWWFGtCFBpQ7YgczmN7siLfOKJ2waHGSOkwnOt
	 0mqlfmFEj1vbA==
Date: Fri, 21 Jul 2023 15:52:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>, tiwai@suse.com,
	perex@perex.cz, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v5 00/11] ALSA: hda: Adding support for CS35L56 on HDA
 systems
Message-ID: <d7f96ecc-3900-4149-94b4-8bf96dc0728c@sirena.org.uk>
References: <20230721132120.5523-1-rf@opensource.cirrus.com>
 <87bkg5z5c4.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n0NYlQtDrz93hsxo"
Content-Disposition: inline
In-Reply-To: <87bkg5z5c4.wl-tiwai@suse.de>
X-Cookie: Do, or do not
Message-ID-Hash: R2FEIRU7UA44LNFU66CBX7BAU64RGYIL
X-Message-ID-Hash: R2FEIRU7UA44LNFU66CBX7BAU64RGYIL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/R2FEIRU7UA44LNFU66CBX7BAU64RGYIL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--n0NYlQtDrz93hsxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 21, 2023 at 04:50:35PM +0200, Takashi Iwai wrote:
> Richard Fitzgerald wrote:

> > Changes are trivial so I have carried forward Mark's and Takashi's acks.

> Mark, I suppose it's fine to take all of those to my sound.git tree?

Should be.  Might be handy to have a branch to pull from in case of
conflicts I guess but probably not essential?

--n0NYlQtDrz93hsxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS6m8MACgkQJNaLcl1U
h9C3TAf+O4sNPx4efX134iRtM5GDWQTtPtEpS60ujm6bSTONrcvy4zyNcY5UOfR4
oyQP5xl1PgBJKhUwOqjwYvE4g6ZlJPt5YXOjIYdUZNm+OO+cM+3tVv2blewpqsVx
c3ca4p4KBJS8FGBJIIOiK5k8vwLLwW+o3zJVuDB/W6rZurTKBE6Ph9GyL/YLsx0f
v3efNtm3EoSXFp+LwVOxPbc48IbpA08bZhv+31KKZqeoeEQhMmHl55eRfr4V+Lwn
JAslTfEfn1oJUKrCUWKZ/xEzKkTo0m4l5ialNdxboLly/vHV/KYFgRyIxJavwn5g
8/IAOdFKdAQ7HewGdFExz2T7dpH2jg==
=NcQm
-----END PGP SIGNATURE-----

--n0NYlQtDrz93hsxo--
