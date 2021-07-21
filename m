Return-Path: <SRS0=DIBW=MN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F00C6377A
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jul 2021 20:17:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD2261222
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Jul 2021 20:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD2261222
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tsoy.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A1F2168F;
	Wed, 21 Jul 2021 22:17:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A1F2168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626898673;
	bh=pwICeVEDseZyf81YMabOfLtj9z6wS+3SB2jPLgBb3KI=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hmSL3k95l6h01Bs6SQWoBWlzOHNdrmhP4xqvvWphRM3AIEt95BsCjc8FMo1QorvS/
	 aE+OsQAl0htcM6fw89aA1o7jgopAlle0qWg5WeicSFyI+uWAlsxRrFAbISi1U1q4fl
	 E5SWeuuTzp4A+icb8za8f2cyQ/8x72GRMt4vkzqM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 332F2F804AB;
	Wed, 21 Jul 2021 22:17:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 19589F804AC; Wed, 21 Jul 2021 22:17:01 +0200 (CEST)
Received: from puleglot.ru (puleglot.ru [IPv6:2a01:4f8:1c0c:58e8::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B300F80143
 for <alsa-devel@alsa-project.org>; Wed, 21 Jul 2021 22:16:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B300F80143
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=tsoy.me header.i=@tsoy.me
 header.b="Bpo79JOB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tsoy.me;
 s=mymail; h=Sender:Content-Transfer-Encoding:MIME-Version:Content-Type:
 References:In-Reply-To:Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VBQGKs10jIpkJb2GxXlNLxJwDzedYjfKoTL5TAXMzDs=; b=Bpo79JOBz9VKPdFFBWED1qqEFp
 EgXm5qa+aaWGECPBa39NPx3WU8t1rg/MG4osh734LrQX5bXGk1P4TWEvw1TGSxK8IgsssuDy31RZP
 i85zrhnkb336t4Nr+9P9yxv/ZEWgG1GCcr6+hCmBQaBWpD5xcPNxUwgeQ4S/zD0cS2LQ=;
Received: from [10.8.10.223]
 by puleglot.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <puleglot@puleglot.ru>)
 id 1m6IeC-0005Ux-Lv; Wed, 21 Jul 2021 23:16:51 +0300
Message-ID: <c95dd9ae3e38b8a9965785b6f2b94bcca8df21ea.camel@tsoy.me>
Subject: Re: mic not working on JBL Quantum series USB headsets
From: Alexander Tsoy <alexander@tsoy.me>
To: Jakub =?UTF-8?Q?Fi=C5=A1er?= <jakub@ufiseru.cz>, 
 alsa-devel@alsa-project.org
Date: Wed, 21 Jul 2021 23:16:43 +0300
In-Reply-To: <53ec08048f961a8a2564556e0daa78f0@ufiseru.cz>
References: <53ec08048f961a8a2564556e0daa78f0@ufiseru.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
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

В Вт, 20/07/2021 в 18:00 +0000, Jakub Fišer пишет:
> Hello Alsa people,
> 
> hope this is the right place to post.
> 
> My Quantum 800's microphone doesn't work and I found other reports
> suggesting
> this issue affects the whole Quantum product line.

This device consists of two interfaces. The first interface contains a
single playback endpoint and the second interface contains playback and
capture endpoints. So JBL Quantum probably needs a registration quirk
similar to Kingston HyperX devices. Please try the patch below:

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 8b8bee3c3dd6..f54331892d7a 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1897,6 +1897,7 @@ static const struct registration_quirk registration_quirks[] = {
 	REG_QUIRK_ENTRY(0x0951, 0x16d8, 2),	/* Kingston HyperX AMP */
 	REG_QUIRK_ENTRY(0x0951, 0x16ed, 2),	/* Kingston HyperX Cloud Alpha S */
 	REG_QUIRK_ENTRY(0x0951, 0x16ea, 2),	/* Kingston HyperX Cloud Flight S */
+	REG_QUIRK_ENTRY(0x0ecb, 0x203e, 2),	/* JBL Quantum 800 */
 	{ 0 }					/* terminator */
 };
 


