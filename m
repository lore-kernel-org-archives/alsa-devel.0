Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CA1CD98C7
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:32:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A19060229;
	Thu, 11 Jun 2026 21:32:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A19060229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781206349;
	bh=GDueoNOR0Gv19HvxBu/9Lx2vEf5PdMPDk+r3vyyw1/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=g1w62o4v68t21ecd3M+VUoiRNQoITgfOCa5aqw3zzAnkaYAczUjQi1BPcg+VBr9Od
	 vG03GtRqOzWlIA+x/MAPemfkhv5mJTIHjo21BxyLgxuot3OrOzg8Ep6FElYjRPUOKJ
	 eYdCbzkL7WmEvMisLO6q4qCQ6ZOCsQFc93fV2XQA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 33F21F8067F; Thu, 11 Jun 2026 21:31:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F3BE6F8067F;
	Thu, 11 Jun 2026 21:31:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9EB28F8058C; Wed, 10 Jun 2026 15:31:55 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781098315;
	b=o/qWbcxkLRYz1Qxq5GZ+0yp3+h+t7B+/PlU0ZcgD/6K/lD1VherjD3vWTqWjOAVVJWXv
	 3FoCp3gIpFBFYlXK6DwmGK2jj6N5R9uvDoZ4hnUqsG5o5Z41r8RGHV1gI/DYAZT48JALs
	 +Cn4ogfXabTbQUSZTv+1j9Sf/fBXysLCRIfFMmM7tEPRzbHfLsyNFgdLgG9D+CsmHA8QF
	 YATJTOKHppxXPi6izX8iUBj8YFQNvAVoAB3hMU3Fz4wPZ+my/n+phhSeeArxQLhAHkVoH
	 OcICCjVWcosdUX7VjwjgV+CQMfNkcTuRX8E0iDtYVZJQjkNp+66D9Hd5qT6KujNcGNQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781098315;
	h=DKIM-Signature:Date:From:To:Subject:MIME-Version:Message-ID;
	bh=GDueoNOR0Gv19HvxBu/9Lx2vEf5PdMPDk+r3vyyw1/I=;
	b=XYImP2MAMvQVBYbuOW15AEWKoI0uai6P87fSt+Us0fZMVzyAF308ZEI1/5+4Y3Io9jKN
	 DrQegwCGmWhftmjSXie45MxM2BPedZ1aiV/VcvgG56e5LiDfpGlfy3CsbQn1zA3GMi1wy
	 JWS/LOJ0VxmfCxxpCks8cD6RcnHglTETVuftt3neJKdy9cC3IE9RdnOTIIez5GhPazwVH
	 Phyhsr/zO3ER1NPYPqKENEtR6ZWprxNEzECHWTfJ0pq1YIHhqTvxOUkzCmZglYjag7Shf
	 9o69O1mSaWDS1kU8e9ph6HjcJenU1SSY9FTs3ucpgnc0fQe+GhCAzA+w4bCvNhgaaCg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=UBD94fUv;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3A7E2F801F5
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2026 15:31:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A7E2F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=UBD94fUv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=GDueoNOR0Gv19HvxBu/9Lx2vEf5PdMPDk+r3vyyw1/I=; b=U
	BD94fUv/adJBOb6PBaXiJyVdXuylVMTKdXvQ3GDpn2Vkoj2ucyBTFGm8qdEv2Cpx
	IJgCvpwDJZxBAuqfi5wFG31DQnbP7teXthKASWo4ujBh7eb6tU9cvPe2QlTyYgH/
	1SOAaZov3p9OHZF6wOfhTPX0hJsYNTRPHIyNZZ6swQ=
Received: from ks002278$163.com ( [101.241.83.252] ) by
 ajax-webmail-wmsvr-40-100 (Coremail) ; Wed, 10 Jun 2026 21:31:47 +0800
 (CST)
X-Originating-IP: [101.241.83.252]
Date: Wed, 10 Jun 2026 21:31:47 +0800 (CST)
From: "thomas.kuang" <ks002278@163.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re:Re: [alsa-devel] [BUG] Lenovo ThinkBook 16 G7 QOY (Snapdragon X)
 - No soundcards detected
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <0a578098-7003-4048-9c29-affb632c44c9@oss.qualcomm.com>
References: <5fc3ab80.a3e2.19ea717f09f.Coremail.ks002278@163.com>
 <3c28dd62-223c-4447-8cec-c7c527aa49e3@oss.qualcomm.com>
 <5c57153a.79.19eae7e2814.Coremail.ks002278@163.com>
 <0a578098-7003-4048-9c29-affb632c44c9@oss.qualcomm.com>
X-NTES-SC: 
 AL_Qu2TA/ySt0sr4SaaZukcnEgSg+g2WMS1vvkv24BUc+sEqBvX3hwKeG9dNlnW9u+2Kj6xsD6YWj5Fz/9oRplS5bvBRoOdYSWhdbFTo5L5fA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6aac2e60.9b61.19eb1bb6031.Coremail.ks002278@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: ZCgvCgD3nxpDZylq28IGAA--.5737W
