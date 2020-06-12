Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A4BC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:59:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15FC92081A
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 09:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="agsh/IXK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk header.b="fGmj5Aoe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FC92081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xwax.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A50681670;
	Fri, 12 Jun 2020 11:58:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A50681670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591955949;
	bh=qNxGjqjiXCcVLD335mlnfogxeLvvF3IMCDpFwRQ9ELQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=agsh/IXKT5c/tejXZDT2lSEeiiCmLwYadZULCeJJMFcNlQgIIz0myDroSGMTMDlso
	 rWY9PiyU/knC6Qljtl1i5Gc23FPYRMpWmkROw2HuZklILKVa/CTodzByrYIT3haZQf
	 1ep6iAtBqCqMOHXliUOjbjpmzAhC9iMUZQBwoq/k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5835FF802E2;
	Fri, 12 Jun 2020 11:55:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ECEB7F80252; Fri, 12 Jun 2020 11:55:40 +0200 (CEST)
Received: from jazz.pogo.org.uk (jazz.pogo.org.uk [213.138.114.167])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ADA51F8021E
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 11:55:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ADA51F8021E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=pogo.org.uk header.i=@pogo.org.uk
 header.b="fGmj5Aoe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pogo.org.uk
 ; s=a;
 h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
 Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NtUWw1ZaFiaubZotRN+aKom7e/OBmHLdxc7fGbsNeAo=; b=fGmj5AoeZLi23NcL07fzOjUfz3
 NdoS9RaiL+kp1CfOmvoSc+fLDk+9sif2Dc0TmrW7aZ/kj0xyL/O3qNERais7wqtT8xI3opgI6XF9b
 7AItWhDm++nrUSJnpxze6cxVlIjRwdqi7ymJMXl2uUGJOU3LCoR4HS9mv38ifCeyP52+L8zriPakx
 E+y/U0JEUryv72FQRapNAghIYgA/NelQfYWuRwlaxJgVnge93j8FdTsoKZOjQIa9SLB9kaIH3AxSg
 SXSGWulwLzazn4qWKyOS3SuhBmb4XCaaTkN+VZPxyGrAbgIULPwV+0QYfr9ivAhSFfLzIi42qTEY0
 PN6z/EQg==;
Received: from cpc1-hari17-2-0-cust102.20-2.cable.virginm.net ([86.18.4.103]
 helo=stax.localdomain) by jazz.pogo.org.uk with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93.0.4 (FreeBSD))
 (envelope-from <mark@xwax.org>)
 id 1jjgPK-000ATU-Hz; Fri, 12 Jun 2020 10:55:30 +0100
Received: from mark by stax.localdomain with local (Exim 4.84)
 (envelope-from <mark@stax.localdomain>)
 id 1jjgPK-00012i-6R; Fri, 12 Jun 2020 10:55:30 +0100
From: Mark Hills <mark@xwax.org>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 1/9] control: Fix typos in the namehint example
Date: Fri, 12 Jun 2020 10:55:22 +0100
Message-Id: <20200612095530.3970-1-mark@xwax.org>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <2006121020220.23374@stax.localdomain>
References: <2006121020220.23374@stax.localdomain>
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

Ths "namehint" is a list, and there doesn't seem to have been any
history where the separator would be a colon.
---
 src/control/namehint.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/control/namehint.c b/src/control/namehint.c
index ecd470f3..d81d3a7e 100644
--- a/src/control/namehint.c
+++ b/src/control/namehint.c
@@ -543,10 +543,10 @@ static int add_software_devices(snd_config_t *config, snd_config_t *rw_config,
  * User-defined hints are gathered from namehint.IFACE tree like:
  *
  * <code>
- * namehint.pcm {<br>
+ * namehint.pcm [<br>
  *   myfile "file:FILE=/tmp/soundwave.raw|Save sound output to /tmp/soundwave.raw"<br>
- *   myplug "plug:front:Do all conversions for front speakers"<br>
- * }
+ *   myplug "plug:front|Do all conversions for front speakers"<br>
+ * ]
  * </code>
  *
  * Note: The device description is separated with '|' char.
-- 
2.17.5

