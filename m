Return-Path: <SRS0=gwzj=YI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF3DC10F14
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Oct 2019 20:12:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21EAB20854
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Oct 2019 20:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LqMSiIKp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="NYPIzsty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EAB20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17EB8844;
	Tue, 15 Oct 2019 22:11:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17EB8844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571170330;
	bh=lDWRlXfnRTxWZbBRC0VvdtznSJmCtFVUcwEx1aDR1zI=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LqMSiIKpGlFf5hiqNN2lxuX/Ds6wMs+RvrgRTmaYcUr4F0ieY6MV6PGQDsXfodYew
	 drDLXVJHcoJJB0grgl2CIHiHXYyEJTwUGoGedNLSozQnyw4US6MA2GVfrLWvnl+kP2
	 0Tu5FE27oayhMA/Si3Xn4VZGALazrmA6nyHSM8Lg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A1285F804A9;
	Tue, 15 Oct 2019 22:11:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1CF0DF804AA; Tue, 15 Oct 2019 22:11:18 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B667DF80323
 for <alsa-devel@alsa-project.org>; Tue, 15 Oct 2019 22:11:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B667DF80323
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="NYPIzsty"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j6HBGoSLsDkumToPMsvulNAETkRI+xrg8kbnWkdYhCU=; b=NYPIzstyR2zBVTFxuLrMS2kKI
 KmGW74v5rFlluGh4bTnnVOxBfa6Rs19rD0EHxwmTlum8sEEwDBHqh0QhsVOCtbMqmXetC2B6U9W0d
 8fk7U+/BxIS0KwPO05M4SZ6mMgZlK9YNgW8oI9MM3aD/wf1ti7/+dryMetQzxU4tKgRhE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iKTA2-0003Oe-9U; Tue, 15 Oct 2019 20:11:14 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 85EF02741CD7; Tue, 15 Oct 2019 21:11:13 +0100 (BST)
Date: Tue, 15 Oct 2019 21:11:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Message-ID: <20191015201113.GE4030@sirena.co.uk>
References: <20191009181356.GO2036@sirena.org.uk>
 <3811afd6d83c491077dd30089bcf836f56f146c3.camel@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <3811afd6d83c491077dd30089bcf836f56f146c3.camel@linux.intel.com>
X-Cookie: Yes, but which self do you want to be?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Takashi Iwai <tiwai@suse.de>, Curtis Malainey <cujomalainey@google.com>,
 alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [ANNOUNCE] 2019 Linux Audio miniconference
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
Content-Type: multipart/mixed; boundary="===============3122578893224854432=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============3122578893224854432==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DqhR8hV3EnoxUkKN"
Content-Disposition: inline


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 14, 2019 at 08:47:07PM +0100, Liam Girdwood wrote:
> On Wed, 2019-10-09 at 19:13 +0100, Mark Brown wrote:

> > Thus far for the agenda we have:

> >  - Use case management enhancements (Curtis)
> >  - DSP framework integration (Liam?)
> >  - Soundwire status (Pierre?)
> >  - Componentisation status/plans (Me)

> Audio Virtualisation. (Me).

Sure, I'll add that.

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2mJ+AACgkQJNaLcl1U
h9Ay4wf+MsvUB3phMph+FeseDNtUCbZB56TddQDXZG4REJqWos8QI36uPQCnja++
VRER25MNwykMnD0KugHFnVlYbUrYAwswUgiIwSUAvnoEZiMtXwqCKSyMKeFoZYb+
u/nIKXIXVhS+TG4R3ZKXabbExsRKiHfDx7viGiX3D11km7G1BpDHDEX+bD94FGxF
WLEYHCkHcjuR3vnLtTCiBhPVQlWbIHDEeJ2+09q8aRGQ/mLfcsvMcJkPk5CnzfEu
bJbR69f2DtGyyD7nTNxJvaOlTeza3KINPAIZGqTsi6YMvcmWhF/rlhvP1hXWh8Hc
YhpoJ5/ulqqs4Z7vOaweOghtICW66w==
=52TT
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--

--===============3122578893224854432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3122578893224854432==--
