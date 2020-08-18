Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49475C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:12:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A8A20738
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="l6MEIzKV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ysoXPfr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A8A20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2414E17FE;
	Tue, 18 Aug 2020 19:11:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2414E17FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597770744;
	bh=J7IMCR9VGxvuNnH4wgPg8mBRpRL4cmvMOZY0WSvKWms=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l6MEIzKVTiPHJHClrLVRi+CqhrUnyp9RfCpguwiWTezj2ONDx8XbK9ce9RASPysL4
	 on4YKkcY0YrXfNu46aPWl7eVuCqisg6UvDOoaKnT0FrL4FKMx3QX4suZKbN2FL18bt
	 CpZi/kP28YYwXqxOO14SAPkp2Bqtc7TACLYgdUSE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1D0CF80114;
	Tue, 18 Aug 2020 19:10:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69D1EF80228; Tue, 18 Aug 2020 19:10:50 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5639BF80114
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 19:10:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5639BF80114
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ysoXPfr6"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B4E6B2063A;
 Tue, 18 Aug 2020 17:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597770642;
 bh=J7IMCR9VGxvuNnH4wgPg8mBRpRL4cmvMOZY0WSvKWms=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ysoXPfr6h0TtHWQDqxjEXV3OXUQHVeGbdvyGy0t+gk0na63mYj7r8eFeo/OoDKS1r
 HqU+rtl72t9ovmdK3W/1bRJ1ARPib1kT3jCg4uEdloCECPGU8fMCuyUmPy8b6SiQWI
 O7h0pr9c4OiAVosG4cURUGfNoDcrJzpmV4EeeNZk=
Date: Tue, 18 Aug 2020 18:10:11 +0100
From: Mark Brown <broonie@kernel.org>
To: "Lu, Brent" <brent.lu@intel.com>
Subject: Re: [PATCH v3] ASoC: hdac_hdmi: support 'ELD' mixer
Message-ID: <20200818171011.GE5337@sirena.org.uk>
References: <20200818004413.12852-1-brent.lu@intel.com>
 <20200818143632.16539-1-brent.lu@intel.com>
 <20200818150225.GC5337@sirena.org.uk>
 <DM6PR11MB36421674C19320503D26DABC975C0@DM6PR11MB3642.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
Content-Disposition: inline
In-Reply-To: <DM6PR11MB36421674C19320503D26DABC975C0@DM6PR11MB3642.namprd11.prod.outlook.com>
X-Cookie: You're at Witt's End.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>,
 Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
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


--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 18, 2020 at 03:22:03PM +0000, Lu, Brent wrote:

> > Please don't send new patches in the middle of existing threads, it makes it
> > hard to keep track fo what is going on.

> Sorry for the problem. Does it mean I should avoid using " --in-reply-to=" when
> sending new patch set?

Yes, please.

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl88C3IACgkQJNaLcl1U
h9BiEQf/ShKme+ABfZ554O96jaOy/4SG+HMYbjm8COsRqE0J48jxiWSVdjX8N7zA
1biJiI3NRqPYVkZ34K6SXTF5tVrbogM5W2SVsyUBHTATywi+4xmY2vNq9gTup5dt
tXsPXtV4jeaeDyVwkk9GnoIylgAx9BHJ7YytytwRZ/d1vok+iZrfWdRALuLpc2F2
dIFwFIeJL0HNB2ClK3lhpyEjbYvXplo8asRpnC19YD6A43r3M/ZL1m0HRyiD18eL
zWBEk9fSHqphMLDQEkPhJ27Dycc5I5BRXL3nKqmyc8jcniXUvII/U3GZ+uyR4Ntf
XPR14ygpAbeMY13F6HmTDnSlCqkPgQ==
=zVQK
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--
