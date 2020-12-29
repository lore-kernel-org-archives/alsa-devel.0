Return-Path: <SRS0=cglx=GB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76D7C43381
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Dec 2020 15:17:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D3922262
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Dec 2020 15:17:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D3922262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ADA7E1800;
	Tue, 29 Dec 2020 16:16:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ADA7E1800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609255025;
	bh=95vYDprDKLQKHZRGmeEnhFIjbiFR9nL+tK9XucZ8YuA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eW3ItL8rOO6umUO2N6WZeHIbXHby0+wNfaAx4GESi+YLyzJ4DpOq3TUGsfojkAXDw
	 0I0JkpK6C1teR2e91m+d2NZFPaJpxlsOfsRvXDsN4k9MUK/yYJsnyrnSANuOzCduln
	 0gQbgtcd0iXb/k/cCG+LnIffvM0rrHyWkC/l5WnI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29B3BF80141;
	Tue, 29 Dec 2020 16:16:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 053E2F8022D; Tue, 29 Dec 2020 16:16:13 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5AD59F80141
 for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2020 16:16:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5AD59F80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="mv9piNhK"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F63D221F8;
 Tue, 29 Dec 2020 15:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609254969;
 bh=95vYDprDKLQKHZRGmeEnhFIjbiFR9nL+tK9XucZ8YuA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mv9piNhKIgoz0RQTwhhrA6GWv5Bkgp+L2F+y4ESxD2npoXPjfbGvBnQAgYWsPhATc
 p2RXbFn8odK2JuMUQhw+NVA8PQbUvoMWr/uf3SJlw79/nwHsXB2eHvlAEiBGp7CgZV
 1gYRP1XxXo5KddxjelfUWMM4jLPLc4Xl0HPja9ErmumxppDEgqDPOabMuOhChroPqu
 +vdU4D7zeeo+OuNWJFEz4u/J6dvsDnCWLjruy9y/9gQIuWwgutlpjWYKL8dQPNUgxH
 Udz4E32m4lQsuIeR15OYv2M72nZkD8Xwq5TCcvMxcC7+9n2PPErHr349RguU6M1mvJ
 ukfFyl9AmGX1Q==
Date: Tue, 29 Dec 2020 15:15:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 01/14] mfd: arizona: Add jack pointer to struct arizona
Message-ID: <20201229151548.GG4786@sirena.org.uk>
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <20201227211232.117801-2-hdegoede@redhat.com>
 <20201228122138.GA5352@sirena.org.uk>
 <44f84485-8efc-39f9-d0a7-cb8db2ea3faa@redhat.com>
 <20201228162807.GE5352@sirena.org.uk>
 <20201229130657.GN9673@ediswmail.ad.cirrus.com>
 <19c2d056-4f71-2c4c-c243-cdcc0115876c@redhat.com>
 <20201229150635.GP9673@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="L1c6L/cjZjI9d0Eq"
Content-Disposition: inline
In-Reply-To: <20201229150635.GP9673@ediswmail.ad.cirrus.com>
X-Cookie: Mother Earth is not flat!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Chanwoo Choi <cw00.choi@samsung.com>, patches@opensource.cirrus.com,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Lee Jones <lee.jones@linaro.org>
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


--L1c6L/cjZjI9d0Eq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 29, 2020 at 03:06:35PM +0000, Charles Keepax wrote:

> There is maybe more argument for porting the Arizona code across
> anyways, since for a long time Android didn't properly support extcon
> either. It supported the earlier out of tree switch stuff, extcon

Completely moving the driver doesn't cause the same problems as the
current proposal (unless it drops functionality I guess, there were
issues with adding new detection types into the input layer but I can't
remember if this hardware was impacted by that or not).

> had a switch compatibility mode, but that didn't actually work I
> think due to android hard coding some sysfs naming or something
> (memory is a little fuzzy on the details was a while ago now).

Yeah, it was a trivial edit to make it work which given everyone was
patching Android anyway wasn't a huge issue for shipping things (or you
could futz it in the kernel too if you felt like it).

--L1c6L/cjZjI9d0Eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/rSCMACgkQJNaLcl1U
h9CUKgf/SmDmGdKlxuefiZf+m3Z/r7FO8yNOH1WS14nUrLB0rrnMrZo1L4YclSaI
PfBmU8oY1oNdStYSmZU9L9GMX4MsZgQbxq6cQbzF0B09B2Ep7PgxrciJqD3qiW1M
iItg0BLvQdhRJVgAV+7CTJjbpfAOGhWUmgkVdOp6LKvu1N65GKqiz4pV/XRI1fqV
bLJYgRA2xTIkZHaJj4JnLtMh+vJ8bjZvlUAR9QHnJRSRX/vLaxv4X7ezmr/lpnbE
X4twV7fMvouejovP73ZalUQavmB5bnelqiGUcR1+Zlo+KaUbSqI2r9xHqHGhYTRG
hir59aihExkem4ZCL1igDCuQ1XcHuw==
=bbZQ
-----END PGP SIGNATURE-----

--L1c6L/cjZjI9d0Eq--
