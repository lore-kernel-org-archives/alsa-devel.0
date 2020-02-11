Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C9DC352A3
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 10:23:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011DF20714
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 10:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JhdauHtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011DF20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F40D86E;
	Tue, 11 Feb 2020 11:22:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F40D86E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581416595;
	bh=juDTutxUmTbKNKmp9kzSP5vpDsX8vA0WT4r+4E8UJZE=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JhdauHtbKEPtv0jcLSI+i6MNeDFlct1tazQB2ZLuMM/j9LQZQiJPaiZxQfFGhE2gF
	 8N+/aQgG/t2XTfDH80KmSq2NhFe8yxRY1trirXwlOR4Ky0dnDg0mddtPX+Z9i+vFlt
	 hjc/2XGVjSzYfkQyTKg4/3Rcj4RA7DF2pmwBJXLo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D71ECF8013E;
	Tue, 11 Feb 2020 11:22:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 04411F80145; Tue, 11 Feb 2020 11:22:23 +0100 (CET)
Received: from mx1.emlix.com (mx1.emlix.com [188.40.240.192])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81F9BF800E7;
 Tue, 11 Feb 2020 11:22:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81F9BF800E7
Received: from mailer.emlix.com (unknown [81.20.119.6])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id B53CB5FB81;
 Tue, 11 Feb 2020 11:22:18 +0100 (CET)
From: Rolf Eike Beer <eb@emlix.com>
To: patch@alsa-project.org
Date: Tue, 11 Feb 2020 11:22:18 +0100
Message-ID: <5948808.FfnTCzJfH2@devpool35>
Organization: emlix GmbH
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH] do not set close-on-exec flag on descriptor if
	it was already set
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

VGhlcmUgaXMgbm8gbmVlZCB0byBzZXQgdGhpcyBhZ2FpbiBpZiBPX0NMT0VYRUMgaXMgc3VwcG9y
dGVkLgoKU2lnbmVkLW9mZi1ieTogUm9sZiBFaWtlIEJlZXIgPGViQGVtbGl4LmNvbT4KLS0tCiBp
bmNsdWRlL2xvY2FsLmggfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9sb2NhbC5oIGIvaW5jbHVkZS9sb2NhbC5oCmluZGV4IGVhMGVj
MzJkLi5lZDZiYTkzNiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9sb2NhbC5oCisrKyBiL2luY2x1ZGUv
bG9jYWwuaApAQCAtMzIwLDggKzMyMCwxMCBAQCBzdGF0aWMgaW5saW5lIGludCBzbmRfb3Blbl9k
ZXZpY2UoY29uc3QgY2hhciAqZmlsZW5hbWUsIGludCBmbW9kZSkKIAkJCWZkID0gcnNtX29wZW5f
ZGV2aWNlKGZpbGVuYW1lLCBmbW9kZSk7CiAJfQogI2VuZGlmCisjaWZuZGVmIE9fQ0xPRVhFQwog
CWlmIChmZCA+PSAwKQogCQlmY250bChmZCwgRl9TRVRGRCwgRkRfQ0xPRVhFQyk7CisjZW5kaWYK
IAlyZXR1cm4gZmQ7CiB9CiAKLS0gCjIuMjUuMAoKCi0tIApSb2xmIEVpa2UgQmVlciwgZW1saXgg
R21iSCwgaHR0cDovL3d3dy5lbWxpeC5jb20KRm9uICs0OSA1NTEgMzA2NjQtMCwgRmF4ICs0OSA1
NTEgMzA2NjQtMTEKR290aGFlciBQbGF0eiAzLCAzNzA4MyBHw7Z0dGluZ2VuLCBHZXJtYW55ClNp
dHogZGVyIEdlc2VsbHNjaGFmdDogR8O2dHRpbmdlbiwgQW10c2dlcmljaHQgR8O2dHRpbmdlbiBI
UiBCIDMxNjAKR2VzY2jDpGZ0c2bDvGhydW5nOiBIZWlrZSBKb3JkYW4sIERyLiBVd2UgS3JhY2tl
IOKAkyBVc3QtSWROci46IERFIDIwNSAxOTggMDU1CgplbWxpeCAtIHNtYXJ0IGVtYmVkZGVkIG9w
ZW4gc291cmNlCgpCZXN1Y2hlbiBTaWUgdW5zIGF1ZiBkZXIgRW1iZWRkZWQgV29ybGQgMjAyMCBp
biBOw7xybmJlcmchCi0+IEhhbGxlIDQsIFN0YW5kIDM2OAoKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNh
LWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
