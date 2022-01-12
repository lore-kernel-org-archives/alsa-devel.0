Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9BAC433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Jan 2022 14:21:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 278801B00;
	Wed, 12 Jan 2022 15:20:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 278801B00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641997297;
	bh=RRhmaQsH91uHTw71wtOmZx3VIMdk1PxtBkkRzyfrfzc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GkaADoLkXm7v6tAdlcRQ14a0RF44W6478sxxp0xjF68aMoqQIRPps8o5YMPgJJ7w5
	 VbNke+pOnNEMxOzAvOyDs+TjvmUvFXhkryphaVjeB+u74c5gCHpx17m3NEnQh32mb8
	 0P56BPVP/d/YVqIHC7U5u84xL5aaQYP1hGuFsJ5g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BAFBEF8025E;
	Wed, 12 Jan 2022 15:20:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74E6FF8026A; Wed, 12 Jan 2022 15:20:45 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 458ACF80054
 for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2022 15:20:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 458ACF80054
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UYbz0uXP"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E45DAB81EF9;
 Wed, 12 Jan 2022 14:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FC0C36AEA;
 Wed, 12 Jan 2022 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641997239;
 bh=RRhmaQsH91uHTw71wtOmZx3VIMdk1PxtBkkRzyfrfzc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UYbz0uXPInouIEqplR6A9hPjOld8c0c8CYH/JiMN8KLMHaYRs4infv05/HmmzSBsy
 po1SBDs4Pxh/Tem2uVpLaqdB+XSMuN3j897nqD6TrJB0RVGkYFuUuwalRHGeUKQ0So
 bjJBmjTJmQ4STq2PAc3Fg4IvyphLvTiYNP2en6adwMnGieQjlaGHkNIxfEt46IOUhU
 9n6lbhkk0ogGDrF8e/9Q5pcJc5ZNd4Ko+iXCLcdK2ffHB/zVPIpBcTLHcaqLeK/YKW
 wtFkTJ58wtE+xizv7mbdfSsttoumIjIb1k31dsGm67fz5Fn9gcM+sz+7562dE8kwP6
 sUH/coXQjLCQQ==
Date: Wed, 12 Jan 2022 14:20:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: codecs: Check for error pointer after calling
 devm_regmap_init_mmio
Message-ID: <Yd7jsoTqhdzldOHT@sirena.org.uk>
References: <20220111013215.494516-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yFTNbuUxyqjoLy6G"
Content-Disposition: inline
In-Reply-To: <20220111013215.494516-1-jiasheng@iscas.ac.cn>
X-Cookie: //GO.SYSIN DD *, DOODAH, DOODAH
Cc: cezary.rojewski@intel.com, bgoswami@codeaurora.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com,
 lgirdwood@gmail.com, srinivas.kandagatla@linaro.org
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


--yFTNbuUxyqjoLy6G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 11, 2022 at 09:32:15AM +0800, Jiasheng Jiang wrote:
> The devm_regmap_init_mmio() may return error pointer under certain
> circumstances, for example the possible failure of the kzalloc() in
> regmap_mmio_gen_context(), which is called by devm_regmap_init_mmio().

This doesn't apply against current code, please check and resend.

--yFTNbuUxyqjoLy6G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHe47EACgkQJNaLcl1U
h9Dt+gf9Eb/xv7Ke6BmtuB7TbiXVjloQqaMz+eAF1LXUtO/K/ChdrowhQSMHLeRa
wkiUVm8zh/+rAiN9g/ZcaCECI4/yv7VIyWbgSUAEy6GCZfCsYuSAO1b0KpyQTWDd
Nb6Gd/QNEDrOOXQN6utAWk2X0SYY5B1kaJAKjBtGDFEoRCDJ8XgD2LFjJQkjZi7O
aHMISkOB8//AWGXkz3z9xeB3uMLmama8Chc1gV34Knvl3l3f5TJAEnJ5RnWjk5GQ
pKFkNJ5HFCeYjHAY/+pEnHsvRwp+Nspot1O+gK3DNfbKFRMMmm+BJt6ON0dnxQtb
0TWOLm+pZDyERLLtLl7TeYDSQwaN9g==
=635e
-----END PGP SIGNATURE-----

--yFTNbuUxyqjoLy6G--
