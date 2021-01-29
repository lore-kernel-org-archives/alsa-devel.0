Return-Path: <SRS0=iLk1=HA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8228DC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 15:50:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27D5361477
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 15:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D5361477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E18451699;
	Fri, 29 Jan 2021 16:49:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E18451699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611935442;
	bh=e/sXWdTyRlpTKUdqo8J5LSga7f/037C+kqn+aEVn3Ss=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E7bNXSU33A9cEPenOrvxI9fWLokO3IG84sfaCNUaR8r/C2VzkkDOwYkbdzevJoMJs
	 mBqlRksf/MVUherjwiPHfIQhfW2CEOtJwwkOj4cF8hMkub0Ewut/OM9d9arP9dkhH5
	 SF3PnBWhGMpkCvjeCeVYwmNb/W9kB5CrVt0mygpQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6944AF80218;
	Fri, 29 Jan 2021 16:49:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BEF96F80259; Fri, 29 Jan 2021 16:49:49 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8257F800E9
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 16:49:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D8257F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JPGJP7Le"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1C3364D9A;
 Fri, 29 Jan 2021 15:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611935383;
 bh=e/sXWdTyRlpTKUdqo8J5LSga7f/037C+kqn+aEVn3Ss=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JPGJP7Le5YyWyzUYnYZj4yAmRtbQjRg/geIa+1MRoosEKkPbXLsmC2eNoMsn2Gybf
 srcwPDHOH/UT4c5X6FamOjTPbxz03cZf5piNH/Z5JR8giJLdQB0Vx7Yqp/Zl8MXCsm
 ayKNE5HGS26kgu3oYvu5JC1WNdeSXOYbFnvPEoSW8jTmyEaslmrE954XnHoqy3uOJN
 1mxBI5CTmBy8BChEgDBOsFj3XkNMIdy3NlZPP5m7gHPLCVzWTmoO80YmKzeYOQvi81
 OV4nD6w9GTkMYQTRrvXZiRTdyoRukLoPXr5dqxRq2sUNjrjSnPdZ2MU5+NP+X7txSh
 3XhgQl2fy7I0Q==
Date: Fri, 29 Jan 2021 15:48:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: Re: [PATCH 4/8] ASoC: tegra: Select SND_SOC_RT5659
Message-ID: <20210129154858.GE4560@sirena.org.uk>
References: <1611920470-24225-1-git-send-email-spujar@nvidia.com>
 <1611920470-24225-5-git-send-email-spujar@nvidia.com>
 <20210129124454.GB4560@sirena.org.uk>
 <d6cb9252-246e-d6c7-7500-5f1d1823325c@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="orO6xySwJI16pVnm"
Content-Disposition: inline
In-Reply-To: <d6cb9252-246e-d6c7-7500-5f1d1823325c@nvidia.com>
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


--orO6xySwJI16pVnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 29, 2021 at 09:02:52PM +0530, Sameer Pujar wrote:
> On 1/29/2021 6:14 PM, Mark Brown wrote:

> > This is a generic device, not something specific to Jetson, why force
> > on a driver that may not be required on other boards using this driver?

> Yes specific boards using 'SND_SOC_TEGRA_AUDIO_GRAPH_CARD' may require
> 'SND_SOC_RT5659'. But there is no platform specific config. Is there a
> better way to enable config 'SND_SOC_RT5659' conditionally?

If the user wants a given CODEC driver then they should enable that
driver.

--orO6xySwJI16pVnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAULmoACgkQJNaLcl1U
h9DRBAf/X7dtLHnUY4lmJDMbL6g5Zd2lzKUuVeqmatlxjnTuDEitB0I0ovmZWeyh
cwaaB6ievlXidSRQMlCSDqgPdcR5PLityy0/uL08sy8H+ZY6xrD+KiyUdtd99O41
Gn8entBzJvGxlUQzNQRGPL5hLl3tie8IdOTvp4Uqc6wILVXiKMHOtIutY1pZi1yq
Dikd4zraRCfVjxeiwGBDyNvaP6cwNQlEotes9FigSNPq2VtfPvMziKaujv9dW2JR
FXzF3qqqoUgazhHtRl5o3UcqsMgJ3apiVJFAAdq6VuCXFqLNXJVaR1UGZ/ciIn3S
7JAVEUUJesiM7qJWQDVwlaFPqzdU3w==
=jDux
-----END PGP SIGNATURE-----

--orO6xySwJI16pVnm--
