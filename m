Return-Path: <SRS0=nhcg=4A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C47BC352A4
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Feb 2020 10:09:11 +0000 (UTC)
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F38D21569
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Feb 2020 10:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TRyVTfLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F38D21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF337166D;
	Wed, 12 Feb 2020 11:08:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF337166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581502148;
	bh=IgH+cPTdJO3it65SrKeMr6HrPOg/JWyGvTLfOR54opc=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TRyVTfLrR5UpG+5RPLIwIJkKw+2Rt/6AsrlaJK6g6xMzATsSsRs0mGrqDBMmaIoGg
	 CjAZGwZMwbEDCsv/BYkfHMtUeVLE8hf8hvP9VZ9RitkdF6JVs+fmey0/puKzYbnm4r
	 shtEbQNMEuRMGqk2RRaxl/n5kEkNpr1HMsfGtR+k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4DCE2F8014F;
	Wed, 12 Feb 2020 11:08:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07666F80157; Wed, 12 Feb 2020 11:08:17 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 4B0DDF800E7
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2020 11:08:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B0DDF800E7
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60D3930E;
 Wed, 12 Feb 2020 02:08:12 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCC6E3F68F;
 Wed, 12 Feb 2020 02:08:11 -0800 (PST)
Date: Wed, 12 Feb 2020 10:08:10 +0000
From: Mark Brown <broonie@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Message-ID: <20200212100810.GA4028@sirena.org.uk>
References: <1654227.8mz0SueHsU@kreacher>
 <197693303.hiACyxC3Vm@kreacher>
MIME-Version: 1.0
In-Reply-To: <197693303.hiACyxC3Vm@kreacher>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Linux PM <linux-pm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Amit Kucheria <amit.kucheria@linaro.org>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [alsa-devel] [PATCH 24/28] sound: Call cpu_latency_qos_*()
 instead of pm_qos_*()
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
Content-Type: multipart/mixed; boundary="===============5991984098092810200=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============5991984098092810200==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2020 at 12:34:15AM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> Call cpu_latency_qos_add/update/remove_request() and
> cpu_latency_qos_request_active() instead of
> pm_qos_add/update/remove_request() and pm_qos_request_active(),
> respectively, because the latter are going to be dropped.

What's the story with dependencies here, I only have this patch and not
the cover letter?

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5DzocACgkQJNaLcl1U
h9CdQwf/Q2e/vTZXZOGkQc4SmmLKO8vWdGP403zQCNWSaKnp8IbFP281lmCkdON+
JzyFvlSUWFUEE8U7sSIuzWo7dLQurQkEq1O2klXl8W4HXo0W+8MZtsfFWQHt48ST
vCwe03qod15tZiXHwCfZzIxrwpM5/GfyX9EvFpa7BXCrHPkYs6R9Nr6W6txlwVQC
2Ase3vHCV8SycxbO7t5i4IYkKbjqhy9w/tw0SC+CtUVYCPKwnNXOMESjAnlKeec+
lpaW2Csy6UPWrWTPI8+03haZjxWMAk1zeL3F1ke8jYRCJly/2msG2px7DU1fKXRM
4mHpdaPzJIFLlB4tZFcse46+9ckXyQ==
=Qcri
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--

--===============5991984098092810200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5991984098092810200==--
