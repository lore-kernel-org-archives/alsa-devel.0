Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054AAC7EE26
	for <alsa-devel@archiver.kernel.org>; Tue, 23 May 2023 17:26:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5DBF61ED;
	Tue, 23 May 2023 19:25:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5DBF61ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684862809;
	bh=hZem+bw/YpKsx96rrifNWNXdixYFstBba2CYEgc/T6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nHq/56ULQkSTiXEgiejM+L6Ps+gdcI0rnWVo4Qh+SuwcKVwb0UlKpJrvQBr+qGnH5
	 omELLflhipI0DCukjo6V3/E6GHd8WYPIrNYWHG0qF80kjl7n1q4ELclJbuxeSmwTZk
	 Tf1VJoTVY6h7wiIOYLLo9Ii25+q79PBlLdYWQYa0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6DE3CF8016A; Tue, 23 May 2023 19:25:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A393F80542;
	Tue, 23 May 2023 19:25:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0018F8024E; Tue, 23 May 2023 19:25:26 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 13721F8016A
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2023 19:25:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13721F8016A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=CWQsINp8
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D05AE62D05;
	Tue, 23 May 2023 17:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7717C433D2;
	Tue, 23 May 2023 17:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684862722;
	bh=hZem+bw/YpKsx96rrifNWNXdixYFstBba2CYEgc/T6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CWQsINp88A7hoy48glJuXnfc3JCjt3kDEhepUVQ9SEyjhPvs1YBvdL0uc95t6UvrF
	 tzv9SKhj8PKfs+SuaIsa+BwtolCHTKGN29n7rWBsVGs+R0clBApQ7fQOUPUTzyiBjN
	 jPtMlfNp22SRQx+dFgISC34Ooe/5HcRzSmLwq3HOyNiV7RcOORbWT8HselDTw3wVBV
	 FRIc9jWalv6c3qJtdsko9iz85YyL9ndqYxD8BnBgoNSphvjg/s8qVumU95MyKdR0Je
	 1u5mmlmlT+l7SIU9ouh4PFUcKoVHMLLcorvnD19j6DwKlLXcSHBBeIqohKDZqFW73b
	 XdkiqLtzZtl4w==
Date: Tue, 23 May 2023 18:25:17 +0100
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
	ckeepax@opensource.cirrus.com, tanureal@opensource.cirrus.com,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] regmap: sdw: check for invalid multi-register writes
 config
Message-ID: <f9484905-fc8d-450a-bc52-00ba99db0d1f@sirena.org.uk>
References: <20230523154747.5429-1-srinivas.kandagatla@linaro.org>
 <dd2d2484-13f9-4fa6-85d2-5a540f137b3a@sirena.org.uk>
 <1f34ca48-75cc-d824-2230-7375146ad970@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oa+ySSvabEXrwp8E"
Content-Disposition: inline
In-Reply-To: <1f34ca48-75cc-d824-2230-7375146ad970@linaro.org>
X-Cookie: Beware of low-flying butterflies.
Message-ID-Hash: RUVXVH6OY3AC46SH5BJZZSKT55HS7V3G
X-Message-ID-Hash: RUVXVH6OY3AC46SH5BJZZSKT55HS7V3G
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RUVXVH6OY3AC46SH5BJZZSKT55HS7V3G/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--oa+ySSvabEXrwp8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 23, 2023 at 06:13:25PM +0100, Srinivas Kandagatla wrote:
> On 23/05/2023 17:58, Mark Brown wrote:
> > On Tue, May 23, 2023 at 04:47:47PM +0100, Srinivas Kandagatla wrote:

> > > +	/* Only bulk writes are supported not multi-register writes */
> > > +	if (config->can_multi_write)
> > > +		return -ENOTSUPP;

> > This doesn't seem like the right fix - I'd expect us to simply choose
> > not to use multiple writes, with an additional flag/check for bus
> > support.

> Is there a way to check if bus support multi-register writes?

> All I can see from the code is that regmap can_multi_write is set based on
> regmap_config from device and write callback from bus.

No, that'd be the additional flag/check bit - see also my question about
if this is something the hardware actually has or not on the CODEC patch.

--oa+ySSvabEXrwp8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRs9vwACgkQJNaLcl1U
h9C9qQf/auuUdT7K6tq7nbLMF/9lM7W/KynIXf3fmUgnWGNiCTCQ/zZTZwMuY5Ec
24PUvz8TnI/gwcFmKwzgOxvD51YTXGTcUHxB1bVv2Ol4nYh4kcULH4iTRlum71qC
D6zDXorhSconpwGee90Dlcq5Y7hX9O2bVLvyJLByfBXhsm2xR0/tt9leRuIWKIJu
PoKJtBBTUTtFUCeOLq2Uy8M9lrY5iDKVIpzJxhvf9DIeWukao/tBQSPgCbnd88sE
w/DJJ5YxrC+qBox+QgNZtbHFbxtm3RMxZJZpiraG4ti/4MxhbvuQJYzvJcGG+XkM
FRILCfhwat7ClnuVQMReWeIq7y8CYA==
=DdSa
-----END PGP SIGNATURE-----

--oa+ySSvabEXrwp8E--
