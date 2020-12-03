Return-Path: <SRS0=z1YM=FH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7485BC00130
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 14:44:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8927322D49
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Dec 2020 14:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8927322D49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 902C61830;
	Thu,  3 Dec 2020 15:44:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 902C61830
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607006696;
	bh=DxJ4yIYFgoE+1eOz/ODDS5hA3PYUv9G+Xtpre9H2l3U=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gMdIkv8Ph6u+ANy+rOIDaLRRG/WCYvbwODU8YTIwvSisxjNRq6cIrm12P1IlyUz6O
	 QVHBeyDbLAyv5k9vFfnDL/a+J6Uo9U4rIIHmITBkJcfU6sarQ+ITxxRkrTRbdzKNZe
	 uG1pPdhfKBy31Y/I64miS1VY3UuekkwFVKCmlbBs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1ADE8F80158;
	Thu,  3 Dec 2020 15:44:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80A88F8025F; Thu,  3 Dec 2020 15:44:04 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6AE8F80082
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2020 15:44:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6AE8F80082
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="t6YKWIB+"
Date: Thu, 3 Dec 2020 14:43:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607006639;
 bh=DxJ4yIYFgoE+1eOz/ODDS5hA3PYUv9G+Xtpre9H2l3U=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=t6YKWIB+WG0ISjOdzos63GK19W7EXUSf5DOAIg5xNO0Qd6voGpvfVSsNfMyzth2kT
 kQGPY0CC2GSrS+9NA2onWGCzvP57m3NFXrZ6CTxJG0Qy8Kl7Vh2EKR6Ebn50l/lDjw
 srbZgZOv7pIILINBadg/xsnLwHsnIg48wWzsLczP/0uw1vudr87Ci2c4ETN5HQrC/i
 h+HNoatu9wTRuRtgBmz0bJ0XFnFz3ZGRiDvgcnrZud6co5dSVFDEtG/BpcqwXLE7lv
 XSPByT4+xQI5qUoDJ4JEjQV0TNLnBhLz30OXF6DJCNOFvj3kEPTTzUonYeMqHmn4JL
 H2AtLhsJd4Xkg==
From: Mark Brown <broonie@kernel.org>
To: Chuhong Yuan <hslester96@gmail.com>
Subject: Re: [PATCH] ASoC: amd: add missed checks for clk_get()
Message-ID: <20201203144356.GG4700@sirena.org.uk>
References: <20201203143116.405930-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rV8arf8D5Dod9UkK"
Content-Disposition: inline
In-Reply-To: <20201203143116.405930-1-hslester96@gmail.com>
X-Cookie: Sacred cows make great hamburgers.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Agrawal Akshu <Akshu.Agrawal@amd.com>
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


--rV8arf8D5Dod9UkK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 03, 2020 at 10:31:16PM +0800, Chuhong Yuan wrote:

>  	da7219_dai_wclk = clk_get(component->dev, "da7219-dai-wclk");
> +	if (IS_ERR(da7219_dai_wclk))
> +		return PTR_ERR(da7219_dai_wclk);
> +
>  	da7219_dai_bclk = clk_get(component->dev, "da7219-dai-bclk");
> +	if (IS_ERR(da7219_dai_bclk))
> +		return PTR_ERR(da7219_dai_bclk);

This is also buggy - instead of ignoring the errors (which is an issue)
we now leak the wclk if the bclk fails.  Probably should convert to devm
as well.

--rV8arf8D5Dod9UkK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/I+asACgkQJNaLcl1U
h9B6wQf/WHDDI4u+PUzca/wx02KyGxHEMupD7sXA+muUTiOQJBg5ZjZsrhA8A1hm
QE1YZhTrsOoNgVOMxJf6xTNOZuuL4SLg1Ui425NLyEo1RFGje54n+sH4bHqYhI+Z
86YIurOLx9pyazc6eJUzhOWC4A99ZoaOP8tTztw3Q3rbtktTNavbD54ypj0C+pb8
YoJlgqI5RYaDNvxDc23s5UiEUgTDG/Ux7kjAn7b44y3sApcuUNYPXWkhgSWSfPmY
j6073kxyYlLUwnsa/ZhZcx4ebFzA1mgz6bf8hdkxW+dszJxh7/GPTfj2eWmgBz57
9o9c433ExVA2aVQLLoZjPA4HCDudZA==
=6c+8
-----END PGP SIGNATURE-----

--rV8arf8D5Dod9UkK--
