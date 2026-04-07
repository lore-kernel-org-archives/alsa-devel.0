Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BABE9D814
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2026 06:50:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 958D7601F3;
	Tue,  7 Apr 2026 08:50:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 958D7601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775544611;
	bh=VFsvKy/b/ecGGEH6mUJtNF4/GqhCrea5tce/bqntlgU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=t74oItve8K4ISttjdG4oniIeDleqxBvSZ6RG0E7XxkoqugGDJn08B6bHbAzhjvizy
	 ObuJlBFHe28tvxTQMh8efE4C5yc8Ert2DuRiIRL9CnUazhErSpzcisXTBf5Vl8bAW3
	 bntnjiqDZn7bVFa6Ta/98s72KeZDCCOQBV8XhOMU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CB08CF805F6; Tue,  7 Apr 2026 08:49:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9974FF805EC;
	Tue,  7 Apr 2026 08:49:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3CCFFF80548; Tue,  7 Apr 2026 08:49:26 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D632F8001F
	for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2026 08:49:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D632F8001F
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a4005f7a54c000-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/739@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/739@alsa-project.org>
Subject: 
 =?utf-8?q?ucm2=3A_Focusrite_Scarlett_18i20_Gen_1_=E2=80=94_fix_USB_ID?=
Date: Tue,  7 Apr 2026 08:49:26 +0200 (CEST)
Message-ID-Hash: 3OP3XPTC5Y5IFJVARHSWDIRSSRQPQQYB
X-Message-ID-Hash: 3OP3XPTC5Y5IFJVARHSWDIRSSRQPQQYB
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3OP3XPTC5Y5IFJVARHSWDIRSSRQPQQYB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM3Mzkgd2FzIG9wZW5lZCBm
cm9tIGdlb210bjoKCiMjIFN1bW1hcnkNCg0KVGhlIGRldmljZSBtYXRjaGluZyByZWdleCBmb3Ig
dGhlIEZvY3Vzcml0ZSBTY2FybGV0dCAxOGkyMCBzZXJpZXMgaW4gYFVTQi1BdWRpby5jb25mYCB1
c2VzIGFuIHVwcGVyY2FzZSBgQ2AgaW4gdGhlIEdlbiAxIHByb2R1Y3QgSUQgKGA4MDBDYCksIGJ1
dCBrZXJuZWwgcmVwb3J0cyBVU0IgY29tcG9uZW50IElEcyBpbiBsb3dlcmNhc2UgKGA4MDBjYCku
IFRoZSByZWdleCBpcyBjYXNlLXNlbnNpdGl2ZSwgc28gdGhlIEdlbiAxIGRldmljZSBuZXZlciBt
YXRjaGVzIGFuZCB0aGUgVUNNIHByb2ZpbGUgZmFpbHMgdG8gbG9hZCBlbnRpcmVseS4NCg0KVGhp
cyBpcyB0aGUgcmVtYWluaW5nIHBpZWNlIG9mIHRoZSBHZW4gMSBVQ00gYnJlYWthZ2UgcmVwb3J0
ZWQgaW4gIzU4OCDigJQgdGhlIEFEQVQgY2hhbm5lbCBjb3VudCBpc3N1ZSB3YXMgYWRkcmVzc2Vk
IGJ5ICM3MzEgKGNvbW1pdCAxN2I0OGIxKSwgYnV0IHRoZSBkZXZpY2UgbmV2ZXIgcmVhY2hlcyB0
aGUgcHJvZmlsZSBhdCBhbGwgZHVlIHRvIHRoaXMgZWFybGllciBtYXRjaCBmYWlsdXJlLg0KDQoq
Tm90ZSwgQ2xhdWRlLUNvZGUgd2FzIGhlYXZpbHkgZGVwZW5kZWQgb24gZm9yIHRoZSB0cm91Ymxl
c2hvb3RpbmcsIGxvY2FsIGJ1ZyBmaXgsIGFuZCB0ZXN0aW5nLioNCg0KLS0tDQoNCiMjIERldGFp
bHMNCg0KSW4gYHVjbTIvVVNCLUF1ZGlvL1VTQi1BdWRpby5jb25mYCwgdGhlIFNjYXJsZXR0IDE4
aTIwIG1hdGNoaW5nIGJsb2NrIHVzZXM6DQoNCmBgYA0KUmVnZXggIlVTQjEyMzU6OCgwMEN8Migw
MXwxKDV8ZCkpKSINCmBgYA0KDQpUaGUga2VybmVsIHJlcG9ydHMgdGhlIEdlbiAxIGNvbXBvbmVu
dCBzdHJpbmcgYXMgYFVTQjEyMzU6ODAwY2AgKGxvd2VyY2FzZSkuIEJlY2F1c2UgdGhlIHJlZ2V4
IGlzIGNhc2Utc2Vuc2l0aXZlIGFuZCBvbmx5IG1hdGNoZXMgYDgwMENgLCB0aGUgYFByb2ZpbGVO
YW1lYCB2YXJpYWJsZSBpcyBuZXZlciBzZXQgYW5kIHRoZSBsb2FkZXIgaGl0cyB0aGUgZmFsbGJh
Y2sgZXJyb3I6DQoNCmBgYA0KVHJ1ZS5FcnJvciAiVUNNIGlzIG5vdCBzdXBwb3J0ZWQgZm9yIHRo
aXMgVVNCIGRldmljZSAoJHtDYXJkTG9uZ05hbWV9IEAgJHtDYXJkQ29tcG9uZW50c30pIg0KYGBg
DQoNClRoaXMgY2F1c2VzIFdpcmVQbHVtYmVyIHRvIHJlcG9ydCB0aGUgZGV2aWNlIGFzIGBbQUxT
QSBVQ00gZXJyb3JdYCBhbmQgcmVmdXNlIHRvIGxvYWQgYW55IHByb2ZpbGUgZm9yIGl0Lg0KDQpU
aGUgb3RoZXIgSURzIGluIHRoZSBzYW1lIHJlZ2V4IOKAlCBgODIwMWAsIGA4MjE1YCwgYDgyMWRg
IOKAlCBhcmUgYWxyZWFkeSBsb3dlcmNhc2UgYW5kIG1hdGNoIGNvcnJlY3RseS4gT25seSB0aGUg
R2VuIDEgYDgwMENgIGlzIGluY29uc2lzdGVudC4NCg0KLS0tDQoNCiMjIEZpeA0KDQpgYGBkaWZm
DQotLS0gYS91Y20yL1VTQi1BdWRpby9VU0ItQXVkaW8uY29uZg0KKysrIGIvdWNtMi9VU0ItQXVk
aW8vVVNCLUF1ZGlvLmNvbmYNCkBAIC0xICsxIEBADQotCQlSZWdleCAiVVNCMTIzNTo4KDAwQ3wy
KDAxfDEoNXxkKSkpIg0KKwkJUmVnZXggIlVTQjEyMzU6OCgwMGN8MigwMXwxKDV8ZCkpKSINCmBg
YA0KDQpTYW1lIHNpbmdsZS1jaGFyYWN0ZXIgY2hhbmdlIGFwcGxpZXMgdG8gYHVjbTIvY29uZi5k
L1VTQi1BdWRpby9VU0ItQXVkaW8uY29uZmAuDQoNCi0tLQ0KDQojIyBUZXN0aW5nDQoNClRlc3Rl
ZCBvbiBGb2N1c3JpdGUgU2NhcmxldHQgMThpMjAgR2VuIDEgKGBVU0IxMjM1OjgwMGNgKSB3aXRo
Og0KLSBLZXJuZWw6IDYuMTkuMTAtemVuMS0xLXplbiAoQXJjaCBMaW51eCkNCi0gUGlwZVdpcmUg
LyBXaXJlUGx1bWJlcg0KLSBgYWxzYS11Y20tY29uZmAgMS4yLjE1LjMNCg0KV2l0aCBib3RoIHRo
aXMgZml4IGFuZCB0aGUgQURBVCBjaGFubmVsIGNvdW50IGZpeCBmcm9tICM3MzEgYXBwbGllZCwg
dGhlIGRldmljZSBsb2FkcyB3aXRob3V0IFVDTSBlcnJvcnMgYW5kIGFsbCBvdXRwdXQgcG9ydHMg
ZW51bWVyYXRlIGNvcnJlY3RseS4NCg0KV2l0aG91dCB0aGlzIGZpeCwgdGhlIEFEQVQgY2hhbm5l
bCBjb3VudCBmaXggaW4gIzczMSBoYXMgbm8gZWZmZWN0IGZvciBHZW4gMSB1c2VycyDigJQgdGhl
IHByb2ZpbGUgbWF0Y2ggZmFpbHMgYmVmb3JlIHRoZSBIaUZpIGNvbmZpZ3VyYXRpb24gaXMgZXZl
ciByZWFjaGVkLg0KDQotLS0NCg0KIyMgUmVsYXRlZA0KDQotIEZpeGVzICM1ODgg4oCUIEZvY3Vz
cml0ZSBTY2FybGV0dCAxOGkyMCBHZW4gMTogVUNNIGNvbmZpZ3VyYXRpb24gZmFpbHMgdG8gbG9h
ZA0KLSBSZWxhdGVkIHRvICM1NTkg4oCUIEFMU0EgVUNNIGVycm9yIGZvciBTY2FybGV0dCAxOGky
MCBHZW4gMiAoQURBVCBjaGFubmVsIGNvdW50IGFkZHJlc3NlZCBieSAjNzMxKQoKUmVxdWVzdCBV
UkwgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZi9wdWxs
LzczOQpQYXRjaCBVUkwgICAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNh
LXVjbS1jb25mL3B1bGwvNzM5LnBhdGNoClJlcG9zaXRvcnkgVVJMOiBodHRwczovL2dpdGh1Yi5j
b20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYK
