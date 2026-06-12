Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD47FCD8CA8
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2026 13:04:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 09961601FF;
	Fri, 12 Jun 2026 15:03:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 09961601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781269445;
	bh=WFT6goNTW9Dz3/H19thINgyVPR8PahiCl0kO3hddVPo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=sdlSlbDAXQoI7zRbQ20moiehkTs+GHOeKgNRLMH5UWfVTfSbfR6Pxp6cMFiwTX9GV
	 +W/ND422KlgNOnwRHDXzFUzkcfLOKxC8mNS9uq37Yn+tHz+OMN06YqW5gcDm6JpnI/
	 CrgOlWpdN2mv4z/QiETo4JzoTxOq8zgW92muYfMk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 67A19F805F3; Fri, 12 Jun 2026 15:03:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D88F1F805F6;
	Fri, 12 Jun 2026 15:03:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D1348F80510; Fri, 12 Jun 2026 15:03:23 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781269403;
	b=aDPHDMOYnz9oAwEvKTKAJO5mNFBWIASTVdNzgDFt6QBTrok0lcH3G2FKKyWGIjql1Mxn
	 16LtK+toz1UCZ6OJ4VzR7ZeS3gbeLSiGHzyRN6wzXvP62wLluAzp9gsIlyJVF1KayIIK0
	 0rnEgUAQ8BPkj0FIbFzQYDm0b3DZrOzXUxmvwLAYErGLqd/GiPPdUd7jjXDL2EZVBF8Mp
	 ndnwOmsLt1FDoDouybEMwUuNrvDRXFjk6bFJ8fxzaw3eO9qpIz3yRh1j4Fj3U0ILl9rJk
	 hjeJQSr8Txt1hGwtFtmg6c2d+5zbRVB47L4yF1BxHDyY7hlXHudGnYFM4ummVyo3EKA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781269403;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=WFT6goNTW9Dz3/H19thINgyVPR8PahiCl0kO3hddVPo=;
	b=BbqKd/jBGem6dPW31NNRYWe4nbUuOK8KtGcpw+YyA7oE00FnjUUaZn3XPflaYa5acs/i
	 Nc4GR9fCQL4gwKqwZFom3MjGdDKJH5FYNXLbVvaZ+noSssLRH8WZekO7D0fnlkPq0SpKZ
	 328Sh8PRKe32r2TmF6mRx4uhX/hTFAfPQvgBFc3Tp2B99+Zf5QZOpdVCjjNoWzMOdTyy4
	 n249df6al0fXgdAtug9++WjDwiBaux3jLsatvJ0pcRKGCBhknuMG7YxT8Bt/CmY0CR0KV
	 Pu4gaFuT/rPDRmvcvIQ6AoTeqXub/l0U1RkBh9FWErKrf4DOKwFPKGFzYA2eQCWpSJg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D11DF80510
	for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2026 15:03:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D11DF80510
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b857154c297e00-webhooks-bot@alsa-project.org>
In-Reply-To: <18b857154c001f00-webhooks-bot@alsa-project.org>
References: <18b857154c001f00-webhooks-bot@alsa-project.org>
Subject: HDA/HiFi-mic.conf: Internal mic incorrectly gated by external Mic
 Jack on ALC287 without Input Source enum
