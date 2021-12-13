Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59ACC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Dec 2021 16:07:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 34444184D;
	Mon, 13 Dec 2021 17:06:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 34444184D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639411649;
	bh=rXnBsVxcBXElloKji2ajbsyDvwCJ0DSAlp3vgNJE2sA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mar4Y4lvM0meucCujLTxCFjNc3JZ5bUwVkDTE4R5kPKxNwkOAd7hpELyv1t+c25ml
	 2i8u3lcew1tXh64JUO9M85cPZoYvUSdrGTlq0oXz7u5gXNSju+5O0f648tbprbgvKY
	 8MxOeLXbqLoD5GLTHEg1agsjsPJsoQ64p0JjiBmE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA755F8013C;
	Mon, 13 Dec 2021 17:06:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7A327F8025D; Mon, 13 Dec 2021 17:06:37 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07A1FF8013C
 for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2021 17:06:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07A1FF8013C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TuIuJ3ps"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2651661162;
 Mon, 13 Dec 2021 16:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72DAC34603;
 Mon, 13 Dec 2021 16:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639411592;
 bh=rXnBsVxcBXElloKji2ajbsyDvwCJ0DSAlp3vgNJE2sA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TuIuJ3psaUqDh/BYj7qu+hKMs8MDyw8/VX5hq8v4ZYL87HI2zrK4KuKQu0yvxt5iI
 s57+N+p/2NOsMBHcBQkbGwXDj6XneJFQZcYXhMgd7VYL4IvmoCl/gVPxiWcGMZNxM/
 nUIFceByrJh4KecFGjPFi1Y7bXTUioW/Flcw31c7fsNIer/CkeMnvi3uG/TXKJybEH
 YNjaWTuXR4ODiLFAPwB7U82Vx14mHtiQ0mpe3d95Cx1tJti99T6gLPcYYp/jXU8u94
 4zpch+4U58euj0h7WuafSaX7wmLXwHn4WWSAox57OUz5sOsTEeu5FHpWOl9yl0iT1r
 CrXdkilVWw2Zg==
Date: Mon, 13 Dec 2021 16:06:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Judy Hsiao <judyhsiao@chromium.org>
Subject: Re: [v2] SoC: qcom: Distinguish headset codec by codec_dai->name
Message-ID: <YbdvgsxMThr0e8zl@sirena.org.uk>
References: <20211213023626.673323-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LeBiO8fVW2rW6wdM"
Content-Disposition: inline
In-Reply-To: <20211213023626.673323-1-judyhsiao@chromium.org>
X-Cookie: No solicitors.
Cc: judyhsiao@google.com, Banajit Goswami <bgoswami@codeaurora.org>,
 cychiang@google.com, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org,
 swboyd@chromium.org, dianders@chromium.org, Takashi Iwai <tiwai@suse.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, yuhsuan@chromium.org
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


--LeBiO8fVW2rW6wdM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 13, 2021 at 10:36:26AM +0800, Judy Hsiao wrote:

> Call stack of the crash:
> ```
>  Unable to handle kernel paging request at virtual address ffffffbfe7bba9ce
>  Mem abort info:

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--LeBiO8fVW2rW6wdM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG3b4IACgkQJNaLcl1U
h9CGawf/bxYlM8BIwZISWj9XwYRJQ4xszBtDniunG9Ubh5idc8v3okv0ft3yEG0j
/dEv2lEEY5geJV2dACTlAUbzdIHd44K7K+SoqTtZar+3p08mzTImfCaXwNvBD5qa
ftA8YH3EyMDxTnqS5f25632WrBfIgvbIL8enlfIqIMRf6UCDmKDIl4eVmN13Wk5w
k82/PDyXplEWTxQ3zyvhbv82g9XzZtkCrT+uqqs3s35ORP1V9Ay4qxc/2Z+CARQi
BfeSbE0RsjZkcnKWSQrDE/msrvaeW34tdL8rCm47Uc2C/FXsrNn46wOUlBaG/Tol
yyyDBjvmziEWRJeqm+8KYwXjZM8x2Q==
=IL/Z
-----END PGP SIGNATURE-----

--LeBiO8fVW2rW6wdM--
