Return-Path: <SRS0=ZBV5=4O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339DAC4BA0D
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 05:34:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D4D21927
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 05:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bUONfRv6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UAtOqdCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D4D21927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 14D55166E;
	Wed, 26 Feb 2020 06:33:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 14D55166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582695287;
	bh=14JEIM/qZPscSn9G3bHWOWhpgQp4kmhPDVuby2vEDqU=;
	h=To:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bUONfRv6P3wPqGG7+0yHEbJ9CkPySUaL9QZ8DJro8tiHSiqioD5p9gkCQ39A0TUe1
	 3WcPD8kdAO8wuOGCGNowza/lTekJzGku55efFBVCXA75+85J7zHo+D2OCHRUujemfO
	 iMRp2+RBqPFYQiqcofEuUzXaNnsAR+vR59iLmkHw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B8C3F8014D;
	Wed, 26 Feb 2020 06:33:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 60BDFF800E8; Wed, 26 Feb 2020 06:33:29 +0100 (CET)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B1B2F800E8
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2020 06:33:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B1B2F800E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="UAtOqdCt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=R7FlMG+Bvduqa3vWTZsVfXNdv+eGdfaeXD+EX3Ia40U=; b=UAtOqdCtIa1gxxR3pMDq5JylXx
 azJWmvIewLWXM6fb3Qjt9wQI3hbwOlkb4pWp67FpIdIpxhf1bvjRPtdR//pAk7Knftf0K37ER/U6q
 S+M704BB8ttr7c2kSFC5WOuxhse7/+E6qzczur9bqiLXOW3XatonRS0zQP1fQl0eJq3jh2mtnLLST
 PBMXdDZq4uXi7rRYMojn0xEezZKWxQHQWR8WY2iHrnMeISKUtwpjLykJ5SG+rCgQsyA+jhxCCt4U1
 1MvkeUIh20O0dwFwssEe8rDixIIp+GeBCjMGC8MekJj26ctgW2NaTqBzb8VShYmhprBK8h0i4PP8L
 UXStqNzQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6pJV-0002Pr-Ll; Wed, 26 Feb 2020 05:32:53 +0000
To: LKML <linux-kernel@vger.kernel.org>,
 moderated for non-subscribers <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.de>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] sound: korg1212: fix if-statement empty body warnings
Message-ID: <91fb1e97-a773-5790-3f65-8198403341e1@infradead.org>
Date: Tue, 25 Feb 2020 21:32:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

From: Randy Dunlap <rdunlap@infradead.org>

Fix gcc warnings when -Wextra is used by using an empty do-while
block instead of <nothing>.  Fixes these build warnings:

../sound/pci/korg1212/korg1212.c:674:44: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:708:43: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:730:43: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:853:43: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:1013:44: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:1035:43: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:1052:43: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:1066:43: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:1087:43: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:1094:43: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:1208:43: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../sound/pci/korg1212/korg1212.c:2360:102: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
 sound/pci/korg1212/korg1212.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200225.orig/sound/pci/korg1212/korg1212.c
+++ linux-next-20200225/sound/pci/korg1212/korg1212.c
@@ -30,7 +30,7 @@
 #if K1212_DEBUG_LEVEL > 0
 #define K1212_DEBUG_PRINTK(fmt,args...)	printk(KERN_DEBUG fmt,##args)
 #else
-#define K1212_DEBUG_PRINTK(fmt,...)
+#define K1212_DEBUG_PRINTK(fmt,...)	do { } while (0)
 #endif
 #if K1212_DEBUG_LEVEL > 1
 #define K1212_DEBUG_PRINTK_VERBOSE(fmt,args...)	printk(KERN_DEBUG fmt,##args)

