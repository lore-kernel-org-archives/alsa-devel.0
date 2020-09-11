Return-Path: <SRS0=2sca=CU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E338EC43461
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:15:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D65E206B8
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="V0EVFlVc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIhtv5Tm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D65E206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9DEC71668;
	Fri, 11 Sep 2020 12:15:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9DEC71668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599819354;
	bh=OSLR7WKpAsGFlS6cyFXhE4P0iBeRMG6g97ZnysjYs9I=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V0EVFlVc3ZrFp1tPE/z65RKpES1u+nPPzG0tT1L0qdw8OOaDVIAY6jArccVrRvCER
	 FMQ9bBnfiR3zK7vXNd+DJbZCNLJEk1xoVQ2Fzf2/6zQKWoiX3J7kcQCDsn07qQc0kN
	 xCfGrv+sNm9GsfdxdKLexbpWVuj0y5jxl4WnBF/w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03C42F8021C;
	Fri, 11 Sep 2020 12:15:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6DA2AF80227; Fri, 11 Sep 2020 12:15:01 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50A76F80100
 for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2020 12:14:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50A76F80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uIhtv5Tm"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1EF95221E5;
 Fri, 11 Sep 2020 10:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599819290;
 bh=OSLR7WKpAsGFlS6cyFXhE4P0iBeRMG6g97ZnysjYs9I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uIhtv5TmIdUsva4pkKFlcwwY9QQNLFFp5BsYD0SGKi3zGarqbRxQoOojXs5tIkGc1
 2txw19EnpMJOLh0o7h4uiZcOkeQM4/znc+DWUQEfKIsiUJwuuelh3ws6bS0uU0kepB
 72C8S/34jXvvHX+CVpIgjs0PrHcQXpZqcyUUUop4=
Date: Fri, 11 Sep 2020 11:14:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Subject: Re: [PATCH] ASoC: core: Optionaly add the component driver name to
 the component name
Message-ID: <20200911101404.GB4895@sirena.org.uk>
References: <20200910200308.9125-1-dafna.hirschfeld@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20200910200308.9125-1-dafna.hirschfeld@collabora.com>
X-Cookie: Only God can make random selections.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, dafna3@gmail.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org, ranjani.sridharan@linux.intel.com,
 enric.balletbo@collabora.com, dmitry.baryshkov@linaro.org,
 kernel@collabora.com
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


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 10, 2020 at 10:03:08PM +0200, Dafna Hirschfeld wrote:

> The ASoC platform driver for Mediatek MT8173 registers
> several components with identical name. This cause an

Why is one driver registering multiple components for a single
underlying device in the first place?

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9bTesACgkQJNaLcl1U
h9C04gf7BZZwKrvOB5Cwa45nlXvWKuAww5NnRsik9jaFHToimYmlsocC/X6dQxkK
GbNBq3MLq4jn+v+S/A4B+rIRc7DOJr1pkgCmQJNKFbhvPIw+SxSiaBF6Plq6hXpE
GzCYiys6uXGG0XM128wHwPyBMxK/hy7hcTBtIFoSC2N/srTNCuYlkWK7FE6QFTnk
EuGkVWt4Hxg4io0Z9v8eDeBvSn5NfXjA48A3ekBbGpacSh1/B7heZ4aj7bUWWnTJ
hjGUuRopKXa9XiRXii6zh5f89qiAN7Vqo0oLv+G05eZO5SFNGr7z/fT4Fw24RCNj
tdlYwU70jcs993mUwt4ezK2UMrpKbQ==
=T1Tz
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
