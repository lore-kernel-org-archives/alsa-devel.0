Return-Path: <SRS0=GKc0=DA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA38C2D0A8
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:39:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE8020791
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AYu4dATF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQr6ZN7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE8020791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F81E174F;
	Wed, 23 Sep 2020 18:38:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F81E174F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600879137;
	bh=FiyYNIydlw3wxJqyUMyIQHWWUDAPi9BauKJqiFoVNRU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AYu4dATF5wTE1r52me9Pa8H+mrUYJeGTvWxSji8xzjK+ECp5RRsX0S5ExjycAuoEg
	 W7icPsuRmBjbD9sHi1q4VtmiY2IEvXxhoBaBwxko5eDieORDGyLqI/jAD9KcJPrzyc
	 etMLvOmveyoKWZAbGfFS5deKuIHMkF91yck/DCmg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BE2F3F80162;
	Wed, 23 Sep 2020 18:38:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4807FF80171; Wed, 23 Sep 2020 18:38:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44C7FF800B4
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2020 18:37:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44C7FF800B4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TQr6ZN7W"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A5F2120791;
 Wed, 23 Sep 2020 16:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600879072;
 bh=FiyYNIydlw3wxJqyUMyIQHWWUDAPi9BauKJqiFoVNRU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TQr6ZN7Wwd8TeXFpLCmmJSRYGrNtpOpIMyRkSBv6DYyhHjrMDWvsHrPV15tpaLimH
 ttMBVNRTz8hDL4N9YqUgmzTI8uax0wGvdUgINZU9tbROrvP5hVa8oavSxgc53GRCcB
 SPYRwOJyqhT01RibJFHLniiCJtTXYLxzSOpCP8WU=
Date: Wed, 23 Sep 2020 17:36:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH 1/6] ASOC: Intel: sof_sdw: restore playback functionality
 with max98373 amps
Message-ID: <20200923163657.GA46671@sirena.org.uk>
References: <20200923080514.3242858-1-kai.vehmanen@linux.intel.com>
 <20200923080514.3242858-2-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20200923080514.3242858-2-kai.vehmanen@linux.intel.com>
X-Cookie: A king's castle is his home.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 Keyon Jie <yang.jie@linux.intel.com>, pierre-louis.bossart@linux.intel.com,
 Rander Wang <rander.wang@intel.com>, ranjani.sridharan@linux.intel.com,
 daniel.baluta@nxp.com
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


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 23, 2020 at 11:05:09AM +0300, Kai Vehmanen wrote:

> Fixes: 7eec07f389a60 ('ASOC: Intel: sof_sdw: add dailink .trigger callback')
> Fixes: 5595f95c32650 ('ASOC: Intel: sof_sdw: add dailink .prepare and .hw_free callback').

I don't seem to have either of these commits, I think you meant
ae3a3918edf57b and 06998d49bcac8a9 respectively?

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9reagACgkQJNaLcl1U
h9DffAf9G1K2A0Yhpixo7RjKRdFbTdGzC5Q0mugRhc0JOEhu8Ovbx6lf8zXSaCST
pKUdnvb4C6BmQoEpkMWBZwwJlp32xtguo/iXxCNtMitjaDaObSKqDiTRkdIyaacX
rlhQC6JKW4mMqUFnlgrTBxu0pLfHL9xhVorowAW69ZsH8gyq5sh2720QRVQInCmN
CFcTQFZhIrJJA50WNxfrzChhrjh1mFO5nvVqRLXAsmuPbagBqt54rQhaLIdsIoEw
slGQEXD7DxcNvcI1elJL3quG/NZWO6wpfyNdoq7X8HRCOt+H3SwRLXRVVOr348YL
8K0rze9bXfJX/mDOpPKMUker840VXA==
=iw2N
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
