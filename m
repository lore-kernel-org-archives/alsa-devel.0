Return-Path: <SRS0=vsGj=3L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C40C2D0DB
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 16:58:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7694F21569
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 16:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XiTk48Wf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7694F21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CFCA51693;
	Wed, 22 Jan 2020 17:57:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CFCA51693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579712292;
	bh=1AsIlw/u82BQScSSwz0m6qQ2Kbi7KGRCy6+DiFvoFjU=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XiTk48WfgqA2al4GPU3TgY+8+ppb9fu4+ZufjJTYvx1I7LjxEjNgeBxyqvePVosF4
	 Cg5Kteu3DeMWJ868qEJg3hn0kfqfYTv3PU+TbbpWvW1e8KccEzQDxpuvKnc2NCZ3Mz
	 exRssCmF3hDkgBEWGtQKEIAuZz7nAb+UBXaTBWT8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5882AF800BA;
	Wed, 22 Jan 2020 17:57:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BDFB7F8020C; Wed, 22 Jan 2020 17:57:21 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 346D7F800E7
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2020 17:57:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 346D7F800E7
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F32E91FB;
 Wed, 22 Jan 2020 08:57:16 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7408B3F6C4;
 Wed, 22 Jan 2020 08:57:16 -0800 (PST)
Date: Wed, 22 Jan 2020 16:57:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Message-ID: <20200122165714.GF3833@sirena.org.uk>
References: <20200120132928.25257-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20200120132928.25257-1-yung-chuan.liao@linux.intel.com>
X-Cookie: Sorry.  Nice try.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
 tiwai@suse.de, pierre-louis.bossart@linux.intel.com,
 liam.r.girdwood@linux.intel.com, bard.liao@intel.com
Subject: Re: [alsa-devel] [PATCH RFC v4 0/6] ASoC: Add Multi CPU DAI support
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
Content-Type: multipart/mixed; boundary="===============4478691339690007055=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============4478691339690007055==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eNMatiwYGLtwo1cJ"
Content-Disposition: inline


--eNMatiwYGLtwo1cJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 20, 2020 at 09:29:22PM +0800, Bard Liao wrote:
> As discussed in [1], ASoC core supports multi codec DAIs
> on a DAI link. However it does not do so for CPU DAIs.

On a first, very high level, read through this makes sense to me (as did
the earlier version I looked at) but it's quite late in the release
cycle so I'll hold off actually doing anything until after the merge
window, I'll try to look through it properly before then so it gets
applied at -rc1 - hopefully other people will get a chance to too.
Thanks for picking this work up!

--eNMatiwYGLtwo1cJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4ofuoACgkQJNaLcl1U
h9DAbQf/VYeZJLhXThX5ktenDql2hXsxXCaYMm14oAqHyqXgjeHhSfyUiFnh3QPj
/P0JzVc5h9gGPu1u8nOSrrlE/oq6S+a4fjfvFv7q4fJFRciXjX2rGYVhpUVXJiGu
VexzUq3UWJuV17xNzRqWMjAi0FHVESF4WP4P/tjdiJQVY+QPOYJ6jrLBQ1g9L3+R
ptjj2KycKZPzAU9DNofplryceaTGpaVMnjCRm3szIH3ZHfLc/ocIPmwQxMXzwQPi
dFF/eEdktquRGBwK9PhBROxljeOkpgZP8nIaJNkAYaI/zt1UEWZGu8aDhUYVEN+w
fdmp3QaDKAFfevnoL6kdj64SS8hC/Q==
=mH13
-----END PGP SIGNATURE-----

--eNMatiwYGLtwo1cJ--

--===============4478691339690007055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4478691339690007055==--
