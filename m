Return-Path: <SRS0=OCx8=ZZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_ADSP_NXDOMAIN,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A058C432C3
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:09:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0192073B
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gVRXl5NR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0192073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kelsos.ptp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F469822;
	Tue,  3 Dec 2019 12:08:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F469822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575371342;
	bh=wqFwr0mQ5uAGDtR8aKulCmVlAy6ppCIC1vhq2pHMB8E=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gVRXl5NRQbFm9OXK8BTFwyclcX4cMG57rHmQ7yKHJM+h9PnYQ2edPmqjSu894P+Qz
	 S45Im3HriahxbD4QmpvRphU74SsUcMGlzP2axXbM1iCyO7jmwwILISmK2u+B+NJ/Ty
	 OQ/tAlgyD/fRV38JLWHTyYX5k6bLXJ5yDxHDaQzQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90367F8015A;
	Tue,  3 Dec 2019 12:08:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EC759F80214; Mon,  2 Dec 2019 16:17:32 +0100 (CET)
Received: from mail.lysator.liu.se (mail.lysator.liu.se
 [IPv6:2001:6b0:17:f0a0::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86DBEF80090
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2019 16:17:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86DBEF80090
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id A938840010
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2019 16:17:24 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 8DF1A40011; Mon,  2 Dec 2019 16:17:24 +0100 (CET)
Received: from kelsos (37-247-17-105.customers.ownit.se [37.247.17.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id C2C3140010;
 Mon,  2 Dec 2019 16:17:22 +0100 (CET)
Received: (nullmailer pid 13822 invoked by uid 1000);
 Mon, 02 Dec 2019 15:17:22 -0000
Date: Mon, 2 Dec 2019 16:17:22 +0100
To: alsa-devel@alsa-project.org
Message-ID: <20191202151722.GA13104@kelsos>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
From: tommy <tommy@kelsos.ptp>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Tue, 03 Dec 2019 12:08:10 +0100
Cc: ptp@lysator.liu.se
Subject: [alsa-devel] alsa-utils say -c is sched_idle,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi,

I'm not subscribed to the list.  I was looking for uses of SCHED_IDLE in
software in general when I stubled upon this.  Although I have no personal
interest in asla development, I thought it would be nice to report it here.

alsa-project/alsa-utils commit 611249ae26f435429dbe1894e210704a723ee277 says:

    alsactl: add --nice and --sched-idle options

    The state management can run at low priority, add --nice and --sched-idle
    options to set the scheduler.


Everywhere in the code it says SCHED_IDLE *except* for the actual call to
sched_setscheduler() which instead sets the policy to SCHED_RR.  I have
looked twice to see that I don't miss anything obvious, and suspect this is
an error, or that there should be a comment that explains this oddity.

Kind regards,
Tommy
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
