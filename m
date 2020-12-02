Return-Path: <SRS0=YmRK=FG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CB7C64E7C
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Dec 2020 16:09:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26A33205CA
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Dec 2020 16:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A33205CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 196781799;
	Wed,  2 Dec 2020 17:08:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 196781799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606925356;
	bh=hOfFwbDGZXojMmvPoTEr6keNo7+YHxhXWhs4T8YnWgY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HM9VLD9YuymR1HND8/vn3M1ifG0FPpxy2ID3qvlc3alD3Ly4xUIVEiSFlSJLOkpaS
	 MtRYOZWAX32nYgizDySfYIJdnYzGdNos6VJfB75RUA8mS7lVfAAEamNe0I5frmb6tc
	 YlSyyb48FJmo/6QjoRElm+RHPt4KvCBraJcIF0xE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 862FAF8025F;
	Wed,  2 Dec 2020 17:08:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4691AF8026B; Wed,  2 Dec 2020 17:08:24 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 276C5F80168
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2020 17:08:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 276C5F80168
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dSPh0xKz"
Date: Wed, 2 Dec 2020 16:07:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606925295;
 bh=hOfFwbDGZXojMmvPoTEr6keNo7+YHxhXWhs4T8YnWgY=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=dSPh0xKzS0f8nyxfeKIChWJXvQBmQxzw6ZTwZvUj5JVG3djF2n85TtxxQFiR5fKO1
 DOykDLPa2zyaQa41LtM3vuQzkQOO/lIUExmgN3xio69LoH4N5ZeDFbciXiK7dLudO2
 XDy6fVLrvKEL1tW6EJuNgbJ7aff5HZdEsctHtA8w=
From: Mark Brown <broonie@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v2 3/5] ASoC/SoundWire: rt715-sdca: First version of
 rt715 sdw sdca codec driver
Message-ID: <20201202160740.GG5560@sirena.org.uk>
References: <20201130144020.19757-1-yung-chuan.liao@linux.intel.com>
 <20201130144020.19757-4-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hTiIB9CRvBOLTyqY"
Content-Disposition: inline
In-Reply-To: <20201130144020.19757-4-yung-chuan.liao@linux.intel.com>
X-Cookie: Sauron is alive in Argentina!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 vinod.koul@linaro.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
 hui.wang@canonical.com, vkoul@kernel.org, srinivas.kandagatla@linaro.org,
 jank@cadence.com, sanyog.r.kale@intel.com, rander.wang@linux.intel.com,
 bard.liao@intel.com
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


--hTiIB9CRvBOLTyqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2020 at 10:40:18PM +0800, Bard Liao wrote:
> From: Jack Yu <jack.yu@realtek.com>
>=20
> First version of rt715 sdw sdca codec driver.

This doesn't apply against the ASoC tree, please check and resend.

--hTiIB9CRvBOLTyqY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/Hu8sACgkQJNaLcl1U
h9AI1wf+Mocj13rHR7jKwStrov94tgBi8NYh1GZ10nu7IPGznNB/fwfRf0QiMHJR
DUtsGdQ6Ezgd2kCpEaG1UacBiAG8n10RWd4PGFz7JQmud/S7EvHLyi922Q8web6B
lbHUpjXOF+/7JBXiPG5mDdRMW8yWywXiUlmM9/7wQLAaBzi2NT3092d60fZihj6C
pD1MR5o/j4e2ctvg+AaD2rxxm1KLiEirG8vbcaJM/772htm6x+oQaDvpZmYoj/Dq
KLKEyMoSUgn9TcHlnYkA/rbn5LnDef3taCr0MyeDCAUC52DauZ/yMBv3lOzToMco
y9taEMeO8qfd06h48GM2Hm4JP9aODw==
=0vGc
-----END PGP SIGNATURE-----

--hTiIB9CRvBOLTyqY--
