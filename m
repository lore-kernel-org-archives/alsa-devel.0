Return-Path: <SRS0=AXUI=KO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CB3C433B4
	for <alsa-devel@archiver.kernel.org>; Wed, 19 May 2021 05:50:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52F9761364
	for <alsa-devel@archiver.kernel.org>; Wed, 19 May 2021 05:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F9761364
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D22E51674;
	Wed, 19 May 2021 07:49:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D22E51674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621403401;
	bh=/bQut9Zw5uSRlrRAwq3IJB9MGB5Kw6NL8Ux8H6vIUX0=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=RA26t4JBCcjlzYnDx5zbUulrullsgvUr+wIOu/F/un0cNC+1MrEsTM6xsOpyFT95E
	 bdrPPjQUJ6QT77+yFRqV7M0in3woMCun5xYvsMxySJvaJ3xPZsC8qWhhCGMBwBSByy
	 XRRKHTB4zlV56RzXVeDrFymXb8fN4zKJ6Dzp5ncc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56B7CF8014C;
	Wed, 19 May 2021 07:49:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 72AC0F8016E; Wed, 19 May 2021 07:49:09 +0200 (CEST)
Received: from mail4.protonmail.ch (mail4.protonmail.ch [185.70.40.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C08C8F80148
 for <alsa-devel@alsa-project.org>; Wed, 19 May 2021 07:49:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C08C8F80148
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.b="B567oXRf"
Date: Wed, 19 May 2021 05:48:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail; t=1621403339;
 bh=vRqoG97gqF+ayQpXfchSUikxlLdezQJf6W5GrO4nu0g=;
 h=Date:To:From:Reply-To:Subject:From;
 b=B567oXRfF64tZe1WWdfek65uDOleUi4yE4ew2KqFycL8NIAa7MvRcsL2C0gM8gKk2
 do4Ai5XdSZft4FCe2lU809CWQ5ziwy27hQBQFO1DW+3ae8nITY05iRLue3YoWkhYUM
 FWM+ohACggW9G9RuPFd4DbrwZCScTQhG7KUNAvps=
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
From: "re.mcclue" <re.mcclue@protonmail.com>
Subject: Intel HDA Driver Issue With PCM RW Interleaved
Message-ID: <3GXvg2z0sYlmlwylckstDNNXwCFBbCbPmclFAPK-zN6DMEdtpCMZFcNRVpCSGt9IccFbdl8ci5_hRe92wTsFpbwCEpLMAr3Yg4D60LjEbyU=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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
Reply-To: "re.mcclue" <re.mcclue@protonmail.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

SSdtIHRyeWluZyB0byBwbGF5IFBDTSBidWZmZXIgc2luZ2xlIHRocmVhZGVkIHdpdGhvdXQgYnVm
ZmVyIHVuZGVycnVuLgpQcm9ncmFtIHNvdXJjZTogaHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20vdGFr
YXN3aWUvZDhhOTU1M2MyMzA5NzFkOTc0YTNkZmM3NTliMmZmNjcKKHN0cnVjdCBzbmRfcGNtX3N3
X3BhcmFtcykuc3RhcnRfdGhyZXNob2xkIGlzIGFsdGVyZWQgc28gYXMgdG8gYWxsb3cgc3BlY2lm
eWluZyB0aGUgc3RhcnQgb2YgYXVkaW8gZnJhbWUgdHJhbnNtaXNzaW9uIGFuZCBwcmV2ZW50IHVu
ZGVycnVuIGlzc3Vlcy4KSW4gbXkgYXBwbGljYXRpb24sIG9uIGlvY3RsKGZkLCBTTkRSVl9QQ01f
SU9DVExfU1RBVFVTLCAmc3RhdHVzKSwgSSByZWNlaXZlOiBGaWxlIGRlc2NyaXB0b3IgaW4gYmFk
IHN0YXRlCk91dHB1dCBvZiAkKGRtZXNnKSBpczogWyA2OS4wMTMwODRdIHNuZF9oZGFfaW50ZWwg
MDAwMDowMDoxZi4zOiBUb28gYmlnIGFkanVzdG1lbnQgMTI4CldoYXQgaXMgY2F1c2luZyB0aGlz
IGlzc3VlIGFuZCBob3cgY2FuIEkgc29sdmUgaXQ/ClRoYW5rcwoKU2VudCB3aXRoIFtQcm90b25N
YWlsXShodHRwczovL3Byb3Rvbm1haWwuY29tKSBTZWN1cmUgRW1haWwu
