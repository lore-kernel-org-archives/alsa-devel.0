Return-Path: <SRS0=DG6G=YR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0473ECA9EAF
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:50:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D77221872
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hAfNsIf8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="TGKwTSId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D77221872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A88716B9;
	Thu, 24 Oct 2019 13:49:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A88716B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571917812;
	bh=iOkMdzuJKs1E4dk+Of8vp5QuPPjxy1DrAoWB5oPeKio=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hAfNsIf8S9BBLIMc3/Lq1T+UwHYESbp5TOPBcrU9XHJNZBsYGSM8R2QCIO9ZFlZlo
	 TWCNvCSkH++irSK6v2vQzxgHQqQZTH1jkFv5lgOZBd64fGENS/NclvzvqQK+gygP43
	 3zfmqCZz8yJ0tYZzCsF2iwVTFUfAgzHQ6la6GJMs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F8A4F80390;
	Thu, 24 Oct 2019 13:48:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE145F80377; Thu, 24 Oct 2019 13:48:40 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 539CAF80377
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2019 13:48:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 539CAF80377
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="TGKwTSId"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rya3DttOH7mGpBbYccvVcDmtBP1uPjK2Qmqfw3ceCVk=; b=TGKwTSIdFblunuhkY+f6Bfi00
 GTxrJlfklmPP8W2Hd8cfd/597oR1jUpVNrypPoQmpTBvZMb+4QCs7ti5oLHJLLyd5O2MN3FYZjxzA
 7721YxpFhYwjN+ew3EjkivvS8nSPljUfJ2rhmHKlgb6YsS3XP2sgZx70hCZw/RuE6iToI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iNbbZ-0003Qd-Bp; Thu, 24 Oct 2019 11:48:37 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id D4724274293C; Thu, 24 Oct 2019 12:48:36 +0100 (BST)
Date: Thu, 24 Oct 2019 12:48:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Message-ID: <20191024114836.GB46373@sirena.co.uk>
References: <874l00yzxm.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
In-Reply-To: <874l00yzxm.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Filmed before a live audience.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Pavel Machek <pavel@denx.de>, Linux-ALSA <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-dpcm: tidyup for_each_dpcm_xx()
	macro
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
Content-Type: multipart/mixed; boundary="===============2470744408051668080=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============2470744408051668080==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 11:10:29AM +0900, Kuninori Morimoto wrote:
>=20
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> for_each_dpcm_xx() macro is using "dpcm" as parameter (1),
> but, it is also struct member (2).

This doesn't apply against current code, please check and resend.

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2xj5QACgkQJNaLcl1U
h9CDawf/ZojyJKkZvZPUlzXIwc3Njz3F6Am2uSfsQdQBuLm2Ia6Dwx8mKV1huj1g
dlPzxUzjrcY6CjkOWEKqKymKIk7lHC76a9DncdieBN0mLzI9UXsILItlxQg66POI
cKHkHnRKXVgpGpNlhi4089JCSMf926XEJ424MS20FdnYr64KeXAtbglmtpRGqUKM
pbtJNlgYivfrmCJa73Sx6SHqLMxJcvEdN5TsbzZUX1nurdBNPKdQRpxg6QMXIFeW
XrLa+Gh16W9a77XxnCjhN2Zm0YnLVQeX7UeBmuRYbixnF8umYquDey9pKPe/j8Dn
vvJfviXJ4xw2H0MU3hHA9IiNar4E9Q==
=ZM/x
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--

--===============2470744408051668080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2470744408051668080==--
