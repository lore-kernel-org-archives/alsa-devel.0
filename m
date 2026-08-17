Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E17AC5DF66
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2026 01:16:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10AB96021D;
	Mon, 17 Aug 2026 03:15:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10AB96021D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786929365;
	bh=hBBDFY50Jm/ddYcDmP9u+xz8JfAoB+2huipiilSRXTw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=dC7ZdQGoScR2aPQIZ3IF7vNIP7toy8SDl8hzzJb5kId5dpAsxkjIQ1tvSVSWMzAOt
	 Y5yNtiknMR9bpl17WfBE5y2jQ58VpoPwfnvRWQk8PTD939TEH1MsawoMu8bVz9daaW
	 PWahFBm42Tp5cqlvRevv41gC3eU8POZbei64x1HU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E9E54F805F6; Mon, 17 Aug 2026 03:15:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5306CF805F8;
	Mon, 17 Aug 2026 03:15:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 544ECF8047D; Mon, 17 Aug 2026 03:15:20 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786929318;
	b=Q7yz3bvRKMA2TLF3BEaPIQQO//2ONEWiqz9fmepS94M0suFog/5wYPBnYmom0CBG3nGi
	 BFW41FS2MbehragciD+8vZ5JMHlbuqlnXk/bOw6jnUOe/tQECt4TaKCccvWM2340xKV6F
	 xEB77fvW1sNgzUSy5XY9lkV0JbVmsx3oVaGa1JSfTMs26rins4HhWWmnZjKCPw/FS4zLk
	 NUQ+Lcm+4rEWsJ/DDFT9yuWahCBEBxmX9XLDWasDR1hkTL9UppnyY6P8JBF1Ci+YYTlEl
	 GsmPkzVc29Ds/1vc/JyvhlhZa32mMUfO9W4NdmokRbjR+8dgoxwBRx68vW5Cw6Tl5YA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786929318;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=hBBDFY50Jm/ddYcDmP9u+xz8JfAoB+2huipiilSRXTw=;
	b=Z6sHUazsnfI26wulfLZd/YYZeRjy+BaA34pquhfvKWepFX22QP1pOn0262CSaPovwfpG
	 nu0mC6QsrI9DNJrMKr9q0/vRgVj+q5NAB2ita8hNgiZrQnlw7ErLfy7QTYo9dfWDlZMDs
	 zzbZ6iialxMfODYjbkFboNsV+n+7NmKWP7J5Q584SSy0EDp6z3Rd7DP6cdwjabPPt6dfE
	 Wd+mOha9zvm7Uesa0owM5WiqG9IwEvSqska3QV0iObSptM+UgifgPYUydpAAbsQQZYFA8
	 AFhdVAX0gDpbUdx+qeosipfjEUp2+03kut+q2p+oLN8QN9RmsbpLr8x50Wcmy6KNTXA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id C0FE3F801F7
	for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2026 03:15:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0FE3F801F7
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18cc72bf13901100-webhooks-bot@alsa-project.org>
In-Reply-To: <18cc72bf135d9a00-webhooks-bot@alsa-project.org>
References: <18cc72bf135d9a00-webhooks-bot@alsa-project.org>
Subject: sof-soundwire: cs42l45 silent on boot when headphones already plugged
 in
