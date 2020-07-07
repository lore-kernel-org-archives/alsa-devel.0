Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36E6C433E1
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:15:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F5A920738
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jdhUMEFi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="QrsRcD7H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="iLdIx1X2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5A920738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ivitera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC4EE11C;
	Tue,  7 Jul 2020 19:14:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC4EE11C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594142147;
	bh=KBJnmmUybBkjosyjfih53BKS57nYly2nZ6YFrhCqA9g=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jdhUMEFiMCoGKiGryBMBPdwWRlZ4cyRCYTWarKW7Xvxy3aoCAVPWkTct40TrLC6Dc
	 948wzwjBGEk2pVhm4NYiVj+s7HMg/ni2CxL3U07OW8x79thlnSbSLe+qM7mZrV8+mK
	 yki9x1cMxWVlOFIWCOGbkyv52NPwJu4RVDMK0lTk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 78A6FF801F9;
	Tue,  7 Jul 2020 19:14:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7F79F80216; Tue,  7 Jul 2020 19:14:56 +0200 (CEST)
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46D11F8011F
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 19:14:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46D11F8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="QrsRcD7H"; 
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="iLdIx1X2"
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id 23E98A1F4B1AA;
 Tue,  7 Jul 2020 19:14:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1594142086; bh=KBJnmmUybBkjosyjfih53BKS57nYly2nZ6YFrhCqA9g=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=QrsRcD7HAJXToNZAqfmvw9oQewyo8719uMx7PBQWRqweYjmZeqtalgqYLwUYi5ah3
 5H+3IWntDOwCJlNv8B6EsAw90+uA7Bl6z7rljZ0zhs4WHjbf4CVVbx7OTi+pj8V+lm
 JWsSCgUlX1rT/UExYPO1erKhr96TPMys2aqYhQ5M=
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3-M-4wFTpiuC; Tue,  7 Jul 2020 19:14:40 +0200 (CEST)
Received: from [192.168.105.119] (ip28.insite.cz [81.0.237.28])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id 654AAA1F42AE2;
 Tue,  7 Jul 2020 19:14:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1594142080; bh=KBJnmmUybBkjosyjfih53BKS57nYly2nZ6YFrhCqA9g=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=iLdIx1X24DRFR7kHN3Iwn90Bz8Y6WnzF36dhoeR1HePRpZSWz0MJiMue5aS75eaBL
 lDxgHhhGKRqOWwHIKjE97ntdFmUi1j0LmHRs/oJX3nVSfnZonuPA7fkBL2VxE6A7V1
 lBvI0zR0HIn/2AN4eAi3s2sp1czYF8GYQ0aO+alM=
Subject: Re: Ignored USB-audio implicit feedback in kernel 5.8rc3
To: Alexander Tsoy <alexander@tsoy.me>, alsa-devel@alsa-project.org
References: <5be78c36-bca0-da9c-43ec-2e2a538948a8@ivitera.com>
 <51a129ba-d74f-bfe3-933c-4805bc87804a@ivitera.com>
 <5bd5efb4-66f0-955c-783e-57aff997028a@ivitera.com>
 <c233f32650a48c92a6c984db9da1f5c231df27a7.camel@tsoy.me>
From: Pavel Hofman <pavel.hofman@ivitera.com>
Message-ID: <9491051b-3b7b-bf5b-a5bc-403229145ea9@ivitera.com>
Date: Tue, 7 Jul 2020 19:14:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c233f32650a48c92a6c984db9da1f5c231df27a7.camel@tsoy.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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


Dne 07. 07. 20 v 12:34 Alexander Tsoy napsal(a):
> В Чт, 02/07/2020 в 13:28 +0200, Pavel Hofman пишет:
> 
> USB Audio Class specs are pretty clear about it: only one isochronous
> endpoint is allowed per interface. And it can be accompanied by the
> *explicit* feedback endpoint.
> 
> I have patches that implement autodetection of implicit feedback, but I
> need to clean them up and be careful not to break Scarlett 18i8/18i20
> 3rd Gen (these devices have 3 altsettings per interface and probably
> require some additional sample rates filtering, so that each sample
> rate uniquely match one single altsetting).
> 

Alexander, thanks for the clarification. If I understand correctly the 
existing single-interface condition is incorrect and no 
implicit-feedback device can work without a quirk now.

Thanks for your WIP patches, very much appreciated.

Best regards,

Pavel.
