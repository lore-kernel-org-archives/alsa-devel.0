Return-Path: <SRS0=7xvc=JU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E670C433B4
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Apr 2021 16:57:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E909361006
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Apr 2021 16:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E909361006
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CAA0116CB;
	Fri, 23 Apr 2021 18:57:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CAA0116CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619197075;
	bh=LfID890VAjx1GZR+zOrDOxEjOHzkC+fZhl1uOkQgHsw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g7zJTSxo9Mx+aD6gFj08N0xgDCWKJWIA7D3KGulxFrqyHOiH8sVBr1y/7T3kv/aXQ
	 xiKcT5zktWsrhPoCMx3NHY0G6xuN/NOhAQDcW+kx+8jTRUTETpIP624LZe7q++MlNj
	 1b2uScqoi/zRC5QUTzwPAiQ4im5/0Bl8hnzWSGZ4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 506FFF8019B;
	Fri, 23 Apr 2021 18:57:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DAD76F80227; Fri, 23 Apr 2021 18:57:04 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4EA0DF800AE
 for <alsa-devel@alsa-project.org>; Fri, 23 Apr 2021 18:57:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4EA0DF800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="r5veA+Xw"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FA89611AE;
 Fri, 23 Apr 2021 16:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619197018;
 bh=LfID890VAjx1GZR+zOrDOxEjOHzkC+fZhl1uOkQgHsw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=r5veA+XwtEUJElzT1v6yOIVjcnYgfLhLHRdA/om5LzaouZiCO5kAYjkTP1F2/MQ+g
 0yyG03jy82r4Ix6/aqifdqt2fg50ItCwKTNxi3eM8gkLvo+72oFxgZcUjLnc7FQkxT
 jvOWV5pgX1FTP0wrCGMUEgo/gRBkWzkCr0r2iCcDon0sgEDfsGGN8BKERulBIdSgVp
 CJHDeIjag9Q31U6GZnPxnlW6k0TUSNHPs/lE2zIobgahDbb6tEyzmjGcsAOgBDLt+n
 eCfDuJ/9ngfXzXuGvv/3vkrnfk/zy8nPq+Z1ZOZo1pgIgrdEaGSg27/5hx1zU4YJjl
 yIG8RNvTnJhng==
Date: Fri, 23 Apr 2021 17:56:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 05/14] spi: pxa2xx: Consolidate related headers under
 include/linux/spi
Message-ID: <20210423165630.GH5507@sirena.org.uk>
References: <20210423163437.89306-1-andriy.shevchenko@linux.intel.com>
 <20210423163437.89306-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rn7IEEq3VEzCw+ji"
Content-Disposition: inline
In-Reply-To: <20210423163437.89306-5-andriy.shevchenko@linux.intel.com>
X-Cookie: This is now.  Later is later.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Daniel Mack <daniel@zonque.org>, linux-input@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org
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


--Rn7IEEq3VEzCw+ji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 23, 2021 at 07:34:28PM +0300, Andy Shevchenko wrote:

> We have two headers split between include/linux and include/linux/spi.
> Consolidated them under SPI realm, i.e. in the latter folder.

Why?  Isn't the point to maintain an abstraction between the general
purpose use of the SSP IP and its application as a SPI controller?  I'd
check the cover letter for the series but there doesn't seem to be one.

--Rn7IEEq3VEzCw+ji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCC/D0ACgkQJNaLcl1U
h9CLHAf/eyWaZV/yF5wLiXo/wOpqfrx3e/NqVjLRELGlZE+ar0ILQQ9eW9MXKr1d
dY8YMPYTi95D/hs2pHwY+69eqE/jSVqiDXg0ClNqfcNE+T/u+AJP5AjN8vxkHgA1
2D5kguaPu/cBUZgByp4oDlAVTdFlT44mLDNwgjBaJR+/zMUl35CTKqzLYD2XB7+6
vj9KiXPatFJLphF9XoDc0s8Z2lZZkUWhVG3hku2pvH8E2X+zJpAQYFKtxwXAKSrt
zjuR7BvYrlIRgZnYT6ct3gtl+fPoBXimyvWDH86cxopeAsiHcFg7Jq7+TqlOYtPY
ZEwe0ACiO9v2GD60nmZC4JwhDTSMgA==
=0Eci
-----END PGP SIGNATURE-----

--Rn7IEEq3VEzCw+ji--
