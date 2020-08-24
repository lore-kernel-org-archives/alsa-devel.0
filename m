Return-Path: <SRS0=/b47=CC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AA6C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2020 00:03:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2BEE20720
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2020 00:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HdetqOeO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u2LVtBXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2BEE20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48F4984D;
	Mon, 24 Aug 2020 02:02:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48F4984D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598227414;
	bh=Etmm19EdKH5+qt9qthmtvTehGNnSrbuLFT7c+/OhOVw=;
	h=To:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HdetqOeOUrf5we4ytLWbB0V0v/sGx/R3pREN7+dHVuZJnHN4+CPe6j0MbhcVu/fTn
	 KIipcEktZRwt5RDzy7re3vWUZUki0uJtXrV4YlFZbsSJitDI0g83PUhqxFlWxIZn9k
	 ILmv6gvZNyw0PlX1tCsC0qE6rk2ffhhJwiKU+/5I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CEF02F800C0;
	Mon, 24 Aug 2020 02:02:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 14DA6F8025A; Mon, 24 Aug 2020 02:02:42 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4C6E1F800EB
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2020 02:02:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C6E1F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="u2LVtBXO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=p5Qc68KZfangV2bqxREUc+eShqFQXctpwYrlmpxjIr8=; b=u2LVtBXOpVCWkjmFnz56jg0W6X
 lMQd5XnkdBCTw1c1ZJ28jHHvaEgNpA9VHyNjlCOZOo4+PCoxVDbBaYYpDkl9a/PU81lfdxndFzBej
 Ce4/xsnSBDiSt+uARqwnekKbUf23tse6eiCOC4UOAEErL4IbkVYC6N2hSLOo0tux2hrNxV7LDUddQ
 nLP5Dtu/nLIJJeoxEOXz6OfFHzUQ7TyG1kJNToumrbmUJissHgIEh12VBmsAYJVSB4Y40/cPF9Hgh
 phDxmIcGUCRVkxPHb+UPUkd38eIBzuK7FGA2LwiuGQ+o/dkUwySI4mQ4qfi/dUt/g2jtLyGeHyjuw
 7q8fU0fg==;
Received: from [2601:1c0:6280:3f0::19c2]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k9zwQ-0002Vm-87; Mon, 24 Aug 2020 00:02:26 +0000
To: LKML <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 moderated for non-subscribers <alsa-devel@alsa-project.org>,
 "Alexander A. Klimov" <grandmaster@al2klimov.de>,
 Takashi Iwai <tiwai@suse.de>, Jonathan Corbet <corbet@lwn.net>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: sound/cards: fix heading underline lengths for
 https: changes
Message-ID: <357ee576-32a2-6e2b-1db6-78be39253846@infradead.org>
Date: Sun, 23 Aug 2020 17:02:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Fix documentation build warnings for underline length too short,
caused by s/http/https/ and not changing the accompanying underlines.

Documentation/sound/cards/audigy-mixer.rst:335: WARNING: Title underline too short.
US Patents (https://www.uspto.gov/)
----------------------------------

Documentation/sound/cards/sb-live-mixer.rst:340: WARNING: Title underline too short.
US Patents (https://www.uspto.gov/)
----------------------------------

Fixes: 7ed33ea6b4fa ("ALSA: Replace HTTP links with HTTPS ones")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander A. Klimov <grandmaster@al2klimov.de>
Cc: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/cards/audigy-mixer.rst  |    2 +-
 Documentation/sound/cards/sb-live-mixer.rst |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- lnx-59-rc2.orig/Documentation/sound/cards/audigy-mixer.rst
+++ lnx-59-rc2/Documentation/sound/cards/audigy-mixer.rst
@@ -332,7 +332,7 @@ WO 9901953 (A1)
 
 
 US Patents (https://www.uspto.gov/)
-----------------------------------
+-----------------------------------
 
 US 5925841
 	Digital Sampling Instrument employing cache memory (Jul. 20, 1999)
--- lnx-59-rc2.orig/Documentation/sound/cards/sb-live-mixer.rst
+++ lnx-59-rc2/Documentation/sound/cards/sb-live-mixer.rst
@@ -337,7 +337,7 @@ WO 9901953 (A1)
 
 
 US Patents (https://www.uspto.gov/)
-----------------------------------
+-----------------------------------
 
 US 5925841
 	Digital Sampling Instrument employing cache memory (Jul. 20, 1999)

