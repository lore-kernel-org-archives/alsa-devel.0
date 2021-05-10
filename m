Return-Path: <SRS0=6VrY=KF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD459C43460
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 12:11:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 554F9613DF
	for <alsa-devel@archiver.kernel.org>; Mon, 10 May 2021 12:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554F9613DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3583716A2;
	Mon, 10 May 2021 14:10:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3583716A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620648691;
	bh=LDVAdlR+VMCba4GWFXIi0m+j0tXX4AqaAF0jAJM1Fi0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l+VNDMTZC3y7Felj6ETOwahXB76/aflGqZpSjvGcEZEDW+dOXJkLZvXEML4cPfj3s
	 +l1UcTgbDWNJ3jK/Q9t/AUjwL7eN6sqLgf7doQscccK5CizEuz33bScIKS4jUVAw15
	 cgZjTfm/jCoPx4isGZaVWqw1tnnWayi4S5ofpusc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BE51AF8020C;
	Mon, 10 May 2021 14:10:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9076F80240; Mon, 10 May 2021 14:10:39 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8970DF800E9
 for <alsa-devel@alsa-project.org>; Mon, 10 May 2021 14:10:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8970DF800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="o8M/5ecx"
Received: by mail.kernel.org (Postfix) with ESMTPSA id F36D0613DE;
 Mon, 10 May 2021 12:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620648632;
 bh=LDVAdlR+VMCba4GWFXIi0m+j0tXX4AqaAF0jAJM1Fi0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o8M/5ecxIiiaNCLz1lwPxU7vvx8vMNqoOZScYGZOoNmWBd6NFlEmwscHxTRHaLZar
 zsegEkmv7AJ5zKd0zyt4isw3Xr8u3gQ5oG5iL6dmj5Fy8Nobm1gwMNx9bgl7iVe46e
 yv58e6QbJc6A44/+uaogTxcqQ3lRhRQZUjGMab0pRZRLK4tZaqerNws3ZUV0G8NPCt
 vL1z6gzNjo9xC7zmpk12qVjQRYiQGcsYayMSH+YmPo9YnGVAoOKB8ytmabY6tWQBFp
 PEz6M9LorNP+VYTRQBnERgQII9uvZNgcqZznieI3YS4q8w7bb/KGXQc0jTj16dRF5n
 HuhS85MIsGs1A==
Date: Mon, 10 May 2021 13:09:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 07/14] spi: pxa2xx: Introduce int_stop_and_reset()
 helper
Message-ID: <20210510120953.GA15173@sirena.org.uk>
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <20210423182441.50272-8-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <20210423182441.50272-8-andriy.shevchenko@linux.intel.com>
X-Cookie: Thank God I'm an atheist.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>,
 linux-spi@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
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


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 23, 2021 at 09:24:34PM +0300, Andy Shevchenko wrote:
> Currently we have three times the same few lines repeated in the code.
> Deduplicate them by newly introduced int_stop_and_reset() helper.

This doesn't apply against current code, please check and resend.

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmCZIpAACgkQJNaLcl1U
h9Cp/Qf9HjrqO+Ih1Zy7jNct0FMPG4OiaQ8HJZJnYADG4PqR6JvW8eFqW4oT2pUG
cL+1pv2rRUH9usmD0W9lvTpygFCV562BwChfVFxefotUym0XVHKkHjHXIvbD0ofJ
5tiT0Gmt3en0flelPBhJLnDJ1v/EJ4LEdDG7g+ND3gDuluHJNlzdhVQKEqaQ2/lG
kjYZbAEN9IsNYo8SMrmdLoHWk1yNPf0mViXCfOwmZE+hNTbms+y62FfiPGLzftAT
aBM5HFR3GhqkRF/s9xbPGcJvx/SRGU6cxiqUwxeEoyjANcNhLM9gboRbhj8diH+q
BAK7h8jG9sLLUtvLfa3HOVn6wLP3Yw==
=d+gt
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
