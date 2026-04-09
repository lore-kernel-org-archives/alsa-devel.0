Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE31F31E5A
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2026 16:05:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB27D60201;
	Thu,  9 Apr 2026 18:05:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB27D60201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775750722;
	bh=90vZKGUQsT2+7FPjICJxLX7BaGj+e9VopnWWmeGLBgQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=FZo5eqcUBKe5oquCMyInUYmDeeKG7FDsi8Rl2V7QbcqxeGspZ7Og4A2PbThhI/hRP
	 Fgkqw5X7STfBnzXt3o23HBmjGxKIcZsyxGzASdvFYBokVqm0hWiVahXmvCPkXSHZY9
	 +Ome+vENc32rXdo5sZ3JiM3lzRu07TyInjzO/td0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EECCCF805F5; Thu,  9 Apr 2026 18:04:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 39578F805F1;
	Thu,  9 Apr 2026 18:04:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83ACFF8052D; Thu,  9 Apr 2026 18:04:39 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 235BBF8012B
	for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2026 18:04:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 235BBF8012B
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a4bbd47b537000-webhooks-bot@alsa-project.org>
In-Reply-To: <18a4bbd47abd3500-webhooks-bot@alsa-project.org>
References: <18a4bbd47abd3500-webhooks-bot@alsa-project.org>
Subject: aplay does not use WAV/FLAC channel layout metadata,
 potentially causing incorrect multichannel playback unless --chmap is
 manually specified
