Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10239C433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:57:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8063F2067C
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nRinXjdr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdfWy0/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8063F2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13855170A;
	Wed, 26 Aug 2020 11:56:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13855170A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598435860;
	bh=Du92FRhluqAO2AfdX7nuJTjVbvuW6hgvo/vP+lWSr24=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nRinXjdrI4ZQptqK/JhLL+bE7CHTOge/E0JPmDZbp8FrhTJNrsXlRB26GEGvUdZyz
	 jrArjF+y96wg2I/KgO+HHLk4VyRwcasTW4pOAk9OrC96F1ide3NUV09HWiEd/jcvJ4
	 XStsfjiTPu/zB+OX1FiAQXZVCpNorHgrT2RuTyeo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4189F800EB;
	Wed, 26 Aug 2020 11:56:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CED23F801D9; Wed, 26 Aug 2020 11:56:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A737DF800EB
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 11:56:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A737DF800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DdfWy0/Q"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B216E2067C;
 Wed, 26 Aug 2020 09:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598435797;
 bh=Du92FRhluqAO2AfdX7nuJTjVbvuW6hgvo/vP+lWSr24=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DdfWy0/QaWPFtQjk2lXSEtNgQqysT5/WhksLCOpQllp9p4OOtV7AP/mzQ5vFDWHlD
 sLUtEGwkdKj9uLYZOrPFtQ+iGre0kpZEzY2CIznSxdCpVKuYPRtR5OoB5n6qgoQPey
 0ln0FMJ6Ge1RBMERGg4vOwjJ2wuPY0FYYohFLmU4=
Date: Wed, 26 Aug 2020 10:56:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/4] regmap: sdw: move to -EOPNOTSUPP
Message-ID: <20200826095600.GA4965@sirena.org.uk>
References: <20200825171656.75836-2-pierre-louis.bossart@linux.intel.com>
 <20200825214858.GK5379@sirena.org.uk>
 <6f7e5830-4dd8-1ecc-20c3-df75bc9ef265@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <6f7e5830-4dd8-1ecc-20c3-df75bc9ef265@linux.intel.com>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 25, 2020 at 05:08:55PM -0500, Pierre-Louis Bossart wrote:

> > > -ENOTSUPP is not a valid error code, use recommended value instead.

> > What makes you say this - it's what regmap uses internally for
> > unsupported operations?

> This was flagged by scripts/checkpatch.pl (must be a new addition).

checkpatch is broken.

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9GMa4ACgkQJNaLcl1U
h9A/SQf9HoAkYdbr7u7FlIMWhzgxCUW+PydJy4E0E+RX1QXJxu5obdTE/47MxSIb
bQ2qLl9g1OyqblmHty4BJSGCH/8mHqiNbnidixs3X1jUGkKepC/MWLPNDNTLRNMG
67ckWqo71U4tODQcO2gEdmY4ADZo1b93YkataMFExkVYs+tcZ+0h88gzrxE6DKLM
lIDq+0U3SL0V0i3kp+OJ5e8CU2Lku7cal/+EK8yGsLAe+4o8QVc2p2w1C9VZ6KUG
PDcSyqQq/jTcjio3WnrDzFv54keLw4yh0nyDeQ5liWQYM2m6hwRaWPc7JZT5UxYe
4x1gBq/4qbM70bYgCwcZilMV2T3UaA==
=dXb/
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
