Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6198FFB5E85
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2026 23:09:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E0C4601EF;
	Tue, 17 Mar 2026 00:08:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E0C4601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773702549;
	bh=OSL8mnNoAcDLOHvdXBFdrNHitBBLjbdecMqGchzoxP8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=NM/2Dry4blOispMoYK3/Us7qwxaBF0MYJ6iSitfmXQkiqAeIythCcPTT42GM9m+Jc
	 d77G/9EZZFxc5YXcsH871sMzuwvXc76Tx6G4xh/zR9hCCgJaEm/xPDN2XHgRWvEVkl
	 3AuHJQEdStL4RYgHy7GuMFn5hl7q8haQ3kAFo8Bs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3CACCF805EF; Tue, 17 Mar 2026 00:08:32 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D59B2F805ED;
	Tue, 17 Mar 2026 00:08:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8C3C1F804F3; Tue, 17 Mar 2026 00:08:25 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E56FBF8012B
	for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2026 00:08:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E56FBF8012B
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189d750788b21f00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/724@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/724@alsa-project.org>
Subject: Roland BridgeCast X - add USB1 support,
 changed channel count from 16 to 14 and changed Labels to more closely match
 Rolands Software.
Date: Tue, 17 Mar 2026 00:08:25 +0100 (CET)
Message-ID-Hash: NIIV5YW4POFHWBWD3VRKIP2SCXE3UT3H
X-Message-ID-Hash: NIIV5YW4POFHWBWD3VRKIP2SCXE3UT3H
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NIIV5YW4POFHWBWD3VRKIP2SCXE3UT3H/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM3MjQgd2FzIG9wZW5lZCBm
cm9tIFAtdi1EOgoKTW9zdCBpbXBvcnRhbnRseSB0aGlzIFBSIGFkZHMgc3VwcG9ydCBmb3IgdGhl
IFVTQjEgcG9ydCBvbiB0aGUgZGV2aWNlIHZpYSBSZWdleCAoaSB1c2VkIHRoZSBST0RFQ2FzdGVy
IFBybyBJSSBlbnRyeSBhcyBhbiBmb3JtYXR0aW5nIGV4YW1wbGUpLg0KSXQgYWxzbyBjaGFuZ2Vz
IHRoZSBjb21tZW50cyBvZiB0aGUgZGlmZmVyZW50IEF1ZGlvIERldmljZXMgdG8gbW9yZSBjbG9z
ZWx5IG1hdGNoIHRoZSBSb2xhbmQgbGFiZWxzLCBpIGFsc28gY2hhbmdlZCB0aGUgY2hhbm5lbCBj
b3VudCBmcm9tIDE2IHRvIDE0LiBNeSBkZXZpY2Ugb25seSBzaG93cyAxNCBjaGFubmVscyBpIGNh
bid0IHNlZW0gdG8gZW5hYmxlIDE2IGNoYW5uZWxzIHJlZ2FyZGxlc3Mgb2Ygc2V0dGluZ3MuDQpJ
dCBjb3VsZCBiZSByZWxhdGVkIHRvIHZpcnR1YWwgc3Vycm91bmQgc291bmQgb3IgVVNCIHBvcnRz
IGJ1dCBpIGRpZCBub3QgZ2V0IHRoaXMgd29ya2luZy4gTWF5YmUgYSBzZWNvbmQgY29uZmlnIGlz
IG5lZWRlZCB0byBhY2NvbW1vZGF0ZSB0aGUgYXBwYXJlbnRseSBkaWZmZXJlbnQgY2hhbm5lbCBj
b3VudHM/DQoNCg0KU3lzdGVtIFNwZWNzOg0KYGBgDQpPcGVyYXRpbmcgU3lzdGVtOiBDYWNoeU9T
IExpbnV4DQpLREUgUGxhc21hIFZlcnNpb246IDYuNi4yDQpLREUgRnJhbWV3b3JrcyBWZXJzaW9u
OiA2LjI0LjANClF0IFZlcnNpb246IDYuMTAuMg0KS2VybmVsIFZlcnNpb246IDYuMTkuNy0xLWNh
Y2h5b3MgKDY0LWJpdCkNCkdyYXBoaWNzIFBsYXRmb3JtOiBXYXlsYW5kDQpQcm9jZXNzb3JzOiAx
NiDDlyBBTUQgUnl6ZW4gNyA1NzAwWDNEIDgtQ29yZSBQcm9jZXNzb3INCk1lbW9yeTogNjQgR2lC
IG9mIFJBTSAoNjIuNyBHaUIgdXNhYmxlKQ0KR3JhcGhpY3MgUHJvY2Vzc29yOiBBTUQgUmFkZW9u
IFJYIDkwNzAgWFQNCmBgYA0KDQpSb2xhbmQgQnJpZGdlQ2FzdCBYOg0KRmlybXdhcmUgVjMuMCAt
IFNFUCAyMDI1DQpDb25uZWN0ZWQgdmlhIFVTQi0xDQoNCmNhdCAvcHJvYy9hc291bmQvY2FyZDAv
c3RyZWFtMCBnYXZlIHRoZSBGb2xsb3dpbmcgT3V0cHV0Og0KDQpgYGANClJvbGFuZCBCUklER0Ug
Q0FTVCBYLUkgVjIgYXQgdXNiLTAwMDA6MDk6MDAuMS0yLCBoaWdoIHNwZWVkIDogVVNCIEF1ZGlv
DQoNClBsYXliYWNrOg0KICBTdGF0dXM6IFJ1bm5pbmcNCiAgICBJbnRlcmZhY2UgPSAxDQogICAg
QWx0c2V0ID0gMQ0KICAgIFBhY2tldCBTaXplID0gMzkyDQogICAgTW9tZW50YXJ5IGZyZXEgPSA0
ODAwMCBIeiAoMHg2LjAwMDApDQogIEludGVyZmFjZSAxDQogICAgQWx0c2V0IDENCiAgICBGb3Jt
YXQ6IFMzMl9MRQ0KICAgIENoYW5uZWxzOiAxNA0KICAgIEVuZHBvaW50OiAweDBkICgxMyBPVVQp
IChBU1lOQykNCiAgICBSYXRlczogNDgwMDANCiAgICBEYXRhIHBhY2tldCBpbnRlcnZhbDogMTI1
IHVzDQogICAgQml0czogMjQNCiAgICBDaGFubmVsIG1hcDogRkwgRlIgRkMgTEZFIFJMIFJSIEZM
QyBGUkMgUkMgU0wgU1IgVEMgLS0gLS0NCiAgICBTeW5jIEVuZHBvaW50OiAweDhlICgxNCBJTikN
CiAgICBTeW5jIEVQIEludGVyZmFjZTogMg0KICAgIFN5bmMgRVAgQWx0c2V0OiAxDQogICAgSW1w
bGljaXQgRmVlZGJhY2sgTW9kZTogWWVzDQoNCkNhcHR1cmU6DQogIFN0YXR1czogU3RvcA0KICBJ
bnRlcmZhY2UgMg0KICAgIEFsdHNldCAxDQogICAgRm9ybWF0OiBTMzJfTEUNCiAgICBDaGFubmVs
czogNg0KICAgIEVuZHBvaW50OiAweDhlICgxNCBJTikgKEFTWU5DKQ0KICAgIFJhdGVzOiA0ODAw
MA0KICAgIERhdGEgcGFja2V0IGludGVydmFsOiAxMjUgdXMNCiAgICBCaXRzOiAyNA0KICAgIENo
YW5uZWwgbWFwOiBGTCBGUiBGQyBMRkUgUkwgUlINCiAgICBTeW5jIEVuZHBvaW50OiAweDBkICgx
MyBPVVQpDQogICAgU3luYyBFUCBJbnRlcmZhY2U6IDENCiAgICBTeW5jIEVQIEFsdHNldDogMQ0K
ICAgIEltcGxpY2l0IEZlZWRiYWNrIE1vZGU6IFllcw0KYGBgCgpSZXF1ZXN0IFVSTCAgIDogaHR0
cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25mL3B1bGwvNzI0ClBhdGNo
IFVSTCAgICAgOiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYv
cHVsbC83MjQucGF0Y2gKUmVwb3NpdG9yeSBVUkw6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXBy
b2plY3QvYWxzYS11Y20tY29uZgo=
