Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D983C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 12:52:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC3064E7D
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 12:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC3064E7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C5A5885D;
	Mon,  8 Feb 2021 13:51:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C5A5885D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612788741;
	bh=9IjLVP5T0wUUCJwwqwgMjD3RIpZbFWCwOIuAE4nRasg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FyudFdHAIgdAbhtd2lHepOCM0YUsNWQ6b1S/qczWPQGJSFA4Ac6OIDaj+P+9rfhQ2
	 dXvDeb1JRPTQvznIh5BogDijPyffcchB+vXqZla61TosVVaCmjOSNTf0rTb0sQD+8h
	 jux6XGuMHQSuw/5Y/uRGZZt8cyIpUusWTOI0QrVg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53073F80169;
	Mon,  8 Feb 2021 13:51:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79400F8022B; Mon,  8 Feb 2021 13:51:29 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 035ECF8013A
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2021 13:51:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 035ECF8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Q8K+ouHP"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E12A064E75;
 Mon,  8 Feb 2021 12:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612788684;
 bh=9IjLVP5T0wUUCJwwqwgMjD3RIpZbFWCwOIuAE4nRasg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Q8K+ouHPGUQOgK/g4tivJy/BBRC6Sv9PuuYidu3jIhAre2qW1Y2NoXAbOz9O5K1ED
 OZyrW+hL/FYm7j8DJb51+0w7hm6G+CPkO8d7jIzCKII9cI0yvuesP4G7wcmJTxzEYA
 BDfumCYMaSq0e6ck9CtFw/5jh7cVKE3+Lk02iStv7P5A5KwgmXrNadLjeBHIfKwJ1D
 TMcPMkG0Or6S5tYFWC4oyihVZGLScMG+jwqfYtrlquaoEWI4Hxe4MPY5HN0Bfh7jAB
 HUS/ATt2rzlMxNhU127Lc8bFeXehepYdDChharTda7zf1FzT921PzTBohwMIoBwm7i
 EpSM1Xaa+MBQw==
Date: Mon, 8 Feb 2021 12:50:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Subject: Re: [RESEND PATCH v2 0/9] soundwire/regmap: use _no_pm routines
Message-ID: <20210208125032.GF8645@sirena.org.uk>
References: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
 <20210206102644.GN2656@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
Content-Disposition: inline
In-Reply-To: <20210206102644.GN2656@vkoul-mobl.Dlink>
X-Cookie: You will triumph over your enemy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
 srinivas.kandagatla@linaro.org, jank@cadence.com, sanyog.r.kale@intel.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>, rander.wang@linux.intel.com,
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


--ChQOR20MqfxkMJg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 06, 2021 at 03:56:44PM +0530, Vinod Koul wrote:

> Applied all sdw patches, thanks

Is there a tag I can pull the new APIs from?

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAhM5gACgkQJNaLcl1U
h9Cn5Af/QPKks2pyEPXbJqMyKyRplL9nrj8AmVJjIcza+PjXIXsc95fjt9WJw1w5
QU5WrskcCm35zqvOOXyjW9Isn2LYK41MblnPE+XAEofNsNSAWwCqnGMR42frS/nm
SF4l02Q0nuQEz6Lf7042mvYV2qS8QecMNnDlLHfo5yJCp0irtBBF0WWqi0GRPJ+0
doyhiUzpnSaR90cf5UgQe8CoNJdD9zbU+xmN3lKxP/7dgl18RdAiLs3nxdiRGPX0
e/M113XNYKBB8CxeP+/cEkWK7c7+0exz5dHfaus2VfLXMMjSD+Fym+9P26rI5iZ4
CY3U6idFm8VnrEhRGm6JrIBVlztFOQ==
=ueCe
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--
