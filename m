Return-Path: <SRS0=q21C=4W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A792BC3F2D2
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:12:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376B62072A
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IBQErVD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376B62072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 77D17823;
	Thu,  5 Mar 2020 20:11:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 77D17823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583435519;
	bh=Tg22VAbaXpgfvwqMyFJUM5bgNTIA1RSUTchM0Dcun9M=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IBQErVD0SPNmykpmT+X3op0UX0WcNWV2v6mwY9yh+U3JeChoZou1M8P5TNxzdy5N2
	 yGfgv5m5GzwvuW7ILINYQ8l6eZZVfhKlE3zDkn6jWZPGVCjEK7HSfWKycdWhO5Pm6m
	 kvKhjSJtmMmQ1Hv6XInFQawWJ8zfc/pLuFg6OnRI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB5F1F80245;
	Thu,  5 Mar 2020 20:11:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84579F8025F; Thu,  5 Mar 2020 20:11:07 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 24873F800D8
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2020 20:11:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24873F800D8
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFBBA30E;
 Thu,  5 Mar 2020 11:11:01 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 606893F6CF;
 Thu,  5 Mar 2020 11:11:01 -0800 (PST)
Date: Thu, 5 Mar 2020 19:10:59 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 2/3] ASoC: Intel: bdw-rt5677: fix module load/unload
 issues
Message-ID: <20200305191059.GL4046@sirena.org.uk>
References: <20200305130616.28658-1-pierre-louis.bossart@linux.intel.com>
 <20200305130616.28658-3-pierre-louis.bossart@linux.intel.com>
 <20200305133638.GE4046@sirena.org.uk>
 <13857c7b-f7d2-9be2-c1e1-a577a774773e@linux.intel.com>
 <20200305135908.GF4046@sirena.org.uk>
 <c1419cb1-c1d6-897d-05a4-48e57a3e15db@linux.intel.com>
 <20200305174324.GH4046@sirena.org.uk>
 <7c52ff6f-76ef-7c55-65e6-9c0437bb983a@linux.intel.com>
 <20200305183335.GK4046@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IuJpT0rwbUevm2bB"
Content-Disposition: inline
In-Reply-To: <20200305183335.GK4046@sirena.org.uk>
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


--IuJpT0rwbUevm2bB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 05, 2020 at 06:33:35PM +0000, Mark Brown wrote:
> On Thu, Mar 05, 2020 at 12:08:57PM -0600, Pierre-Louis Bossart wrote:

> > b) do you have any objections if we remove this devm_ use without trying to
> > dig further into the gpio management. This is a 2015 product that we use to
> > verify the SOF driver on Broadwell, not an Intel-owned device.

> The main thing I'm missing with this is a coherent explanation of the
> problem and how the changes proposed fix it.

Just to emphasize: the main concern here is that the issue is understood
and that it's not just going to pop up again as soon as something
changes.

--IuJpT0rwbUevm2bB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5hTsMACgkQJNaLcl1U
h9AR2Af7BOUy+sNAJAEw+WajcIvcrI1wH+yUgoMhOIjlhR8H96l0LNDPxO69Jlpk
9efrj6YLW1o4dJQ0LPQzj+TrUOKkboN5LGZPiwj5QpzuJZgG/50gqwJ7iIqe1H+q
b1x4YeqksdyQTvnPqSdBc/l7mSx1LDvWptta91P3DaVZT72gYiV3y5sN8L9uVVma
w3QJusxR2HkMXHbpM0FannWgm87bwVHsuL0zWFNR8EmpvCEaVnwx3FSDkVK4YxHd
9iCLe605KPfpHldDminr82ndOANHH/GoFRM0BiMUIoH95PlVhyWLjvXHLqL58WWG
9T7P5DprVMZzk+/uDMlGcuQdfDkODw==
=/Brb
-----END PGP SIGNATURE-----

--IuJpT0rwbUevm2bB--
