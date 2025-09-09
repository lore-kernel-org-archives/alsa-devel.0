Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA5ACAC583
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Sep 2025 14:57:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C76C460203;
	Tue,  9 Sep 2025 16:57:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C76C460203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1757429832;
	bh=w4gB1mLnwTW96nJfXudqHNe3hcEF+zW/paQjHHagFZk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=GOER/QZn6+iy+rU0leGsolPbPq9ZYVE4a5OI/0E1IEO5aK5khzFCQ6zK1D3PSLOqk
	 aRvLMOIq4Z6NvJLtMjnil3YcLB4YYEbjuQuN8NuvF6w4tq1eMPKAZOhW2PLtZev7P0
	 tff82cPb+Nlrch5NnRlTk/p3ZtTEH7/laT8h/rdE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9A49FF805D5; Tue,  9 Sep 2025 16:56:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 43CBEF8027B;
	Tue,  9 Sep 2025 16:56:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6EFBFF8027B; Tue,  9 Sep 2025 16:56:27 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id DA756F800B8
	for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2025 16:56:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA756F800B8
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1863a513c1b40600-webhooks-bot@alsa-project.org>
In-Reply-To: <1863a513bff15c00-webhooks-bot@alsa-project.org>
References: <1863a513bff15c00-webhooks-bot@alsa-project.org>
Subject: Segfault in snd_config_delete due to incorrect node deletion in
 parse_array_def / parse_def
