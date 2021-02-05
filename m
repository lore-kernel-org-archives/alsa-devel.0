Return-Path: <SRS0=mf2d=HH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B88C433E0
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 16:37:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BDE64EE0
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Feb 2021 16:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BDE64EE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 411861660;
	Fri,  5 Feb 2021 17:36:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 411861660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612543039;
	bh=atgG6ZN8qTkgFk4Rn2oN6WjAYzQG6orMRi//pvIqDSs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u0rmjJgC0SKYkAOnoeqrwW8E/4atRx34F8OrSQggjK3YdYAVtn1vc1hGJH1d/7SaV
	 GhZg+r5vK/EV4hZDFenwsSKcIy2sfAhrSH0JM20AtjwtEoZHSO9CHs7q6g6k3EQf+s
	 541/dL80PcKNwJD5cHefjOgm8uXmckWfur2aIjA8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A4079F80139;
	Fri,  5 Feb 2021 17:36:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E67DF8015A; Fri,  5 Feb 2021 17:36:24 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A51A4F80139
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2021 17:36:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A51A4F80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Suw0L4OF"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B990E64EBF;
 Fri,  5 Feb 2021 16:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612542975;
 bh=atgG6ZN8qTkgFk4Rn2oN6WjAYzQG6orMRi//pvIqDSs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Suw0L4OFlWHxsGatQ0G/fzxfOHKBWS21NjPqgYMKhurs+7au00bODMYEq8NuKUeXO
 Kt4ZF4oezNdls43RyfoX/lqGi/G41v+aP4F+ZMhtMC6P3GjQQvom8HUamdDWWKByrt
 aDZCsXJwlM+VszFDTsufprtIYC8UIJyeE5ijCaPP8NFZSMZ77+wKJmqVEvaHdmUp5t
 whuO0XHvNfuVaEzXs4cjwBMeGCiGIGm8FoM+HD9ukewheTmxH/ZegBOafSU3j1R1Lt
 SLDX3kmSwYRPeGWiQSX3pD/wvxGZwNwX7pzQB+DrbD4BkIKxe1PIyaIhNu5MebjZTk
 xfBMlQ5c7f/LA==
Date: Fri, 5 Feb 2021 16:35:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Sia Jee Heng <jee.heng.sia@intel.com>
Subject: Re: [PATCH RFC 0/4] Add HDMI support for Intel KeemBay I2S
Message-ID: <20210205163525.GH4720@sirena.org.uk>
References: <20210204014258.10197-1-jee.heng.sia@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Yia77v5a8fyVHJSl"
Content-Disposition: inline
In-Reply-To: <20210204014258.10197-1-jee.heng.sia@intel.com>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com
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


--Yia77v5a8fyVHJSl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 04, 2021 at 09:42:54AM +0800, Sia Jee Heng wrote:
> The below patch series are to support Audio over HDMI.
> The modification in this patch series shall allow I2S driver
> to playback standard PCM format and IEC958 encoded format to
> the ADV7511 HDMI chip.

This seems fine - what's the plan for getting the DRM patch merged?  I
can apply it if that's best for people.

--Yia77v5a8fyVHJSl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAdc8wACgkQJNaLcl1U
h9DaZAf/SF4ZKmjHzIITNbEZmHIzkGIGwD62llRkhiFWft7j3wJVsmSfBAbMwi8M
5Gg8O0govo2CjmxFWdqbmU4AG7m3GKINIYt1us5u0+DHUOEKbWqr6/iHaWK3vUqE
yKPyHzbuKmFp5p9/gVWswJu2WK28UNcVuGNXEYtMr7DzvsyAsKCwbs1MzdrnvVd0
7Jh9Nwygks4xEqpe7tOIXHNgpmd3Kkj62iWgqpfL3jJ6ADFmvW0R7OyVa+ahETAW
QazkM8+O9vpZDhSBLzF5TeMp4FCQTPNmnh330s5UNNvEbx6YL49k1OdgREIED7HM
ZVr9tN2pzsmo2Dtuu2PN65uWRRQnMg==
=+IvZ
-----END PGP SIGNATURE-----

--Yia77v5a8fyVHJSl--