Date: Mon, 17 Aug 2026 03:15:20 +0200 (CEST)
Message-ID-Hash: CJEJPDMRJFGW5VIQRQT3AHCRFCMKWY2L
X-Message-ID-Hash: CJEJPDMRJFGW5VIQRQT3AHCRFCMKWY2L
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CJEJPDMRJFGW5VIQRQT3AHCRFCMKWY2L/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzgzMyB3YXMgb3BlbmVkIGZyb20ga2Fm
YXRla2FjdHVhbDoKCiMgc29mLXNvdW5kd2lyZTogY3M0Mmw0NSBzaWxlbnQgb24gYm9vdCB3aGVu
IGhlYWRwaG9uZXMgYWxyZWFkeSBwbHVnZ2VkIGluCgojIyBEZXNjcmliZSB0aGUgYnVnCgpPbiBE
ZWxsIFhQUyAxNiBEQTE2MjYwIChgc29mLXNvdW5kd2lyZWAsIGhlYWRzZXQgY29kZWMgYGNzNDJs
NDVgKSwgcmVib290aW5nICoqd2l0aCBoZWFkcGhvbmVzIGFscmVhZHkgcGx1Z2dlZCBpbioqIHlp
ZWxkcyBubyBzb3VuZCBmcm9tIGhlYWRwaG9uZXMgb3Igc3BlYWtlcnMuIFRoZSBkZXNrdG9wIGNv
cnJlY3RseSBzaG93cyBoZWFkcGhvbmVzIGFzIHBsdWdnZWQgaW4gYW5kIHNlbGVjdGVkLiBVbnBs
dWdnaW5nIGFuZCByZXBsdWdnaW5nIHRoZSBqYWNrIGltbWVkaWF0ZWx5IHJlc3RvcmVzIGhlYWRw
aG9uZSBhdWRpby4KClRoaXMgbWF0Y2hlcyB0aGUgY2xhc3Mgb2YgYnVnIGluIGh0dHBzOi8vZ2l0
aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZi9pc3N1ZXMvODA0IChgY3M0Mmw0M2Ag
bWlzc2luZyBIZWFkcGhvbmUgU3dpdGNoIGluIFVDTSBFbmFibGVTZXF1ZW5jZSkuIFRoZSBzaGlw
cGVkIGBjczQybDQ1YCBkZXZpY2Ugc2VjdGlvbiBoYXMgKipubyBFbmFibGVTZXF1ZW5jZSAvIERp
c2FibGVTZXF1ZW5jZSoqIGF0IGFsbCDigJQgb25seSBqYWNrICsgbWl4ZXIgZWxlbWVudCBuYW1l
cyDigJQgc28gYSBib290IHdpdGggdGhlIGphY2sgYWxyZWFkeSBpbnNlcnRlZCBuZXZlciBydW5z
IGEgcGF0aC1lbmFibGUgc2VxdWVuY2UuCgpDdXJyZW50IGAvdXNyL3NoYXJlL2Fsc2EvdWNtMi9z
b2Ytc291bmR3aXJlL2NzNDJsNDUuY29uZmAgKGFsc2EtdWNtLWNvbmYgMS4yLjE2LjEpOgoKYGBg
ClNlY3Rpb25EZXZpY2UuIkhlYWRwaG9uZXMiIHsKCUNvbW1lbnQgIkhlYWRwaG9uZXMiCgoJVmFs
dWUgewoJCVBsYXliYWNrUHJpb3JpdHkgMjAwCgkJUGxheWJhY2tQQ00gImh3OiR7Q2FyZElkfSww
IgoJCVBsYXliYWNrTWl4ZXIgImRlZmF1bHQ6JHtDYXJkSWR9IgoJCVBsYXliYWNrTWl4ZXJFbGVt
ICJjczQybDQ1IEhlYWRwaG9uZSIKCQlKYWNrQ29udHJvbCAiY3M0Mmw0NSBPVCA0MyBIZWFkcGhv
bmUgSmFjayIKCX0KfQpgYGAKCmBhbHNhLmNvbXBvbmVudHNgIG9uIHRoaXMgbWFjaGluZToKCmBg
YApIREE6ODA4NjI4MjIsODA4NjAxMDEsMDAxMDAwMDAgIGNmZy1hbXA6NCBpZWM2MTkzNy1wY206
Nyw2LDUgaHM6Y3M0Mmw0NSBtaWM6Y3M0Mmw0NS1kbWljIHNwazpjczM1bDU2CmBgYAoKUGlwZVdp
cmUgc2VsZWN0cyBgSGlGaV9fSGVhZHBob25lc19fc2lua2AgYW5kIHRoZSBIZWFkcGhvbmVzIHBv
cnQgaXMgYGF2YWlsYWJsZWAuIEFmdGVyIGEgcmVwbHVnLCBgY3M0Mmw0NSBIZWFkcGhvbmUgUGxh
eWJhY2sgU3dpdGNoYCBpcyBgb24sb25gLiBXZSBkaWQgbm90IGNhcHR1cmUgbWl4ZXIgc3RhdGUg
ZHVyaW5nIHRoZSBzaWxlbnQgYm9vdCAocmVwb3J0aW5nIGFmdGVyIHJlY292ZXJ5KS4KCiMjIFN0
ZXBzIHRvIHJlcHJvZHVjZQoKMS4gUGx1ZyBpbiAzLjUgbW0gaGVhZHBob25lcy4KMi4gUmVib290
LgozLiBQbGF5IGF1ZGlvLiBVSSBzaG93cyBoZWFkcGhvbmVzIHNlbGVjdGVkOyBubyBzb3VuZCBv
biBoZWFkcGhvbmVzIG9yIHNwZWFrZXJzLgo0LiBVbnBsdWcgYW5kIHJlcGx1ZyBoZWFkcGhvbmVz
IOKGkiBzb3VuZCByZXR1cm5zIG9uIGhlYWRwaG9uZXMuCgojIyBIYXJkd2FyZSAvIHNvZnR3YXJl
Cgp8IEl0ZW0gfCBWYWx1ZSB8CnwtLS0tLS18LS0tLS0tLS18CnwgTWFjaGluZSB8IERlbGwgSW5j
LiBYUFMgMTYgREExNjI2MCAoYm9hcmQgMEgySFg5KSB8CnwgQ2FyZCB8IHNvZi1zb3VuZHdpcmUg
LyBgc25kX3NvY19zb2Zfc2R3YCB8CnwgQ29kZWMgfCBjczQybDQ1ICsgY3MzNWw1NiBhbXBzICsg
Y3M0Mmw0NS1kbWljIHwKfCBLZXJuZWwgfCBsaW51eCA3LjEuOC5hcmNoMS0zIHwKfCBhbHNhLXVj
bS1jb25mIHwgMS4yLjE2LjEtMSB8CnwgUGlwZVdpcmUgfCAxLjYuOCB8CnwgV2lyZVBsdW1iZXIg
fCAwLjUuMTUgfAp8IERpc3RybyB8IE9tYXJjaHkgNC4wLjAtMSAoQXJjaCkgfAoKIyMgRXhwZWN0
ZWQKCkJvb3Qgd2l0aCBoZWFkcGhvbmVzIGluc2VydGVkIHNob3VsZCBlbmFibGUgdGhlIGhlYWRw
aG9uZSBhbmFsb2cgcGF0aCAoc2FtZSBhcyBhIGphY2staW5zZXJ0IGV2ZW50KSBzbyBwbGF5YmFj
ayBpcyBhdWRpYmxlIHdpdGhvdXQgdW5wbHVnL3JlcGx1Zy4KCiMjIFN1Z2dlc3RlZCBkaXJlY3Rp
b24KCkFkZCBFbmFibGUvRGlzYWJsZSBzZXF1ZW5jZXMgKGFuZCBgUGxheWJhY2tTd2l0Y2hgIGlm
IGFwcHJvcHJpYXRlKSBmb3IgYGNzNDJsNDUgSGVhZHBob25lIFBsYXliYWNrIFN3aXRjaGAgLyBy
ZWxhdGVkIEZVL09UIGNvbnRyb2xzLCBhbmFsb2dvdXMgdG8gdGhlIGBjczQybDQzYCBmaXggZGlz
Y3Vzc2VkIGluICM4MDQsIHNvIFVDTSBhcHBsaWVzIHRoZSBwYXRoIHdoZW4gdGhlIEhlYWRwaG9u
ZXMgZGV2aWNlIGlzIGVuYWJsZWQgYXQgc2Vzc2lvbiBzdGFydCDigJQgbm90IG9ubHkgb24gYSBo
b3RwbHVnIGVkZ2UuCgpJc3N1ZSBVUkwgICAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJv
amVjdC9hbHNhLXVjbS1jb25mL2lzc3Vlcy84MzMKUmVwb3NpdG9yeSBVUkw6IGh0dHBzOi8vZ2l0
aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZgo=
