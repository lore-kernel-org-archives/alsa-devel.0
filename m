Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1E8C25B10
	for <alsa-devel@archiver.kernel.org>; Fri, 10 May 2024 06:14:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E3B4AE8;
	Fri, 10 May 2024 08:14:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E3B4AE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1715321695;
	bh=GcGGzGvYTnpARMt/AI5IU7S4k5OFyk1tpsWpYMoYjcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vBXn5iyX1iw+ksoCCvTfe9gJIWJOYaab4rMzKFWtMzMb48VSMJvOBv30dgGZEac0x
	 Byrvqs/pkIVSl0a+K+VNHDGzg9gj/tVK6ST63TyBsTYfG3rveu/64aJutG+CiQgZTO
	 ouBRmwmJnlr1jYvSh4/FColPlA6d4drJvoCxc9uc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6A13AF805A9; Fri, 10 May 2024 08:14:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D3F76F805A9;
	Fri, 10 May 2024 08:14:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A47EDF8049C; Fri, 10 May 2024 08:14:15 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B81E0F8024C
	for <alsa-devel@alsa-project.org>; Fri, 10 May 2024 08:14:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B81E0F8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VcxfVZkH
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B921ECE12CC;
	Fri, 10 May 2024 06:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD07C113CC;
	Fri, 10 May 2024 06:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715321646;
	bh=GcGGzGvYTnpARMt/AI5IU7S4k5OFyk1tpsWpYMoYjcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VcxfVZkHI2PN9GT/A6Ie2JpUCLXvDZ445sFIKtu6SteAEJNjUEIQmcSPtTL9Gaff4
	 9F+i4dcWBCvQA+c2jHCvTcK0vTrEC72EQLiig7BopziafxXVX2gXJMX5OO7+kxyr0U
	 p9U39b+JKiWRmO1xfVlfNzTKz8cRpti/PQnJsXkmEu7iwKFV97iUz3NhPSNUJt3O6G
	 blDtJy+LTrw51bUX2cjujeqpByvrjN81pldB/ef8JVDGxdlKmoCR5PBsVS8RBdrIwF
	 +xrQyRCT0mnb8Wh4oYrc7VdpvOdpR+NOnu1ivJh0UNUwHvAGF2ggVlRalqTlrAKONo
	 weeHegGwXFt+Q==
Date: Fri, 10 May 2024 07:14:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, bard.liao@intel.com,
	yung-chuan.liao@linux.intel.com, kevin-lu@ti.com,
	cameron.berkenpas@gmail.com, tiwai@suse.de, baojun.xu@ti.com,
	soyer@irl.hu, Baojun.Xu@fpt.com
Subject: Re: [PATCH v4 2/3] ALSA: ASoc/tas2781: Fix wrong loading calibrated
 data sequence
Message-ID: <Zj27LHKXSFXx_6G2@finisterre.sirena.org.uk>
References: <20240510034123.1181-1-shenghao-ding@ti.com>
 <20240510034123.1181-2-shenghao-ding@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XFZRnGJeJ9yJiLPF"
Content-Disposition: inline
In-Reply-To: <20240510034123.1181-2-shenghao-ding@ti.com>
X-Cookie: Did I SELL OUT yet??
Message-ID-Hash: C6H4BVMOGXTGFYA2SMNSQSE76BDB5HO2
X-Message-ID-Hash: C6H4BVMOGXTGFYA2SMNSQSE76BDB5HO2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C6H4BVMOGXTGFYA2SMNSQSE76BDB5HO2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--XFZRnGJeJ9yJiLPF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 10, 2024 at 11:41:20AM +0800, Shenghao Ding wrote:

>  - Divide one patch into two individual patches. compiling warning patch
>    has been upstream in another patch (Fixes: 1ae14f3520b1 ("ASoC: tas2781:
>    Fix a warning reported by robot kernel test"))

Oh, I see what's going on - when you split a patch up into several
patches each individual patch needs to have it's own changelog
describing what's going on in that specific patch.  If you just
replicate the changelog you had for the original patch into each of the
split patches it will inevitably not describe the separated out patches
well.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--XFZRnGJeJ9yJiLPF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY9uysACgkQJNaLcl1U
h9C/xQf/cyPxlEXFdtS915Zzymf6A2TgMO5OeS1+5HrB001oEMTyOX9DmHRVNiZG
53thK9VMJPUFZcw/qrjxtTRSV8Uf2zOx7YtC7QXCyonB3HM4MwRk6wvmF0n1AV/u
jBamorjme2Bfv1lqfPvv/guVNWhl0AUOWnDlBNYfU9Q71/MBADrixWHqACG0GLO1
MvgUgBYHXSj9uUbtcLNhyUY4chDk6lx7L2DP8lIC8dGrxK7r5W4j1y8Wodnn5RlB
oehwsucjA/N5Pgw7ZuXRAcaXnZYgsdVPIlG7IKGjBXhAh0aK5+QDtWR9Td6bfmsb
La3dh+SC1AEosVa63EqnSlaFgs1R4A==
=VKsH
-----END PGP SIGNATURE-----

--XFZRnGJeJ9yJiLPF--
