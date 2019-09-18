Return-Path: <SRS0=PUtL=XN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC80C4CEC4
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:47:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59AF321907
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BS7wIOXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59AF321907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grossmann-venter.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54E91166C;
	Wed, 18 Sep 2019 10:46:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54E91166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568796441;
	bh=Bq8Q2T+jShJk8T0HhXcg/7abmB8F+txhbkVo7eRxVR8=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BS7wIOXpN2MBCXPTNQQ1gjWA8iix2oRr+Qv95lcxupjBtqrKuUQhxXIm9p5QofdRZ
	 oV7gNFUMuY6OTkZunznws+sux27Dx7SF7XmDaitUR/iAuw66lMot7PGE6Ccfc65T8i
	 A3TaJD9RNry5MQ7nFq8Bh7WrSlhQy12Qj36i+6HI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E635FF80146;
	Wed, 18 Sep 2019 10:46:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 24695F80506; Wed, 18 Sep 2019 10:46:29 +0200 (CEST)
Received: from server54-2.web-hosting.com (server54-2.web-hosting.com
 [198.54.126.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9CFC0F80146
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2019 10:46:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CFC0F80146
Received: from [::1] (port=50696 helo=server54.web-hosting.com)
 by server54.web-hosting.com with esmtpa (Exim 4.92)
 (envelope-from <admin@grossmann-venter.com>) id 1iAVbR-0009Ao-3s
 for alsa-devel@alsa-project.org; Wed, 18 Sep 2019 04:46:25 -0400
MIME-Version: 1.0
Date: Wed, 18 Sep 2019 04:46:21 -0400
From: liebrecht@grossmann-venter.com
To: alsa-devel@alsa-project.org
Message-ID: <0c48cbff966673fe6842621e3e1317f4@grossmann-venter.com>
X-Sender: admin@grossmann-venter.com
User-Agent: Roundcube Webmail/1.3.7
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - server54.web-hosting.com
X-AntiAbuse: Original Domain - alsa-project.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - grossmann-venter.com
X-Get-Message-Sender-Via: server54.web-hosting.com: authenticated_id:
 liebrecht@grossmann-venter.com
X-Authenticated-Sender: server54.web-hosting.com: liebrecht@grossmann-venter.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: rewritten was: [admin@grossmann-venter.com],
 actual sender does not match
Subject: [alsa-devel] alsa acting up
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

See images in links.

1) 
"http://grossmann-venter.com/visitors/ug/alsa/alsa-pulse-181vsl_unplug.png"
2) "http://grossmann-venter.com/visitors/ug/alsa/alsa-dont 
recognize1818VSLpng"

1) As soon as pulseaudio is started Alsa says 1818VSL is unplugged....?

2) Clearly Presonus 1818VSL is found as lsusb output says, but alsa has 
no clue about it.

How do
I get alsa to recognise 181VSL as it is found by lsusb so it is presnet 
on the system.

It used to work fine but alsa just stopped working with 1818VSL recently 
for no reason.

I know this is a developers group, but please at least answer where I 
can get help. Alsa help is absolutely non-existing.

I also posted a bug with no response in another thread.


Thanks.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
