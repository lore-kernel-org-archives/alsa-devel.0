Return-Path: <SRS0=vl9c=YK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E139CFA372A
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:44:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2662089C
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nCsikF2E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="BnAw9avp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2662089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A18E184F;
	Thu, 17 Oct 2019 13:43:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A18E184F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571312642;
	bh=EX4NBt5/+o45uG+8Sy8R2RbPSQjYY87bMQZyjBvuFe0=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nCsikF2ELWic4vFN/uGxIklrgTyOfzg/5O2G3ol+qy46vih+mKdZeXjDNbu+9IBRP
	 4WXHJ/Fi8d0gJ0NOjT1nYWaL03H42jt1RYT9HOHIwJKqwGxDE+9YR2Wz3dPOXx/HCb
	 ox+C8Z5jsMG1KVvquHkxrvztQnY3a49E/TPEdOVI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D99BDF804A9;
	Thu, 17 Oct 2019 13:43:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C3072F804AA; Thu, 17 Oct 2019 13:43:09 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2298F80322
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2019 13:43:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2298F80322
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="BnAw9avp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fLFd7LzF6yq9UZSwX1XeG9QvY/4tQpRIA8giSgYZH9Q=; b=BnAw9avpmlEstxbFUi4F2lH9M
 kswYTuDgvgJuSt4yuRpikoUxBKl6HEdT/g5Nlz9N+kblWycf/P/Oe5s6dboVnXTwe7uVbNcQd+492
 0760QGFvuLkB/mYVJ8koh3k+zL9n10/vUJHrWqBoSBD059V9VK/w10bvzOFgwzeVNXh74=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iL4BL-0000rn-3v; Thu, 17 Oct 2019 11:43:03 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 56B7B27429C0; Thu, 17 Oct 2019 12:43:02 +0100 (BST)
Date: Thu, 17 Oct 2019 12:43:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Message-ID: <20191017114302.GE4976@sirena.co.uk>
References: <20191014180059.07.I5388b69a7a9c551078fed216a77440cee6dedf49@changeid>
 <201910150924.II2vi71d%lkp@intel.com>
 <CA+Px+wXEpPbWgsQcrz3YVbH1-3z9Jgy3KM3H8o=O6T3M2Gbb2A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+Px+wXEpPbWgsQcrz3YVbH1-3z9Jgy3KM3H8o=O6T3M2Gbb2A@mail.gmail.com>
X-Cookie: Shut off engine before fueling.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Gwendal Grignou <gwendal@google.com>, devicetree@vger.kernel.org,
 ALSA development <alsa-devel@alsa-project.org>, kbuild-all@lists.01.org,
 kbuild test robot <lkp@intel.com>, Nicolas Boichat <drinkcat@google.com>,
 robh+dt@kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Benson Leung <bleung@google.com>, Dylan Reid <dgreid@google.com>,
 Jimmy Cheng-Yi Chiang <cychiang@google.com>
Subject: Re: [alsa-devel] [PATCH v3 07/10] ASoC: cros_ec_codec: support WoV
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
Content-Type: multipart/mixed; boundary="===============6266572349827041145=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============6266572349827041145==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WK3l2KTTmXPVedZ6"
Content-Disposition: inline


--WK3l2KTTmXPVedZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 15, 2019 at 02:49:41PM +0800, Tzung-Bi Shih wrote:
> On Tue, Oct 15, 2019 at 9:34 AM kbuild test robot <lkp@intel.com> wrote:

> >       priv->ec_shm_addr = of_read_number(regaddr_p, 2);
> >                           ^~~~~~~~~~~~~~
> >                           wov_read_audio
> >    cc1: some warnings being treated as errors

> The error is caused by EC_CODEC=y but CONFIG_OF is not set:
> $ grep -e 'CONFIG_OF.*' -e 'EC_CODEC' config
> # CONFIG_OF is not set
> CONFIG_SND_SOC_CROS_EC_CODEC=y

If that can happen there's missing dependencies in Kconfig or missing
ifdefs in the code.

--WK3l2KTTmXPVedZ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2oU8UACgkQJNaLcl1U
h9A7/wf+LvKUAV7H+vgj/Q6qc7dRiYEn9n3hdiKSBQN1pDXOxHlDbTFhg21WyZOZ
IcmOiGga1iRv7w3qV5geKJGXnR0W5WwTcmiwOYRhBlTjO/0C8wvnWn9PnpGZTR4i
VxidkVnUx67DATwTDwbcHnXS0QSGNZOJofa84byEy2Rn/Ctd1c84dNzFbsxQxHDV
rC25xFZLE+CkFAo8+MN00xW0ZR14YzhrGyJvIwbapx9NThyuf03Tx4CnHWyz1/ia
klhfcyX9Gaozl5mkGTcLSpk3+rO/VZUwK99XrheSXHwsyGKJAvffg+VeL5lUQDAu
IexVAZk0pMTQVnB20o/LoHcirDt0iw==
=V6Ke
-----END PGP SIGNATURE-----

--WK3l2KTTmXPVedZ6--

--===============6266572349827041145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6266572349827041145==--
