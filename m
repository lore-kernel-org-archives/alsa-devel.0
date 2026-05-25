Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B18FCD5BB1
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2026 17:13:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7B68D601E2;
	Mon, 25 May 2026 19:12:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7B68D601E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779729182;
	bh=3Sq8Pty5tudeUnfmLcJe+N7lKphjTgVS2tvtrAzJzMc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=KvkI6CCk4Ema6i39WMPb00mTyAjhEkkNNov2CU6MfFcZVfPtKxyuxxCihefCTGy6G
	 dKloHUYyAE4zZglzh6E0CwnSZA3vzEbgG3qYSGdjkEwNVsLwQxh0rKa8FskzXoXXj0
	 xHI2ahrF5p2dLOSSFAbKpIY13dOUOQilvjbi6T2I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BD53CF805AA; Mon, 25 May 2026 19:12:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 84D43F805F6;
	Mon, 25 May 2026 19:12:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0B5F5F80557; Mon, 25 May 2026 19:12:23 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 78D8CF8047D
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 19:12:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78D8CF8047D
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b2de396de93300-webhooks-bot@alsa-project.org>
In-Reply-To: <18b2de396db34900-webhooks-bot@alsa-project.org>
References: <18b2de396db34900-webhooks-bot@alsa-project.org>
Subject: 
 =?utf-8?q?Headphone_jack_=283=2E5mm=29_silent_on_Alienware_18_with_sof-arl-rt722_=E2=80=94_speakers_work?=
Date: Mon, 25 May 2026 19:12:23 +0200 (CEST)
Message-ID-Hash: CHCTSWBYFXCXSA3CTW66NQHFOYVOX3X5
X-Message-ID-Hash: CHCTSWBYFXCXSA3CTW66NQHFOYVOX3X5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CHCTSWBYFXCXSA3CTW66NQHFOYVOX3X5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzc2NiB3YXMgb3BlbmVkIGZyb20gZDBt
bTM5MjoKCkhhcmR3YXJlOgoKQWxpZW53YXJlIDE4IChBcmVhXzUxTSBBQTE4MjUwLTBNNjZSRikK
QXVkaW86IEludGVsIFNPRiArIHJ0NzIyIChoZWFkcGhvbmUvbWljKSArIHJ0MTMyMCAoc3BlYWtl
cikgdmlhIFNvdW5kV2lyZQpLZXJuZWw6IDcuMC4xIC8gNy4wLjUgLyA3LjAuOSBub2JhcmEuZmM0
MyAoYWxsIHNhbWUgYmVoYXZpb3IpCmFsc2Etc29mLWZpcm13YXJlOiAyMDI1LjEyLjItMS5mYzQz
CgpQcm9ibGVtOgozLjVtbSBoZWFkcGhvbmUgamFjayBwcm9kdWNlcyBubyBhdWRpby4gTGFwdG9w
IHNwZWFrZXJzIHdvcmsgZmluZS4KRmluZGluZ3M6CgpKYWNrIGRldGVjdGlvbiB3b3JrcyBjb3Jy
ZWN0bHkg4oCUIGV2dGVzdCAvZGV2L2lucHV0L2V2ZW50MjYgY29uZmlybXMgU1dfSEVBRFBIT05F
X0lOU0VSVCBldmVudHMgZmlyZSBvbiBwbHVnL3VucGx1ZwpQaXBlV2lyZSByb3V0ZXMgdG8gSGVh
ZHBob25lc19fc2luayAoc3RhdHVzOiBSVU5OSU5HKSwgYWxsIG1peGVyIGNvbnRyb2xzIGF0IDEw
MCUsIG5vdGhpbmcgbXV0ZWQKVG9wb2xvZ3kgQUJJIG1pc21hdGNoIGF0IGJvb3Q6IFRvcG9sb2d5
IEFCSSAzOjI5OjEgdnMgS2VybmVsIEFCSSAzOjIzOjEKVUNNIHByb2ZpbGUgYnVncyBpbiAvdXNy
L3NoYXJlL2Fsc2EvdWNtMi9zb2Ytc291bmR3aXJlL3J0NzIyLmNvbmY6CgpFbmFibGVTZXF1ZW5j
ZSByZWZlcmVuY2VzICdIZWFkcGhvbmUgU3dpdGNoJyDigJQgY29udHJvbCBkb2Vzbid0IGV4aXN0
IChhY3R1YWw6ICdIZWFkcGhvbmUnKQpKYWNrQ29udHJvbCAiSGVhZHBob25lIEphY2siIOKAlCBk
b2Vzbid0IGV4aXN0IChrZXJuZWwgcmVnaXN0ZXJzIGl0IGFzICJIZWFkc2V0IEphY2siKQoKClRl
c3RlZDogbW9kdWxlIHJlbG9hZCwgYWxzYWN0bCBpbml0LCBVQ00gcGF0Y2gg4oCUIG5vIGNoYW5n
ZQoKZG1lc2c6CnNvZi1hdWRpby1wY2ktaW50ZWwtbXRsOiBsb2FkaW5nIHRvcG9sb2d5OiBzb2Yt
YXJsLXJ0NzIyLWwwX3J0MTMyMC1sMi50cGxnClRvcG9sb2d5OiBBQkkgMzoyOToxIEtlcm5lbCBB
QkkgMzoyMzoxCnNvZl9zZHc6IEFTb0M6IFBhcmVudCBjYXJkIG5vdCB5ZXQgYXZhaWxhYmxlLCB3
aWRnZXQgY2FyZCBiaW5kaW5nIGRlZmVycmVkCgpJc3N1ZSBVUkwgICAgIDogaHR0cHM6Ly9naXRo
dWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25mL2lzc3Vlcy83NjYKUmVwb3NpdG9yeSBV
Ukw6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZgo=
