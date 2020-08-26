Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2409C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 17:27:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA202075E
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 17:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="q85RxUyF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRE9gAq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA202075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E39A177B;
	Wed, 26 Aug 2020 19:26:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E39A177B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598462819;
	bh=S8TXZrq1wbwhPqABDtlshBxR1KjWnaZqnCtcuEK91FA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q85RxUyFX5xvbSbt4qteyBHvUEAIfTAcTwOj89Xs1Dcu3HGyDwmGLXtXyR0ZhCe76
	 NHOIyBSXuY3z71/2pzxjhgZXhH83ULApmB2wfo8t9caN5Qzy+pAhTk61YBtQcmcEo6
	 mWQJbRA/KRc3tx/U4xe/avH9BhBoyLkmhGUHnu8M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5D6FF8016F;
	Wed, 26 Aug 2020 19:26:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 547D0F801D9; Wed, 26 Aug 2020 19:26:07 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E49F3F800EB
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 19:25:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E49F3F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="vRE9gAq6"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AE5152075E;
 Wed, 26 Aug 2020 17:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598462753;
 bh=S8TXZrq1wbwhPqABDtlshBxR1KjWnaZqnCtcuEK91FA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vRE9gAq6ZNqBg3N58fycZZ/pb3EXixz70zN1ZsNqLj65QEbquM7zRlhelGMNG2pr2
 iiIXK2zbHSarABuV77ZxpjApU/K6VsKSvHrr7YqyEyczQNBv4lHPEeYIdoFgIxpA6s
 I53dOocISH2azcG9NvRRUt+xr/E1JC4gQJR+84Rs=
Date: Wed, 26 Aug 2020 18:25:16 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/4] regmap: sdw: move to -EOPNOTSUPP
Message-ID: <20200826172516.GM4965@sirena.org.uk>
References: <20200825171656.75836-2-pierre-louis.bossart@linux.intel.com>
 <20200825214858.GK5379@sirena.org.uk>
 <6f7e5830-4dd8-1ecc-20c3-df75bc9ef265@linux.intel.com>
 <20200826095600.GA4965@sirena.org.uk>
 <s5ha6yhu3af.wl-tiwai@suse.de>
 <20200826101301.GB4965@sirena.org.uk>
 <s5h8se1u2or.wl-tiwai@suse.de>
 <927c93bc-9ad8-7e5d-a5ea-d566e5f543df@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BHMq0+oGliEfCAkH"
Content-Disposition: inline
In-Reply-To: <927c93bc-9ad8-7e5d-a5ea-d566e5f543df@linux.intel.com>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>,
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


--BHMq0+oGliEfCAkH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2020 at 10:05:50AM -0500, Pierre-Louis Bossart wrote:

> I assumed this change to -EOPNOTSUPP reflected a consensus in kernel-land,
> it's obviously not the case. This patch was supposed to be a trivial
> clean-up...

No, it's just some random guy sent a patch.  They've not made any
perceptible effort to interact with any of the existing users.

> So to be clear, what is the direction for existing code
> a) keep -ENOTSUPP as is?
> b) move to -EOPNOTSUPP?

> And what is the preference for new code?

If you want to change this you'd need to change it over the whole
subsystem (if not other subsystems), including the places where the
value is used.

--BHMq0+oGliEfCAkH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9GmvwACgkQJNaLcl1U
h9CVZwf/X1R3FvN72dVYg3h6EUe0Lc2dc9uETB0siPhxUEa3nMuatoNxcp5W4x1U
d6oIj55I4XmyMV4M7qUTaJWPiuIxptj/X6tuFQysg2QULq98txsRtp/S8+UnSeW3
l9ECbZxahzFi6ydJI+QEZbdTu3gykzMrZ4vPHRJ430/Q9Xof+GSiBQ5yWKwz8Yy3
nmmkeSDJk0AFLkqCzpG3pDRo+HxEnKfcJVaDl//AYnmKySZxzu0PacTVf7ceFYIa
ehD1Z2lBJEG2wcAfwJaEh1IFG+NiqbePpBH+Nziy71y7UVc082qCfE31NZlkt6Ts
MJUmhHp0xcUaBV9koqd5IQKGnmWw8Q==
=ls7t
-----END PGP SIGNATURE-----

--BHMq0+oGliEfCAkH--
