Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C70C433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Dec 2021 13:26:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5E2C1F8B;
	Mon,  6 Dec 2021 14:25:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5E2C1F8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638797160;
	bh=23bWVipbi4lQe7/wbua2k2oEGCpFGNw9N0040dL29Bc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tMaiRvwphbhzAr5tawj+XnLh06+D4M5+1FAXNJlT8wopmSw9JVYU5pgpNiok/rIc4
	 mzGKf6y+6qoovY4A2/E8zQ4qYpWUfLdF5rKhXeYWcLSTucAxEhGT/s7aigzHmoKEjW
	 2KLC0okhKJ5RMa0FTVQthFQYIZoGDNw5e/342F6M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76F81F804E5;
	Mon,  6 Dec 2021 14:25:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5FE43F804EC; Mon,  6 Dec 2021 14:25:07 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11CA0F804E4
 for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2021 14:25:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11CA0F804E4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="EVcLpM3W"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0C503B8104F;
 Mon,  6 Dec 2021 13:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0FAC341C1;
 Mon,  6 Dec 2021 13:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638797101;
 bh=23bWVipbi4lQe7/wbua2k2oEGCpFGNw9N0040dL29Bc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EVcLpM3WUMdsxyWLGN9cEr9kcyzceJY24/tBFQ/LkCyxpL5lR8/C83yQ/WeFyXxr3
 3l61rgFn+5kHUa0liy1Wp5PyCxxF+dyjntuHqVHd+hNL0uYP2Upj2wJHffcQetEGhr
 cBXiJ08oGQ4Ejxacp/D/1MpuZRpM9FMrpbgYeQbtLO8e+IBKTOiPaFTU/PksidMUFU
 5dMRrSsApdjGs5+geP3HcMB9qW/SsT+B3cE6LYsu3UQXa9ccOQUoMkd4oeoo/NxlpP
 3mgderEZ7IP10vnpSPdXPRkubOpqX+EnrwrsdamMgpDt/uDo/64XWYMLFXx5/IYGoC
 6/vwUDINR8Jtg==
Date: Mon, 6 Dec 2021 13:24:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Bernard Zhao <bernard@vivo.com>
Subject: Re: [PATCH] sound/soc: remove useless bool conversion to bool variable
Message-ID: <Ya4PKMFCP1n5Sthz@sirena.org.uk>
References: <20211206021100.321170-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IQbEZeBX9Rukd5iP"
Content-Disposition: inline
In-Reply-To: <20211206021100.321170-1-bernard@vivo.com>
X-Cookie: You will soon forget this.
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>,
 James Schulman <james.schulman@cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>, linux-kernel@vger.kernel.org
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


--IQbEZeBX9Rukd5iP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 05, 2021 at 06:11:00PM -0800, Bernard Zhao wrote:

> This patch remove useless bool conversion to bool variable

> -	classh_config->classh_algo_enable = classh ? true : false;
> +	classh_config->classh_algo_enable = (classh != NULL);

There's no bool variable here...

--IQbEZeBX9Rukd5iP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGuDygACgkQJNaLcl1U
h9Dv3Qf3XG7gVlM3Kturxyb43OVC6b6mRkv+is7OA5mf9kilrBwbUQe3yBUwXvFG
kkWosDZFuFwdyDaeU+0htZhJDIUOvwXMX8NL69GCyS2Kc0wumOj2zsQ2GCKqgRmD
8izZQotqMC86KK0hXmJUY3TKGolt33k8xrXzJ2K/noaMpBcC5aEWmqitFOmsc9mF
lnODiutQarhVX0w4h4s5ndag5HoLuMFEjL1jDY8LuN4kAEfuShg3JF39k1MTtRZy
ShXAFbszJfUoPsM4Z9BZ0/FWMYGpfzKJWrkoKWileC0OhAInGkHUt/L+UvayBnEC
EVzHDkj/bYekXOfvuIdfkVAsh3kg
=Q00E
-----END PGP SIGNATURE-----

--IQbEZeBX9Rukd5iP--
