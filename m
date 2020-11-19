Return-Path: <SRS0=WcGQ=EZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BE5C56201
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2020 17:00:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE3EB221FB
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2020 17:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="M7zi9/Lm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6rlbMoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3EB221FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1110016FD;
	Thu, 19 Nov 2020 17:59:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1110016FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605805200;
	bh=I+vQOV7NFsvgezS4J4zNhYoG5UIbts/xEpojk/dlhmA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M7zi9/LmXUn1pKK6rnFMuRrI9OK75oni+cr9UpwBLqpG+77N6UVlPWrPSuEgIfiRf
	 7VUzcSFdFOxBsSfEc77cBM3Fgbagw8+XB13rVbIM/vR3r55UcwH/wQtXbyKi3wz8oY
	 s55tT0lTsRaG3Tlvm5Z0656sXfL+18tAUXFHMyds=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F5FAF8015A;
	Thu, 19 Nov 2020 17:59:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2281FF80169; Thu, 19 Nov 2020 17:59:08 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5FB59F800EE
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2020 17:59:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5FB59F800EE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="K6rlbMoi"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3B582221FB;
 Thu, 19 Nov 2020 16:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605805136;
 bh=I+vQOV7NFsvgezS4J4zNhYoG5UIbts/xEpojk/dlhmA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K6rlbMoirfax/UrWqnwxGuyBksR4+28/z5fDmsyfqjYrT7Ysh25RjWzJSI41VZF1c
 k2dm0Wviz8PU61ZHPwPhj0746mWmWgSaNnA6ibpmCH9uMCjbHVX44U70rxW+pd90tj
 j0LDc6xS5NJKYDacD8FsVf23MapXD1pCp1oBMe/8=
Date: Thu, 19 Nov 2020 16:58:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [RFC] ASoC: max98373: don't access volatile registers in bias
 level off
Message-ID: <20201119165836.GG5554@sirena.org.uk>
References: <20201109135543.7862-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lHGcFxmlz1yfXmOs"
Content-Disposition: inline
In-Reply-To: <20201109135543.7862-1-yung-chuan.liao@linux.intel.com>
X-Cookie: Chocolate chip.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, ryans.lee@maximintegrated.com,
 kai.vehmanen@linux.intel.com, tiwai@suse.de,
 pierre-louis.bossart@linux.intel.com, vkoul@kernel.org, bard.liao@intel.com
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


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 09, 2020 at 09:55:43PM +0800, Bard Liao wrote:
> We will set regcache_cache_only true in suspend. As a result, regmap_read
> will return error when we try to read volatile registers in suspend.
> Besides, it doesn't make sense to read feedback data when codec is not
> active. To avoid the regmap_read error, this patch try to return a fake
> value when kcontrol _get is called in suspend.

> However, the question is what is the "correct" behavior when we try to
> read a volatile register when cache only is set.
> 1. return an error code to signal codec is not available as what we have
> now.
> 2. return a fake value like what this patch do.
> 3. wake-up the codec and always return a valid value.

This depends a bit on what the value is, if a value obtained by waking
the device up is likely to be useful and what userspace is likely to
do if it gets an error.

> -SOC_SINGLE("ADC PVDD", MAX98373_R2054_MEAS_ADC_PVDD_CH_READBACK, 0, 0xFF, 0),
> -SOC_SINGLE("ADC TEMP", MAX98373_R2055_MEAS_ADC_THERM_CH_READBACK, 0, 0xFF, 0),

For things like voltage and temperature it seems like if we return zero
that's not much different from a userspace point of view than returning
an error, they're both clearly bad values so if userspace is doing any
kind of error checking based on looking at the values it's likely to get
upset by unexpected values - a clear indication that it was the read
that failed might be better than bogus data, stops someone wondering why
there's no power or the device is suddenly freezing.  Or if it's
important that we get a value for monitoring purposes then waking the
device up and reading a value might make more sense though it'd burn
power if done by some random ALSA UI on a regular basis which wouldn't
be desirable either, it'd be relatively slow too.

Another option might be for the driver to cache the last value it got
when powering down, that way it can return something "sensible" even if
it's not up to date.

TBH I'd consider moving these to hwmon, it's possibly a bit more
idiomatic to have these there than in the ALSA API where things do stuff
like go through and read all the controls I think?  Not sure that it'd
be that much happier with values that are only intermittently readable
though so the underlying problem remains.

--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+2pDsACgkQJNaLcl1U
h9C7Dwf/TnRL+rAdLKW1bkr7dNB47kQteWLQUI0Yg0OdvZ0yjvfrwRZahMDaJ/3U
6dGZwJk21YYERKft3p9BUuYZqBsiN9eJbu5SD2sAicaKknR3IkyrV8Ro8+LiQRBL
HxBpBUSa+Ywa3n8EBFtLN50ssDF2aL7Uc0P3Q9rGzb7KtmvCbfS48Vm7rALD9Z6p
COAQqsOFHLmr2ThlHnRKTc6NIb04BwnKIfnaft/r4+ZN8fPA5zmr4hDYaymJTgdj
oGgV/ROI0TE4pBpemwSRUFdmt4YiIRNcPR4wU78Emmi8Kt4WBDdhZncGgXpIkhbH
QJAgpB1BX1XMQ9Rad1zdU1dFEW48YQ==
=SiDD
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--
