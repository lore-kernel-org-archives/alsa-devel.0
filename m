Return-Path: <SRS0=oJpy=2F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84355C43603
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Dec 2019 19:53:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 142F524685
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Dec 2019 19:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Do+7PIal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142F524685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=larkos.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D029E1668;
	Sun, 15 Dec 2019 20:52:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D029E1668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576439615;
	bh=Jn0/LieDNh3fCHXa//VQwyi3pI77J+49YhStk9OtOfU=;
	h=From:To:References:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Do+7PIalIRrL7WZVXNY6ahHPpaI5cq1i7WPWA4p2t961LQdOOJ1lbQkORzTSbJcL3
	 WGufM8Q33rbOOqbL3R2K6anAJxWlGD1iHYIYzLh+2AnuEMRek4eVQHVAPG7/hdvG6i
	 lWunvgGfBug2SBvaAq4wUzHvcBGWx8ZnDAli7SfE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DEF89F80264;
	Sun, 15 Dec 2019 20:51:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 992DBF80234; Sun, 15 Dec 2019 19:58:00 +0100 (CET)
Received: from larkos.de (larkos.de [188.68.52.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51982F800CE
 for <alsa-devel@alsa-project.org>; Sun, 15 Dec 2019 19:57:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51982F800CE
Received: from a89-182-230-81.net-htp.de ([89.182.230.81]
 helo=[192.168.178.12])
 by larkos.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <martin@larkos.de>)
 id 1igZ5Y-0007Ur-Qr; Sun, 15 Dec 2019 19:57:57 +0100
From: Martin Regner <martin@larkos.de>
To: tiwai@suse.de
References: <20191202074947.1617-1-tiwai@suse.de>
Message-ID: <e3420134-e0a8-db0e-90b9-258573c4de39@larkos.de>
Date: Sun, 15 Dec 2019 19:57:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191202074947.1617-1-tiwai@suse.de>
Content-Language: de-DE
X-Mailman-Approved-At: Sun, 15 Dec 2019 20:51:50 +0100
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH] ALSA: hda: Modify stream stripe mask only
 when needed
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

SGkgYWdhaW4sCgppIGRpZCBhIGxpdHRsZSBiaXQgb2YgcmVzZWFyY2ggYW5kIG15IGN1cnJlbnQg
c29sdXRpb24gaXMgdGhpcyBwYXRjaDoKCgpkaWZmIC1ydSBhL2luY2x1ZGUvc291bmQvaGRhdWRp
by5oIGIvaW5jbHVkZS9zb3VuZC9oZGF1ZGlvLmgKLS0tIGEvaW5jbHVkZS9zb3VuZC9oZGF1ZGlv
LmjCoMKgIDIwMTktMTItMTUgMTk6NDk6MTUuNzc1Njg5ODczICswMTAwCisrKyBiL2luY2x1ZGUv
c291bmQvaGRhdWRpby5owqDCoCAyMDE5LTEyLTE1IDE5OjQ4OjIzLjQ3NDY4ODU0NSArMDEwMApA
QCAtNDkzLDcgKzQ5Myw3IEBACiDCoMKgwqDCoMKgwqDCoCBib29sIHByZXBhcmVkOjE7CiDCoMKg
wqDCoMKgwqDCoCBib29sIG5vX3BlcmlvZF93YWtldXA6MTsKIMKgwqDCoMKgwqDCoMKgIGJvb2wg
bG9ja2VkOjE7Ci3CoMKgwqDCoMKgwqAgYm9vbCBzdHJpcGU6MTvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC8qIGFwcGx5IHN0cmlwZSBjb250cm9sICovCivCoMKgwqDCoMKgwqAg
Ym9vbCBzdHJpcGU6MDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIGFwcGx5
IHN0cmlwZSBjb250cm9sICovCgogwqDCoMKgwqDCoMKgwqAgLyogdGltZXN0YW1wICovCiDCoMKg
wqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIHN0YXJ0X3dhbGxjbGs7wqDCoMKgIC8qIHN0YXJ0ICsg
bWluaW11bSB3YWxsY2xrICovCmRpZmYgLXJ1IGEvc291bmQvaGRhL2hkYWNfc3RyZWFtLmMgYi9z
b3VuZC9oZGEvaGRhY19zdHJlYW0uYwotLS0gYS9zb3VuZC9oZGEvaGRhY19zdHJlYW0uY8KgwqAg
MjAxOS0xMi0xNSAxOToxNTozNy41MTI1ODM1MjMgKzAxMDAKKysrIGIvc291bmQvaGRhL2hkYWNf
c3RyZWFtLmPCoMKgIDIwMTktMTItMTUgMTk6MTU6NDguOTc2NTg0NTkwICswMTAwCkBAIC0xMjIs
NyArMTIyLDYgQEAKIMKgwqDCoMKgwqDCoMKgIHNuZF9oZGFjX3N0cmVhbV93cml0ZWIoYXp4X2Rl
diwgU0RfU1RTLCBTRF9JTlRfTUFTSyk7IC8qIHRvIGJlIApzdXJlICovCiDCoMKgwqDCoMKgwqDC
oCBpZiAoYXp4X2Rldi0+c3RyaXBlKSB7CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c25kX2hkYWNfc3RyZWFtX3VwZGF0ZWIoYXp4X2RldiwgU0RfQ1RMXzNCLCAKU0RfQ1RMX1NUUklQ
RV9NQVNLLCAwKTsKLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXp4X2Rldi0+c3RyaXBl
ID0gMDsKIMKgwqDCoMKgwqDCoMKgIH0KIMKgwqDCoMKgwqDCoMKgIGF6eF9kZXYtPnJ1bm5pbmcg
PSBmYWxzZTsKIMKgfQoKSSBkb24ndCByZWFsbHkgdW5kZXJzdGFuZCB0aGUgYXBwcm9hY2ggaW4g
dGhlIG9yaWdpbmFsIGNvbW1pdC4gQXMgZmFyIGFzIAppIHVuZGVyc3RhbmQgdGhpcywgdGhlIHN0
cmlwZSBwcm9wZXJ0eSBpcyBpbml0aWFsbHkgc2V0IHRvIDEuCkluIHRoZSBwYXRjaF9oZG1pLmMg
aXQgaXMgc2V0IHRvIDEgaWYgdGhlIEFDX1dDQVBfU1RSSVBFIGZsYWcgaXMgc2V0LiAKRmluYWxs
eSBpdCBpcyBzZXQgdG8gMCBpbiB0aGUgZnVuY3Rpb24gc25kX2hkYWNfc3RyZWFtX2NsZWFyLgoK
V2l0aCB0aGlzIHBhdGNoIHRoZSBzdHJpcGUgcHJvcGVydHkgaXMgaW5pdGlhbGx5IDAsIHNldCB0
byAxIGlmIHRoZSAKQUNfV0NBUF9TVFJJUEUgZmxhZyBpcyBzZXQgYW5kIG5ldmVyIHRvdWNoZWQg
YWdhaW4uCgpVbmZvcnR1bmF0bHkgaSBjYW4ndCB0ZXN0IHRoaXMgb24gYW5vdGhlciBtYWNoaW5l
LgoKS2luZCByZWdhcmRzCgpNYXJ0aW4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1w
cm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2Fsc2EtZGV2ZWwK
