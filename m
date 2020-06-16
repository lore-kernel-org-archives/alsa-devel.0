Return-Path: <SRS0=xZai=75=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFE1C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 08:13:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A422074D
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 08:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OjOP0M0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A422074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=reaktanz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B18F167A;
	Tue, 16 Jun 2020 10:12:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B18F167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592295179;
	bh=GB4/Sj2N1ynfjSqfU6MB2WMpm745vHzdCLza/zjpgWQ=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OjOP0M0udp71qbAkGYkKyBNSHwyYM4mIn9ga6kja683tlSGzTQzSbCSnpwDxF+3KQ
	 XjOZWMwLmtp0ZJBef1qZf5bUDllrE8XBg2hVWmzDlO1iosEZXcMB1fTQioGeaL0MSn
	 p0VFvc6iKwdFcnbbAm5a+cnt+SnmuHO5LgrIrGp8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FAB9F80217;
	Tue, 16 Jun 2020 10:12:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61BF4F8022B; Tue, 16 Jun 2020 10:12:06 +0200 (CEST)
Received: from dd48038.kasserver.com (dd48038.kasserver.com [85.13.164.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2824EF80114
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 10:11:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2824EF80114
Received: from meadow.localnet (x4e3034a9.dyn.telefonica.de [78.48.52.169])
 by dd48038.kasserver.com (Postfix) with ESMTPSA id A9923500085D
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 10:11:58 +0200 (CEST)
From: "m.eik michalke" <alsa@reaktanz.de>
To: alsa-devel@alsa-project.org
Subject: presonus StudioLive 24.4.2
Date: Tue, 16 Jun 2020 10:11:57 +0200
Message-ID: <1859294.RmyynjnHiM@meadow>
Organization: http://www.reaktanz.de/blog
X-Face: :Fk?kfw3:=Vz)np%nh,d4^[#)-y,9IYe:y,; }P|%`fw>/.msl.f=*6j*-f$vL09$qopvp6
 Ox|(^ge<|+0iS]{&|\<0>i7r'@'k+i=eB5y8*pO$#xT+$2uq=`
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

hi,

i'm trying to get a presonus StudioLive 24.4.2 up and running:

  https://www.presonus.com/products/studiolive-24.4.2

so far i'm partly successful -- looks like the board is automatically detected 
and supported by the firewire dice module.

however, i'm only offered 16 of the 24 supported audio channels. in the list 
of soundcards it is merely shown as "studiolive" without further info on the 
model. i wasn't able to find further info on this board's status with regards 
to alsa, so if there's documentation on this somewhere, could someone please 
point me to it?

in case that as of now the studiolive isn't officially supported or the above 
behavior is due to the fact that so far only the 16.4.2 is known to the 
module, i'm willing to help as far as i can ;) i hope that already seeing 16 
channels is a good point to start and that it's not too hard to make the 
remaining 8 show up as well...


best regards :: m.eik



