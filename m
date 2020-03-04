Return-Path: <SRS0=cEba=4V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B00C3F2D1
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 19:39:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4062C2166E
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 19:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XSHaXjXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4062C2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96DCA850;
	Wed,  4 Mar 2020 20:38:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96DCA850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583350775;
	bh=HTVfFAISTkoYVCcdx6H3LGq1DInvTxYEzR7LGvjseBo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XSHaXjXDF61Epufapr/XRFmsmTDDshBI17P3gL+GFdiDpTG0nH+w6VISvf9j8KSbS
	 UQBQzbg1tjUDIXrGhjGZu3nkBuXyPPqc4raveDZdUI2SyMx0oRXyIi6FSogq/BVHmN
	 gLOtG9sxJhI/hL6VcbaeInuDXi3ju3YfGcbUmX8M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 25617F801EC;
	Wed,  4 Mar 2020 20:38:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6CCE3F801ED; Wed,  4 Mar 2020 20:38:42 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 5201EF8012D
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2020 20:38:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5201EF8012D
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B41C4B2;
 Wed,  4 Mar 2020 11:38:37 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDA1C3F6C4;
 Wed,  4 Mar 2020 11:38:36 -0800 (PST)
Date: Wed, 4 Mar 2020 19:38:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: 5.5.y - apply "ASoC: intel/skl/hda - export number of digital
 microphones via control components"
Message-ID: <20200304193835.GH5646@sirena.org.uk>
References: <147efa37-eb57-7f17-b9eb-84a9fe5ad475@perex.cz>
 <20200304154450.GB5646@sirena.org.uk>
 <a6d57c14-0794-77d0-5c6f-c0c897d254b5@perex.cz>
 <20200304160916.GC5646@sirena.org.uk>
 <44cf4ff8-120f-79fd-8801-47807b03f912@linux.intel.com>
 <20200304181113.GE5646@sirena.org.uk>
 <669e6e57-3a84-7cf5-398f-eefdd333fadb@linux.intel.com>
 <20200304190620.GF5646@sirena.org.uk>
 <3b00df9a-6b53-def7-4304-d9829de749c6@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZYOWEO2dMm2Af3e3"
Content-Disposition: inline
In-Reply-To: <3b00df9a-6b53-def7-4304-d9829de749c6@linux.intel.com>
X-Cookie: Tomorrow, you can be anywhere.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Sasha Levin <sashal@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>, stable@vger.kernel.org
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


--ZYOWEO2dMm2Af3e3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 04, 2020 at 01:30:59PM -0600, Pierre-Louis Bossart wrote:
> On 3/4/20 1:06 PM, Mark Brown wrote:

> > Anyway, is my understanding correct that this is fixing a regression
> > caused by switching the default to SOF?

> This is fixing a regression on platforms that have digital microphones,
> where SOF is automatically selected by default. For platforms without DMICs,
> the legacy driver is still used and this patch has no effect.

OK, in that case this should go in then - it's certainly a lot better
than reverting the switch to SOF.

--ZYOWEO2dMm2Af3e3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5gA7oACgkQJNaLcl1U
h9Aqnwf+N5KM/Cmi4GB26cAI4MASpEEAzL4A2C9YOOvYiffNanyIkQMMmKaXRywa
+AulLIdp9/iTKJ/EnFlGujCSH5t83Jt5/H8wS3DdcMPCCpHG70LcUbVmTZchieTq
o+Xh90wM52QI+MRhL9l/pyi62VxbTjzD0uY5Rt9fOPS27h+jjrdwMyFrv5V9WbYw
QBTk9CWCrRyNXaFwadSmkvuWvCiCivC+SQVml37qNMt6ckkRjGClZlOxqK9Drc/u
graRgpVwPgeFFlvTCacOPd0FLt0HHGjaBdCsRJeyo3+oRN/57rXTXamVgsRlykwI
JskeYZHzTgqEO/aCf+4+2wKU9rRl/g==
=f+O1
-----END PGP SIGNATURE-----

--ZYOWEO2dMm2Af3e3--