Date: Tue,  9 Sep 2025 16:56:27 +0200 (CEST)
Message-ID-Hash: 32C2G3TPUSX7QIZQTEB6AF5SNDPCXXPP
X-Message-ID-Hash: 32C2G3TPUSX7QIZQTEB6AF5SNDPCXXPP
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/32C2G3TPUSX7QIZQTEB6AF5SNDPCXXPP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtbGliIGlzc3VlICM0Nzcgd2FzIG9wZW5lZCBmcm9tIG1pZHppc2hp
OgoKV2hpbGUgZnV6emluZyBzbmRfY29uZmlnX2xvYWQoKSBhIHJlcHJvZHVjaWJsZSBzZWdtZW50
YXRpb24gZmF1bHQgaW5zaWRlIHNuZF9jb25maWdfZGVsZXRlKCkgd2FzIGRpc2NvdmVyZWQuCgpU
aGUgcm9vdCBjYXVzZSBpcyBpbmNvcnJlY3QgY2xlYW51cCBsb2dpYyBpbiB0aGUgY29uZmlndXJh
dGlvbiBwYXJzZXIgZnVuY3Rpb25zIChwYXJzZV9hcnJheV9kZWYoKSBhbmQgcGFyc2VfZGVmKCkp
LgoKSW4gbXVsdGlwbGUgYnJhbmNoZXMsIGV4aXN0aW5nIGNvbmZpZ3VyYXRpb24gbm9kZXMgYXJl
IHJlcGxhY2VkIGluY29ycmVjdGx5OgoKLSBUaGUgcGFyc2VyIHNvbWV0aW1lcyBjYWxscyBzbmRf
Y29uZmlnX2RlbGV0ZShuKSB3aGVyZSBuIGlzIE5VTEwgb3IgYSBuZXdseSBhbGxvY2F0ZWQgbm9k
ZSwgaW5zdGVhZCBvZiBkZWxldGluZyB0aGUgZXhpc3Rpbmcgbm9kZSByZXR1cm5lZCBieSBfc25k
X2NvbmZpZ19zZWFyY2goKSAodmFyaWFibGUgZykuCi0gSW4gb3RoZXIgY2FzZXMsIGEgbmV3bHkg
Y3JlYXRlZCBub2RlIGlzIGFkZGVkIHRvIHRoZSBwYXJlbnQgYmVmb3JlIGl0cyBjb250ZW50cyBh
cmUgc3VjY2Vzc2Z1bGx5IHBhcnNlZC4gSWYgcGFyc2luZyBmYWlscywgdGhlIHJvbGxiYWNrIHBh
dGggZGVsZXRlcyB0aGlzIG5vZGUgZXhwbGljaXRseSwgYW5kIGxhdGVyIHRoZSBwYXJlbnQgZGVs
ZXRlcyBpdCBhZ2FpbiBkdXJpbmcgcmVjdXJzaXZlIGNsZWFudXAsIHNvIGl0IGNhdXNlcyBkb3Vi
bGUtZnJlZSBvciBjb3JydXB0ZWQgbGlua2VkIGxpc3QuCgpUaGlzIHJlc3VsdHMgaW4gY29ycnVw
dGVkIHBhcmVudOKAk2NoaWxkIHJlbGF0aW9uc2hpcHMgYW5kIGV2ZW50dWFsbHkgU0VHViB3aGVu
IHNuZF9jb25maWdfZGVsZXRlKCkgdHJpZXMgdG8gcmVhZCBjb25maWctPnJlZmNvdW50IG9mIGFu
IGFscmVhZHkgZnJlZWQgbm9kZS4KCkluIGJvdGggcGFyc2VfYXJyYXlfZGVmKCkgYW5kIHBhcnNl
X2RlZigpLCBfc25kX2NvbmZpZ19tYWtlX2FkZCgpIGlzIGNhbGxlZCB0b28gZWFybHkgKGJlZm9y
ZSBwYXJzaW5nIGNoaWxkIGNvbnRlbnRzKS4gT24gZXJyb3IsIHRoZSBwYXJzZXIgZGVsZXRlcyB0
aGUgY2hpbGQgbWFudWFsbHksIGJ1dCB0aGUgcGFyZW50IHdpbGwgbGF0ZXIgZGVsZXRlIGl0IGFn
YWluIGR1cmluZyByZWN1cnNpdmUgY2xlYW51cC4KClByb3Bvc2VkIGZpeDogCmBgYApkaWZmIC0t
Z2l0IGEvc3JjL2NvbmYuYyBiL3NyYy9jb25mLmMKaW5kZXggOTA1YzhmNGQuLjdlNDAzMTkyIDEw
MDY0NAotLS0gYS9zcmMvY29uZi5jCisrKyBiL3NyYy9jb25mLmMKQEAgLTEyNzQsNyArMTI3NCw4
IEBAIHN0YXRpYyBpbnQgcGFyc2VfYXJyYXlfZGVmKHNuZF9jb25maWdfdCAqcGFyZW50LCBpbnB1
dF90ICppbnB1dCwgaW50ICppZHgsIGludCBzCiAJCQlzbnByaW50ZihzdGF0aWNfaWQsIHNpemVv
ZihzdGF0aWNfaWQpLCAiJWkiLCAqaWR4KTsKIAkJCWlmIChfc25kX2NvbmZpZ19zZWFyY2gocGFy
ZW50LCBzdGF0aWNfaWQsIC0xLCAmZykgPT0gMCkgewogCQkJCWlmIChvdmVycmlkZSkgewotCQkJ
CQlzbmRfY29uZmlnX2RlbGV0ZShuKTsKKwkJCQkJc25kX2NvbmZpZ19kZWxldGUoZyk7CisJCQkJ
CWcgPSBOVUxMOwogCQkJCX0gZWxzZSB7CiAJCQkJCS8qIG1lcmdlICovCiAJCQkJCSgqaWR4KSsr
OwpAQCAtMTMwNSw3ICsxMzA2LDcgQEAgc3RhdGljIGludCBwYXJzZV9hcnJheV9kZWYoc25kX2Nv
bmZpZ190ICpwYXJlbnQsIGlucHV0X3QgKmlucHV0LCBpbnQgKmlkeCwgaW50IHMKIAkJCQkJZ290
byBfX2VuZDsKIAkJCQl9CiAJCQl9IGVsc2UgewotCQkJCWVyciA9IF9zbmRfY29uZmlnX21ha2Vf
YWRkKCZuLCAmaWQsIFNORF9DT05GSUdfVFlQRV9DT01QT1VORCwgcGFyZW50KTsKKwkJCQllcnIg
PSBfc25kX2NvbmZpZ19tYWtlKCZuLCAmaWQsIFNORF9DT05GSUdfVFlQRV9DT01QT1VORCk7CiAJ
CQkJaWYgKGVyciA8IDApCiAJCQkJCWdvdG8gX19lbmQ7CiAJCQl9CkBAIC0xMzI4LDYgKzEzMjks
MTAgQEAgc3RhdGljIGludCBwYXJzZV9hcnJheV9kZWYoc25kX2NvbmZpZ190ICpwYXJlbnQsIGlu
cHV0X3QgKmlucHV0LCBpbnQgKmlkeCwgaW50IHMKIAkJCWVyciA9IExPQ0FMX1VORVhQRUNURURf
Q0hBUjsKIAkJCWdvdG8gX19lbmQ7CiAJCX0KKwkJaWYgKCFza2lwICYmIG4gJiYgIW4tPnBhcmVu
dCkgeworCQkJZXJyID0gc25kX2NvbmZpZ19hZGQocGFyZW50LCBuKTsKKwkJCWlmIChlcnIgPCAw
KSB7IHNuZF9jb25maWdfZGVsZXRlKG4pOyBnb3RvIF9fZW5kOyB9CisJCX0KIAkJYnJlYWs7CiAJ
fQogCWRlZmF1bHQ6CkBAIC0xNDIyLDcgKzE0MjcsNyBAQCBzdGF0aWMgaW50IHBhcnNlX2RlZihz
bmRfY29uZmlnX3QgKnBhcmVudCwgaW5wdXRfdCAqaW5wdXQsIGludCBza2lwLCBpbnQgb3ZlcnJp
ZAogCQkJZXJyID0gLUVOT0VOVDsKIAkJCWdvdG8gX19lbmQ7CiAJCX0KLQkJZXJyID0gX3NuZF9j
b25maWdfbWFrZV9hZGQoJm4sICZpZCwgU05EX0NPTkZJR19UWVBFX0NPTVBPVU5ELCBwYXJlbnQp
OworCQllcnIgPSBfc25kX2NvbmZpZ19tYWtlKCZuLCAmaWQsIFNORF9DT05GSUdfVFlQRV9DT01Q
T1VORCk7CiAJCWlmIChlcnIgPCAwKQogCQkJZ290byBfX2VuZDsKIAkJbi0+dS5jb21wb3VuZC5q
b2luID0gdHJ1ZTsKQEAgLTE0NjQsNyArMTQ2OSw3IEBAIHN0YXRpYyBpbnQgcGFyc2VfZGVmKHNu
ZF9jb25maWdfdCAqcGFyZW50LCBpbnB1dF90ICppbnB1dCwgaW50IHNraXAsIGludCBvdmVycmlk
CiAJCQkJCWdvdG8gX19lbmQ7CiAJCQkJfQogCQkJfSBlbHNlIHsKLQkJCQllcnIgPSBfc25kX2Nv
bmZpZ19tYWtlX2FkZCgmbiwgJmlkLCBTTkRfQ09ORklHX1RZUEVfQ09NUE9VTkQsIHBhcmVudCk7
CisJCQkJZXJyID0gX3NuZF9jb25maWdfbWFrZSgmbiwgJmlkLCBTTkRfQ09ORklHX1RZUEVfQ09N
UE9VTkQpOwogCQkJCWlmIChlcnIgPCAwKQogCQkJCQlnb3RvIF9fZW5kOwogCQkJfQpAQCAtMTQ4
Myw2ICsxNDg4LDEwIEBAIHN0YXRpYyBpbnQgcGFyc2VfZGVmKHNuZF9jb25maWdfdCAqcGFyZW50
LCBpbnB1dF90ICppbnB1dCwgaW50IHNraXAsIGludCBvdmVycmlkCiAJCQllcnIgPSBMT0NBTF9V
TkVYUEVDVEVEX0NIQVI7CiAJCQlnb3RvIF9fZW5kOwogCQl9CisJCWlmICghc2tpcCAmJiBuICYm
ICFuLT5wYXJlbnQpIHsKKwkJCWVyciA9IHNuZF9jb25maWdfYWRkKHBhcmVudCwgbik7CisJCQlp
ZiAoZXJyIDwgMCkgeyBzbmRfY29uZmlnX2RlbGV0ZShuKTsgZ290byBfX2VuZDsgfQorCQl9CiAJ
CWJyZWFrOwogCX0KIAlkZWZhdWx0OgoKYGBgCgpJc3N1ZSBVUkwgICAgIDogaHR0cHM6Ly9naXRo
dWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLWxpYi9pc3N1ZXMvNDc3ClJlcG9zaXRvcnkgVVJMOiBo
dHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtbGliCg==
