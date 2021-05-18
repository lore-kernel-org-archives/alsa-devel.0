Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDC8C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 19:03:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B136100C
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 19:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B136100C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8788C1736;
	Tue, 18 May 2021 21:02:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8788C1736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621364592;
	bh=sdZL9I3CYqnmNdbaDv09xNUuFQMlOFOby5Mx98nuknI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NyF/xmc92bG7JllDNcBKll0AQL6KqgOMXB3ZGpjQGJnQ5jlo9z2AA88SY4v+6yPWJ
	 l2K3TbLcU17WpHe6SJazNiZZSpr/3LJtr5DDTz+i2qrhQrKrQGA/g9x6SGXaeDsjrE
	 tT6OuVw/vl1ORaU6TJkT+LJS1KBy8rKAOtXzm5X8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 098DBF801DB;
	Tue, 18 May 2021 21:02:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EBA68F80217; Tue, 18 May 2021 21:02:19 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22AB1F8012C
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 21:02:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22AB1F8012C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jkA0KHs3"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03AFF610E9;
 Tue, 18 May 2021 19:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621364530;
 bh=sdZL9I3CYqnmNdbaDv09xNUuFQMlOFOby5Mx98nuknI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jkA0KHs3eDaFXWk2tfoyd7fXi+8NNwqKxFfF7Raqgd2LUWHojjNy5HsF8m+76R2aX
 lQnA/zI1x6vqFpjZucZU07DLnnb2lDFHe84R8sHi9TB7LTgEgrLk6ciZUbWMpcM10j
 aQVquSkmAnXSFYwrw7nF5VEwJ+RxUlYGattsb/lKTM7zl33QgjQe/VW0KlroCikM0l
 WjXvvSZYihm2Ha1+QZUu+JsmV4xy2CigofgCERlWDjHljg1bp56Ni2taMm6Up9C96d
 6ldgjMO5AvYk2qaQogBzWw+5ykVUoPBnKahCHTh0bxLOip6ytET+PJYZCaZYYEIL/i
 B823iXoi5Zivw==
Date: Tue, 18 May 2021 20:01:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: hda: don't send DAI_CONFIG IPC for
 older firmware
Message-ID: <20210518190125.GH4358@sirena.org.uk>
References: <20210518174121.151601-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MGu/vTNewDGZ7tmp"
Content-Disposition: inline
In-Reply-To: <20210518174121.151601-1-ranjani.sridharan@linux.intel.com>
X-Cookie: Radioactive cats have 18 half-lives.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Yong Zhi <yong.zhi@intel.com>
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


--MGu/vTNewDGZ7tmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 18, 2021 at 10:41:21AM -0700, Ranjani Sridharan wrote:

> BE hw_params op was recently added for SSP type DAIs.
> But sending the DAI_CONFIG IPC during hw_params
> is not supported with older firmware. So add an ABI check
> to avoid sending the IPC if the firmware ABI is older than
> 3.18.

Should we warn if we were trying to configure something but weren't able
to?  Seems like something has got out of sync if we're trying to do so.

--MGu/vTNewDGZ7tmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCkDwUACgkQJNaLcl1U
h9BZQAf/Zdwb3IOACv9O1JcSENjdmXYzCYR+asxUtAXLGPIwjUcACnqQ/PLp6bzo
EgtHVJhuX5TO/imCHBTrWSUl+Y4fnzM3016jTEhOwZQcdTm5nhoxR36YMMre4FSh
azrpY0IfgMTPzCqsjKTCQsUNULLFUWy/kLltpwlNEY2MOz4nowgHt/4TvaC9Om5/
fayNfa46Apjtb4YpjO6C7anVn3PcKx8u4v6lAMnDfY5ohEKnr2KwA+lI0VrauezJ
giayMqTD67ao59d875kodtIafREKA/Oaz05iWsrT8WzGmrcxikShZlgc3OpejRQV
b2BbvxdLc1wsZzh8b4fEAcIcSI/RJw==
=/4+m
-----END PGP SIGNATURE-----

--MGu/vTNewDGZ7tmp--
