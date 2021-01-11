Return-Path: <SRS0=maC8=GO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CE3C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 09:57:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E76822AAD
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 09:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E76822AAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F257516A9;
	Mon, 11 Jan 2021 10:56:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F257516A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610359066;
	bh=cAZu7S70mi3NkmOTLsHAHbWrZvNYRuXq3kPfV2Fw5Y4=;
	h=To:Subject:In-Reply-To:From:Date:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=Z6kqd/9HaikQkBYisNck/t2hRQq+d7pYOnoiVXgYfnHtCCEUenO/RvJ6w6F5H6Fhq
	 STh/yjL/NqrO3sNrOPdBIjOeGx1HV3/EOF6pfWWFs0AMM0/rHuI6aN96+qwA1+H2FN
	 nYZ+YRT4+x45qRyDacOVVwtGDaMXsZsx0xCgMSms=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77A9DF8016C;
	Mon, 11 Jan 2021 10:56:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A059F8016D; Mon, 11 Jan 2021 10:56:53 +0100 (CET)
Received: from m176148.mail.qiye.163.com (m176148.mail.qiye.163.com
 [59.111.176.148])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57C7FF8013D
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2021 10:56:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57C7FF8013D
Received: from vivo.com (wm-8.qy.internal [127.0.0.1])
 by m176148.mail.qiye.163.com (Hmail) with ESMTP id 568541A493A;
 Mon, 11 Jan 2021 17:56:37 +0800 (CST)
Message-ID: <AJsAUwACDs*x8qLUpTvPvKqR.3.1610358997320.Hmail.zhucancan@vivo.com>
To: Colin King <colin.king@canonical.com>
Subject: =?UTF-8?B?UmU6W1BBVENIXVtuZXh0XSBBU29DOiBzb2MtcGNtOiBGaXggdW5pbml0aWFsaXNlZCByZXR1cm4gdmFsdWUgaW4gdmFyaWFibGUgcmV0?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.232
In-Reply-To: <20210108123546.19601-1-colin.king@canonical.com>
MIME-Version: 1.0
Received: from zhucancan@vivo.com( [58.251.74.232) ] by ajax-webmail (
 [127.0.0.1] ) ; Mon, 11 Jan 2021 17:56:37 +0800 (GMT+08:00)
From: =?UTF-8?B?5pyx54G/54G/?= <zhucancan@vivo.com>
Date: Mon, 11 Jan 2021 17:56:37 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
 oVCBIfWUFZS0sYQkpJSE5PHktLVkpNSktITkNCQkxIQkNVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
 FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1LQklKTkpPQ0xPN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
 WUc6MQg6Lgw6OD8IUQNDCjcuCy8NKw0wCilVSFVKTUpLSE5DQkJMTE5KVTMWGhIXVQETDhgaFRga
 FTsNEg0UVRgUFkVZV1kSC1lBWU5DVUlOSlVMT1VJSElZV1kIAVlBTkxOQzcG
X-HM-Tid: 0a76f0e0416d9394kuws568541a493a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
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

QWdyZWUsIHRoYW5rcy4KCgo+Cj5DdXJyZW50bHkgd2hlbiBhdHRlbXB0aW5nIHRvIHN0YXJ0IHRo
ZSBCRSBmYWlscyBiZWNhdXNlIHRoZQo+RkUgaXMgbm90IHN0YXJ0ZWQgdGhlIGVycm9yIHJldHVy
biB2YXJpYWJsZSByZXQgaXMgbm90IGluaXRpYWxpemVkCj5hbmQgZ2FyYmFnZSBpcyByZXR1cm5l
ZC4gIEZpeCB0aGlzIGJ5IHNldHRpbmcgaXQgdG8gMCBzbyB0aGUKPmNhbGxlciBkb2VzIG5vdCBy
ZXBvcnQgdGhlIGVycm9yICJBU29DOiBmYWlsZWQgdG8gc2h1dGRvd24gc29tZSBCRXMiCj5hbmQg
YmVjYXVzZSB0aGlzIGZhaWx1cmUgcGF0aCBoYXMgYWxyZWFkeSByZXBvcnRlZCB0aGUgcmVhc29u
IGZvcgo+dGhlIGVhcmx5IHJldHVybi4KPgo+QWRkcmVzc2VzLUNvdmVyaXR5OiAoIlVuaW5pdGlh
bGl6ZWQgc2NhbGFyIHZhcmlhYmxlIikKPkZpeGVzOiAyYzEzODI4NDBjMTkgKCJBU29DOiBzb2Mt
cGNtOiBkaXNjb25uZWN0IEJFcyBpZiB0aGUgRkUgaXMgbm90IHJlYWR5IikKPlNpZ25lZC1vZmYt
Ynk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+Cj4tLS0KPiBzb3Vu
ZC9zb2Mvc29jLXBjbS5jIHwgMSArCj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4K
PmRpZmYgLS1naXQgYS9zb3VuZC9zb2Mvc29jLXBjbS5jIGIvc291bmQvc29jL3NvYy1wY20uYwo+
aW5kZXggNDgxYTRhMjVhY2IwLi5iNzg3Y2U0Y2ViNWEgMTAwNjQ0Cj4tLS0gYS9zb3VuZC9zb2Mv
c29jLXBjbS5jCj4rKysgYi9zb3VuZC9zb2Mvc29jLXBjbS5jCj5AQCAtMjQ0Myw2ICsyNDQzLDcg
QEAgc3RhdGljIGludCBkcGNtX3J1bl91cGRhdGVfc3RhcnR1cChzdHJ1Y3Qgc25kX3NvY19wY21f
cnVudGltZSAqZmUsIGludCBzdHJlYW0pCj4gCQlmZS0+ZHBjbVtzdHJlYW1dLnN0YXRlID09IFNO
RF9TT0NfRFBDTV9TVEFURV9DTE9TRSkgewo+IAkJZGV2X2VycihmZS0+ZGV2LCAiQVNvQzogRkUg
JXMgaXMgbm90IHJlYWR5ICVkXG4iLAo+IAkJCWZlLT5kYWlfbGluay0+bmFtZSwgZmUtPmRwY21b
c3RyZWFtXS5zdGF0ZSk7Cj4rCQlyZXQgPSAwOwo+IAkJZ290byBkaXNjb25uZWN0Owo+IAl9Cj4g
Cj4tLSAKPjIuMjkuMgo+CgoKDQoNCg==
