Return-Path: <SRS0=Sdsu=W6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F68C3A5A2
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:28:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F14EA238C5
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MbsEeFpB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VTCPO1vD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14EA238C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C2B061685;
	Tue,  3 Sep 2019 18:27:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C2B061685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567528097;
	bh=5Zver/FVLhYKFtx1qrClS8vWWhpVyvq+/AR2PPpddjE=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=MbsEeFpBLasQlIeCNLqsPccW6QK37/vZURhd0vQLeOOwY+qKMmASvP9oQvpqWc7xN
	 8WXdIR5kuv4VqRf6O3N0z7asqHv54DUWIKKfPJDT4fZsbPUIAtj12ygVYAGw0U1ye8
	 lReXv/XczsHlygmN7ALvu8pKLqXZMgjJCUyg+UQ0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CD39F803D7;
	Tue,  3 Sep 2019 18:27:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D029F8045F; Tue,  3 Sep 2019 18:27:25 +0200 (CEST)
Received: from sonic304-22.consmr.mail.ir2.yahoo.com
 (sonic304-22.consmr.mail.ir2.yahoo.com [77.238.179.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 29330F80392
 for <alsa-devel@alsa-project.org>; Tue,  3 Sep 2019 18:27:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29330F80392
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.b="VTCPO1vD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1567528040; bh=LCTufPjaBRyUz82lp6lN7OqEUE5Ld2syaos7wWu/IcE=;
 h=Date:From:Reply-To:To:Cc:In-Reply-To:References:Subject:From:Subject;
 b=VTCPO1vDEPnqaStfH4nkMq19F2xDFFaOaJ7LEmsM5DgmKlVA36Z0XQXj1LuET87Eg1iQexhE87RwJbNpW/sNsIH0YLSeBYtNksio0MR4q4pXAHuKzw1JcAs4N4+CvOpjaWAmgq50DkwFTxB5GPn0fPIxaZkAVRMnOmwehT30yUVJdtfpGtcbrBkJgdqhlDevgbUhFZk3wuNgzwlJck6zUcvB+g7cAWUbvhC9ybM9DgN4LAHJ5rTX2jwAH5CLnS04oa4MbmLp8QYFkvckfOEVHB/SvuxUHW15pWiFRKCXpTkeeWMSY5TARXN3HPQQ4frMUY+reyEXzUJ6P73gbe/iSA==
X-YMail-OSG: v_L6Ju0VM1klYsFAfO6DxDUQ0UKHIclUeUWzxDE4k4UjCSiwSUstejwyJIh3zxG
 K45DgUQfg0k6gm77OWV1GngS.o2xylgebzqj_FldHQ5aCYr0hftkB0zPIwNyswINRW6Ta.MLAQJM
 fnPCCfe2b5NNir8u5PAvfkF.6Uiyeo1wFFRCpiqLlItYJAFHc7wGShObRyjRxVY5IiPqyw8KwPZp
 O974C5W7OVfDTmi980aIqSUnI3Zly2CmUItWMgsuZI9AHcLxpk35xqkk4DLFGmqlgQJ95dOlfGTc
 aSCA2eUKIG8v_cEBJM1O4IMujFyOfWjRPlp1DvmTbPTl0CU4YzIbNMpt6vvDh.OCqpK3IrNeCOZ8
 FqgYKP1FEKBR.4zihedpB26TLS6ztEhmRKbJsMpt6hpOKCr1lTx.dzq6oKEB0l.u9YwLD04pkS0e
 Vo3PcNVQ3jGNfAEPJ0Bo0lmQwET5TOXjsRLn2GjNDBw0c5h7OYZO6m1Irz0G0WQc_lHlYrXvuSx1
 rGDUK3Vd37I5OvDmyNBVF889H1WkzuhnuLn3AMl78nzE2Gvvjm8huE6dpcmc2LqJqDJ0vedrHIGu
 Mv9plQIy2J606c7oDpkOxODlTFEvuqL2ZMCKSTGQ93E6ycibIgalPM9t3SyHMKJOVPEr6nsPeEXA
 vRcDCzNcIMVtRf1LHdDsE8O8gevPoQQ.T1yVDN_trpZ83PiRwS7QstUUl.YbmYdWXMl.dY2g82RK
 W9Nwtnnof3Dd1CaQBVvmG1CmDOnZ1DceroZ.7Zl6AWwyiaj0gyVdoR.NOBW6pIwPkpIeiB4MqsNU
 NQN7ebhSkb3IDgTCoR3tpcSVAPkQWtFcB32fE6fMM916L.ozWaUZJrZFMgoH4tAm49rBXmtUPkyC
 gq2_Z750xM1CX0cDt3nZbwBjRaPHCxNP86Rc2mDGC33dqzQnxWDCWf.GzQ.B_bPqrVvAKNRmDMiD
 uhQWSyjIkNqc9a3ugRzrzEZ0F5k3CR1YjN1SB2TbiEPbypezzwGHQfFjj2Ne5l4gMScCs1tF3T7d
 cM2IeNeM_mRkHAKCjj0Sz6unlXq4J9cNwzOys_E8qacAv90rU_moCNU7g3pfdNDDsqrlDSvk_SjP
 elBidIu7HEAjHQjIg_0ZR34kcqYb_HtgBnFMmth5fRakD.7ChHwRCTmr6r3haU0YuuIrwHABOw0i
 iLACqRpUdFq4tPoFlFrtonCa84sKeLx3vuFx9wSf1WM6jQD8NWw05zQNMcmj8aOrrC_6tQ_ydAre
 s_b24rk_brFtTiXP4QSJIh.vcBXjZ6VLYLK3k3V8AsK0RogPXt_rhC9dn_BegeQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.ir2.yahoo.com with HTTP; Tue, 3 Sep 2019 16:27:20 +0000
Date: Tue, 3 Sep 2019 16:27:17 +0000 (UTC)
From: Hin-Tak Leung <htl10@users.sourceforge.net>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <2004928875.2948311.1567528037874@mail.yahoo.com>
In-Reply-To: <20190902130606.GA4911@workstation>
References: <1091462655.1815609.1567426196596@mail.yahoo.com>
 <20190902130606.GA4911@workstation>
MIME-Version: 1.0
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, g@b4.vu
Subject: Re: [alsa-devel] sound/usb kernel modules as a DKMS package.
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
Reply-To: htl10@users.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

 

On Monday, 2 September 2019, 14:31:24 BST, Takashi Sakamoto <o-takashi@sakamocchi.jp> wrote:
...
> > https://github.com/HinTak/sound-usb-dkms
>

> As a quick glance, the repository is just for deb-based distributions.
> From my experience, users who eager to use the latest source codes tend
> to use Arch Linux and Gentoo Linux...

I have added some manual-install instructions for Fedora, after trying them out myself on a Fedora 30 docker instance.
(and built the dkms rpm package within it). I'd expect Arch /Gentoo works the same way.  
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
