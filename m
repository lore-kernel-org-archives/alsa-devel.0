Return-Path: <SRS0=j21J=6I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0269C55191
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:47:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 507CF20776
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2020 10:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Icb2hDz1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP0EHgRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507CF20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB17916AF;
	Fri, 24 Apr 2020 12:46:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB17916AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587725269;
	bh=IewgKVWJvxyhdE4TKcCYoEvv7xD+0FgI7QpltLoN86M=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Icb2hDz1emtExqEdWnJLzCf3LBc9L8mp3S6GuCzs+wcKfS1QOLJPBo09HksbsZZAJ
	 7FBRNG01/T+sPNI8bxZKOgfP8Hc6F0zzUsP/+cS8B/5rgSx9C/I9Hhkq+ExLGMRc/L
	 1VNZ0umiCYRlkHKRQZdKxzcqWpuOGEu/u5jPySKE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A932F80121;
	Fri, 24 Apr 2020 12:46:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 98244F80142; Fri, 24 Apr 2020 12:46:57 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1ABE1F80116
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2020 12:46:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1ABE1F80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GP0EHgRP"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 146732064A;
 Fri, 24 Apr 2020 10:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587725209;
 bh=IewgKVWJvxyhdE4TKcCYoEvv7xD+0FgI7QpltLoN86M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GP0EHgRP62u/B+a36tX2U1F85Xn34FBjvigS/Dh48dUQcn+s+5WAOzeGnKIQb/g91
 ZUpE4Znj6F+mCM+3S7ncf/anWckRzANZL1ebbEG8WmnbkOplFDkoNtXpONO8UnKm4m
 ORzXELHjJGWh9a9316DHpqzcxadJBitPQ8SJUh5o=
Date: Fri, 24 Apr 2020 11:46:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm8962: Force suspend/resume during system
 suspend/resume
Message-ID: <20200424104646.GC5850@sirena.org.uk>
Mail-Followup-To: Charles Keepax <ckeepax@opensource.cirrus.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
 perex@perex.cz, tiwai@suse.com, tglx@linutronix.de,
 allison@lohutok.net, info@metux.net, patches@opensource.cirrus.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1587708727-13657-1-git-send-email-shengjiu.wang@nxp.com>
 <20200424104347.GJ44490@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
In-Reply-To: <20200424104347.GJ44490@ediswmail.ad.cirrus.com>
X-Cookie: Information is the inverse of entropy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 patches@opensource.cirrus.com, Shengjiu Wang <shengjiu.wang@nxp.com>,
 tiwai@suse.com, lgirdwood@gmail.com, tglx@linutronix.de, info@metux.net,
 allison@lohutok.net
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


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 24, 2020 at 10:43:47AM +0000, Charles Keepax wrote:

> intended to put the CODEC into runtime suspend. I am guessing the
> reason you have problems is because of the driver doing its own
> pm_runtime operations in set_fll, which probably takes an extra
> reference preventing the power down. Is a more complex fix
> correcting the interaction with DAPM the correct solution here?

Or just updating the machine driver to turn off the FLL when shutting
down (or even when the device is idle in general).

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6iw5YACgkQJNaLcl1U
h9DD5Qf/aNoM7gNzCjtutvsHglTVC2IeVikq5qWepEIkjE2Za8SbDHTb+o+EFvnR
D21oMf1biEpUZitXu5tFrk+vhCLLXD+lsPathUE0suZubm1tUrmsEyLmZ5tzWO5R
LE/KIAA0VGzkInIq8ywzUP15Yu8ruUMFfDWiKpFWn8t8yFfkOqWhH5VpvE59b0za
dixQK3ngHIh2D37+GxZ0iJWDpaF0mmk1qfn8wAKYWp3RxMCTbNRcRfzZm+qXkGPd
QUJnnN3+dovMnbR1U838fb9x83DjFndOOCGoRbNJ9NA6mPuB1Ubpu/e6QE8d0BOT
7G3qLT5B4KrGBSIaRbBzSj9flX7Snw==
=SsMB
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
