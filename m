Return-Path: <SRS0=qvmA=JD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB41C433B4
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 12:23:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3DE561262
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 12:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DE561262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4749015F9;
	Tue,  6 Apr 2021 14:22:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4749015F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617711795;
	bh=SpDyZo8ivVbgd42e/yPJ5DJn8UCBcZa18gjldb1HiI8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vcYuVdAZE20X2hZk6u2YV6lbI6ZG1//0igopTmPSl3UMrIjKTUtdH7Yb0TV0rf3qv
	 vCd86vTeXvkNZTIa6NutnFaVEXeiSSwWTXVWdaGtihrMnA8l2n+v4iy7CCyyh7XSjA
	 Oslrp/d2MibaJ2xADBGLjD4d3WCjkjNHU+qNVmoc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD1C2F80169;
	Tue,  6 Apr 2021 14:22:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 43916F8020B; Tue,  6 Apr 2021 14:22:23 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 91774F80124
 for <alsa-devel@alsa-project.org>; Tue,  6 Apr 2021 14:22:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91774F80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="N/MSX83N"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3F72613BD;
 Tue,  6 Apr 2021 12:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617711733;
 bh=SpDyZo8ivVbgd42e/yPJ5DJn8UCBcZa18gjldb1HiI8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N/MSX83Nbbw2Uie6O/1U31eCsT1I6mHEfcc3mWYml2nf6HKbW7CEP4oJEhYEVFsXY
 jrM2v8P0+KwAmSy1t+kSU+CnIQfP1pIZ9y/YFhrecJ5qmtTtFzTXwre3vlkvu69F1H
 SwLUP3d4vKMwzcKtmlS1hSZtXOLetjvWQTqu/vMuLR5FTM8W5toXWES/kD4vDloa6k
 EdTsTAzFvN5TFQa9EVVkm8A4FjX9h+rQ3igk1uW59tsFBS3EssrEFnHePvVmWDAMET
 hVgqmZI28MV/4xYQHsH9RBgcxpRM3BtA5bNKLk0eyjFp/JRv115SZtq+cGy8YNxJXQ
 eN6v9jOEFxRFg==
Date: Tue, 6 Apr 2021 13:21:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: Re: [PATCH 4/5] SOC Codecs: TLV320AIC3X add SPI: SPI code
Message-ID: <20210406122156.GH6443@sirena.org.uk>
References: <20210406105018.59463-1-jiri.prchal@aksignal.cz>
 <20210406105018.59463-5-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oyqLL/JqMvClXZi1"
Content-Disposition: inline
In-Reply-To: <20210406105018.59463-5-jiri.prchal@aksignal.cz>
X-Cookie: BARBARA STANWYCK makes me nervous!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>
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


--oyqLL/JqMvClXZi1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 06, 2021 at 12:50:17PM +0200, Jiri Prchal wrote:
> Things related to SPI in separate file.
> Please help with getting model value, line 34. I didn't find out where to get "driver_data".

Look at how adau1977 does this - spi_get_devicde_id().

--oyqLL/JqMvClXZi1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBsUmMACgkQJNaLcl1U
h9C0owf/TPITNdVagU/lvSVCU1DDTqHuchdS5Hu3PMo4f5tQcZIBrxl7duboSZh/
Vac+6MAnH6hveQwCHWnQZrB0/Q+0Ns0rexpFM+nBrBhRiMduoC4N/0yv96pJMU3F
J3AzrIZkE7eCr6g77wD4B1lLBfZSrJLxjSgHBpOHiJgomrU84w/Jb/Fcw5yFOp3x
H/R0NaS2zLM+kMkLmM671SWRHrNKRq90FVnk5946gOG7cXiJAFpD+bPdIaIvEn6x
2wqYBpwk7zlpuujgjysLSFlagfTFMRNzTlmdo3s88g4L2sYhcWBw1XZNHLCFBzW0
dWblblu+jEgm2SZwGJcYrprC8/n8Kg==
=8Zhl
-----END PGP SIGNATURE-----

--oyqLL/JqMvClXZi1--
