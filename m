Return-Path: <SRS0=JLiH=6H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0A6C2BA19
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 10:24:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B9F20781
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 10:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="scOlfUmx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXnuOrjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B9F20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A6B51690;
	Thu, 23 Apr 2020 12:23:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A6B51690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587637462;
	bh=nt6BxUMN9W2eJF7E9nemEDO2szsJjgfFAzjuRjtd3Us=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=scOlfUmxp8KJ/XUOCygHj3kWev66SbkL/DwYHE9IqzC+sOXm/HCd107NPZHuCuxG7
	 D7bAuvphawi4TWr7RhbWtCYHhDqItvDOjLaGabFRLAhl2gbr0f6VrzEzmtOmW84Odl
	 +AFhUxW6TV0E3oO2trKhHwnw1tTtZxKhFh0WBgaQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C14DF800F2;
	Thu, 23 Apr 2020 12:23:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03F27F800FF; Thu, 23 Apr 2020 12:22:50 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BEAA3F800FF
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2020 12:21:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BEAA3F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RXnuOrjP"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7603F2074F;
 Thu, 23 Apr 2020 10:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587637279;
 bh=nt6BxUMN9W2eJF7E9nemEDO2szsJjgfFAzjuRjtd3Us=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RXnuOrjPt+5uK+vtmfLy+653zHEpc3aVLTlJHtDE8BsHBf6GvHDeZGYC/NeOPUPcc
 tqdPaMzB0IrldqaQ68oyZw9JFmTNLt/Cjr2EzBMJXL9HtmMmNT916Iw8K8TJRz19Yp
 lI4QiKysCakuUGB7AtME8XJTvTJlipp7CTwHshjk=
Date: Thu, 23 Apr 2020 11:21:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH v2 0/3] Add support for different DMIC configurations
Message-ID: <20200423102116.GB4808@sirena.org.uk>
References: <20200422120532.31492-1-mateusz.gorski@linux.intel.com>
 <89873366-c063-5754-0e18-511477c3daa5@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <89873366-c063-5754-0e18-511477c3daa5@intel.com>
X-Cookie: This unit... must... survive.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, tiwai@suse.com,
 Mateusz Gorski <mateusz.gorski@linux.intel.com>
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


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2020 at 11:11:05AM +0200, Cezary Rojewski wrote:
> On 2020-04-22 14:05, Mateusz Gorski wrote:

> > Changes in v2:
> > - removed patch 1/4 swapping machine device and platform device
> >    registration order
> > - alt_tplg_name creation now uses different field to read machine driver
> >    name
> > - including of <sound/soc-acpi.h> moved to different patch

> Ain't change-block supposed to be just below message body?

Only in patches to stop them getting included in the git changelog.

> Don't believe series need to be resend just to fix cosmetics:
> Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>

Well, I don't seem to have a copy of it so it'll need a resend for that
unless it's just held up somewhere and arrives shortly.

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6hbBsACgkQJNaLcl1U
h9Dirgf+Lh2CSaRCl1bWga0HFUsfQzZCrKhSNbCP4aMBl4tuJh9MyGZgBreURDSZ
655sjzS5Axd9BMQVoMZPvGuyG3pYni+od8t898YmQ4HhkRBPQzh6LuKsIjEYbBhz
0h2iyWTK+EYujFpsLQxcJ8zgBw09nEo9qgCj49Uy0G7nn6usP7YAQyli8AijsXUT
gZV/eoQWzSP+HKRGVibO6u5wTBpZq23rEwgYbp+RZzQcDd+xl9VQwCzk+fe1RS0C
tHdcr1OGwEJS3NsBkB5KmOXqwwJw8NO8SvRpPGb4S7syYVcjz4VdoLkWtakvGzmI
+D5OoKdytfVBxWYgpdwesLFft+8CZg==
=QGti
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
