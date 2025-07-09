Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3A1C83F09
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Jul 2025 08:47:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 196C660200;
	Wed,  9 Jul 2025 10:47:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 196C660200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1752050858;
	bh=uQxOYRvhs1dO9YSJnNB7tHiB35UHAz6K7hOo9VmXY+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Ag9HhHnIUcT17qJgVLTQWzD48TsKTxatoWJEfF2HhKC8lVKMTfXb2sKgnQCS18aCO
	 hw0aUd2JdivTtjX3tfXp9NH3x20qfj69jftVQPp4idFSLgZITr/VNRjaHS0K1pYyqG
	 gIv0+4HgLR0yHgPd76PIBPwCY3B9JHjtl8gxGXW4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0ACC7F805D5; Wed,  9 Jul 2025 10:47:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 729CBF805C6;
	Wed,  9 Jul 2025 10:47:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A2D0AF804F2; Wed,  9 Jul 2025 10:46:50 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 42EDEF800FA
	for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2025 10:46:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42EDEF800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AoP987Dk
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 682B4A54764;
	Wed,  9 Jul 2025 08:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97906C4CEF0;
	Wed,  9 Jul 2025 08:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752050803;
	bh=uQxOYRvhs1dO9YSJnNB7tHiB35UHAz6K7hOo9VmXY+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AoP987DkYwFOKbEqSX8RyTKu8GJlh5CiIxRpF6Xo3fdNBZ8oluAKLufGQEXBJnc12
	 kTui6Na/YflqX+Wz3zCy5ix+G8CVRq/x57MxP2Ta+dK6u+IiQ8aLxEjojHOPTf/hOG
	 H7vaWKdknaaqGTvzb7QlUTS20chEVqKr9k0jJmMT1DocofDWwtbb9PJka75IOWtSi7
	 538DV8dOkTa6CaB8/EnEtsYY+NRCHVndVilOLu9PkqbmYcpyZexH7zUFjVPQ7En5dF
	 9xParte1oEOiLqWDHYyR2R4U6VbBWGW7l7gW2Pstw+fE89J0n8hjUtT2uLVp8zS54C
	 oHrf8nDhLcZeA==
Date: Wed, 9 Jul 2025 09:46:39 +0100
From: Mark Brown <broonie@kernel.org>
To: ew.kim@samsung.com
Cc: s.nawrocki@samsung.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: samsung: Implement abox generic structure
Message-ID: <aG4sb7UcqvHz_Z5r@finisterre.sirena.org.uk>
References: 
 <CGME20250709002150epcas2p467416bdbc16754726599a0cacb1feecc@epcas2p4.samsung.com>
 <20250709001002.378246-1-ew.kim@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DxAKD3zsp1okH161"
Content-Disposition: inline
In-Reply-To: <20250709001002.378246-1-ew.kim@samsung.com>
X-Cookie: Do not cut switchbacks.
Message-ID-Hash: XFTWGNK7PEWVOUD2SDUFGBH6FIDX7D4H
X-Message-ID-Hash: XFTWGNK7PEWVOUD2SDUFGBH6FIDX7D4H
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XFTWGNK7PEWVOUD2SDUFGBH6FIDX7D4H/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--DxAKD3zsp1okH161
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2025 at 09:10:02AM +0900, ew.kim@samsung.com wrote:
> From: ew kim <ew.kim@samsung.com>
>=20
> Implemet basic abox generic drivers.
> This driver is a management driver for the generic drivers used in
> Automotive Abox, connecting them to SOC drivers.
> It supports various Exynos Automotive SOCs.

I can't really tell what the driver is supposed to do from this - what
is abox?  Looking at the code I'm not really much clearer, to a large
extent because it doesn't seem to integrate with the subsystem (or other
kernel subsystems) at all.  It looks like this might be intended to
control a DSP offload system, but it's not 100% clear, and it seems like
there's an ioctl() interface which it looks like it's exposing internal
abstractions to userspace.  This needs to be some combination of much
more clearly explained and better integrated with the existing kernel
subsystems, right now I can't really review it effectively because it's
hard for me to tell what the code is trying to do.

I've got a few very supreficial comments below but really there's a
structural problem that needs to be addressed first.

> +++ b/sound/soc/samsung/auto_abox/generic/abox_generic.c
> @@ -0,0 +1,568 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 Samsung Electronics Co., Ltd.
> + *        http://www.samsung.com/

It's now 2025...

Please also make the entire comment a C++ one so things look more
intentional.

> +//#define DEBUG

Just delete this, it can be added if needed.

> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/delay.h>
> +#include <linux/suspend.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/pcm_params.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/sched/clock.h>
> +#include <linux/ktime.h>
> +#include <linux/iommu.h>
> +#include <linux/clk-provider.h>
> +#include <linux/kmod.h>
> +#include <linux/umh.h>
> +#include <linux/string.h>

Do you really need all these headers?

> +static struct abox_generic_data *g_abox_generic_data;

This isn't really the kernel style - neither the g_ naming, nor the
concept of having a global for a driver.

> +/**
> + * @cnotice
> + * @prdcode
> + * @Sub_SW_Component{abox_generic}
> + * @ALM_Link {work item url}
> + * @purpose "get value from virtual address"
> + * @logic "return global abox_generic_data"
> + * \image html
> + * @params
> + * @param{in, -, -, -}
> + * @endparam
> + * @retval {-, struct *abox_generic_data, !NULL, NULL}
> + */

This is not the style for kernel comments, and doesn't seem to make
terribly much sense.

--DxAKD3zsp1okH161
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhuLGwACgkQJNaLcl1U
h9D+wQgAg6ZiLWn6Tov6pqpgGSvOVCG4bO1wv+lii8kju0nn5wslEp0AFE4uumGf
j2XuTXW1grfaywB4hCwouLmd/7kkB6AyrQlrftw9I50TrN3AViIU/hvYQwXMI5wf
v+T8Hz90rmxvWHi7A2OkMK4jBAJtUxyBayxx3o9vnV55bb0yYQKSaoZUYwTWIx5a
mFlgnzsS6ZdNG3FFp6AOEDOmypiJBZSpVTS37VifxCEa2bO/qCsgboXMC/8Jwz0U
1Um1xoTMu1gJarD6+b012HGTvLp5eV7srl9LNwROFxXmhRG1p+IJAbFybBHJaNxs
ILL9EhWyeBZt5EaOzlUpLVgFOtxJBA==
=1drM
-----END PGP SIGNATURE-----

--DxAKD3zsp1okH161--
