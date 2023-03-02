Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1119C6FA8E
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Mar 2023 17:29:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C2FD82C;
	Thu,  2 Mar 2023 18:28:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C2FD82C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677778151;
	bh=iilU92fnhVkjswDzFSRq9gc9hVZYATbY55ueOQu1GxE=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kenD6Ian2/gsa6nJIkxRjei2KsuTIQOphU/TQOgGdwExgjoQCe+Eg8fML9CO0+Egj
	 svOKPYdEdZTld/FlgX96U6+6tfq5hXzqTyLZ2kETA3Af72tVfqblwYiQmWH55pvybl
	 r3L1Ix3wcR8KM0hXBBpVYL7Tp/Rq9QVLkA6nqA3k=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BA1BF80266;
	Thu,  2 Mar 2023 18:27:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6C5FAF80266; Thu,  2 Mar 2023 18:27:56 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 99BC5F800C9
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2023 18:27:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99BC5F800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=sMfIx0K7
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id A3707B812A8;
	Thu,  2 Mar 2023 17:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84F8C433D2;
	Thu,  2 Mar 2023 17:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677778068;
	bh=iilU92fnhVkjswDzFSRq9gc9hVZYATbY55ueOQu1GxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sMfIx0K78J3pzDSDmxKqRKBpqAlExyLj9g/oTCz+YNOVMQViOSImdurWPYoxw1134
	 XIoMKr/HCrQuBnEkclLZ/BW16rgj8+gwsjSBngGa9Ro+TeZaQJmsp6S52NXAO/4OnZ
	 FzpSdU3nqjkYNIRJTAydtZ1lQ/XF32zv6m1BoCgn7PCoVD7jcn/S3q+dY3XCiOAvkl
	 rDGrUen3h0Uvp6gKR3GlhF+lHImAnCE6pfZGpkAN6qg7JrR6yTYorspYDcfOHMP1/9
	 ut/EFMtY06nf7dfOjMouMYfL6JXFBqckHPdujCpeu/xrrP1zcS02fnPptuz7zmSgGz
	 Hq20jqvlMCY4g==
Date: Thu, 2 Mar 2023 17:27:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Subject: Re: [PATCH 5/5] ASoC: cs35l45: Hibernation support
Message-ID: <e25417af-e524-4462-9d78-c66cf994eb1e@sirena.org.uk>
References: <20230302172636.2344058-1-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+XSwFAWCKUTMt1r3"
Content-Disposition: inline
In-Reply-To: <20230302172636.2344058-1-vkarpovi@opensource.cirrus.com>
X-Cookie: Who messed with my anti-paranoia shot?
Message-ID-Hash: 3LHLZXM4ZZS7OLJNGWBOQNWFUPH5YWOD
X-Message-ID-Hash: 3LHLZXM4ZZS7OLJNGWBOQNWFUPH5YWOD
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3LHLZXM4ZZS7OLJNGWBOQNWFUPH5YWOD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--+XSwFAWCKUTMt1r3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2023 at 11:26:36AM -0600, Vlad Karpovich wrote:
> From: "Vlad.Karpovich" <vkarpovi@opensource.cirrus.com>
>=20
> Adds support for the amplifier hibernation controlled by
> DSP firmware.

I've now got three copies of this patch (just this one, the first four
only came once).

--+XSwFAWCKUTMt1r3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQA3I4ACgkQJNaLcl1U
h9BxTwf8CqFx8xiI5xarOP7OEAY77GoBP2ovOFBb2GlIQB2nkvZ/QnmIaVkLtPi/
G+CLiA/LI45Z3ZXAUOjCKG28yB0LdZqisw+PfkLuv6Ei4CseO3a5uZtByDxHXjg2
+iQ2oeMd+laVmVlSe7U4Ee8OA8OC3AZvSerMtfZKQNck+ort8T5Aq/CGPMBJpvMY
eFVToM2V7HtI/UricmyQav8gDQ4jMDBi4x8oF8ge65hK/3xszfvTSDLrAh7kmqNW
qRbrz3TLlrhAkIi+Oyjps7udEGG5gLEoAqC2z/4B5a+Oikk8PE5RWNG4p7cH3CoB
Ix5yHl9JCErMJxuU3D2GOUBpNd12uA==
=Jlgw
-----END PGP SIGNATURE-----

--+XSwFAWCKUTMt1r3--
