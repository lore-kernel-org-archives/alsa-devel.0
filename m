Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4A1CC6B2A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:51:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C5F6660210;
	Thu, 15 Oct 2026 01:51:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C5F6660210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792021894;
	bh=SX4cxjv8R/96tiMRDwagtpzWtxojTw9uTc/Q85Ol6ZQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=gGeg8/BPI5i3mNcw/F7aGvMTP0OPbXvyeRaeIwGaJ5drAkrPvFHZACyJ09h88P64j
	 8yPBts627qG/v7JS06zOAKVny8ZORLe7gwugHGxYdK0h6Mmo1TYbc6PM3CwWYeyOip
	 awtKeyhA5glrUUTF5TBH4ZoiWdrlRUpbawExH5Sg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 110C9F805F7; Thu, 15 Oct 2026 01:51:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 81C26F80601;
	Thu, 15 Oct 2026 01:51:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42067F804CF; Thu, 15 Oct 2026 01:50:55 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792021854;
	b=N0kt0xI+55SIe1G+7izLRqhSbuBKgW39UCNAMgDl9v1NECVpR/rH1d50cGrxsH8QZlNd
	 /sYvK8wfxMjp/gyC+ungfjqzKvmRgaaFRLIDP/U3h7DFf4n8dRTwIK2PPjJlL5cJo5o+y
	 BnHedlYKrv6d2srmBOhuDhxqUixrrGLhZqDc3xDruVUOwqPqA9W8TI+ogAF1pkohlfffB
	 z213N+WMi5nIggTJWxAFooFtOfg9D+XiLNsukvtCJcUg8ieHosrVG+4EyyXVh/0YTIwZy
	 JiILMTYPrMQariPca88hrxlf0FoBSz6CS6+/swbiXwzq0JFj42/BecZxKaQoa6wgUGQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792021854;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=SX4cxjv8R/96tiMRDwagtpzWtxojTw9uTc/Q85Ol6ZQ=;
	b=b0xoEBkGYxJ+KD0PfLRe26k1MKa7ifdX/51C0OHRepO4eynIGuCcjrUVg6ksrydQHFNu
	 JSOGKy69PTQIYpWvHqM3GKnz8G2O2sIWbOY5DT4H3Y4FS/eGBKVA87fhm9yhcOUUQN6u1
	 ajVsN0FYvXccZVfnQDSP1F+j9EkK03J5udfViNdqQ4Oguaa06wt2aoNxCaRZRCQ+V4Oxh
	 LY1AdCAZ/BB+QAQHvEqfiIgQfU6ii56clg+jSJO/rd6Jp9ieaA7OMVSW3Sv2P332J+yUc
	 rzP1ucvhOc7NN9JhmTQASPNWINMOfbFObX4lbT7Y37f/ZZkglWBN+Mu9r8Ab2LLBvPw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 27AB1F800BD
	for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2026 01:50:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27AB1F800BD
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18de8a614eed3c00-webhooks-bot@alsa-project.org>
In-Reply-To: <18de8a614eca2800-webhooks-bot@alsa-project.org>
References: <18de8a614eca2800-webhooks-bot@alsa-project.org>
Subject: USB-Audio: ASUS ROG Zenith II S/PDIF output mapped to wrong PCM
 device
