Return-Path: <SRS0=A1sP=CN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE18C43461
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:27:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F2C20770
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 09:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="G4zte7gf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKvcHO/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F2C20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1EA3F1ABD;
	Fri,  4 Sep 2020 11:26:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1EA3F1ABD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599211635;
	bh=4PTJ1XJ+HWOyuTE1GmwLHh+FAQUzDaWamJMZYkIFE4A=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G4zte7gf5qtqyC7C0qb5Y/ImxV6JMH412zd9woqcJDgsuMPsdpw/WRLZdIXyBcvC7
	 QDN35HFSD0kbBt5ufiWyFFTe2mL/ViGsF7CHyrSvCUColNRURIteEB07JLJ2S0dAsD
	 HP0JdcWDcZ12KCrastKiBD20N2AosvbDmnDBstAs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B54B9F80212;
	Fri,  4 Sep 2020 11:26:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E6DFF8024A; Fri,  4 Sep 2020 11:26:24 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3C55F800F0
 for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2020 11:26:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3C55F800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HKvcHO/N"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D5A77206B8;
 Fri,  4 Sep 2020 09:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599211575;
 bh=4PTJ1XJ+HWOyuTE1GmwLHh+FAQUzDaWamJMZYkIFE4A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HKvcHO/NcTcGPgNBRnTdAAXQ5jjUTx/zgO19sDZ8z6f3BpsUnk24IlLbGzQ7TlQck
 b80VqGNi0aco7VNqJtncUonqgkL7LiCCyAeujCkK6FKHTXCJat6v/PIZIYHldSnrUg
 alpciBZ3LHTiwqTgSsedYh9G68harCgIqAFC5xhI=
Date: Fri, 4 Sep 2020 10:25:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [RFC] soc_pcm_open: error path behavior change since v5.6
Message-ID: <20200904092533.GB4625@sirena.org.uk>
References: <48810933-41cf-265c-1784-2e2acf979720@intel.com>
 <87a6y6mmzt.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <87a6y6mmzt.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Heisenberg might have been here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Takashi Iwai <tiwai@suse.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2020 at 09:01:03AM +0900, Kuninori Morimoto wrote:

> > Should dai's ::shutdown() be introducing some kind of state-check from
> > now on? - similarly to how developers deal with some of the core pcm
> > operations e.g.: ::prepare() (as it may get invoked multiple times in
> > a row so check is there to prevent redundancy).
> > Or, perhaps behavior change should be reverted with ::shutdown()
> > routine again being called only after successful ::startup()?

> I'm sorry but I couldn't 100% understand your opinion.
> But I understand that it is related to rollback order.
> Now I'm posting patch for it. It is not yet 100% but 1st step.
> Does it help for you ?

> https://lore.kernel.org/r/87wo1kvozz.wl-kuninori.morimoto.gx@renesas.com

It's not just the ordering, it's more the fact that we will clean up
things which failed to initialize.

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9SCA0ACgkQJNaLcl1U
h9DF0Af+Nj+6aHHMOZjB7Ybay8bliGqHbUxzgvRO/AOsMhkRW5pOj7k+8uOrKlw1
L0tqqNTGA9LYhDOiNGnOej6Ndxt0bYcB2vmqsLdjMW2+DRCNe6aIkl749+PbY4b0
4B2RGNU/p/e0ozm5hpGVFz97+3gsD90type9ucU4wc+SQIj1PdmDw8PV89ye0V7t
PjiA6dC+qLD9QR8QIOlBoRy2p661mbLzaoSfnMD3iiUt9T0C90MAsLqVjLVglhtB
znL45Kzc+JXWqhLIl0KXVAEfdsMCbikxXidqLBWIIij1ZYgeeHThUHA9i5fNs6Hu
EL/igNBf303qx5rhht85qs5/Uj8uug==
=Z/K8
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
