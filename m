Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BED2C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Nov 2022 15:27:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C77FC1681;
	Wed, 23 Nov 2022 16:26:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C77FC1681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669217217;
	bh=zL0CCT56Xgsxd4SQl/Dl26mTBGpIJpFPMV7Sf5vSiW8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WwCUUNsJ9QLGlnQTiTV+MDDf7Dv8kL833n5QZibN/Ghp1TIHW1KDziccbbbLoSAuP
	 xMBN5xxfnRsWHoZ6n5UtHW4BxurlG+5BgzuKlVCx+ILA+ki1fjOdZNgl8Mhd1Xh/VH
	 bMNTOahNe9GfD+q8RzjHSTyXaAiSvRC5MvgWQOGE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CFB6F80249;
	Wed, 23 Nov 2022 16:26:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E020F8025D; Wed, 23 Nov 2022 16:26:05 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D7D7F80149
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2022 16:25:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D7D7F80149
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IbHoBq+m"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E33DF61D97;
 Wed, 23 Nov 2022 15:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC14C433D7;
 Wed, 23 Nov 2022 15:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669217156;
 bh=zL0CCT56Xgsxd4SQl/Dl26mTBGpIJpFPMV7Sf5vSiW8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IbHoBq+mDlW1CD4ianlE4we3e4rnN+mAAJLuJRgJHdz5xBDqDyV8NeR+CbkZVpqc3
 ZbgLNTd2St/C0fASeCDww26vjNpwB0JYFlL1gBiaFC0wYlS4eh6+FaRmFwTrbRK9PB
 w0qWlEzU2+Wfi1Cl5sHG7ZBy6tugvtBwQ3pEw9f5yYHWafQTrStoaVgsOkW45uCQhQ
 ishK2l5NuvFEUnBx4pkiZoY8EwjasbuwSShlq+0jrB+NNFe9CJsn6AhwYDgIy8ryOU
 DeIOLs1khsFqfETj2rnUa/67bcSA18kPTgFMxtFG0nlcqhjROQPnPfvYJkhewhQRd1
 MB0Bm9ojkUSxA==
Date: Wed, 23 Nov 2022 15:25:51 +0000
From: Mark Brown <broonie@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC/soundwire: remove is_sdca boolean property
Message-ID: <Y347f24Tx5yZtjLw@sirena.org.uk>
References: <20221118025807.534863-1-yung-chuan.liao@linux.intel.com>
 <20221118025807.534863-2-yung-chuan.liao@linux.intel.com>
 <Y3enHzY8XY70/nWR@sirena.org.uk> <Y34znr8o9+RceRif@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mO0JegAO4sWomPS/"
Content-Disposition: inline
In-Reply-To: <Y34znr8o9+RceRif@matsya>
X-Cookie: I'm rated PG-34!!
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com,
 peter.ujfalusi@linux.intel.com, bard.liao@intel.com
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


--mO0JegAO4sWomPS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 23, 2022 at 08:22:14PM +0530, Vinod Koul wrote:
> On 18-11-22, 15:39, Mark Brown wrote:
> > On Fri, Nov 18, 2022 at 10:58:06AM +0800, Bard Liao wrote:
> > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> > > The Device_ID registers already tell us if a device supports the SDCA
> > > specification or not, in hindsight we never needed a property when the
> > > information is reported by both hardware and ACPI.

> > Acked-by: Mark Brown <broonie@kernel.org>

> sound/soc/codecs/rt1318-sdw.c does not exist for me in sdw/next. Can I
> get a tag for the changes merged into ASoC for this

Not reasonably, that's basically the entire tree since Linus doesn't
like branches.

--mO0JegAO4sWomPS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN+O34ACgkQJNaLcl1U
h9BeTQf/arDxellNcCzUN/glW39lE/e9xse49cq5bOioF02H5Njfsyq3WgvqsGAw
XDC7uiQlMXsyhAlAVTRf4A8ENym66Xa9a7tVl8e3zsrG1RIFIAsrAzsRCw2YfqO5
xoTr4f1qAN6v/l+IMM6mvgFDFf5IlEp68lt04RcUvoBP67hGeiC/H3UcN9BeFhKf
gilZ0E/AqGusU0gYyrzoFHoFOkex1kpLSe7O1XBQBd+sBaD9Jvg/1/bgudMvGVN6
Bp5wWZSjEXdEEf+sab9JVfHBEiUHMtLcFh7e9GUhERuRg9z0EHSM8qUmXuSnFZCq
prAlH54N3Voiz+eg0BkQ42+ZumH3wQ==
=b6cd
-----END PGP SIGNATURE-----

--mO0JegAO4sWomPS/--
