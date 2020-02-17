Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5363C34021
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:04:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC4820718
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WbVab8Uu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ap2c.com header.i=@ap2c.com header.b="P8bzdAuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC4820718
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ap2c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0816839;
	Mon, 17 Feb 2020 15:03:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0816839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581948259;
	bh=4UU4MoMrU+/oNwXcGFGjLVmIH/ZEaVTh2kenL8qtvUY=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WbVab8UuE5Ulf7Zz/hWAZO3832lJ9bT7Q0FP6nIaSroqlcM7U+UUdAWbT6+2f2e4I
	 1vwkyThIYK9krTRWt32fJn7vNRgQ5JQfyskvejjuz8+/sUeEnE+yGgA8gIk/Wk/rr2
	 1CfnPnI/v77Cq1Mw0JA4JhPggtkTnQ/zH7Fe+Zag=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03F43F8015E;
	Mon, 17 Feb 2020 15:03:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B246F80172; Mon, 17 Feb 2020 15:03:22 +0100 (CET)
Received: from berkelium.ap2c.org (berkelium.ap2c.org [81.56.109.121])
 by alsa1.perex.cz (Postfix) with ESMTP id B6F82F800B6
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 15:03:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6F82F800B6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ap2c.com header.i=@ap2c.com
 header.b="P8bzdAuq"
Received: from berkelium.ap2c.org (localhost [127.0.0.1])
 by berkelium.ap2c.org (Postfix) with ESMTP id F3A391115;
 Mon, 17 Feb 2020 15:03:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ap2c.com; s=ap2cCom;
 t=1581948198; bh=gr5LuANKkxkymfIM8Fjh7yQ1wP5sA92Ugyg+o9cpwv4=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=P8bzdAuqkOrcclDe0cLfqGl0faROWggQ2aAzxd57TnI+oT83KktXYdbriyQiS0xHv
 M7cX79Z6izDnoTksSdLoxaEQW5Alm5F6phjTxZsnTt5lBDmZScz7HqGY8oR16sl3Ek
 Q34YnwnH2VCWwcuI5U51BUjJk2dXBQvmM0CD481s=
X-Virus-Scanned: amavisd-new at ap2c.org
Received: from berkelium.ap2c.org ([127.0.0.1])
 by berkelium.ap2c.org (berkelium.ap2c.org [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id KvCrov1aXXOG; Mon, 17 Feb 2020 15:03:17 +0100 (CET)
Received: from antimony.ap2c.org (unknown
 [IPv6:2a01:e34:ec20:ab90:63ad:3e9d:5e02:f5e0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by berkelium.ap2c.org (Postfix) with ESMTPSA;
 Mon, 17 Feb 2020 15:03:17 +0100 (CET)
From: =?ISO-8859-1?Q?Aur=E9lien?= Croc <aurelien@ap2c.com>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
Date: Mon, 17 Feb 2020 15:03:16 +0100
Message-ID: <2757884.e1HrdM282F@antimony.ap2c.org>
Organization: =?UTF-8?B?QVDCskM=?=
In-Reply-To: <s5himk5bq39.wl-tiwai@suse.de>
References: <1610933.XPBrhYXKCp@antimony.ap2c.org>
 <s5himk5bq39.wl-tiwai@suse.de>
MIME-Version: 1.0
Subject: Re: [alsa-devel] No sound with Realtek ALC298 on a Samsung Galaxy
	book
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

> The BIOS seems broken, it just sets a single output pin.
> You need to try to figure out the pin connections, e.g. via
> hdajackretask program.  The headphone might work with that.
> But the speaker output might need another special handling, and it's
> nothing but trial-and-test with the existing quirks for similar
> devices.  Take a look at sound/pci/hda/patch_realtek.c.

Thank you for your answer. I tried hdajackretask but I didn't succeed to ge=
t =

sound from headsets.. Maybe I didn't tried all the advanced features of thi=
s =

tool..
I also tried some quirks from  your file but it changes nothing. There are =
too =

many possibilities. It seems to be hard to test them all.

Don't you know a solution to get what is bugged or to get information about =

which channel is linked to headets or internal speakers from Windows driver=
s? =

I think about a tool to sniff communication between the driver and the soun=
d =

card? or read information from the sound card under windows?
Reverse engineering the Windows driver would lead to the solution but will =
be =

very long for me since I'm not familiar with the Intel HDA card and how thi=
s =

Realtek chip internally works.
Don't hesitate if you have any hints which could help me (and all the other =

users of this laptop..)
Cheers, =


Aur=E9lien

Le lundi 17 f=E9vrier 2020, 09:00:42 CET Takashi Iwai a =E9crit :
> On Sat, 15 Feb 2020 17:56:58 +0100,
> =

> Aur=E9lien Croc wrote:
> > Dear ALSA community,
> > =

> > I just bought a Samsung Galaxy book 12" laptop and I installed the late=
st
> > Fedora version (31) on it. Unfortunately when I try to listen something
> > there is absolutely no sound from speaker nor headsets. I checked that
> > volumes of the different channels were max. I also checked for muting
> > system but I didn't found anything.
> > Of course it works perfectly under Windows.
> > I saw on internet that many ALC298 users had troubles with it. I tried
> > different options to the intel hda driver (especially the model one) but
> > it
> > changes nothing.
> > =

> > Here is the alsa-info.sh output: http://alsa-project.org/db/?
> > f=3D871881e295972b9ecf252b25e90d659e38d939b8
> > I would appreciate some help in order to find a solution.
> > Tell me if you need more information.
> > Thanks in advance.
> =

> The BIOS seems broken, it just sets a single output pin.
> You need to try to figure out the pin connections, e.g. via
> hdajackretask program.  The headphone might work with that.
> But the speaker output might need another special handling, and it's
> nothing but trial-and-test with the existing quirks for similar
> devices.  Take a look at sound/pci/hda/patch_realtek.c.
> =

> =

> Takashi



_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
