Return-Path: <SRS0=iLk1=HA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9ABC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 12:46:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A67664DE9
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 12:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A67664DE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 060FB1693;
	Fri, 29 Jan 2021 13:45:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 060FB1693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611924399;
	bh=ORRud7zP8lvgT+PZMYSBmB0Hacq02bg/z3Lb2Jb8Z8g=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oTmpT2pZ6AFlzXeggJoLXe7b3hSFYF5jdDYnvuXsRT/QFtfkJFxL3m3bTFislGLop
	 KWuta+4Z9SAIomAEtvmjyqN8prg4BxsxcrTPTWAOzGBS5/qvj6YAi1Dd23bNzC69Bz
	 W7vGcXUXCWW5mos1O9yrRgBbLLPW4JVlZ9aXrpIU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C06BF80130;
	Fri, 29 Jan 2021 13:45:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0501F80259; Fri, 29 Jan 2021 13:45:46 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84161F800EB
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 13:45:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84161F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TrfGI05h"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DA7564D9E;
 Fri, 29 Jan 2021 12:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611924339;
 bh=ORRud7zP8lvgT+PZMYSBmB0Hacq02bg/z3Lb2Jb8Z8g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TrfGI05h+m+0FhRP41/xeTCYxePdjxenxK8U3bbgvQmJyWq/g+EAu2GV+i3Db4bbl
 ldYirBTr7N3HJLs29/e5mcjGKdWN+lZ0rDOAdpTxivtqKf3Utb5qXRfzlY25WJruAD
 LmCoGy17wy5VyieA6TrHOxrhrpjWiIbA3xcdPQ2QvKBBxw+hJ6POOtG6gTHh8DJNwt
 DNz9A0N0HVOZ/0MMn45VZQXQwIIp1BWIUZCzJytopR0Lcw+diWaEhgOcJki7tYtNsN
 r9LMzij6uhh969YktKDU35o91YqyUhOnWUjR98e+IO0CxN+egc/O1o4uf1rybx93Hi
 hndhz5FE+jn4w==
Date: Fri, 29 Jan 2021 12:44:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH 4/8] ASoC: tegra: Select SND_SOC_RT5659
Message-ID: <20210129124454.GB4560@sirena.org.uk>
References: <1611920470-24225-1-git-send-email-spujar@nvidia.com>
 <1611920470-24225-5-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <1611920470-24225-5-git-send-email-spujar@nvidia.com>
X-Cookie: One organism, one vote.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, robh+dt@kernel.org,
 jonathanh@nvidia.com, sharadg@nvidia.com, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 29, 2021 at 05:11:06PM +0530, Sameer Pujar wrote:
> Select SND_SOC_RT5659 to verify external audio over Jetson platforms.
> Jetson AGX Xavier has an on-board RT5658 audio codec and to use this
> enable required config.
>=20
>  config SND_SOC_TEGRA_AUDIO_GRAPH_CARD
>  	tristate "Audio Graph Card based Tegra driver"
>  	depends on SND_AUDIO_GRAPH_CARD
> +	select SND_SOC_RT5659
>  	help

This is a generic device, not something specific to Jetson, why force
on a driver that may not be required on other boards using this driver?

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAUA0YACgkQJNaLcl1U
h9ABawf9HXgzOttmkvKi4f1ZnYBndiof6VKIGYzASXCyFczad33uLS+RQ/ZT4/bM
U+J6EBW8Dp1Ql/FwY+z6e+MMyZHdK6UcnUcHKzreegwcNlSkd8zqUUVuKh7ETYFG
+M2NJrlsO9B1v6kybDafYvxmk63OWC2TCab29362/TwY/4b8RvUxaT/vrSPWQjwG
oQm+FzpPok+3K1A4XiVIOM0RsHF0pI8eE/p5YwgRbFBYnRU2GpLPP+1SwR2xxXvc
v9Hl9j0Q75h09AMFK9U/L4u0cKrZdW4F8TXrt9DnrIt3yCt2zTyHEsMVPZZ88iCV
wPEVJXWAe9kz4WE8pspm2lXSsmuj5g==
=QTQY
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
