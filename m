Return-Path: <SRS0=FfYG=YJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425EAFA372A
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:22:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4074B2067B
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nNtY3NUv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="aUnyNquE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4074B2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA3DD846;
	Wed, 16 Oct 2019 13:21:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA3DD846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571224964;
	bh=CwWixuNNOMRccj79hBuBAX5844CzKEekNpshbx3gXGU=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nNtY3NUvOSA9SMshzSJuAqeXtJSFJ2Jsr1yimokXlD4ZYWmWAGc5yfIDeLWRL2aai
	 EUMJcb1lmmSOuHz5V/BjruszZFQrLZdSH41vDcLZyF0JYAxsg3/i//MPC3aX4ZXGmW
	 WNpct7Iqfe4qO1CgWqeIQJcLqBRsKHrsIIdC7Sro=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C715F80323;
	Wed, 16 Oct 2019 13:21:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23732F80362; Wed, 16 Oct 2019 13:21:53 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0AE23F8011F
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2019 13:21:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0AE23F8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="aUnyNquE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r4pNwh2dmhWXG+v4aEuIpnxxNPpW6rBRdlS9GKndf0U=; b=aUnyNquE6nEcDeYCZwzqfCb6B
 8l95CuQaspIk7Ez41LdJhqhZUZ7spIzoRkVgXEogQKAuHEhjLtx/gjWGzImN+O0L7qa28gghaaO8y
 iBVArnBmDpZtkAPGuDJs3Gk/XH2FEuaufb9etG/9ilGBqMc3rzuaIvIU7Oq+cdDV9j13U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iKhNE-00058r-79; Wed, 16 Oct 2019 11:21:48 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 4A64D2741FD5; Wed, 16 Oct 2019 12:21:47 +0100 (BST)
Date: Wed, 16 Oct 2019 12:21:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@gmail.com>
Message-ID: <20191016112147.GB4881@sirena.co.uk>
References: <87a7a24l7r.wl-kuninori.morimoto.gx@renesas.com>
 <CAEnQRZAsZ=Q=tcqCzVp8bvj4Jme+YTH9GxmMoBgvOT+w6z8iiw@mail.gmail.com>
 <877e564ht5.wl-kuninori.morimoto.gx@renesas.com>
 <CAEnQRZDtwFoXQ2H_j1v-95Pnh=QzZFX86jHk1RTq1oqSO+5jRw@mail.gmail.com>
 <93911ba6-370e-4b93-d3c2-81081b1be0aa@linux.intel.com>
 <87o8yhwn3d.wl-kuninori.morimoto.gx@renesas.com>
 <CAEnQRZDEZySYWzJ9gifVAiZ0qOxDe_w9zMxgsLbN0URmpcYCAw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEnQRZDEZySYWzJ9gifVAiZ0qOxDe_w9zMxgsLbN0URmpcYCAw@mail.gmail.com>
X-Cookie: Serenity through viciousness.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: sof: include types.h at header.h
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
Content-Type: multipart/mixed; boundary="===============1550812174625133441=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============1550812174625133441==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 16, 2019 at 02:11:57PM +0300, Daniel Baluta wrote:

> That means Mark needs to drop Morimoto-san's patch.

Please send a patch reverting it if you think that's the best option.

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2m/UoACgkQJNaLcl1U
h9Dqhwf9E60V4iryxuaws+aHC9IejLxrFH451wry2kjLpKAUaACcRj8JPTlUqQhi
cyAoh4tv4QthkewzDywfAERggHqKYSo9SlssugotMcxocXBG/ItK9PtMEt6jJOc3
06TuVKCHMVFTY2UoGhe9/3GGt3pmB5Pn4KzaSQmobXVoPioNNs3Z0wA3AV7Uwn89
XwhwRscfiz2eCD9SJZXT5aezjAHIOtGH50pJHUWCKhLNDaQzRRT1bm1t3MOwqrP5
kl0Mwn/dvsU3iiA3PkJYPvxScNpne/U7GTJjtdIlhwegwOLxM2O4qbZUML4K6QjZ
ZAkzTlFqa13LxumNcFavs+7EVUNqaQ==
=sAsZ
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--

--===============1550812174625133441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1550812174625133441==--