Date: Fri, 12 Jun 2026 15:03:23 +0200 (CEST)
Message-ID-Hash: 63AQN2XA2L2FD2Z7AXMCFQOPL3UI7L22
X-Message-ID-Hash: 63AQN2XA2L2FD2Z7AXMCFQOPL3UI7L22
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/63AQN2XA2L2FD2Z7AXMCFQOPL3UI7L22/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzc4NSB3YXMgb3BlbmVkIGZyb20gZmFi
aWFubWFydGluczoKCiMjIyBNYWNoaW5lCi0gKipNb2RlbDoqKiBMZW5vdm8gTGVnaW9uIFBybyA3
IDE2SUFYMTBIIChETUkgcHJvZHVjdCBuYW1lOiA4M0Y1KQotICoqQ29kZWM6KiogUmVhbHRlayBB
TEMyODcgKFZlbmRvciBJZDogMHgxMGVjMDI4NywgU3Vic3lzdGVtIElkOiAweDE3YWEzOTA2KQot
ICoqRHJpdmVyOioqIHNvZi1oZGEtZHNwCi0gKipCSU9TOioqIFE3Q040NFdXCi0gKiphbHNhLXVj
bS1jb25mIHZlcnNpb246KiogMS4yLjE2CgojIyMgUHJvYmxlbQoKT24gdGhpcyBtYWNoaW5lLCB0
aGUgaW50ZXJuYWwgbWljcm9waG9uZSAoTm9kZSAweDEyLCBQaW4gRGVmYXVsdCAweDkwYTYwMTQw
OiBgW0ZpeGVkXSBNaWMgYXQgSW50IE4vQWApIGlzIHJlcG9ydGVkIGFzIHVuYXZhaWxhYmxlIGJ5
IFBpcGVXaXJlL1dpcmVQbHVtYmVyIGJlY2F1c2UgdGhlIFVDTSBjb25maWd1cmF0aW9uIGFzc2ln
bnMgdGhlIHdyb25nIGBKYWNrQ29udHJvbGAuCgpUaGUgY29kZWMgZXhwb3NlczoKLSBgSW50ZXJu
YWwgTWljIFBoYW50b20gSmFja2AgPSBvbiAoYWx3YXlzLW9uLCBpbnRlcm5hbCBtaWMgcHJlc2Vu
dCkKLSBgTWljIEphY2tgID0gb2ZmIChleHRlcm5hbCAzLjVtbSBqYWNrLCBub3RoaW5nIHBsdWdn
ZWQgaW4pCi0gKipObyoqIGBJbnB1dCBTb3VyY2VgIG9yIGBDYXB0dXJlIFNvdXJjZWAgZW51bSBj
b250cm9sCgojIyMgUm9vdCBDYXVzZQoKSW4gYHVjbTIvSERBL0hpRmktbWljLmNvbmZgLCB0aGUg
YElmLm1pY3NldHVwYCBjb25kaXRpb24gY2hlY2tzIGZvciBhbiBgSW5wdXQgU291cmNlYCAvIGBD
YXB0dXJlIFNvdXJjZWAgZW51bS4gV2hlbiBuZWl0aGVyIGV4aXN0cywgaXQgZW50ZXJzIHRoZSBg
VHJ1ZWAgYnJhbmNoIHdoaWNoIHVuY29uZGl0aW9uYWxseSBzZXRzOgoKYGBgCkRldmljZU1pY0ph
Y2sgIk1pYyBKYWNrIgpgYGAKClRoaXMgYXNzb2NpYXRlcyB0aGUgaW50ZXJuYWwgbWljIGRldmlj
ZSB3aXRoIHRoZSBleHRlcm5hbCBqYWNrJ3MgYXZhaWxhYmlsaXR5LiBTaW5jZSBgTWljIEphY2tg
ID0gb2ZmIChubyBleHRlcm5hbCBtaWMgcGx1Z2dlZCBpbiksIFBpcGVXaXJlJ3MgQUNQIG1hcmtz
IHRoZSBtaWMgcm91dGUgYXMgYGF2YWlsYWJsZTogbm9gLCBhbmQgR05PTUUgcmVwb3J0cyBubyBt
aWNyb3Bob25lIGF2YWlsYWJsZS4KClRoZSBpbnRlcm5hbCBtaWMgaGFyZHdhcmUgd29ya3MgcGVy
ZmVjdGx5IOKAlCBkaXJlY3QgQUxTQSByZWNvcmRpbmcgKGBhcmVjb3JkIC1EIGh3OjEsMGApIHN1
Y2NlZWRzLgoKIyMjIEV4cGVjdGVkIEJlaGF2aW9yCgpUaGUgaW50ZXJuYWwgbWljIHNob3VsZCBo
YXZlIG5vIGBKYWNrQ29udHJvbGAgKG9yIHVzZSBgSW50ZXJuYWwgTWljIFBoYW50b20gSmFja2Ap
IHNvIGl0cyBhdmFpbGFiaWxpdHkgaXMgbm90IHRpZWQgdG8gdGhlIGV4dGVybmFsIGphY2sgc3Rh
dGUuCgojIyMgUHJvcG9zZWQgRml4CgpJbiB0aGUgYFRydWVgIGJyYW5jaCBvZiBgSWYubWljc2V0
dXBgICh0aGUgIm5vIHNvdXJjZSBzZWxlY3RvciBlbnVtIiBmYWxsYmFjayksIGFkZCBhIGNvbmRp
dGlvbjogaWYgYEludGVybmFsIE1pYyBQaGFudG9tIEphY2tgIGV4aXN0cywgZG9uJ3QgYXNzaWdu
IGBEZXZpY2VNaWNKYWNrICJNaWMgSmFjayJgLiBTb21ldGhpbmcgbGlrZToKCmBgYApUcnVlIHsK
ICAgIERlZmluZSB7CiAgICAgICAgRGV2aWNlTWljTmFtZSAiTWljIgogICAgICAgIERldmljZU1p
Y0NvbW1lbnQgIlN0ZXJlbyBNaWNyb3Bob25lIgogICAgICAgIERldmljZU1pY0phY2sgIk1pYyBK
YWNrIgogICAgICAgIERldmljZU1pY1ByaW9yaXR5IDIwMAogICAgfQoKICAgIElmLmludGVybmFs
bWljX3BoYW50b20gewogICAgICAgIENvbmRpdGlvbiB7CiAgICAgICAgICAgIFR5cGUgQ29udHJv
bEV4aXN0cwogICAgICAgICAgICBDb250cm9sICJpZmFjZT1DQVJELG5hbWU9J0ludGVybmFsIE1p
YyBQaGFudG9tIEphY2snIgogICAgICAgIH0KICAgICAgICBUcnVlLkRlZmluZS5EZXZpY2VNaWNK
YWNrICIiCiAgICB9Cn0KYGBgCgpUaGlzIHByZXNlcnZlcyB0aGUgZXhpc3RpbmcgYmVoYXZpb3Ig
Zm9yIG1hY2hpbmVzIHdpdGggb25seSBhbiBleHRlcm5hbCBtaWMgamFjaywgd2hpbGUgY29ycmVj
dGx5IGhhbmRsaW5nIG1hY2hpbmVzIHdoZXJlIHRoZSBzb2xlIGNhcHR1cmUgZGV2aWNlIGlzIHRo
ZSBpbnRlcm5hbCBtaWMuCgojIyMgQ29kZWMgRHVtcCAocmVsZXZhbnQgZXhjZXJwdCkKCmBgYApO
b2RlIDB4MTIgW1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDQwYjogU3RlcmVvIEFtcC1JbgogIFBp
bmNhcCAweDAwMDAwMDIwOiBJTgogIFBpbiBEZWZhdWx0IDB4OTBhNjAxNDA6IFtGaXhlZF0gTWlj
IGF0IEludCBOL0EKICAgIENvbm4gPSBEaWdpdGFsLCBDb2xvciA9IFVua25vd24KICAgIERlZkFz
c29jaWF0aW9uID0gMHg0LCBTZXF1ZW5jZSA9IDB4MAogICAgTWlzYyA9IE5PX1BSRVNFTkNFCgpO
b2RlIDB4MTkgW1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDQ4YjogU3RlcmVvIEFtcC1JbgogIFBp
bmNhcCAweDAwMDAzNzI0OiBJTiBEZXRlY3QKICAgIFZyZWYgY2FwczogSElaIDUwIEdSRCA4MCAx
MDAKICBQaW4gRGVmYXVsdCAweDAzYTExMDMwOiBbSmFja10gTWljIGF0IEV4dCBMZWZ0CiAgICBD
b25uID0gMS84LCBDb2xvciA9IEJsYWNrCiAgICBEZWZBc3NvY2lhdGlvbiA9IDB4MywgU2VxdWVu
Y2UgPSAweDAKYGBgCgojIyMgQUxTQSBDb250cm9scwoKYGBgCkludGVybmFsIE1pYyBQaGFudG9t
IEphY2s6IHZhbHVlcz1vbgpNaWMgSmFjazogdmFsdWVzPW9mZgooTm8gJ0lucHV0IFNvdXJjZScg
b3IgJ0NhcHR1cmUgU291cmNlJyBjb250cm9sIGV4aXN0cykKYGBgCgpJc3N1ZSBVUkwgICAgIDog
aHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25mL2lzc3Vlcy83ODUK
UmVwb3NpdG9yeSBVUkw6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20t
Y29uZgo=
