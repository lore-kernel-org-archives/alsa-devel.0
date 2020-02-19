Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA250C34022
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 09:06:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7342821D56
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 09:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lYsjcrzW";
	dkim=pass (1024-bit key) header.d=ap2c.com header.i=@ap2c.com header.b="oEq1E4wC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7342821D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ap2c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C40BD16FD;
	Wed, 19 Feb 2020 10:05:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C40BD16FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582103192;
	bh=8vL7puauUqwwf8sAU66lbIgtKKPn4Uhnyv5ohIwkGtI=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lYsjcrzWIrpaZqh1U44jdxdoKUe32jOJ6fhC9GZ5LesbpMlIo39Ffy1ZxTwZhdg8F
	 pkZHHpq1El4v6yzLodf5IaM0HrflJA9xw6/EyZrf0Ty9gder1CUUlNs/9t06FhOp97
	 V7RoRlxEgzb+awAmVCE8Rq//FvIqqGVoLLC0RCqw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B631F801F4;
	Wed, 19 Feb 2020 10:05:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9106CF80142; Wed, 19 Feb 2020 10:05:41 +0100 (CET)
Received: from berkelium.ap2c.org (unknown
 [IPv6:2a01:e35:1386:d790:250:fcff:fe42:7bed])
 by alsa1.perex.cz (Postfix) with ESMTP id D4DF7F80142
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 10:05:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4DF7F80142
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ap2c.com header.i=@ap2c.com
 header.b="oEq1E4wC"
Received: from berkelium.ap2c.org (localhost [127.0.0.1])
 by berkelium.ap2c.org (Postfix) with ESMTP id C76EA136B
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 10:05:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ap2c.com; s=ap2cCom;
 t=1582103137; bh=8vL7puauUqwwf8sAU66lbIgtKKPn4Uhnyv5ohIwkGtI=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=oEq1E4wC5DC03TjMFBvDE8dVxj/ZjhcEBu/heqcHblwT7kfwPZFokBvoXEqf5YOfC
 B6feNcArUntCYoK6vDQ2bFVJIQCXwuGUgTkqZLexfZ5onZTEzsmirqie6VtFtIku00
 JtsVhfVvK1G1A9T3kcKnbWhYCUBltUhZC5WiliC0=
X-Virus-Scanned: amavisd-new at ap2c.org
Received: from berkelium.ap2c.org ([127.0.0.1])
 by berkelium.ap2c.org (berkelium.ap2c.org [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id W0XT8zd5unJ3 for <alsa-devel@alsa-project.org>;
 Wed, 19 Feb 2020 10:05:37 +0100 (CET)
Received: from antimony.ap2c.org (unknown
 [IPv6:2a01:e34:ec20:ab90:63ad:3e9d:5e02:f5e0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by berkelium.ap2c.org (Postfix) with ESMTPSA
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 10:05:37 +0100 (CET)
From: =?ISO-8859-1?Q?Aur=E9lien?= Croc <aurelien@ap2c.com>
To: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] No sound with Realtek ALC298 on a Samsung Galaxy book
Date: Wed, 19 Feb 2020 10:05:36 +0100
Message-ID: <3375274.Es2tsrqsTZ@antimony.ap2c.org>
Organization: =?UTF-8?B?QVDCskM=?=
In-Reply-To: <s5h1rqsc1kd.wl-tiwai@suse.de>
References: <1610933.XPBrhYXKCp@antimony.ap2c.org>
 <5023991.OkN0jAucn1@antimony.ap2c.org> <s5h1rqsc1kd.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
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

Hi,=20

> Aha, so the input works but only the output doesn't?
> Then it's not about the basic stuff like pin configuration but rather
> the missing COEF setup or such that is specific to Realtek codec
> (and/or the Samsung platform).
>=20
> Kailang, do you have any clue?

While waiting for Kailang's answer (and I hope he'll get the solution!!),=20
isn't it possible to grab information from Windows? I'm sorry I don't know=
=20
very well how Realtek chip works but if the problem would comes from some=20
registers which are not well initialized isn't it possible to dump the stat=
e=20
of the realtek chip and its registers under Windows and compare it with the=
=20
one under Linux?
Because I'm not sure that revers engineer the Windows driver would really=20
easily lead to the solution.

Thank you again for your help.

Aur=E9lien



