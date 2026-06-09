Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0099CD98C7
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:59:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 419B56020B;
	Wed, 10 Jun 2026 09:59:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 419B56020B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781078397;
	bh=HWm4DkF3Mf2TnZuAPa4kEWhAGOf7Lxd7r5damhMUGjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nvriyW0AgxPoiRAcnK6Wwpk66DmWjG6csbWxUTMHPk/YjRJ6eP7IL1Gy4MU3LCKbC
	 HYFgZI/P8eIHiK76SOZg9ZvPeDPLHB/mZT1Ff/5dH2hMWFN5THG9ON/86xEDGdVH9E
	 t3kHbWEBZQ0M3idrD9ft3CWVeWNj97YSu8jW80D0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 36609F80672; Wed, 10 Jun 2026 09:58:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D70D8F80675;
	Wed, 10 Jun 2026 09:58:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9AE64F8058C; Wed, 10 Jun 2026 00:26:11 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781043971;
	b=BfEvgzH6NPg9RE5pufPmpuQFUrLmdb19vU9l2awD3Cenj3K2C1V1GWBcMSskc3KpBjJL
	 YagNhAMocR0nndvQ0fkW0AuZi79W7OqL2I/3kqEjkhQAXoj5ojnrCozVlUUQOdtD2EH9K
	 tPxcmEtPRWs9ImyTsJR1qJ/67aMBoZCAA2G2EnNVQtLtDAj4HkBiTpzdx1oy1dhohDG69
	 lxliLjFDdoiMNJHO4mkawrAd+U4J80Qb2LF34nO4bRgbgfqIaI0FxcYC1+M00T9MYgFqI
	 qGOCLtbA7SLU/amMoQEr9Eq7MHEr0Uz47EtwyipM7JlZfWq05UUkkTxvCWIjf641q4Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781043971;
	h=DKIM-Signature:Date:From:To:Subject:MIME-Version:Message-ID;
	bh=HWm4DkF3Mf2TnZuAPa4kEWhAGOf7Lxd7r5damhMUGjw=;
	b=AVU1rpzldeei+ZCuJCVqLsDbXth7Zbex9bJ9M46uiTDwDEvA8kq2pXS86l2WRCg3x/p3
	 WTe3Q9YalsWF0VBx5nheb33ywrCWlf0cqpDAEAauUNQ/a3IcH1gQGwIuiXlSRw/aEqLiz
	 Hf8Q9KvuaXlCU70Tstoc6v3u32HzaOFq9PoTDVARb6NXFY877gRHE0MgXB1XjKgNBV+T+
	 nb708CBcHNqVsb1za+c79bi/tE/QOfdDEjLj+hBkg8bOSR6qDO5jvspD5+b5Tdnqv/dKP
	 ZA7IhqdkNWRiRGFPQSZvQ2r/nZpEzSMfX2T1UsRiT8+P/flCrzr2OTH2zsC5SHwOJGQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=SV5mNrVT;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 46874F8011B
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2026 00:26:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46874F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=SV5mNrVT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=HWm4DkF3Mf2TnZuAPa4kEWhAGOf7Lxd7r5damhMUGjw=; b=S
	V5mNrVTz0OyfcOauMuuAAxlMSj207aPSaghXY5Ynk6yCnnA14q79q4W7L3lU2gd3
	9cxSpEXFOoe4F7fpcpz8M140YmkbUIDEu3MlIuz0NeaVMQPlbt7MpZImgbA5Dz6i
	sUPz1yhrSUTOBaX/lEXDTK1r8TpWqx3ptVNLwLxGwk=
Received: from ks002278$163.com ( [101.241.83.252] ) by
 ajax-webmail-wmsvr-40-114 (Coremail) ; Wed, 10 Jun 2026 06:26:03 +0800
 (CST)
X-Originating-IP: [101.241.83.252]
Date: Wed, 10 Jun 2026 06:26:03 +0800 (CST)
From: "thomas.kuang" <ks002278@163.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [alsa-devel] [BUG] Lenovo ThinkBook 16 G7 QOY (Snapdragon X)
 - No soundcards detected
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <3c28dd62-223c-4447-8cec-c7c527aa49e3@oss.qualcomm.com>
References: <5fc3ab80.a3e2.19ea717f09f.Coremail.ks002278@163.com>
 <3c28dd62-223c-4447-8cec-c7c527aa49e3@oss.qualcomm.com>
