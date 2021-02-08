Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744B9C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 11:53:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2A264E79
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 11:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2A264E79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54B8E83B;
	Mon,  8 Feb 2021 12:52:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54B8E83B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612785182;
	bh=khj0Ksstxc70pqDkTZPUJ+hyC/Zp9C28p+//y1Izqto=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F1fER0bSo/SpTofWcJhBFJSpdl+E9+ruKT3oJ/ND1wlrAT9Qc5e4Y1V19Cv6PFuuG
	 19xMYAQuIwtS5oELnhnEkxwr9qNK456SFFSsQdU+b7pmmIjBOqJsGQeP4exkn8E1PV
	 WZx3TF+aueoy/Y/SFMC91o5L+fypTjZXlUZehvqU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C128AF8013A;
	Mon,  8 Feb 2021 12:52:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ECFE4F80169; Mon,  8 Feb 2021 12:52:09 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0CF19F8013A
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2021 12:52:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CF19F8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VvzvTa2C"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D08864E56;
 Mon,  8 Feb 2021 11:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612785124;
 bh=khj0Ksstxc70pqDkTZPUJ+hyC/Zp9C28p+//y1Izqto=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VvzvTa2CGSU8UkdTZrHmjfVeGkhd0XP7bI1HvBXw/V8QYFT1n9oPXWw3P4dCeh9dp
 tCULJOL68X5Z3jNqhPLL5AEiqe+lcpuCh0agkKYK3FJT0wybkh7Bp19yf91R8Pflak
 HOI0rKKPO3vrtR1vrzPjMbolzWlDN4nZj8thr4+cuqzyBbIs1RGwzEjP4Be9M8emAP
 Lv5vFes0K36m8a+xQE4YITlivDNLMTIHb99O1Ra1Gvlg2qvfXNE4Q+P5X0jlVlz4JX
 TmJYjy+CZiQ0J+AaWkwPO36/DYtDMUkkEQ3cIPSo+79MspG7YMmnOTet1h+C9B91o3
 AwBHSmtUNL3kA==
Date: Mon, 8 Feb 2021 11:51:12 +0000
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 2/7] ASoC: fsl_rpmsg: Add CPU DAI driver for audio
 base on rpmsg
Message-ID: <20210208115112.GD8645@sirena.org.uk>
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-3-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Content-Disposition: inline
In-Reply-To: <1612693435-31418-3-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: You will triumph over your enemy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, timur@kernel.org,
 lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, nicoleotsuka@gmail.com,
 robh+dt@kernel.org, festevam@gmail.com
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


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 07, 2021 at 06:23:50PM +0800, Shengjiu Wang wrote:

> +static int fsl_rpmsg_hw_params(struct snd_pcm_substream *substream,
> +			       struct snd_pcm_hw_params *params,
> +			       struct snd_soc_dai *dai)
> +{

...

> +	ret = clk_prepare_enable(rpmsg->mclk);
> +	if (ret)
> +		dev_err(dai->dev, "failed to enable mclk: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int fsl_rpmsg_hw_free(struct snd_pcm_substream *substream,
> +			     struct snd_soc_dai *dai)
> +{
> +	struct fsl_rpmsg *rpmsg = snd_soc_dai_get_drvdata(dai);
> +
> +	clk_disable_unprepare(rpmsg->mclk);

hw_params() can be called multiple times and there's no need for it to
be balanced with hw_free(), I'd move this to a different callback (DAPM
should work well).

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmAhJbAACgkQJNaLcl1U
h9AJqwf/X2Soo9XPi4+IXcHpXJMeYJEz2SrnSt4si8m1Bri4Ow7pyiSeFmffguOV
s768sMvqLorPsUHuRjMXB9NHG9hAkV/avnPqptxPH722QegXhi7ej0+kxrhrtyhf
ZefpKevO5qjvYMagXCqbRUBTHZMY0aACqCvWfLqsmC0LtSA4OHCiSHJFQKvsdxIA
MJmUyvPr9KP5z4mwD+yRO6jdTztZw4693lVUyYcRLDuCHelBhDZ0Gs4R3QGPTuI6
PKLJlxZ2P6R95mLc4ygvk4AUbsm8z5yzFoMzF3zyifwrD2PLe3X/0x/TGeUniLPZ
xAu7MVI9SOtCn+IlfAcoHK43UmMJgg==
=LRAl
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--
