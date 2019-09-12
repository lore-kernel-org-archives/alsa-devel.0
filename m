Return-Path: <SRS0=5I5Q=XH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B09C4CEC5
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Sep 2019 15:06:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DE62206CD
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Sep 2019 15:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qJ//I15z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE62206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ladisch.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC20A1681;
	Thu, 12 Sep 2019 17:05:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC20A1681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568300798;
	bh=dlplBjncfr6MieISXs22K6ZtZmMKGdGyBxIegaQdxHY=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qJ//I15zkj07dCZjya+itOdSkoE3Rl9STMiUv9a1dq2gkBLo17rEfYs3uPj4FZAB7
	 XhhrWZ8D1DXOp2KHyCE6gMNJJcQ7KUmIzJbLwMapXoLca6RtCkIyp6svUaZuOSnhXS
	 Z3wOoWTopRAvKlcbZgQie3plfzeWRIF1nCumxzE8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A9EBF80321;
	Thu, 12 Sep 2019 17:05:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B2FD2F80368; Thu, 12 Sep 2019 17:05:45 +0200 (CEST)
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6202F80143
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2019 17:05:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6202F80143
Received: from olorin.ladisch.de (unknown [46.114.32.78])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 418885583EFB;
 Thu, 12 Sep 2019 17:05:41 +0200 (CEST)
To: htl10@users.sourceforge.net
References: <1000767908.8406503.1568280868516@mail.yahoo.com>
From: Clemens Ladisch <clemens@ladisch.de>
Message-ID: <e9f48f93-6974-5dde-61dc-1d6d8dc4260f@ladisch.de>
Date: Thu, 12 Sep 2019 17:04:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1000767908.8406503.1568280868516@mail.yahoo.com>
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.99.4 at webclient5
X-Virus-Status: Clean
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] alsa compliance test: H340 (USB audio) playback /
 capture rate asymmetry bug?
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

Hin-Tak Leung wrote:
> ID 046d:0a38 Logitech, Inc. Headset H340

Please show the output of "lsusb -v" for this device.


Regards,
Clemens
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
