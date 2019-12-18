Return-Path: <SRS0=OYz8=2I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_ADSP_ALL,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3DBC43603
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:21:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1DB21D7D
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="URzJ7a92";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=svenschwermer.de header.i=@svenschwermer.de header.b="UGEixSlL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1DB21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=svenschwermer.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 31961852;
	Wed, 18 Dec 2019 09:20:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 31961852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576657279;
	bh=26tKXJ7ozvlAwNsIcKLAll62iTjEzsdFOI6lmaDyJD4=;
	h=From:Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=URzJ7a92KmrlZFr54I6y+EFys5MVuV3WWmlzs3xbQNWEWYv1Ew46EXhSKawXeFGEu
	 SQsGLOAXc/1AcfBW+IWp4apepYbP9zuM+Qf1T2hksHZueB5Oq9Zb1M1TEb7G6fkLgJ
	 yfXjQv3fLpyFaA4767nWJsVQ8FqnLfxwxL7+zHQ8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B21B8F8015A;
	Wed, 18 Dec 2019 09:20:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E080AF8022C; Wed, 18 Dec 2019 09:20:26 +0100 (CET)
Received: from mail.sven-schwermer.de (mail.sven-schwermer.de [116.203.52.77])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43865F8014C
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2019 09:20:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43865F8014C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=svenschwermer.de header.i=@svenschwermer.de
 header.b="UGEixSlL"
From: Sven Schwermer <sven@svenschwermer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
 s=mail; t=1576657223;
 bh=1w53jQHE0B0//mcC4Ho2jG3mkun608d/MJUaKtF6EpA=;
 h=From:Subject:Cc:To;
 b=UGEixSlLRAGO1zQLi2zzY0PjEZXAYMNzeIdQg8vP9ZhXuU9hG753VaMpDjav6+sVo
 6kBM0B8rv/jFJgnAq3PQMwTlZqsmMpMgK8AqPVZnLGvBsiP8QCYMj3NKI4agf141+s
 ceU3iu9rQRtnq2XrnFz/jKHrFBQ0892mqlwAxEfbvfJAuEGW0VbdT7cKzmBEN4ih+e
 b+3lmg9PDIA7cMOyZ9X/A5J9qosll3E613MYYEQz/s7A1o+yWfD3fTGfKuDOao8cru
 i8emBjMJMKATCT94tF3q/Oj/YYPEQTtHdGg9aPa3EOTLzZhE6RZpC5HqOsVIHlQ2F9
 lU2Nd/68zQT8A==
Mime-Version: 1.0
Message-Id: <6978DC0D-29C5-4E81-ACCF-5A2C4041FDD7@svenschwermer.de>
Date: Wed, 18 Dec 2019 09:20:22 +0100
To: alsa-devel@alsa-project.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [alsa-devel] TI McASP: Independent RX & TX
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

SGksCgpJ4oCZbSBsb29raW5nIGF0IGhvb2tpbmcgdXAgdHdvIGNvZGVjcyB0byBhIHNpbmdsZSBB
TTMzNTjigJlzIE1jQVNQIGluc3RhbmNlLiBPbmUgY29kZWMgd2lsbCBiZSBob29rZWQgdXAgdG8g
dGhlIHJlY2VpdmUgc2VjdGlvbiB3aGlsZSB0aGUgb3RoZXIgb25lIHdpbGwgYmUgaG9va2VkIHVw
IHRvIHRoZSB0cmFuc21pdCBzZWN0aW9uLiBCQ0xLLCBNQ0xLIGFuZCBmb3JtYXQgd2lsbCBub3Qg
bmVjZXNzYXJpbHkgYmUgc2hhcmVkIGFuZCBtYXkgZGlmZmVyLiBBcyBmYXIgYXMgSSB1bmRlcnN0
YW5kLCB0aGUgTWNBU1AgYWxsb3dzIHRvIG9wZXJhdGUgcmVjZWl2ZSBhbmQgdHJhbnNtaXQgcHJl
dHR5IG11Y2ggaW5kZXBlbmRlbnRseS4KCkxvb2tpbmcgYXQgdGhlIEFTb0MgZHJpdmVyIChkYXZp
bmNpLW1jYXNwLmMpLCBob3dldmVyLCBpdCBzZWVtcyB0byBtZSB0aGF0IGl0IGlzIG5vdCByZWFs
bHkgcG9zc2libGUgdG8gdXNlIHJlY2VpdmUgYW5kIHRyYW5zbWl0IGluZGVwZW5kZW50bHkuIElz
IHRoYXQgY29ycmVjdD8gSXMgdGhhdCBwYXJ0aWN1bGFyIHVzZSBjYXNlIG5vdCB3aXRoaW4gdGhl
IHNjb3BlIG9mIHRoZSBjdXJyZW50IGRyaXZlciBvciBpcyBteSBpbml0aWFsIGFzc3VtcHRpb24g
d3JvbmcgdGhhdCB0cmFuc21pdCBhbmQgcmVjZWl2ZSBhcmUgYmFzaWNhbGx5IGluZGVwZW5kZW50
PwoKQW55IHBvaW50ZXJzIGFyZSBhcHByZWNpYXRlZC4KCkJlc3QgcmVnYXJkcywKU3ZlbgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1h
aWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFs
c2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
