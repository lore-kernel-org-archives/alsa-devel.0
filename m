Return-Path: <SRS0=ZYEx=2B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35461C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:26:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5424206A5
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 17:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mOP8N278"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5424206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC07F16BA;
	Wed, 11 Dec 2019 18:26:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC07F16BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576085216;
	bh=zHsZ1oi47cDdo/v5JJZkwCr78yk7985Xi/rVR/bgb4o=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mOP8N278K00JRtVnICdHTHoFg35JhicV698YFfW64fJVz/uVjPypEBQxK9BNgdGnH
	 G8ZESFk2+WtPi7o2HTNP4lO5lFcm0OQ2UlSk+ftjbhj3UezyjViJu7Wqrw8I2HE7b2
	 Jh+lKPKTwaDoRIzTsEbl5+3idleqI3kMA4DoWgtg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 09082F8025E;
	Wed, 11 Dec 2019 18:10:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34C81F8021E; Wed, 11 Dec 2019 18:10:13 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 5452AF8021E
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2019 18:10:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5452AF8021E
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EC0730E;
 Wed, 11 Dec 2019 09:10:09 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 915B53F52E;
 Wed, 11 Dec 2019 09:10:08 -0800 (PST)
Date: Wed, 11 Dec 2019 17:10:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Message-ID: <20191211171006.GH3870@sirena.org.uk>
References: <20191210145406.21419-1-tiwai@suse.de>
 <20191210145406.21419-15-tiwai@suse.de>
 <20191211163418.GE3870@sirena.org.uk>
 <s5ha77yiz4i.wl-tiwai@suse.de>
 <20191211165738.GG3870@sirena.org.uk>
 <s5h7e32iyjk.wl-tiwai@suse.de>
MIME-Version: 1.0
In-Reply-To: <s5h7e32iyjk.wl-tiwai@suse.de>
X-Cookie: NOBODY EXPECTS THE SPANISH INQUISITION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH for-5.6 14/23] ASoC: sh: Drop superfluous
	ioctl PCM ops
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
Content-Type: multipart/mixed; boundary="===============5407023547111293260=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============5407023547111293260==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="svZFHVx8/dhPCe52"
Content-Disposition: inline


--svZFHVx8/dhPCe52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 11, 2019 at 06:04:31PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > People send stuff through the merge window, and if everyone waits for
> > the end before submitting you end up with conflicts still.

> Yeah, that's a bad habit that people can't wait.

> The submission for the next kernel during the merge window isn't
> acceptable for many other subsystems, so I had to wait until rc1
> release.

It doesn't really make much difference from my point of view, I just
queue stuff up to apply once -rc1 comes out.

> > I've applied most of it - there's only a couple that didn't end up
> > applying at all (IIRC these ones actually got fixed up).

> OK, could you give the list of missing patches, so that I don't
> overlook anything?

Should just be:

ASoC: mediatek: Use managed buffer allocation
ASoC: SOF: Use managed buffer allocation

--svZFHVx8/dhPCe52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3xIu4ACgkQJNaLcl1U
h9Bz0wf/U4EYR5xo0zeg+lKASnNoWXS9etl7VyRMcewLszTEJImXgJgAcjTrTMQd
DlGp0QU6DmhyRneLwWliQ1rGlq73Fh3lrRz6hcV/F4d3E6ORexTqN5dvBGCJ4mIP
aeVrnrtX9KrXKlCBCZ51P9mBoR1izg3he5EhzQRP4oV5LwFGA42G9AOl7/kTKMWP
8rM9u66Uvvw/mwZGW+wIDTmN5AsqGpDuUSTLLanciMvNQYgzpyIGp082hE9AEe+q
U2nxjicuO+2NpgfKmMFUCI1wyLSvGTrWtdwGR6ELYKVpvs14C245z/2gjkohFS0p
4W1gGd3EG5o8tx5cfgnC5o29ZrTpBg==
=G6du
-----END PGP SIGNATURE-----

--svZFHVx8/dhPCe52--

--===============5407023547111293260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5407023547111293260==--
