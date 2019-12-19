Return-Path: <SRS0=OsOn=2J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A313FC43603
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:19:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A51224672
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="to8G08LI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A51224672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3D6F084F;
	Thu, 19 Dec 2019 13:18:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3D6F084F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576757939;
	bh=t5mPXrVppiHwVqcZjXl7tCaXekK/w97+vIB9Zm2vRUM=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=to8G08LIZ66syWPGDutTSORho2SzdYiUMIYGLH5hNEqdz/XxR6jH2MTMuVXR8HtfR
	 X/pPdtgfAV/8cSyRtpjPlTQJRIdJvHdt3LEuX3V/kONYXCY5js4pIllKNhgUjgkgoL
	 zMkNpv0vldFK0vl70QcIrCLG29Y0et97CqF4WJF0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE1A1F80218;
	Thu, 19 Dec 2019 13:18:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6EF4BF80234; Thu, 19 Dec 2019 13:18:07 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id D4021F8014F
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2019 13:18:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4021F8014F
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9067531B;
 Thu, 19 Dec 2019 04:18:02 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B5CE3F719;
 Thu, 19 Dec 2019 04:18:01 -0800 (PST)
Date: Thu, 19 Dec 2019 12:18:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Message-ID: <20191219121800.GA5047@sirena.org.uk>
References: <20191218185938.38282-1-broonie@kernel.org>
 <CA+Px+wUBdCt_VCmKHSpHmi9WO7_eQAxSVZL+Q3oLMdH6C-RtNQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+Px+wUBdCt_VCmKHSpHmi9WO7_eQAxSVZL+Q3oLMdH6C-RtNQ@mail.gmail.com>
X-Cookie: I smell a RANCID CORN DOG!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: max98090: Remove empty suspend
	function
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
Content-Type: multipart/mixed; boundary="===============9198295664031890653=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============9198295664031890653==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 19, 2019 at 05:59:24AM +0800, Tzung-Bi Shih wrote:
> On Thu, Dec 19, 2019 at 2:59 AM Mark Brown <broonie@kernel.org> wrote:

> >         SET_SYSTEM_SLEEP_PM_OPS(max98090_suspend, max98090_resume)
> This is which you should replace to NULL.

Ugh, so I did - thanks.

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl37anUACgkQJNaLcl1U
h9ATeAf/ZEodAtEgO5dFHbG1xfGTRUx+wYcqpGeuF7xoGr8CGKeq/r8ent15LVpq
Mb17lOa2WPRJNDn3nzAv1h5WSgmPLoqK/AcIll0/uUAdFUmmWvftL2/FnVRm6CaU
7KgnMjAiRzrwVtQ7W2Cm8c3pzS37tFHI0qCOqIRDT8s+EhwyarWNPiW0tdadFmVC
SGIGwD+fIAvbc05HkPMDa6/5r09/f0CH3vPqhR7Qqe/kttlieeMqIdXd0sL1R5xy
Qol9CfbqIr9D5RAE18dwEjO7Y/5EGXnd1kVZE72bDeF23EnAiBYXJUFMc0LkG4tF
tJjd5nd0UCK4eFzIqNLuh5/cYggpHA==
=+JtX
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

--===============9198295664031890653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============9198295664031890653==--
