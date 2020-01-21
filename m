Return-Path: <SRS0=ytyY=3K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3816CC2D0CE
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:00:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5D321569
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tN4knr9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5D321569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 130061664;
	Tue, 21 Jan 2020 17:59:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 130061664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579626031;
	bh=nZ7dasIX6rwYCRq/VU2WN6jGwsCHNlLarYn8gMzLit8=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tN4knr9OIBu1jB3hj4VTtuMPEcFxPpCxq8UaZM3VenMp3/jkY/9xllcLHy5QHm6uq
	 7VFju5wZOtMIcsYx1tWL1wfWN5B8CwU4+/7EuPVV+mGtqrX0Ukg8aIt8R2X0pR4hWX
	 fiuhffCfapsdiZWGx52DeAZI0E2nLmahLedmVWT0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6408EF800E7;
	Tue, 21 Jan 2020 17:59:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3575AF800E7; Tue, 21 Jan 2020 17:59:38 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id BCA05F800E7
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2020 17:59:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BCA05F800E7
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38E9230E;
 Tue, 21 Jan 2020 08:59:27 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABA9D3F6C4;
 Tue, 21 Jan 2020 08:59:26 -0800 (PST)
Date: Tue, 21 Jan 2020 16:59:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
Message-ID: <20200121165925.GH4656@sirena.org.uk>
References: <1579603421-24571-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
MIME-Version: 1.0
In-Reply-To: <1579603421-24571-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
X-Cookie: You too can wear a nose mitten.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 open list <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.com,
 Colin Ian King <colin.king@canonical.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: amd: Fix for Subsequent Playback
	issue.
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
Content-Type: multipart/mixed; boundary="===============6558018729216936587=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============6558018729216936587==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Content-Disposition: inline


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 21, 2020 at 04:13:35PM +0530, Ravulapati Vishnu vardhan rao wrote:

> If we play audio back to back, which kills one playback
> and immediately start another, we can hear clicks.
> This patch fixes the issue.

>  	/* Disable ACP irq, when the current stream is being closed and
>  	 * another stream is also not active.
>  	 */
> +	kfree(rtd);

This free looks like a separate change which seems good and useful but
should be in a separate patch?

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4nLewACgkQJNaLcl1U
h9B1+gf8CwB3aqHMAKHEgAHRutMujXPYif+JPjkD1gl9Cp8EFmrOkjwAO8ADVa3U
IhZonqAQvpX8nuRp2yq+GMTn0M3wKQHrZ8SZzFoY2az5dujgpV9shBrcSRAQa+vM
rnYexlnHXPlr/FFYHhcSlqPFgglHcZLJUIuioBk3OxoPrlXxnAcbhBP9zCpSZex3
mMwT3vlLmOTlhHkBhWNDGH7l3z5dd8N43iFMNCQP8zMEwggCkEPC4IYrLidXVORb
YE7fkOtRgRKJQhDjKN7QaH8XRSbbGdGK+9FthNOJXteCkp/VkU2ne7Mt0etqKDa/
ulqij1ZBM43yKQAhB8WIdYCQIw7oYw==
=m2Ma
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--

--===============6558018729216936587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6558018729216936587==--
