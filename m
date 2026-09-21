Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20637C982ED
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:39:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A61D3601F3;
	Mon, 21 Sep 2026 14:39:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A61D3601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789994382;
	bh=E16M8xFFUL3ADajX161EYOdhFiFX2jIEMstg13axVEc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=HPY8W8aQs/mxWou2pP3HRhQqgWQZUeqDhmfHmsA/qPi9bAFnCdfnekPUXfqjNbPFn
	 sL1C1IYl+dRmGBOU/pYbL+2iOpDmvYq0R5vqeBHeg1w0Z3vVpV8S6BWWzL2EOZMs5S
	 7jeEPc6ad9aVUMw2lyFW57J56Bm3Df8kh0yIixOM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BCD5AF805FC; Mon, 21 Sep 2026 14:39:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6ABFFF805ED;
	Mon, 21 Sep 2026 14:39:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A0EDBF804F3; Mon, 21 Sep 2026 14:39:02 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789994341;
	b=MdWACbSZ1UYbz3tmo3LGXAyyPnsvg7HszONeDR0qvrwNBl/ZN6s7o5Ra+UQN//Cz7hFH
	 aC2qfn8uW1olvkCuYYDWUkBSYapKtTNzbfFIQLYoLT9yNqjnQlUS6+jz9zq7lFRrG6Yqp
	 US46Dsa79QxIg3BstLN2lMGU3PExyGpM/zmIIMj/lNTd5Lsr98A/6bKxzXSXW0f6PtBDU
	 8+NAvqPmVqB1/7i1MHK8Hze4N3LAodUqPg/YX07mrVw1HxZBATv8hcRa7fbsy/PLcYP3G
	 VAVb+NentoRytOvgEfkNYavqRyn0o/ybzx7asqXpUA/pfj4vh3RL4osVblTLsn35BAw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789994341;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=E16M8xFFUL3ADajX161EYOdhFiFX2jIEMstg13axVEc=;
	b=YG5Kwz5+FePupC6/mWuj7JprJbb+u/QRF6q30a/KvcgeAC55sl19oTwOEUgTDWBmhSyt
	 7gUVc6XC6oBWuaGJd86gm98HInOL9Z088StTYpx2zJ6pKukZrVtWuSQijxDI47oEnJTA3
	 XEF5tdsKB+X0sPeV6rxD9xHT1H6avy9GxOc4FJaZW6h0OkXI4tWxiSC2MsZPrmYAlGq1c
	 InGcrFMt2APaK/jP/wxjChanq7VjEmu3AhP7a9itr+9B1pTkrGbOtRUgtYt1SB4nnrVjc
	 9pDh7C9ITfk+7742nGR8gdBOqs87pdT87CkJQf+WTrHDY9tdtDIjZcmhI/DUjrBkvLg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 419F3F800B0
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 14:38:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 419F3F800B0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d7565e20ace400-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/859@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/859@alsa-project.org>
Subject: Use UCM profiles for HDMI-only cards
Date: Mon, 21 Sep 2026 14:39:02 +0200 (CEST)
Message-ID-Hash: 7SDUHEB7AKTSMFILCKAMNUV7MM5WAOK6
X-Message-ID-Hash: 7SDUHEB7AKTSMFILCKAMNUV7MM5WAOK6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7SDUHEB7AKTSMFILCKAMNUV7MM5WAOK6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM4NTkgd2FzIG9wZW5lZCBm
cm9tIGZlbGFndW5kOgoKU29tZSBsYXB0b3BzIGhhdmUgc2V2ZXJhbCBvdXRwdXRzIGNhcGFibGUg
b2YgZHJpdmluZyBzZXZlcmFsIGRpZmZlcmVudCBtb25pdG9ycywgd2hpY2ggY2FuIGluIHR1cm4g
aGF2ZSB0aGVpciBvd24gYXVkaW8gY2FwYWJpbGl0aWVzLiBJbiBteSBjYXNlLCBJIGhhdmUgdHdv
IG1vbml0b3JzLCBlYWNoIGNhcGFibGUgb2YgYXVkaW8gb3V0cHV0IGFuZCBzb21ldGltZXMgSSBj
b25uZWN0IG15IEFWUiB0aGF0IGlzIGhvb2tlZCB0byBhIDUuMSBhdWRpbyBzeXRlbS4NCg0KQ3Vy
cmVudGx5IHRoYXQgaXMgZXhwb3NlZCBhcyBvbmUgZGV2aWNlIHdpdGggc2V2ZXJhbCBkaWZmZXJl
bnQgcHJvZmlsZXMuIFRoYXQgbWVhbnMgb25seSBvbmUgY2FuIGJlIHNlbGVjdGVkIGF0IGEgdGlt
ZSBhbmQgaXQgaXMgbm90IHBvc3NpYmxlIHRvIGFzc2lnbiBkaWZmZXJlbnQgb3V0cHV0cyB0byBk
aWZmZXJlbnQgYXVkaW8gc3RyZWFtcywgd2hpY2ggdGhlIGhhcmR3YXJlIGlzIHBlcmZlY3RseSBj
YXBhYmxlIG9mLg0KDQpUaGlzIGNvcnJlY3RzIHRoaXMgYnkgYXBwbHlpbmcgVUNNIHRvIHN1Y2gg
Y2FyZHMgYnkgZGVmYXVsdCAocHJldmlvdXNseSB0aGV5IHdlcmUgaWdub3JlZCkuDQoNClNlY29u
ZCBjb21taXQgcHJvdmlkZXMgaW5mcmFzdHJ1Y3R1cmUgZm9yIHNlbGVjdGVkIGNhcmRzIHRvIG9w
dCBvdXQgb2YgaXQuIEkgYW0gbm90IHN1cmUgd2hpY2ggb25lIHRoZXkgYXJlIGFuZCBob3cgY29t
bW9uIHRoZXkgYXJlLiBVbnRpbCB0aGV5IGFyZSBpZGVudGlmaWVkLCBJIGNhbiBhbHNvIGRyb3Ag
dGhlIHNlY29uZCBjb21taXQuDQoNCkkgb3JpZ2luYWxseSB0cmllZCB0byBzb2x2ZSB0aGlzIGF0
IFBpcGV3aXJlIGxldmVsLCBidXQgaXRzIG1haW50YWluZXIgdGhpbmtzIGl0IGlzIGJldHRlciBk
b25lIGhlcmU6wqBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvcGlwZXdpcmUvcGlwZXdp
cmUvLS9tZXJnZV9yZXF1ZXN0cy8yOTkwI25vdGVfMzY1Mjk0MSBhbmQgaW5kZWVkIHRoaXMgaXMg
bXVjaCBsZXNzIGNvZGUgZm9yIHRoZSBzYW1lIGVmZmVjdC4gVGhhdCBpcyBhbHNvIHdoZXJlIHRo
ZSB3b3JyeSBhYm91dCBzb21lIGNhcmRzIG5vdCBzdXBwb3J0aW5nIHRoaXMgY29tZXMgZnJvbS4g
SSBwZXJzb25hbGx5IGhhdmUgbm8gaWRlYSBob3cgY29tbW9uIHRoYXQgaXMuDQoNCldoYXQgSSBh
bSB0cnlpbmcgdG8gYWNoaWV2ZSBpcyB0byBoYXZlIHRoaXMgKEtERcKgc291bmQgYXBwbGV0KToN
Cg0KPGltZyB3aWR0aD0iNjEwIiBoZWlnaHQ9IjQ3NCIgYWx0PSJTY3JlZW5zaG90XzIwMjYwOTIx
XzE0MTI0OSIgc3JjPSJodHRwczovL2dpdGh1Yi5jb20vdXNlci1hdHRhY2htZW50cy9hc3NldHMv
NTgyNWNkMDgtNTlhNS00NTM5LThiNTMtMjU0NzM0M2EyMjRhIiAvPg0KDQppbnN0ZWFkIG9mIHRo
aXM6DQoNCjxpbWcgd2lkdGg9IjYxMCIgaGVpZ2h0PSI0NzQiIGFsdD0iU2NyZWVuc2hvdF8yMDI2
MDkyMV8xNDI5NTUiIHNyYz0iaHR0cHM6Ly9naXRodWIuY29tL3VzZXItYXR0YWNobWVudHMvYXNz
ZXRzLzUwYzZhMDc1LTQwMjctNGMxYi05NDAxLWMwMTZkNjE4MzhhZiIgLz4NCg0KQnkgdGhlIHdh
eSB0aGUgIlBsYXkgSGlGaSBxdWFsaXR5IE11c2ljIiBjb21tZW50IGZpZWxkIGJ1YmJsZXMgdXAg
dG8gdGhlIHByb2ZpbGUgbmFtZSwgd2hpY2ggaXMgYSBiaXQgYXdrd2FyZC4gQ291bGQgYmUgY2hh
bmdlZCB0byBzb21ldGhpbmcgbGlrZSAiSERNSS9EUCBPdXRwdXQiIG1heWJlLgoKUmVxdWVzdCBV
UkwgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZi9wdWxs
Lzg1OQpQYXRjaCBVUkwgICAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNh
LXVjbS1jb25mL3B1bGwvODU5LnBhdGNoClJlcG9zaXRvcnkgVVJMOiBodHRwczovL2dpdGh1Yi5j
b20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYK
