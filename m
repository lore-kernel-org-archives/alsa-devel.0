Return-Path: <SRS0=Zr1M=45=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1DEC1975A
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:39:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7059D206BE
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EwBcQpfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7059D206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D09CC16DB;
	Thu, 12 Mar 2020 13:38:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D09CC16DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584016766;
	bh=GwCJ2d7xNRs+Skjjk/0vEHgNM60B5BLGqEX7TuGKoi4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EwBcQpfwFukM/V+Jg2eYhItZRJY78+h4mS4YBu2UmWry16s0kq6S0T6Nz/BYXnu4O
	 YlqJIu7sDd2biYMu4JJ1lxvKo+NrLdW6+nVzCdj5MkwKQkoLMGaw7KHQsM93bGdSbm
	 a9s4gbfS5hn2R0Z++PeAn6UznYWLCtxNtRIIG0QQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 61902F801D9;
	Thu, 12 Mar 2020 13:38:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C5BFEF8020C; Thu, 12 Mar 2020 13:38:34 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 48686F8013E;
 Thu, 12 Mar 2020 13:38:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48686F8013E
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5790B31B;
 Thu, 12 Mar 2020 05:38:23 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFCBB3F67D;
 Thu, 12 Mar 2020 05:38:22 -0700 (PDT)
Date: Thu, 12 Mar 2020 12:38:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 2/2] ASoC: export DPCM runtime update functions
Message-ID: <20200312123821.GE4038@sirena.org.uk>
References: <20200312095214.15126-1-guennadi.liakhovetski@linux.intel.com>
 <20200312095214.15126-3-guennadi.liakhovetski@linux.intel.com>
 <55ea2704-121d-9940-3c84-169cc65016d9@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ffoCPvUAPMgSXi6H"
Content-Disposition: inline
In-Reply-To: <55ea2704-121d-9940-3c84-169cc65016d9@linux.intel.com>
X-Cookie: Security check: INTRUDER ALERT!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
 sound-open-firmware@alsa-project.org
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


--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2020 at 05:51:59AM -0500, Pierre-Louis Bossart wrote:
> On 3/12/20 4:52 AM, Guennadi Liakhovetski wrote:

> > This makes DPCM runtime update functions available for external
> > calling. As an example, virtualised ASoC component drivers may need
> > to call these when managing shared DAPM routes that are used by more
> > than one driver (i.e. when host driver and guest drivers have a DAPM
> > path from guest PCM to host DAI where some parts are owned by host
> > driver and others by guest driver).

> My understanding of Mark's feedback was to avoid exposing DPCM functions to
> other subsystems, since there's a long-term desire to move to a different
> domain-based handling instead of the existing FE/BE split.

While we have it I can see that some individual driver might need to
fiddle about with it though, after all a big problem currently is that
the abstraction isn't terribly abstract.

--ffoCPvUAPMgSXi6H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5qLTwACgkQJNaLcl1U
h9BzSAf/UuQidDIHtg7Z3RBA38MWA0BufE6oINNcgbEgbjwbS9uA8dfFNDfnIWCQ
4B0OYNCrE1cd376uI3vX32RyLd8HRVCJq396jd5vXEWwWmuFYRUYT3jKya1k4EzQ
Fbczitvl112HB4b62WBza+lFSbgKEBEiHCTajNGsKGytty3ZIPeN+cRtG8bt9ick
kOO0Dxv5BsLk6fa6nz/M6anN/uxx9sz/VV0Z16R/VrP29gdhb28+aSSRDR8xDUa+
7qOs6KV7mY6oOkZqIV8z+u71djL+FQdkBKcbj/M+aeY0+y+5FK5HpVs39WA2MZdA
U7YImQUvkMEZo/SyX9eFGBUGRvMXTw==
=g/2w
-----END PGP SIGNATURE-----

--ffoCPvUAPMgSXi6H--
