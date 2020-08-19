Return-Path: <SRS0=bO7z=B5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C83C433E3
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:40:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD03207DE
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Aug 2020 08:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dmsDfFeA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuJtQTGs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD03207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5614D1785;
	Wed, 19 Aug 2020 10:40:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5614D1785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597826457;
	bh=oiGIg81VImFLaBXc+cjJbsFLkNWQ4a2+eNPozbjMNs0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dmsDfFeAWMnsHSgohKWuTSpfLZMkXEgGNItrR8dDIbw4O4Nl/GKngjDVClNjrlUlP
	 HWEuo6qk7LPgjP7IKnufu3xIebuhdyy/sfjZz5VQcB4uaCQShczgJR4ZB6GZ4Ra3U0
	 YJLhxWPC1CX6yxaNRIGdYJc64ddx3f/rYWYS9doU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2834F80216;
	Wed, 19 Aug 2020 10:40:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 380CAF80218; Wed, 19 Aug 2020 10:40:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8CAC5F8011C
 for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2020 10:39:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8CAC5F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DuJtQTGs"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 86EFF20772;
 Wed, 19 Aug 2020 08:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597826394;
 bh=oiGIg81VImFLaBXc+cjJbsFLkNWQ4a2+eNPozbjMNs0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DuJtQTGs58CXLAJMLZ8pgnSh2VWCkb3w7SO2zNVqYME2heHqQBAdUXf3ESGjO2B/6
 xUoPiAwOFkGWmVehvT+VdFAJ3X8t+kemlzLWGbaAj3hywx1jDz7FW/AONNgQwvRErH
 1bK1J9/WkBEAOs4f8yq02klrNUkgZTGC0LaZ/xZc=
Date: Wed, 19 Aug 2020 09:39:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 5/7] ASoC: codecs: realtek-soundwire: ignore initial
 PARITY errors
Message-ID: <20200819083922.GA5441@sirena.org.uk>
References: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
 <20200818140656.29014-6-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20200818140656.29014-6-yung-chuan.liao@linux.intel.com>
X-Cookie: I wish you were a Scotch on the rocks.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 vinod.koul@linaro.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 hui.wang@canonical.com, vkoul@kernel.org, srinivas.kandagatla@linaro.org,
 jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2020 at 10:06:54PM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> The parity calculation is not reset on a Severe Reset, which leads to
> misleading/harmless errors reported on startup. The addition of a
> quirk helps filter out such errors while leaving the error checks on
> in steady-state.

Acked-by: Mark Brown <broonie@kernel.org>

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl885TkACgkQJNaLcl1U
h9DBLwf/X2tM2iGHP4+gucIFYm9A9Gdk+fe1Yy+Ss1aBXB9wkEgWc6QwWyg8Xaq0
PZKtoyOzZBfv844U00D+j0oXTpqb8YihMsCGCXuaIOrWiqsOXHZrPDPFMTGGuQJ5
evXAq95XxtSJpfX2Pin6a224dn8bHsyMkIjNThCrdAgeOdkU6hyvLm0K8iTEuTpS
yVdPSD+tUqU2jVmJh4c2DCZu0gi4qlD4p7VH93m57Qamp74bWFLwNUZ346D96Zqa
uXQQNmveYbH4lZ7dMx4ga87b/teuMCbebq+OQ2On6FP5dEJlK7Yoq8MUcKwp2IUa
EEgkYPeK0Qyr4ynMP+Kyy/F841BCpQ==
=nWw4
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