Date: Thu, 15 Oct 2026 01:50:55 +0200 (CEST)
Message-ID-Hash: TGTDWYBEBSKH6BGRPCTJV4NVAENZJ3CA
X-Message-ID-Hash: TGTDWYBEBSKH6BGRPCTJV4NVAENZJ3CA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TGTDWYBEBSKH6BGRPCTJV4NVAENZJ3CA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtbGliIGlzc3VlICM1MzIgd2FzIG9wZW5lZCBmcm9tIGJ5cmNvbGlu
OgoKIyMgU3VtbWFyeQoKT24gdGhlIEFTVVMgUk9HIFplbml0aCBJSSBFeHRyZW1lIChUUlg0MCks
IHRoZSBgaWVjOTU4OmAgUENNIGZvciB0aGUgb25ib2FyZCBVU0IgY29kZWMgIlplbml0aCBJSSBN
YWluIEF1ZGlvIiAoYDBiMDU6MTkxNmAsIFJlYWx0ZWsgQUxDMTIyMC1WQikgb3BlbnMgUENNIGRl
dmljZSAwLiBPbiB0aGlzIGJvYXJkIGRldmljZSAwIGlzIHRoZSA4LWNoYW5uZWwgYW5hbG9nIG91
dHB1dDsgdGhlIG9wdGljYWwgUy9QRElGIG91dHB1dCBpcyBQQ00gZGV2aWNlIDEuIEFzIGEgcmVz
dWx0LCB0aGUgIkRpZ2l0YWwgU3RlcmVvIChJRUM5NTgpIiBvdXRwdXQgaW4gUGlwZVdpcmUvUHVs
c2VBdWRpbyBwbGF5cyB0byB0aGUgYW5hbG9nIGphY2tzIGFuZCB0aGUgUy9QRElGIHBvcnQgaXMg
c2lsZW50LgoKVGhlIHNlY29uZCBvbmJvYXJkIGNvZGVjLCAiWmVuaXRoIElJIEZyb250IEhlYWRw
aG9uZSIgKGAwYjA1OjE5MTVgKSwgaGFzIGEgc2luZ2xlIGFuYWxvZyBwbGF5YmFjayBkZXZpY2Ug
YW5kIG5vIGRpZ2l0YWwgb3V0cHV0LCBidXQgYGllYzk1ODpgIHN0aWxsIG9wZW5zIGl0LCBzbyBQ
aXBlV2lyZS9QdWxzZUF1ZGlvIGxpc3QgYSBkaWdpdGFsIG91dHB1dCBmb3IgaXQgdGhhdCBkb2Vz
IG5vdCB3b3JrLgoKTmVpdGhlciBjYXJkIGlzIGxpc3RlZCBpbiBgVVNCLUF1ZGlvLnBjbS5pZWM5
NThfZGV2aWNlYCBpbiBgc3JjL2NvbmYvY2FyZHMvVVNCLUF1ZGlvLmNvbmZgLCBzbyBib3RoIGZh
bGwgYmFjayB0byBkZXZpY2UgMC4KCiMjIEhhcmR3YXJlCgpgYGAKJCBjYXQgL3Byb2MvYXNvdW5k
L2NhcmRzCiAwIFtBdWRpbyAgICAgICAgICBdOiBVU0ItQXVkaW8gLSBaZW5pdGggSUkgTWFpbiBB
dWRpbwogNCBbSGVhZHBob25lICAgICAgXTogVVNCLUF1ZGlvIC0gWmVuaXRoIElJIEZyb250IEhl
YWRwaG9uZQoKJCBhcGxheSAtbCAgIChjYXJkIDAgYW5kIDQgb25seSkKY2FyZCAwOiBBdWRpbyBb
WmVuaXRoIElJIE1haW4gQXVkaW9dLCBkZXZpY2UgMDogVVNCIEF1ZGlvIFtVU0IgQXVkaW9dCmNh
cmQgMDogQXVkaW8gW1plbml0aCBJSSBNYWluIEF1ZGlvXSwgZGV2aWNlIDE6IFVTQiBBdWRpbyBb
VVNCIEF1ZGlvICMxXQpjYXJkIDA6IEF1ZGlvIFtaZW5pdGggSUkgTWFpbiBBdWRpb10sIGRldmlj
ZSAzOiBVU0IgQXVkaW8gW1VTQiBBdWRpbyAjM10KY2FyZCA0OiBIZWFkcGhvbmUgW1plbml0aCBJ
SSBGcm9udCBIZWFkcGhvbmVdLCBkZXZpY2UgMDogVVNCIEF1ZGlvIFtVU0IgQXVkaW9dCmBgYAoK
YC9wcm9jL2Fzb3VuZC9jYXJkMC9zdHJlYW0wYCAoZGV2aWNlIDApOiBpbnRlcmZhY2UgNCwgMi80
LzYvOCBjaGFubmVscywgOC1jaGFubmVsIG1hcCBgRkwgRlIgRkMgTEZFIFJMIFJSIEZMQyBGUkNg
IChhbmFsb2cpLgpgL3Byb2MvYXNvdW5kL2NhcmQwL3N0cmVhbTFgIChkZXZpY2UgMSk6IGludGVy
ZmFjZSA1LCAyIGNoYW5uZWxzLCA0NC4x4oCTMTkyIGtIeiAoUy9QRElGKS4KCiMjIEV4cGVjdGVk
CgpgaWVjOTU4OkNBUkQ9QXVkaW9gIG9wZW5zIGBodzowLDFgLCBhbmQgdGhlIGZyb250IGhlYWRw
aG9uZSBjb2RlYyBkb2VzIG5vdCBleHBvc2UgYW4gSUVDOTU4IG91dHB1dC4KCiMjIEZpeAoKQWRk
IHRoZSB0d28gY2FyZHMgdG8gdGhlIGBpZWM5NThfZGV2aWNlYCB0YWJsZToKCmBgYAoiWmVuaXRo
IElJIE1haW4gQXVkaW8iIDEKIlplbml0aCBJSSBGcm9udCBIZWFkcGhvbmUiIDk5OQpgYGAKCldp
dGggdGhpcyBtYXBwaW5nIChhcHBsaWVkIGxvY2FsbHkgdmlhIGB+Ly5hc291bmRyY2ApLCBgYXBs
YXkgLUQgaWVjOTU4OkNBUkQ9QXVkaW8gLXZgIHJlcG9ydHMgYEhhcmR3YXJlIFBDTSBjYXJkIDAg
J1plbml0aCBJSSBNYWluIEF1ZGlvJyBkZXZpY2UgMWAsIFBpcGVXaXJlJ3MgSUVDOTU4IHNpbmsg
cGxheXMgb3ZlciBvcHRpY2FsIFMvUERJRiwgYW5kIHRoZSBmcm9udCBoZWFkcGhvbmUgY29kZWMg
c2hvd3MgdXAgYXMgYW5hbG9nIHN0ZXJlbyBvbmx5LgoKVGVzdGVkIG9uIEFsbWFMaW51eCAxMC4y
LCBhbHNhLWxpYiAxLjIuMTUuMywgUGlwZVdpcmUgMS40LjExLCBXaXJlUGx1bWJlciAwLjUuMTAu
CgotLS0KClRoaXMgaXNzdWUgYW5kIHRoZSBhY2NvbXBhbnlpbmcgcHVsbCByZXF1ZXN0IHdlcmUg
Y3JlYXRlZCBieSBDbGF1ZGUgKEFudGhyb3BpYydzIENsYXVkZSBPcHVzIDUuNSwgaGlnaCBlZmZv
cnQpIHZpYSBDbGF1ZGUgQ29kZS4gVGhlIGZpeCB3YXMgdGVzdGVkIGFzIHdvcmtpbmcgb24gdGhl
IGFmZmVjdGVkIGhhcmR3YXJlIGJ5IENvbGluIEJ5cm5lLgoKSXNzdWUgVVJMICAgICA6IGh0dHBz
Oi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS1saWIvaXNzdWVzLzUzMgpSZXBvc2l0b3J5
IFVSTDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLWxpYgo=
