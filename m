Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E92FED2F1
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2026 08:54:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A341601FA;
	Thu, 12 Mar 2026 09:53:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A341601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773305638;
	bh=bqBE5Nrk8+Kxxe00u3YB3+fdnAsA4gyre+mSjK3ugJM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=lY0t2IMFWVKyGWwYZDDUMb8mXQVhTjOW0livAcQv8sqBgKNZCTGCMU0PjV/NlyX8d
	 62nBWDfANAu/QUrcVuFI0r46ugXJU3IcmhXbk83Z0fMU4Bfg/TvR448oeKBdpjYtYM
	 qjVZEx5YLHV+7BdxplB5NYEyEGA6bNVbIgZdVHB0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83FE6F805F1; Thu, 12 Mar 2026 09:53:24 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E8FF7F805F4;
	Thu, 12 Mar 2026 09:53:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5294AF8045D; Thu, 12 Mar 2026 09:53:16 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B96CF80095
	for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2026 09:53:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B96CF80095
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189c0c0ab960cb00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/721@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/721@alsa-project.org>
Subject: HDA: swap Speaker/Headphones PlaybackPriority
Date: Thu, 12 Mar 2026 09:53:16 +0100 (CET)
Message-ID-Hash: MLQGQM6RSNQQUHJMKVKUGZHEWBDLVNYR
X-Message-ID-Hash: MLQGQM6RSNQQUHJMKVKUGZHEWBDLVNYR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MLQGQM6RSNQQUHJMKVKUGZHEWBDLVNYR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM3MjEgd2FzIG9wZW5lZCBm
cm9tIHpvbW11dGVyOgoKRml4ZXMgIzcyMCwgYXNzaXN0ZWQgYnkgQ2xhdWRlIENvZGUgT3B1cyA0
LjYNCg0KIyMgU3VtbWFyeQ0KDQotIFN3YXAgYFBsYXliYWNrUHJpb3JpdHlgIGluIGB1Y20yL0hE
QS9IaUZpLWFuYWxvZy5jb25mYDogU3BlYWtlciAxMDDihpIyMDAsIEhlYWRwaG9uZXMgMjAw4oaS
MTAwDQoNCiMjIFByb2JsZW0NCg0KT24gZGV2aWNlcyB3aGVyZSBTcGVha2VyIGFuZCBIZWFkcGhv
bmVzIHNoYXJlIHRoZSBzYW1lIFBDTSAoZS5nLiBgaHc6c29maGRhZHNwYCksIFBpcGVXaXJlL0FD
UCBnZW5lcmF0ZXMgc2VwYXJhdGUgbXV0dWFsbHkgZXhjbHVzaXZlIHByb2ZpbGVzLiBXaXRoIHRo
ZSBjdXJyZW50IHByaW9yaXRpZXMsIHRoZSBIZWFkcGhvbmVzIHByb2ZpbGUgKDEwMzAwKSBpcyBw
cmVmZXJyZWQgb3ZlciB0aGUgU3BlYWtlciBwcm9maWxlICgxMDIwMCkgd2hlbmV2ZXIgYm90aCBh
cmUgYGF2YWlsYWJsZWAuDQoNClRoaXMgY2F1c2VzIHRoZSBTcGVha2VyIHNpbmsgdG8gKipjb21w
bGV0ZWx5IHZhbmlzaCoqIHdoZW4gYW4gSERNSSBtb25pdG9yIGlzIGNvbm5lY3RlZDogdGhlIEhE
TUkgcG9ydCBiZWNvbWluZyBhdmFpbGFibGUgbWFrZXMgYm90aCBwcm9maWxlcyBgYXZhaWxhYmxl
OiB5ZXNgLCBhbmQgV2lyZVBsdW1iZXIgc2VsZWN0cyB0aGUgaGlnaGVyLXByaW9yaXR5IEhlYWRw
aG9uZXMgcHJvZmlsZSDigJQgZXZlbiB3aGVuIHRoZSBIZWFkcGhvbmUgSmFjayByZXBvcnRzIGBv
ZmZgIChub3RoaW5nIHBsdWdnZWQgaW4pLg0KDQpXaXRob3V0IEhETUksIHRoZSBIZWFkcGhvbmVz
IHByb2ZpbGUgaXMgY29ycmVjdGx5IGBhdmFpbGFibGU6IG5vYCAobm8gcG9ydHMgd2l0aCBhdmFp
bGFiaWxpdHkgZ3JvdXBzIHJlcG9ydCBhdmFpbGFibGUpLCBzbyB0aGUgYnVnIG9ubHkgbWFuaWZl
c3RzIHdpdGggSERNSSBjb25uZWN0ZWQuDQoNCiMjIEZpeA0KDQpTd2FwIHRoZSBwcmlvcml0aWVz
IHNvIFNwZWFrZXIgKDIwMCkgPiBIZWFkcGhvbmVzICgxMDApLiBCdWlsdC1pbiBzcGVha2VycyBh
cmUgdGhlIG5hdHVyYWwgZGVmYXVsdCBvdXRwdXQuIFdoZW4gaGVhZHBob25lcyBhcmUgcGx1Z2dl
ZCBpbiwgV2lyZVBsdW1iZXIgZGV0ZWN0cyB0aGUgSGVhZHBob25lIEphY2sgYmVjb21pbmcgYXZh
aWxhYmxlIGFuZCBzd2l0Y2hlcyB0byB0aGUgSGVhZHBob25lcyBwcm9maWxlIGFjY29yZGluZ2x5
Lg0KDQojIyBUZXN0aW5nDQoNClRlc3RlZCBvbiBIUCBPbW5pQm9vayBYIEZsaXAgMTQgKEludGVs
IEx1bmFyIExha2UsIFJlYWx0ZWsgQUxDMjQ1LCBzb2YtaGRhLWRzcCkgd2l0aCBQaXBlV2lyZSAx
LjQuMTAgYW5kIFdpcmVQbHVtYmVyIDAuNS4xMzoNCi0gSERNSSBjb25uZWN0ZWQsIG5vIHNhdmVk
IFdpcmVQbHVtYmVyIHN0YXRlLCBubyBoZWFkcGhvbmVzIHBsdWdnZWQgaW4NCi0gKipCZWZvcmU6
KiogQWN0aXZlIHByb2ZpbGUgPSBIZWFkcGhvbmVzLCBTcGVha2VyIHNpbmsgbWlzc2luZw0KLSAq
KkFmdGVyOioqIEFjdGl2ZSBwcm9maWxlID0gU3BlYWtlciwgU3BlYWtlciBzaW5rIHByZXNlbnQN
Cg0KTm90ZTogSGVhZHBob25lIGphY2sgc3dpdGNoaW5nIChwbHVnZ2luZyBpbiBhY3R1YWwgaGVh
ZHBob25lcykgaGFzIG5vdCBiZWVuIHRlc3RlZCBvbiB0aGlzIGhhcmR3YXJlLiBUaGUgZXhwZWN0
YXRpb24gaXMgdGhhdCBXaXJlUGx1bWJlcidzIGphY2stYmFzZWQgcHJvZmlsZSBzd2l0Y2hpbmcg
aGFuZGxlcyB0aGlzIHJlZ2FyZGxlc3Mgb2YgYmFzZSBwcmlvcml0eS4KClJlcXVlc3QgVVJMICAg
OiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYvcHVsbC83MjEK
UGF0Y2ggVVJMICAgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20t
Y29uZi9wdWxsLzcyMS5wYXRjaApSZXBvc2l0b3J5IFVSTDogaHR0cHM6Ly9naXRodWIuY29tL2Fs
c2EtcHJvamVjdC9hbHNhLXVjbS1jb25mCg==
