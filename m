Return-Path: <SRS0=iyFA=JF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84469C433ED
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 17:48:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E2461104
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Apr 2021 17:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E2461104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4188844;
	Thu,  8 Apr 2021 19:47:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4188844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617904111;
	bh=GInPOV/0fGJF2ghGb1sB/kI1DOd5qw3oeJrGBT0IXuY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k1pVIDihqyRT1H8yGpj8/4CkVnJeIoDMEvwff/rhyK4coUnfZTd+5RC5EeYfVYvW/
	 d4c0Q4uEDIN6/HDWeFJCXtUu8g43LQ/ltGliPywZBdB3ZivSNEENIDYAMkiWTKznuZ
	 eOBEVVRVJEVmKrTSr0gJwh9LX4s/RW3IOJG54pXU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0FC74F80162;
	Thu,  8 Apr 2021 19:47:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 053DEF80169; Thu,  8 Apr 2021 19:47:39 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0BC5EF8012F
 for <alsa-devel@alsa-project.org>; Thu,  8 Apr 2021 19:47:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0BC5EF8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="OCj57/Qb"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 890736102A;
 Thu,  8 Apr 2021 17:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617904051;
 bh=GInPOV/0fGJF2ghGb1sB/kI1DOd5qw3oeJrGBT0IXuY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OCj57/Qbb4KId+l0eoJlTU6J7cNCsgBOxzjOj0FaXdZFgeAeAks2QF4DDY1ngvqs9
 mYK9hAUDIT4Z+k19+QnseLUTsTtN1u+EIFVR2ZmgCRJSH0T4h/M7K+qGcx/M1uRWmo
 salvQBvaLeJbSjoQ75vFUZfbc0zisFp6BQ2rFIcPLXKjTfpvHJgLk05VPSzkuKuXDO
 YfRL3rYZiONlmtHttILvaXkqT/zk8R8QW2n1RC5jOJ0g+XpHiwa4xkSbnIAkSAApqu
 tzwS1Ob6aAFMEqOKjuerD0O1Xn3/pnjlMJQspxCMaluwLPGEcaLAkGzWVQ4WGzrbdv
 s5Pi+OCbntXCg==
Date: Thu, 8 Apr 2021 18:47:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: core - add more card sysfs entries
Message-ID: <20210408174713.GS4516@sirena.org.uk>
References: <20210408094314.1322802-1-perex@perex.cz>
 <20210408103819.GA40407@workstation> <s5h35w182a5.wl-tiwai@suse.de>
 <45acc908-3603-3479-9fb2-5206339a9ace@perex.cz>
 <20210408120502.GA4516@sirena.org.uk>
 <s5hpmz47w3i.wl-tiwai@suse.de>
 <56c874ae-e801-63df-19fa-a1325f6104ca@perex.cz>
 <20210408162250.GN4516@sirena.org.uk>
 <9ab048b1-09a9-f6c9-da84-bc6371e1720d@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NKys6zTV8iyMJiwY"
Content-Disposition: inline
In-Reply-To: <9ab048b1-09a9-f6c9-da84-bc6371e1720d@perex.cz>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>,
 Pierre-louis Bossart <pierre-louis.bossart@linux.intel.com>
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


--NKys6zTV8iyMJiwY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 08, 2021 at 07:20:39PM +0200, Jaroslav Kysela wrote:
> Dne 08. 04. 21 v 18:22 Mark Brown napsal(a):

> > So if the information provided through the driver is too generic then we
> > should ideally be fixing those drivers/systems to do something sensible.
> > For the DT systems the generic cards have properties that let the system
> > just specify names directly so it will just be a case of setting them
> > properly and it should just be the x86 systems that are a problem.  ACPI
> > is a bit of a lost cause here, most of the systems aren't interested in
> > supporting Linux in the first place and the idioms there aren't great,
> > but for DT it's reasonably tractable to push back on people if there's
> > issues and it's much more scalable to do that than telling individual
> > users to do that.

> DT works only partially. Also, you need the DT compiler to change something,
> it's easier to overwrite things in the booted system. The user experience is
> lower with DT.

TBH I think the ship sailed on user experience no matter what we do here :)
In any case no disagreement that it's useful to have some way to do this
at runtime for systems where it's not possible to update the firmware
for whatever reason.

--NKys6zTV8iyMJiwY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBvQaAACgkQJNaLcl1U
h9A+9gf/fRPXGZ/clgFNFBpFjG7x6jr5AuK3bp+tZuFbDDheJVlT7iAjaBnx/xGP
YNWkVFSMVQvAFa4lRrwnGWmYYtfPW9jmZelNsC2s0kx2cLGmYksrEz0W9Gu4AkWv
HEs3HULsaakB5ZmmagPfWk0bgj3l/M5sYzpDod0XrtsDQTvzQMINV84UhGpZmxwk
yv3tc0gcQ9fVJYZI+9xfQh57oh7JFLPdndvlCM+3KenX1LDV0JQYGpXM/3urd3tS
DXWKjLpevKE+ptcSyWamJENbTxccPgjP+ku3+jjN7byZNRRGPYmjTc2Mt96b97/p
nN0HDgZUjg5bRLm3xKrOw/24KsndWA==
=/uXd
-----END PGP SIGNATURE-----

--NKys6zTV8iyMJiwY--
