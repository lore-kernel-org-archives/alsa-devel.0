Return-Path: <SRS0=PUtL=XN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD293C4CEC4
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:08:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBBBE21920
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="U4JTBhR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBBBE21920
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ladisch.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D943166D;
	Wed, 18 Sep 2019 13:08:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D943166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568804933;
	bh=rCkrsOTR3R+u17KTWqnokm81RnKCAjo7SFrple9NCg8=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U4JTBhR3PX2GgtHduv0Kk6x+15aJdtWm9J33SpQCJeKXTzVq5onGu8pnwSjIzBOyd
	 y1ClePgSo2Uz91vNMLksGmld+6h1yhT50VjM6zV6NS59AA5rtlFHuXrjzPaQEwqNG0
	 cwqhkyRC+kVyRV9Wtv6NvOLC6o2pf+WfOy/mA270=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B904FF804FF;
	Wed, 18 Sep 2019 13:08:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 109FEF80506; Wed, 18 Sep 2019 13:08:01 +0200 (CEST)
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 666D6F800C1
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2019 13:07:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 666D6F800C1
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 0B11755839FD;
 Wed, 18 Sep 2019 13:07:56 +0200 (CEST)
To: liebrecht@grossmann-venter.com, alsa-devel@alsa-project.org
References: <0c48cbff966673fe6842621e3e1317f4@grossmann-venter.com>
From: Clemens Ladisch <clemens@ladisch.de>
Message-ID: <e959c950-4d92-d4a6-dbac-056fbc4b5425@ladisch.de>
Date: Wed, 18 Sep 2019 13:07:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0c48cbff966673fe6842621e3e1317f4@grossmann-venter.com>
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.99.4 at webclient5
X-Virus-Status: Clean
Subject: Re: [alsa-devel] alsa acting up
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

liebrecht@grossmann-venter.com wrote:
> 1) As soon as pulseaudio is started Alsa says 1818VSL is unplugged....?

What is the output of "dmesg | tail" immediately afterwards?


Regards,
Clemens
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
