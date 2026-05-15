Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFE6CD4F25
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2026 13:51:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE64B60241;
	Fri, 15 May 2026 15:51:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE64B60241
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778853112;
	bh=y2tbu+RKMLEnmDkI1w6c6YCwSLUCaH2HjvuHorM9xfc=;
	h=Date:To:From:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=sZAeH5yS32rMa8Y+iQKZWIKECag9eWkBY2zo+LgmH1Bw3nSCnrLhtCX7ATI5wJ1Ym
	 c1AyaNMUfZVKwKYpFHxER13leAnWR+3N83N7Ypc5eAzXP/xwSpi5Fys0wMeIiu1PsC
	 rPSmxApVmgqS74owITjYPcmNgWWfKIt+TecYmS4s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8E4D0F80690; Fri, 15 May 2026 15:50:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EE1DDF80685;
	Fri, 15 May 2026 15:50:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ACF32F80557; Fri, 15 May 2026 11:34:12 +0200 (CEST)
Received: from mail-24429.protonmail.ch (mail-24429.protonmail.ch
 [109.224.244.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3524DF800BD
	for <alsa-devel@alsa-project.org>; Fri, 15 May 2026 11:34:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3524DF800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=SbKw3CvV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1778837643; x=1779096843;
	bh=tVEU0gf1HiLfrb+JIGz0QD+Vt8oz7a/Pvz4wC9151B4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SbKw3CvVOP7FjuvEJDM/OV2AQepBUZNEw9a4aJSDppGbDvxEA6uBRQDcHu7IJIVMq
	 eWMjf045+TvZ0C81Wu8btCHqrguPwng+ZmHet1k3wSJCtZa+YOn2+55smykkEgVn2k
	 o3IvV8pJMFO4GAMar910N4kcUZR/OORsdU5JuIHdFKG2oPAFMZ1K6O4Qvs+F4kZIis
	 CtqeiwDyWZTybLEn5TvilDrMRkLKD39XBlxkF5mlbtiUNnTMp9NbramqsN7AbzmsgA
	 LL164G4CWWfKYJmm9ZpYn89hX/NMyt+3GLr5v3oES6gi+hKdkP4KmJTn+w74189Bpa
	 j29IsnblrNy/w==
Date: Fri, 15 May 2026 09:34:01 +0000
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
From: REBEL 7 <7rebel@proton.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tiwai@suse.com" <tiwai@suse.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Lenovo IdeaPad Pro 5 14AKP10
Message-ID: 
 <3rCLnS937trcQxYR2Ga7JdnTBpn2iTsFB_IhPFLEY3h6XMLMKvg0wb-EMN6hSUHBCuksvqHW3EUTP2EMWSPF01K7oczVIWaybY3DKK9LB_o=@proton.me>
Feedback-ID: 184360822:user:proton
X-Pm-Message-ID: 3a8923f9de5f4a7647106a3edf53d20469772d7d
MIME-Version: 1.0
X-MailFrom: 7rebel@proton.me
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: XU5DXTPSZTHMVXCARBTWECJ4VMCSQO6B
X-Message-ID-Hash: XU5DXTPSZTHMVXCARBTWECJ4VMCSQO6B
X-Mailman-Approved-At: Fri, 15 May 2026 13:50:30 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=utf-8
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XU5DXTPSZTHMVXCARBTWECJ4VMCSQO6B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

VGhlIExlbm92byBJZGVhUGFkIFBybyA1IDE0QUtQMTAgKE1UIDgzSkwsIEFNRCBSeXplbiBBSSA3
IDM1MCkgc2hpcHMKd2l0aCBhIFJlYWx0ZWsgQUxDMjg3IGNvZGVjIGFuZCBubyBlbnRyeSBpbiBh
bGMyNjlfZml4dXBfdGJsW10uIFdpdGhvdXQgYSBmaXh1cCwgdGhlIGludGVybmFsIHNwZWFrZXIg
cHJvZHVjZXMgYSBjb250aW51b3VzIGJ1enouIEhlYWRwaG9uZXMgYXJlIHVuYWZmZWN0ZWQuCgpD
b2RlYyAvIGRtZXNnOgpWZW5kb3IgSWQ6IDB4MTBlYzAyODcKU3Vic3lzdGVtIElkOiAweDE3YWEz
OTEyIChjb2RlYyBkdW1wKQpkbWVzZzogQUxDMjg3OiBwaWNrZWQgZml4dXAgZm9yIFBDSSBTU0lE
IDE3YWE6MDAwMAoKVHdvIGlzc3VlczoKMS4gVGhlIGtlcm5lbCByZWFkcyB0aGUgY29kZWMgU1NJ
RCBhcyAweDE3YWEwMDAwIGluc3RlYWQgb2YgMHgxN2FhMzkxMiAoc2FtZSBzeW1wdG9tIHJlcG9y
dGVkIG9uIHNpYmxpbmcgTGVub3ZvIEtyYWNrYW4gYm9hcmRzKS4KMi4gVGhpcyBpcyBhIDItc3Bl
YWtlciBjaGFzc2lzLiBUZXN0aW5nIG1vZGVsPWFsYzI4Ny15b2dhOS1iYXNzLXNway1waW4gYXBw
bGllZCB0aGUgZml4dXAgY2xlYW5seSBidXQgc2lsZW5jZWQgb3V0cHV0LCBzaW5jZSB0aGF0IGZp
eHVwIGlzIGZvciA0LXNwZWFrZXIgdmFyaWFudHMgdGhhdCByb3V0ZSBhIGJhc3MgZHJpdmVyIHZp
YSBwaW4gMHgxNy4KCkNvdWxkIHRoZSBtYWludGFpbmVyIHBsZWFzZSBhZHZpc2Ugd2hpY2ggQUxD
Mjg3X0ZJWFVQXyogbWFjcm8gaXMKYXBwcm9wcmlhdGUgZm9yIGEgcGxhaW4gMi1zcGVha2VyIExl
bm92byBJZGVhcGFkIGxheW91dD8gSSB3aWxsIGdsYWRseSByZXNlbmQgYSBjb3JyZWN0ZWQgcGF0
Y2guCgpTaWduZWQtb2ZmLWJ5OiByZWJlbDdAcHJvdG9uLm1lCi0tLQpzb3VuZC9wY2kvaGRhL3Bh
dGNoX3JlYWx0ZWsuYyB8IDEgKwoxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYg
LS1naXQgYS9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyBiL3NvdW5kL3BjaS9oZGEvcGF0
Y2hfcmVhbHRlay5jCi0tLSBhL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCisrKyBiL3Nv
dW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCkBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3Bj
aV9xdWlyayBhbGMyNjlfZml4dXBfdGJsW10gPSB7CitTTkRfUENJX1FVSVJLKDB4MTdhYSwgMHgz
OTEyLCAiTGVub3ZvIElkZWFQYWQgUHJvIDUgMTRBS1AxMCIsCisgQUxDMjg3X0ZJWFVQX1RCRCks
IC8qIG1haW50YWluZXI6IHBsZWFzZSBhZHZpc2UgKi8=