X-NTES-SC: 
 AL_Qu2TA/yfvEEt5SmZZukcnEgSg+g2WMS1vvkv24BUc/oEmCf/wAcGX1RuNGXK3v2GMQKqjDetTiBQ+v10batH8oWFFgzNAFQTaGHtxX4F6g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <5c57153a.79.19eae7e2814.Coremail.ks002278@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cigvCgD3d0H8kihq9gQGAA--.37W
X-CM-SenderInfo: dnvqijqsxyqiywtou0bp/xtbC-xuHKGookvu12gAA3P
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-MailFrom: ks002278@163.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: SJC547YKJYEXYUWTNPJMHF3WD6IZFJ6E
X-Message-ID-Hash: SJC547YKJYEXYUWTNPJMHF3WD6IZFJ6E
X-Mailman-Approved-At: Wed, 10 Jun 2026 07:58:51 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SJC547YKJYEXYUWTNPJMHF3WD6IZFJ6E/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

CgpncmVwIF4gL3N5cy9jbGFzcy9yZW1vdGVwcm9jLyovc3RhdGUKL3N5cy9jbGFzcy9yZW1vdGVw
cm9jL3JlbW90ZXByb2MwL3N0YXRlOm9mZmxpbmUKL3N5cy9jbGFzcy9yZW1vdGVwcm9jL3JlbW90
ZXByb2MxL3N0YXRlOm9mZmxpbmUKCgpncmVwIF4gL3N5cy9jbGFzcy9yZW1vdGVwcm9jLyovbmFt
ZQovc3lzL2NsYXNzL3JlbW90ZXByb2MvcmVtb3RlcHJvYzAvbmFtZTphZHNwCi9zeXMvY2xhc3Mv
cmVtb3RlcHJvYy9yZW1vdGVwcm9jMS9uYW1lOmNkc3AKCgoKCgoKCgoKCgpBdCAyMDI2LTA2LTA5
IDE3OjI0OjU3LCAiS29ucmFkIER5YmNpbyIgPGtvbnJhZC5keWJjaW9Ab3NzLnF1YWxjb21tLmNv
bT4gd3JvdGU6Cj5PbiA2LzgvMjYgMTo1NyBQTSwgdGhvbWFzLmt1YW5nIHdyb3RlOgo+PiAKPj4g
Cj4+IEhhcmR3YXJlOiBMZW5vdm8gVGhpbmtCb29rIDE2IEc3IFFPWSAoUXVhbGNvbW0gU25hcGRy
YWdvbiBYIC8gWCBQbHVzIC8gWCBFbGl0ZSkKPj4gS2VybmVsIHZlcnNpb246IDcuMC4wLTIyLWdl
bmVyaWMgKFVidW50dSAyNi4wNCBMVFMpCj4+IEFyY2hpdGVjdHVyZTogYWFyY2g2NAo+PiAKPj4g
UHJvYmxlbSBEZXNjcmlwdGlvbjoKPj4gLS0tLS0tLS0tLS0tLS0tLS0tLQo+PiBBdWRpbyBpcyBu
b3Qgd29ya2luZyBvbiB0aGlzIFNuYXBkcmFnb24gWC1iYXNlZCBsYXB0b3AuIFRoZSBzeXN0ZW0g
ZmFpbHMgdG8gZGV0ZWN0IGFueSBzb3VuZGNhcmRzLAo+PiBldmVuIHRob3VnaCB0aGUgUXVhbGNv
bW0gYXVkaW8gZHJpdmVyIG1vZHVsZXMgYXJlIGxvYWRlZC4KPgo+UGxlYXNlIHBvc3QgdGhlIG91
dHB1dCBvZgo+Cj5ncmVwIF4gL3N5cy9jbGFzcy9yZW1vdGVwcm9jLyovc3RhdGUKPmdyZXAgXiAv
c3lzL2NsYXNzL3JlbW90ZXByb2MvKi9uYW1lCj4KPktvbnJhZAo=
