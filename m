Return-Path: <SRS0=fLcx=YP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220B3CA9EB7
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:54:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE0D21929
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C1PrFgIp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="nsKzOX/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE0D21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6667C1607;
	Tue, 22 Oct 2019 18:35:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6667C1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571762171;
	bh=E/ngehEJkFec3IVaCkkZ0LU5LACRDqcGt3QoPYKmp8Y=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C1PrFgIpnuhH0fzuKyc6iWeJy6kq9lmatnjC9HfW19ZoowW4J2yIVqmQIX0z4PIvF
	 HTFDLjMHeHdHcYdFU9AkuKxfXzzBMG5vFEh/DkZnWtLuyuKqyzk9yyd3JbmlHTLy98
	 LeplB7Q5uJHAyYbhj5yncrYvfSa7zR8Ag6ThB9Pc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E4465F800C0;
	Tue, 22 Oct 2019 18:35:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1F3E9F8031A; Tue, 22 Oct 2019 18:35:18 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C8B0F800C0;
 Tue, 22 Oct 2019 18:35:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C8B0F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="nsKzOX/b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3DAMGtjpRcEj5MxkyBHvgw9I1vtN+eg87OdL/Q7rOxU=; b=nsKzOX/bnhQYhfAQ88mC+POLD
 LqhgI3wA4l4S8A2a4tBz+r3o+TlxcauggO+bP2Ws1IJG7vsbrSD3KmoEHon6rJIILXiL8wZbccXkg
 8vKUkL2HuWf4XfRUBRfJIqG3QNOxPCEUOLmqFgEoJkLdC46I3sbQGbJvPayUDKE5ls+bs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iMx7d-00071w-MA; Tue, 22 Oct 2019 16:35:01 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 21EC22743259; Tue, 22 Oct 2019 17:35:01 +0100 (BST)
Date: Tue, 22 Oct 2019 17:35:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Message-ID: <20191022163501.GK5554@sirena.co.uk>
References: <1550823803-32446-1-git-send-email-twischer@de.adit-jv.com>
 <20191022154904.GA17721@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
In-Reply-To: <20191022154904.GA17721@vmlxhi-102.adit-jv.com>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: twischer@de.adit-jv.com, alsa-devel@alsa-project.org,
 patch@alsa-project.org, kuninori.morimoto.gx@renesas.com,
 Eugeniu Rosca <roscaeugeniu@gmail.com>, Jiada Wang <jiada_wang@mentor.com>,
 linux-kernel@vger.kernel.org, tiwai@suse.com
Subject: Re: [alsa-devel] [PATCH] ASoC: rsnd: dma: fix SSI9 4/5/6/7 busif
 dma address
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
Content-Type: multipart/mixed; boundary="===============2909539970147193175=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============2909539970147193175==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QxIEt88oQPsT6QmF"
Content-Disposition: inline


--QxIEt88oQPsT6QmF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 22, 2019 at 05:49:04PM +0200, Eugeniu Rosca wrote:

> It still applies cleanly to v5.4-rc4-18-g3b7c59a1950c.
> Any chance to see it in vanilla?

Someone would need to resend it.  No idea what the issues are but I
don't have it any more.

--QxIEt88oQPsT6QmF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vL7QACgkQJNaLcl1U
h9Atiwf/TC9MLCgCfLcRjT+GAkZHV5/iKnB0WppOTrYDfawY44SqLnFxcFDqs1xw
ZLYAVe3WabLE3vXk5AuUw2RuqHXEeVLLL/bsGQEIbzMmuSIYo0g8Qv1mOyCA2Q2R
gXHENTJHUPBPnYQeo7JfwVo3stcXdFjnN4LMWJU1rLgNGXrjsfo1jbhAzs1nVXbo
KCqkYC0Z7+/s/Y0lPGJ7QjDlHaRN3Mhj43jvxu3WPxyHRGFN/kXC0anJT0c2J7QE
9B8J5in7U2ptKLnsu8IZd+7NHooSk78VOR7Q1EaTwg2eekqVzd6b8M5C4h88Rb4x
fZu8hn34aED77ELINZbd+aCnXJZeZw==
=tQ84
-----END PGP SIGNATURE-----

--QxIEt88oQPsT6QmF--

--===============2909539970147193175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2909539970147193175==--
