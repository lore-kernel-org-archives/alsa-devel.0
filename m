Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A432A109448C
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Mar 2026 03:37:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9030B601EE;
	Sun, 22 Mar 2026 04:37:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9030B601EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774150673;
	bh=t0qBjpWozHvRiJx1qGKpf4mfpsGg+LnFxfwni26X9pw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=me1zbVCb6HNDqXIZLIkPRD4IdMsGjaOIA749JEEDbIULfmGlIJ7gge9ZRGhS3NlZu
	 3mu6ERPZhaRFhM6It2TbB28kPm2MHX0E8/AOCXSakq84bksabvnytembwsyjmsH/9O
	 EXaMB7lUp0vGhc0BaqrmZcc76fXEjLuXZDvsBaM4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A31D0F805F6; Sun, 22 Mar 2026 04:37:20 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59C72F805F3;
	Sun, 22 Mar 2026 04:37:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5370EF8047D; Sun, 22 Mar 2026 04:37:10 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A67B4F8014B
	for <alsa-devel@alsa-project.org>; Sun, 22 Mar 2026 04:37:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A67B4F8014B
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189f0c9876881300-webhooks-bot@alsa-project.org>
In-Reply-To: <189f0c9876520b00-webhooks-bot@alsa-project.org>
References: <189f0c9876520b00-webhooks-bot@alsa-project.org>
Subject: No sound from internal speakers on Acer Aspire AL16-31P (Realtek
 ALC269VC, likely amp issue)
Date: Sun, 22 Mar 2026 04:37:10 +0100 (CET)
Message-ID-Hash: E7ZXPR4WDHYP2IBHBFJUU42OFKLMAW5W
X-Message-ID-Hash: E7ZXPR4WDHYP2IBHBFJUU42OFKLMAW5W
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/E7ZXPR4WDHYP2IBHBFJUU42OFKLMAW5W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtbGliIGlzc3VlICM1MDAgd2FzIG9wZW5lZCBmcm9tIG5pY29sYXMy
MDE5YWxjdWJvOgoKTGFwdG9wOiBBY2VyIEFzcGlyZSBBTDE2LTMxUApDUFU6IEludGVsIEFsZGVy
IExha2UKQXVkaW8gY29kZWM6IFJlYWx0ZWsgQUxDMjY5VkMKQXVkaW8gY29udHJvbGxlcjogSERB
IEludGVsIFBDSAoKUHJvYmxlbToKSW50ZXJuYWwgc3BlYWtlcnMgcHJvZHVjZSBubyBzb3VuZCBv
biBMaW51eC4gQXVkaW8gc3lzdGVtIGFwcGVhcnMgZnVuY3Rpb25hbCBidXQgb3V0cHV0IGlzIHNp
bGVudC4KClRlc3RlZCBkaXN0cmlidXRpb25zOgotIEZlZG9yYSA0MyAoa2VybmVsIDYuMTcuMSkK
LSBVYnVudHUgMjUuMTAKLSBFbmRlYXZvdXJPUyAoQXJjaC1iYXNlZCkKCk9ic2VydmVkIGJlaGF2
aW9yOgotIFNwZWFrZXJzIGRldGVjdGVkIGFzICJCdWlsdC1pbiBBdWRpbyIKLSBBdWRpbyBwbGF5
cyAobm8gZXJyb3JzKSwgYnV0IG5vIHNvdW5kIGlzIGhlYXJkCi0gSGVhZHBob25lcyBhbmQgSERN
SSBvdXRwdXQgd29yayAoaWYgdGVzdGVkLCBjb25maXJtKQotIHBhY3RsIHNob3dzIHNpbmsgaW4g
U1VTUEVOREVEIG9yIElETEUgc3RhdGUKLSBhbHNhbWl4ZXIgc2hvd3Mgbm9ybWFsIGxldmVscwoK
RGlhZ25vc3RpY3M6CmFwbGF5IC1sIHNob3dzOgpjYXJkIDA6IFBDSCBbSERBIEludGVsIFBDSF0s
IGRldmljZSAwOiBBTEMyNjlWQyBBbmFsb2cKCk1hbnVhbCB0ZXN0OgphcGxheSAtRCBwbHVnaHc6
MCwwIC91c3Ivc2hhcmUvc291bmRzL2Fsc2EvRnJvbnRfQ2VudGVyLndhdgrihpIgbm8gc291bmQg
b3V0cHV0CgpBdHRlbXB0ZWQgZml4ZXM6Ci0gRGlzYWJsZWQgQXV0by1NdXRlIE1vZGUKLSBGb3Jj
ZWQgYW5hbG9nLXN0ZXJlbyBwcm9maWxlCi0gSW5zdGFsbGVkIGFsc2Etc29mLWZpcm13YXJlCi0g
VGVzdGVkIG11bHRpcGxlIGtlcm5lbHMgYW5kIGRpc3Ryb3MKCkNvbmNsdXNpb246Ckxpa2VseSBt
aXNzaW5nIHN1cHBvcnQgb3IgaW5pdGlhbGl6YXRpb24gc2VxdWVuY2UgZm9yIGludGVybmFsIHNw
ZWFrZXIgYW1wbGlmaWVyIChzbWFydCBhbXApLgoKSXNzdWUgVVJMICAgICA6IGh0dHBzOi8vZ2l0
aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS1saWIvaXNzdWVzLzUwMApSZXBvc2l0b3J5IFVSTDog
aHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLWxpYgo=
