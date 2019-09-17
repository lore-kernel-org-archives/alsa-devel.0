Return-Path: <SRS0=kA1C=XM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBF6C4CEC9
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:50:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CDDC21670
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Sep 2019 10:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aJjkYPoI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="d3ghXNPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDDC21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2E0B315F8;
	Tue, 17 Sep 2019 12:50:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2E0B315F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568717456;
	bh=UscMI/nNDCBTUDimCE1z//1EfbOC9L4slP6O0kL7hoI=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aJjkYPoIsj8NQdFs2q5vAb71Jm+yk9E9zaX1TBgmvhYLrJiGCaGGfbckDvmdD/nTA
	 sl6QLFxgXCLZMUMoNX2NMVy7xHtGQBfiDlRlBFB0Z5SJjrXe4OWzru9PWE8zbxqMMT
	 //Be8EqSywBl9dEHPN44lamch7GsxW2HvKhwfe1w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98F20F80307;
	Tue, 17 Sep 2019 12:50:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53C40F80361; Tue, 17 Sep 2019 12:50:03 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CE53CF802BD
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2019 12:49:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE53CF802BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="d3ghXNPh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7ysJyJKJEUr4khG20YZEwGPv0cFPLtQKqiinCxXuok0=; b=d3ghXNPhfvvMkLgEW7LycS0Ug
 ymSwgqY8bAJNrorMgwhnxFj9Rohc8yczZHJMmSo5h0BwDLXQUMS2u0vH3+QMRCG7wrkIKww6LF+/k
 ZrAVCENWlfhmlXwchnRGwmgYebaN2RMhblMPHqtVI1WsF/7uoBD2tA4lPdn9iZR+rvCfQ=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iAB3U-0007hu-0J; Tue, 17 Sep 2019 10:49:56 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 3B2E327419E9; Tue, 17 Sep 2019 11:49:55 +0100 (BST)
Date: Tue, 17 Sep 2019 11:49:55 +0100
From: Mark Brown <broonie@kernel.org>
To: "shifu0704@thundersoft.com" <shifu0704@thundersoft.com>
Message-ID: <20190917104955.GB3524@sirena.co.uk>
References: <1568705889-6224-1-git-send-email-shifu0704@thundersoft.com>
 <1568705889-6224-2-git-send-email-shifu0704@thundersoft.com>
 <201909171540576235182@thundersoft.com>
MIME-Version: 1.0
In-Reply-To: <201909171540576235182@thundersoft.com>
X-Cookie: Know Thy User.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel <alsa-devel@alsa-project.org>, lgirdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, "Navada Kanyana,
 Mukund" <navada@ti.com>, tiwai <tiwai@suse.com>, robh+dt <robh+dt@kernel.org>,
 Dan?Murphy <dmurphy@ti.com>
Subject: Re: [alsa-devel] [PATCH v5] tas2770: add tas2770 smart PA kernel
	driver
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
Content-Type: multipart/mixed; boundary="===============6690035979883635708=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============6690035979883635708==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2019 at 03:40:59PM +0800, shifu0704@thundersoft.com wrote:

> > +reload:
> > + /* hardware reset and reload */
> > + tas2770_load_config(tas2770);

> Sometimes devices need to be reset to return to normal, and this setting is necessary.

But why do we have systems where the device is being reset?  Like I keep
saying I'd just get a normal driver merged first, then go back and
figure out what's going on with the reset support so it can be reviewed
separately.

> > +end:
> > + return IRQ_HANDLED;
> > +}

> I see that the other drivers, the return values in irq_handler are IRQ_HANDLED.

If they've actually handled an interrupt.  There's some buggy drivers
that do it unconditionally, they aren't a good reason to add more.

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2AulIACgkQJNaLcl1U
h9CivAf/TXpClZFNRdOGm/qTXoebLIrHtsAWHL6Bdl4IOjCwRg4e7053muNi9edC
DdQ7xdI1C1uu/G6JoAZ33gCe78eDbqxL/QYXOJS0w75Zyp1/YeTsnbTR8d24P29x
z6Z/Q2f3W62Uc5n/aVp0KLvYI+OklBLH2A7YGOztNLm5FyXLXvKyekr1rwRErYpO
O/0505YBiy1reQSUNpDFpwVDPFwpPT7WSdk6hSi0euR8tUoefU3lV6B5iT1iJktE
nRsUu1j2a7i/8iev1295vbiaFQQ18vCGK7CPzX8uTWhrymZrl20urSyL4Kd+WQLy
BG7HzdYIKjS3LYutXM8425ufkcnzXQ==
=vT2v
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--

--===============6690035979883635708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6690035979883635708==--
