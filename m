Return-Path: <SRS0=OCx8=ZZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF07C432C0
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 12:56:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDAB52073C
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 12:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BX4Rm6So";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="pTO24UA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAB52073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC4E382A;
	Tue,  3 Dec 2019 13:55:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC4E382A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575377782;
	bh=jWWnnge1fb1egX2jfvz35zAGTD1/ccCaKHiQyCw7J0c=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BX4Rm6SoDDRUeGMxC5uTBxpqGPrJFkNoC37ww1g0xzgaFitgM4s4B+lYd36EUpQUc
	 eYOEZ3y5iy5rUG7YuX4Z5BEP0EYe+mhOCJRzplMjXBwe9Mu6nJmG4pw3LXebDzg5jq
	 WQ9ur/5AUPDS1EZSU7hsl7WVqO950FsgpO9QI9aE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70DF5F8015A;
	Tue,  3 Dec 2019 13:55:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F077DF80227; Tue,  3 Dec 2019 13:55:29 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A082F800B4
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2019 13:55:27 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 83BDEA0047;
 Tue,  3 Dec 2019 13:55:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 83BDEA0047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1575377726; bh=8pz9HMXgFQjL0x6li9saJRRG28xtfDHZf0EZPNGoHyY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=pTO24UA8BMzagg1AWF29RdceBfBGIInpjdidvPhbChTVZsY+BHxZDRHROpHZ0wXAl
 OjnOX67KavdfGplMDrzWMOSYNSknzCWwzpwAQ2sBRRUTRn9taiJjITOsWiQ8JyXbTo
 0Mwz9sJuqQaEbbOZI44taHRcAo0DFF1O2g8nEsfA=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue,  3 Dec 2019 13:55:23 +0100 (CET)
To: tommy <tommy@kelsos.ptp>, alsa-devel@alsa-project.org
References: <20191202151722.GA13104@kelsos>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <ff5b96a7-95c2-cc3f-da8a-5a2fecd1b3ce@perex.cz>
Date: Tue, 3 Dec 2019 13:55:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191202151722.GA13104@kelsos>
Content-Language: en-US
Cc: ptp@lysator.liu.se
Subject: Re: [alsa-devel] alsa-utils say -c is sched_idle,
 but actually set sched_rr (BUG?)
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

Dne 02. 12. 19 v 16:17 tommy napsal(a):
> Hi,
> 
> I'm not subscribed to the list.  I was looking for uses of SCHED_IDLE in
> software in general when I stubled upon this.  Although I have no personal
> interest in asla development, I thought it would be nice to report it here.
> 
> alsa-project/alsa-utils commit 611249ae26f435429dbe1894e210704a723ee277 says:
> 
>      alsactl: add --nice and --sched-idle options
> 
>      The state management can run at low priority, add --nice and --sched-idle
>      options to set the scheduler.
> 
> 
> Everywhere in the code it says SCHED_IDLE *except* for the actual call to
> sched_setscheduler() which instead sets the policy to SCHED_RR.  I have
> looked twice to see that I don't miss anything obvious, and suspect this is
> an error, or that there should be a comment that explains this oddity.

Thanks, fixed in 34e373d0b12d96353c49c3dcd73ec52eee11484a .

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
