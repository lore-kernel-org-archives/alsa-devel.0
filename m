Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A02CC3F68F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:23:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13CFB21582
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lum8mJm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CFB21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 69AFB1692;
	Wed, 18 Dec 2019 21:22:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 69AFB1692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576700625;
	bh=dp5me7o/YPawRSTwVyjtaQV0x3WWWGxfzPttMuzKit0=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lum8mJm+PpYsJQiC168yAK54pvgZxOqn/hIR7yFSunqxLMNU8HKbjq4QAX7nclBNC
	 rR1D26Mg8jADlWQsp2I+YYHBwHESJ72qp5Tabq2UsgfZLy2INkAHnb83HNvDycG4/j
	 n2RjQafwBg90D52X+4qUvrPwSZ/i3yjxqT0u0f88=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CD1F2F80269;
	Wed, 18 Dec 2019 21:08:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D3BA5F80269; Wed, 18 Dec 2019 21:07:59 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 7B7B8F8015A
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 21:07:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B7B8F8015A
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8C6D1FB;
 Wed, 18 Dec 2019 12:07:56 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46BF43F67D;
 Wed, 18 Dec 2019 12:07:56 -0800 (PST)
Date: Wed, 18 Dec 2019 20:07:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Message-ID: <20191218200754.GA21386@sirena.org.uk>
References: <20191126141423.21523-1-pierre-louis.bossart@linux.intel.com>
 <s5h4kyqzpge.wl-tiwai@suse.de>
 <0131b134-46dc-991f-230b-fe843f43f078@linux.intel.com>
 <s5hd0cm16vf.wl-tiwai@suse.de>
 <f442ed39-1a86-28fb-b42c-b0e5273cd79a@linux.intel.com>
 <s5hbls57g43.wl-tiwai@suse.de>
 <a90e86ce-b468-28b2-f0a8-30f66429d921@linux.intel.com>
 <s5hr211zd4q.wl-tiwai@suse.de>
 <828b260d-a22a-4c44-4a0b-644057336b67@linux.intel.com>
 <s5hd0clz9k9.wl-tiwai@suse.de>
MIME-Version: 1.0
In-Reply-To: <s5hd0clz9k9.wl-tiwai@suse.de>
X-Cookie: Please take note:
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: Intel: add PCI ID for
	CometLake-S
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
Content-Type: multipart/mixed; boundary="===============3746736432578512381=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============3746736432578512381==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 18, 2019 at 09:02:30PM +0100, Takashi Iwai wrote:

> When looking at the current code, for example, I'm not sure which
> category hits the case of Cometlake-S vs Cometlake-H vs
> Cometlake-LP...

Yeah, it's a bit much at the minute - there's enormous resolution there
with the Intel systems and I'm not 100% sure who's using it.

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl36hxkACgkQJNaLcl1U
h9DYAgf/T5lXETppaDDtWBy+b4syr9p/Jjb7Eg80Q5sh4M5hAkLJMaTw6B3+Ntdp
y5AzWuoCMaJ5d5PfUOp5C2A4cYQ5Z1Zby6BaIadAuJuBGmr5/v5Io5ib9b5jmzrR
ztgfh/uED88CuqlNF5AAW1/vASeTF4U58Rxl30x69U2uQali8JqDJNpUfP4B8vMG
pgb2KkEYdEVWYmpFrQrO6x34D1IAVkMnl3bw60NvfkenbSlx4455EuiDCVY7G1Lm
MMzthv18CgPCoFfKJtuX90uagB/4qqRRst7KEcO4J0LHxfDkija9l1PE9q9XzL8X
rmkWgniHH8Yq4+xXqsYnQkWF7B86IQ==
=RXkh
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--

--===============3746736432578512381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3746736432578512381==--
