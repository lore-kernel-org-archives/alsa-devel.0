Return-Path: <SRS0=q21C=4W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E9DC3F2D2
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 18:16:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE81A208C3
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 18:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bnkRnalq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE81A208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5604F15F8;
	Thu,  5 Mar 2020 19:16:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5604F15F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583432210;
	bh=p2fT8t338jU5/sgK9KJmo2qPlkEfrhf1nea3aS+qS/8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bnkRnalqiOv6uUKdFsU9JcOp/IBBOBw0cgWlwnw+h3r8jxm8R+F2bvsIiE/AP8d+C
	 Ow1aVRtHouH5IRnLP6Rv2upyPqEd6riQd/uwz4RlM9qvj3wnkqe25BQnVTUr0FU4Fm
	 c9sWTgWomj1jXI4h/2X+xavIattlbHpXy+5HqL6c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE5F6F80245;
	Thu,  5 Mar 2020 19:15:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7872AF8025F; Thu,  5 Mar 2020 19:15:58 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 16186F80126
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2020 19:15:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16186F80126
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93D2C30E;
 Thu,  5 Mar 2020 10:15:53 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 158873F6CF;
 Thu,  5 Mar 2020 10:15:52 -0800 (PST)
Date: Thu, 5 Mar 2020 18:15:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 1/3] ASoC: soc-core: introduce exit() callback for
 dailinks
Message-ID: <20200305181551.GJ4046@sirena.org.uk>
References: <20200305130616.28658-1-pierre-louis.bossart@linux.intel.com>
 <20200305130616.28658-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MzdA25v054BPvyZa"
Content-Disposition: inline
In-Reply-To: <20200305130616.28658-2-pierre-louis.bossart@linux.intel.com>
X-Cookie: When among apes, one must play the ape.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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


--MzdA25v054BPvyZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2020 at 07:06:14AM -0600, Pierre-Louis Bossart wrote:

> The exit() is invoked in soc_free_pcm_runtime(), which is not
> completely symmetric with the init() invoked in soc_init_pcm_runtime()
> - not soc_add_pcm_runtime(), but that's the best solution so far.

We *could* look at moving the init back.  In any case this seems
reasonable by itself (I'm less convinced by the users).  However...

> @@ -1069,7 +1075,7 @@ static int soc_init_pcm_runtime(struct snd_soc_card=
 *card,
>  	/* set default power off timeout */
>  	rtd->pmdown_time =3D pmdown_time;
> =20
> -	/* do machine specific initialization */
> +	/* do machine specific allocations and initialization */
>  	if (dai_link->init) {
>  		ret =3D dai_link->init(rtd);
>  		if (ret < 0) {

=2E..I'm not sure why we're saying to do allocations here?  That really,
really shouldn't be a normal thing - allocations should generally be
done at the device model probe.

--MzdA25v054BPvyZa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5hQdYACgkQJNaLcl1U
h9BzQwf/YRpjsWZKqjGFTqHF5tkB2AJaJq6ff6bg6lYTvV27swuCSg422XpqqgL2
8009vVsLOkZ2vUjsQKN/7WvGtqlATkH72JvjXwzkQ4vJf0FpnHMWM4DAk3IwXKrN
xtj82/k8qX1aaa0MklC+QKMwkTXJR2gORqwgbioAQipegTHi1SKrMdK2Cu0i/CVH
tGZKYTPbQ+pu7XIdauVUAZHwL/lO8EtFQ6ehKFGlRwLRwI7tM7VsOmjQkYKCDPWP
LTyAiq4qAGGS5G3BfvD71cVOZNiefWrRJ9g8HmAHCYSYE3QIv+TnX7X6XMZ3NEHf
TUUH3BfXL+YIvaHuOmepGVpPg8BGwQ==
=Zwpj
-----END PGP SIGNATURE-----

--MzdA25v054BPvyZa--