X-CM-SenderInfo: dnvqijqsxyqiywtou0bp/xtbC-wPOb2opZ0PFswAA3M
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-MailFrom: ks002278@163.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: SDXJQ2Q745UQPOLEEQ76H7YFW6NNR342
X-Message-ID-Hash: SDXJQ2Q745UQPOLEEQ76H7YFW6NNR342
X-Mailman-Approved-At: Thu, 11 Jun 2026 19:31:20 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SDXJQ2Q745UQPOLEEQ76H7YFW6NNR342/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Cgp3aGVuIHJ1bsKgCnN1ZG8gc2ggLWMgJ2VjaG8gInN0YXJ0IiA+IC9zeXMvY2xhc3MvcmVtb3Rl
cHJvYy9yZW1vdGVwcm9jMC9zdGF0ZScKc3VkbyBzaCAtYyAnZWNobyAic3RhcnQiID4gL3N5cy9j
bGFzcy9yZW1vdGVwcm9jL3JlbW90ZXByb2MxL3N0YXRlJwoKCmRtZXNnIGlzIGZvbGxvd2luZzoK
wqAgNjI1LjkyOTI2NV0gcmVtb3RlcHJvYyByZW1vdGVwcm9jMDogcG93ZXJpbmcgdXAgYWRzcApb
wqAgNjI1LjkyOTI5Nl0gcmVtb3RlcHJvYyByZW1vdGVwcm9jMDogRGlyZWN0IGZpcm13YXJlIGxv
YWQgZm9yIHFjb20veDFwNDIxMDAvTEVOT1ZPLzIxTkgvcWNhZHNwODM4MC5tYm4gZmFpbGVkIHdp
dGggZXJyb3IgLTIKW8KgIDYyNS45MjkyOTldIHJlbW90ZXByb2MgcmVtb3RlcHJvYzA6IHJlcXVl
c3RfZmlybXdhcmUgZmFpbGVkOiAtMgpbwqAgNjI1LjkyOTMwMl0gcmVtb3RlcHJvYyByZW1vdGVw
cm9jMDogQm9vdCBmYWlsZWQ6IC0yClvCoCA2MjUuOTM2NTI5XSByZW1vdGVwcm9jIHJlbW90ZXBy
b2MxOiBwb3dlcmluZyB1cCBjZHNwClvCoCA2MjUuOTM2NTUyXSByZW1vdGVwcm9jIHJlbW90ZXBy
b2MxOiBEaXJlY3QgZmlybXdhcmUgbG9hZCBmb3IgcWNvbS94MXA0MjEwMC9MRU5PVk8vMjFOSC9x
Y2Nkc3A4MzgwLm1ibiBmYWlsZWQgd2l0aCBlcnJvciAtMgpbwqAgNjI1LjkzNjU1NV0gcmVtb3Rl
cHJvYyByZW1vdGVwcm9jMTogcmVxdWVzdF9maXJtd2FyZSBmYWlsZWQ6IC0yClvCoCA2MjUuOTM2
NTU3XSByZW1vdGVwcm9jIHJlbW90ZXByb2MxOiBCb290IGZhaWxlZDogLTIKCgoKCgoKCgoKCgoK
CkF0IDIwMjYtMDYtMTAgMTg6MzI6NDMsICJLb25yYWQgRHliY2lvIiA8a29ucmFkLmR5YmNpb0Bv
c3MucXVhbGNvbW0uY29tPiB3cm90ZToKPk9uIDYvMTAvMjYgMTI6MjYgQU0sIHRob21hcy5rdWFu
ZyB3cm90ZToKPj4gCj4+IAo+PiBncmVwIF4gL3N5cy9jbGFzcy9yZW1vdGVwcm9jLyovc3RhdGUK
Pj4gL3N5cy9jbGFzcy9yZW1vdGVwcm9jL3JlbW90ZXByb2MwL3N0YXRlOm9mZmxpbmUKPj4gL3N5
cy9jbGFzcy9yZW1vdGVwcm9jL3JlbW90ZXByb2MxL3N0YXRlOm9mZmxpbmUKPj4gCj4+IAo+PiBn
cmVwIF4gL3N5cy9jbGFzcy9yZW1vdGVwcm9jLyovbmFtZQo+PiAvc3lzL2NsYXNzL3JlbW90ZXBy
b2MvcmVtb3RlcHJvYzAvbmFtZTphZHNwCj4+IC9zeXMvY2xhc3MvcmVtb3RlcHJvYy9yZW1vdGVw
cm9jMS9uYW1lOmNkc3AKPgo+VHJ5IHdyaXRpbmcgc3RhcnQgaW50byA+IC9zdGF0ZQo+Cj5UaGlz
IHdpbGwgYXR0ZW1wdCB0byBwb3dlciBvbiB0aGUgRFNQcywgbW9zdCBpbXBvcnRhbnRseSB0aGUg
QSh1ZGlvKURTUAo+d2hpY2ggaXMgbmVjZXNzYXJ5IGZvciBhdWRpbyB0byB3b3JrLiBJZiB0aGF0
IGZhaWxzLCBjaGVjayBkbWVzZyBhcyB5b3UKPm1heSBiZSBtaXNzaW5nIHNvbWUgZmlybXdhcmUg
ZmlsZXMuCj4KPktvbnJhZAo=
