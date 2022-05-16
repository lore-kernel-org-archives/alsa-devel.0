Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5124EC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 16 May 2022 17:53:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 93978847;
	Mon, 16 May 2022 19:52:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 93978847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652723602;
	bh=V6OYfbvl7Gf5jRVgQc6Zwaa10DLCSHKSqD/KiJIBun4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g180stbNHTm3mSvpzeRvmbS/nai1s6GAvgHev57S3ucNpJSgd79oViCqNf4wODniP
	 2jBHwr45K+YO8L4paDA/9N5S6D74PHYi0mLnJgkwZgjTvCcRkknVtoJjuGaZneOEL5
	 4PsLz/KPUEmTUtLaUhIUjadSShxxqd1VcJuhvydM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19FF9F8012F;
	Mon, 16 May 2022 19:52:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6950DF800D8; Mon, 16 May 2022 19:52:30 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07122F800D8
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2022 19:52:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07122F800D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DrLKI83o"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DC947612D6;
 Mon, 16 May 2022 17:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9ABBC385AA;
 Mon, 16 May 2022 17:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652723544;
 bh=V6OYfbvl7Gf5jRVgQc6Zwaa10DLCSHKSqD/KiJIBun4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DrLKI83o0O+3SLQ8Gd81gugSBsgEJvkW8r3IjFj5jvZs5WCQDZfv/oLy+9iLWMBAA
 ST7cF7XRRy1j0sDB1lcG5oQNRF1qn+BlWsPbbX+tGDg2LlZgLUYD5DO5QIW5motEkt
 O4bCAPKqgFSG8lgRmtrzcx+yH8utQ8M1D+dVS4b/e0xKaySz+glNSsFNn+13W1SLbZ
 NxuW+x1iGowuDgoKi916FnXIwCBjSyJE5c8GLizqXT+8t0QeBTBAIin6X/4/8U/QLD
 DBEoq9ZKUehrdGDUXgn2g7aIdShs8JIQO7yCUf5aw7iz7vSxydrmg2JdtxAMN0Fa69
 RuRNZuvafwzfQ==
Date: Mon, 16 May 2022 18:52:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Antonio Terceiro <antonio.terceiro@linaro.org>
Subject: Re: [PATCH] kselftest: alsa: handle cross compilation
Message-ID: <YoKPU/QbrkuJPlnx@sirena.org.uk>
References: <20220516165856.401452-1-antonio.terceiro@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l68LM0N6va3Ya2h5"
Content-Disposition: inline
In-Reply-To: <20220516165856.401452-1-antonio.terceiro@linaro.org>
X-Cookie: May be too intense for some viewers.
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
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


--l68LM0N6va3Ya2h5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 16, 2022 at 01:58:56PM -0300, Antonio Terceiro wrote:
> Calling just `pkg-config` is adequate for native builds, but finding the
> foreign libraries with pkg-config needs pkg-config to be called via its
> architecture-specific wrapper. This works in Debian, where there is a
> corresponding *-pkg-config wrapper script for each enabled foreign
> architecture, just like there are *-gcc, *-ld.

Why does this only apply to the ALSA selftests?  There's a bunch of
kselftests that use unadorned pkg-config calls.

--l68LM0N6va3Ya2h5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKCj1IACgkQJNaLcl1U
h9DcoAf+LVpPlFZWQHDWJ58ZynWUjK/xxuF/HWxAsfbguUHtJNjWrCUgsLI3ipJJ
/dF3BjpNo4wqsC+6DO5DW+aYiUgzOKC9MhY14A0DQPnbmLSmOhmfhDgycXSyiawq
qF6Xj9UX9shFYAYi5A6TnULsxnhAc07vDbj7VgTwmNOpNm4d/8/2ksWReJJi0/Ab
7gnnRE4xV0sqVBg1XQxAarGT3aNu8JBnhwHnr5gEuLAUyrql57+9dIGCJfngtDxY
BB1lgJBTrW8Z8duAmb2JU+9SbmFoeQUawQAxPEJOG2PebDDJsovTNCu8gmrV52fn
+7+y33ypsIRzVF+/WvbVh4JE32YDxA==
=NDzX
-----END PGP SIGNATURE-----

--l68LM0N6va3Ya2h5--