Date: Thu,  9 Apr 2026 18:04:39 +0200 (CEST)
Message-ID-Hash: ZNTXDHY2IQWCXQEPI2IVCVW2XFWAGJXO
X-Message-ID-Hash: ZNTXDHY2IQWCXQEPI2IVCVW2XFWAGJXO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZNTXDHY2IQWCXQEPI2IVCVW2XFWAGJXO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdXRpbHMgaXNzdWUgIzMyNSB3YXMgb3BlbmVkIGZyb20gSm9ubnlH
YXRvcnM6CgpTdW1tYXJ5Ci0tLS0tLS0KV2hlbiBwbGF5aW5nIG11bHRpY2hhbm5lbCBXQVYgb3Ig
RkxBQyBmaWxlcywgYXBsYXkgaWdub3JlcyB0aGUKY2hhbm5lbC1sYXlvdXQgbWV0YWRhdGEgZW1i
ZWRkZWQgaW4gdGhlIGZpbGUgKFdBViBjaGFubmVsIG1hc2sgb3IgRkxBQwpjaGFubmVsIGFzc2ln
bm1lbnQpLiBBcyBhIHJlc3VsdCwgYXBsYXkgYWx3YXlzIHVzZXMgQUxTQeKAmXMgZmFsbGJhY2sK
Y2hhbm5lbCBvcmRlciAoRkwsRlIsTEZFLEZDLFJMLFJSKSB1bmxlc3MgdGhlIHVzZXIgbWFudWFs
bHkgc3BlY2lmaWVzCi0tY2htYXAuCgpUaGlzIGxlYWRzIHRvIGluY29ycmVjdCBjaGFubmVsIHJv
dXRpbmcgKGUuZy4sIGNlbnRlci9MRkUgc3dhcHBlZCkgZXZlbgp3aGVuIHRoZSBmaWxlIGNvbnRh
aW5zIGNvcnJlY3QgbWV0YWRhdGEgZGVzY3JpYmluZyB0aGUgaW50ZW5kZWQgbGF5b3V0LgoKVGhp
cyBhcHBlYXJzIHRvIGJlIGEgbWlzc2luZyBmZWF0dXJlIGluIGFwbGF5IHJhdGhlciB0aGFuIGFu
IEFMU0Ega2VybmVsCm9yIGFsc2EtbGliIGlzc3VlLCBzaW5jZSBBTFNB4oCZcyBkZXNpZ24gZXhw
ZWN0cyBhcHBsaWNhdGlvbnMgdG8gaW50ZXJwcmV0Cm1ldGFkYXRhIGFuZCBjYWxsIHRoZSBjaG1h
cCBBUEkgYWNjb3JkaW5nbHkuCgoKRXhwZWN0ZWQgQmVoYXZpb3IKLS0tLS0tLS0tLS0tLS0tLS0K
V2hlbiBwbGF5aW5nIGEgV0FWIG9yIEZMQUMgZmlsZSB0aGF0IGNvbnRhaW5zIGNoYW5uZWwtbGF5
b3V0IG1ldGFkYXRhOgoKLSBhcGxheSBzaG91bGQgcmVhZCB0aGUgY2hhbm5lbCBtYXNrIC8gY2hh
bm5lbCBhc3NpZ25tZW50Ci0gYXBsYXkgc2hvdWxkIHRyYW5zbGF0ZSB0aGF0IG1ldGFkYXRhIGlu
dG8gYW4gQUxTQSBjaGFubmVsIG1hcAotIGFwbGF5IHNob3VsZCBjYWxsIHNuZF9wY21fc2V0X2No
bWFwKCkgYXV0b21hdGljYWxseQotIHBsYXliYWNrIHNob3VsZCBmb2xsb3cgdGhlIGZpbGXigJlz
IGludGVuZGVkIGNoYW5uZWwgb3JkZXIgd2l0aG91dAogIHJlcXVpcmluZyB0aGUgdXNlciB0byBt
YW51YWxseSBzcGVjaWZ5IC0tY2htYXAKCgpBY3R1YWwgQmVoYXZpb3IKLS0tLS0tLS0tLS0tLS0t
Ci0gYXBsYXkgaWdub3JlcyBXQVYgY2hhbm5lbCBtYXNrcwotIGFwbGF5IGlnbm9yZXMgRkxBQyBj
aGFubmVsIGxheW91dHMKLSBhcGxheSBkb2VzIG5vdCBjYWxsIHNuZF9wY21fc2V0X2NobWFwKCkK
LSBhcGxheSB1c2VzIEFMU0HigJlzIGZhbGxiYWNrIG9yZGVyIChGTCxGUixMRkUsRkMsUkwsUlIp
Ci0gbXVsdGljaGFubmVsIHBsYXliYWNrIGlzIGluY29ycmVjdCB1bmxlc3MgdGhlIHVzZXIgbWFu
dWFsbHkgcHJvdmlkZXMKICAtLWNobWFwPUZMLEZSLEZDLExGRSxSTCxSUiAob3IgYW5vdGhlciBh
cHByb3ByaWF0ZSBtYXApCgoKV2h5IFRoaXMgTWF0dGVycwotLS0tLS0tLS0tLS0tLS0tCk1vc3Qg
bW9kZXJuIG11bHRpY2hhbm5lbCBmb3JtYXRzIChXQVYsIEZMQUMsIEJsdS1yYXkgUENNLCBEb2xi
eSwgRFRTLApmZm1wZWcsIGV0Yy4pIHVzZSB0aGUgc3RhbmRhcmQgNS4xIG9yZGVyOgoKICBGTCwg
RlIsIEZDLCBMRkUsIFJMLCBSUgoKU2luY2UgYXBsYXkgZG9lcyBub3QgdXNlIG1ldGFkYXRhLCBp
dCBwcm9kdWNlcyBpbmNvcnJlY3Qgb3V0cHV0IG9uIGFueQpzeXN0ZW0gd2hlcmUgdGhlIEFMU0Eg
ZmFsbGJhY2sgb3JkZXIgZGlmZmVycyBmcm9tIHRoZSBmaWxl4oCZcyBpbnRlbmRlZApvcmRlci4K
ClRoaXMgYmVoYXZpb3IgaXMgc3VycHJpc2luZyB0byB1c2VycyBhbmQgaW5jb25zaXN0ZW50IHdp
dGggQUxTQeKAmXMgb3duCmV4cGVjdGF0aW9uIHRoYXQgYXBwbGljYXRpb25zIHNob3VsZCBpbnRl
cnByZXQgbWV0YWRhdGEgYW5kIHNldCB0aGUKY2hhbm5lbCBtYXAgZXhwbGljaXRseS4KCgpSZXBy
b2R1Y3Rpb24KLS0tLS0tLS0tLS0tCjEuIFVzZSBhbnkgNS4xIFdBViBvciBGTEFDIGZpbGUgd2l0
aCBjb3JyZWN0IGNoYW5uZWwgbWV0YWRhdGEuCjIuIFBsYXkgd2l0aDoKICAgICBhcGxheSAtRCBo
dzo8ZGV2aWNlPiBmaWxlLndhdgozLiBPYnNlcnZlIGluY29ycmVjdCBjaGFubmVsIHJvdXRpbmcg
KGUuZy4sIGNlbnRlciBhbmQgTEZFIHN3YXBwZWQpLgo0LiBQbGF5IGFnYWluIHdpdGg6CiAgICAg
YXBsYXkgLUQgaHc6PGRldmljZT4gLS1jaG1hcD1GTCxGUixGQyxMRkUsUkwsUlIgZmlsZS53YXYK
NS4gUGxheWJhY2sgaXMgbm93IGNvcnJlY3QuCgoKUmVxdWVzdAotLS0tLS0tClBsZWFzZSBjb25z
aWRlciBhZGRpbmcgbWV0YWRhdGEgcGFyc2luZyB0byBhcGxheSBzbyB0aGF0IGl0OgoKLSByZWFk
cyBXQVYgY2hhbm5lbCBtYXNrcwotIHJlYWRzIEZMQUMgY2hhbm5lbCBsYXlvdXRzCi0gYXV0b21h
dGljYWxseSBzZXRzIHRoZSBjb3JyZWN0IEFMU0EgY2hhbm5lbCBtYXAKClRoaXMgd291bGQgYWxp
Z24gYXBsYXkgd2l0aCBBTFNB4oCZcyBkb2N1bWVudGVkIGV4cGVjdGF0aW9uIHRoYXQKYXBwbGlj
YXRpb25zIGhhbmRsZSBtZXRhZGF0YSBhbmQgd291bGQgZ3JlYXRseSBpbXByb3ZlIG11bHRpY2hh
bm5lbApwbGF5YmFjayBjb3JyZWN0bmVzcyBhbmQgdXNhYmlsaXR5LgoKVGhhbmsgeW91IGZvciB5
b3VyIHRpbWUgYW5kIGNvbnNpZGVyYXRpb24uCgpJc3N1ZSBVUkwgICAgIDogaHR0cHM6Ly9naXRo
dWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXV0aWxzL2lzc3Vlcy8zMjUKUmVwb3NpdG9yeSBVUkw6
IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11dGlscwo=
