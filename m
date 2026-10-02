Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47187CA5FC4
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:27:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D26660299;
	Fri,  2 Oct 2026 18:27:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D26660299
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790958449;
	bh=CewWJccEhCOyZqECakcFuhkp3JDhzt/7AidSf/0RkJs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=m30IJ/8t6p6TfScCodLjwLqU5D+IoMlVKkGzUPhin1WfRSclkwelRj0Fg1tOB2quF
	 QwzSZrBSO9GHr0wkP83PlWDSgFbMunm+MICbqkk7fAp2oOLfIcfPHDhX4ZZhO7sweM
	 LFs7S0WVoWEJLMJYsW3PYt5eFIBgyqDtvWrhXkjY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15137F80602; Fri,  2 Oct 2026 18:26:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59536F80602;
	Fri,  2 Oct 2026 18:26:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C145BF805BA; Fri,  2 Oct 2026 18:26:49 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790958404;
	b=ElNRVtHsnc7d/9ToWbQl34uerMU+E94Jqe2X/AK/h0P2CmvNFbx4t1Pcqo9iJx99aRrv
	 j6R9Hwgv3oHHpXlEQWtLUGTKveGzazoZOrb/yEIHUlzZ5Uhqp8kRlr/g65Kp1wIc72lxt
	 54x67uVs4ADUYsU+b14vDNtlG4SfgZDfSOHXI6N+kGedn7r4Hzn1qpof0xRm3f4T9r8oh
	 P5FLCKuFTR6CTD+NuydD7JFIS/BEyRCHRn7GffZHOl9Qi5DGnfEXz2jubNZW8YiAZuUqf
	 9zlqhxVE4vf7xa5XwFYpEAAxVE0T5T7p+bMiGk/13yVC5j2ypE0vX6tTScWpgFIRUqg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790958404;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=CewWJccEhCOyZqECakcFuhkp3JDhzt/7AidSf/0RkJs=;
	b=dK5m4eJ2VJiZ84BvBTwXy3+e9pBSbF26lFfpLvb/zCBQ0oKfpxSH+lxvK2QJvLfQ9wgV
	 TqBCngrvFYoB6SM8ve29wvjaRXNG6jZWqATEF0AdPG/SSzpjc8voYCN2tgmyqnZUdkJPX
	 7siGooBXWopCGj27rCQ6KBuRyYkkLw9SKTy61BamfBnkV5PtJMJlqPjnLt8JCR7UOmUJa
	 hynvKB2l/EIH4dh5dvVfwCzjyrypFWFVHRK1XJcOqunOnzp1jyKNTe2/KVA340RkX4rbW
	 LYmqkriQRKwuh2PZ8MdelZ2OSRhCRLg8Fb9+lV9pQcfkRXGclo9XqUEyLZa8ZU++6AQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 73F17F800E4
	for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2026 18:26:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73F17F800E4
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18dac32db6928000-webhooks-bot@alsa-project.org>
In-Reply-To: <18dac32db665a300-webhooks-bot@alsa-project.org>
References: <18dac32db665a300-webhooks-bot@alsa-project.org>
Subject: USB-Audio: add MSI MAG B850M Mortar Max WiFi (0db0:83ed) to the
 ALC4080 block
Date: Fri,  2 Oct 2026 18:26:49 +0200 (CEST)
Message-ID-Hash: RYOHOHDIDU4TGNYSP54DEOLS6FQNPFOW
X-Message-ID-Hash: RYOHOHDIDU4TGNYSP54DEOLS6FQNPFOW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RYOHOHDIDU4TGNYSP54DEOLS6FQNPFOW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzg2NSB3YXMgb3BlbmVkIGZyb20gUmFu
aHVpcnlhbjoKCiMjIyBEZXZpY2UKCi0gTW90aGVyYm9hcmQ6IE1TSSBNQUcgQjg1ME0gTW9ydGFy
IE1heCBXaUZpIChNUy03RTkyKQotIE9uYm9hcmQgYXVkaW86IFJlYWx0ZWsgQUxDNDA4MCAoQXVk
aW8gQm9vc3QpLCBleHBvc2VkIG92ZXIgaW50ZXJuYWwgVVNCCi0gVVNCIElEOiBgMGRiMDo4M2Vk
YAoKICBgYGAKICBCdXMgMDA2IERldmljZSAwMDQ6IElEIDBkYjA6ODNlZCBNaWNybyBTdGFyIElu
dGVybmF0aW9uYWwgVVNCIEF1ZGlvCiAgYGBgCgotIE1pc3NpbmcgZnJvbSB0aGUgQUxDNDA4MCBi
bG9jayBpbiBib3RoIHYxLjIuMTYuMSBhbmQgY3VycmVudCBtYXN0ZXIKICAoY2hlY2tlZCAyMDI2
LTEwLTAzKS4gU2libGluZyBib2FyZHMgYXJlIGxpc3RlZCBhbHJlYWR5IOKAlCBlLmcuCiAgYDBk
YjA6NzY5NiBNU0kgTUFHIEI2NTBNIE1vcnRhciBXaWZpYCBhbmQgYDBkYjA6Y2M3OCBNU0kgTUFH
IEI4NTBNCiAgTW9ydGFyIFdpZmlgIOKAlCBzbyB0aGlzIGxvb2tzIGxpa2UgYSBzaW1wbGUgb21p
c3Npb24gb2YgdGhlICJNYXgiIHZhcmlhbnQuCgojIyMgUHJvYmxlbQoKVGhlIGNhcmQgbWF0Y2hl
cyBubyBVQ00gcHJvZmlsZToKCmBgYAokIGFsc2F1Y20gLWMgMCBsaXN0IF92ZXJicwpBTFNBIGxp
YiBwYXJzZXIuYzozMDY6KGVycm9yX25vZGUpIFtlcnJvci51Y21dIFVDTSBpcyBub3Qgc3VwcG9y
dGVkIGZvciB0aGlzClVTQiBkZXZpY2UgKEdlbmVyaWMgVVNCIEF1ZGlvIGF0IHVzYi0wMDAwOjBi
OjAwLjAtMTEsIGhpZ2ggc3BlZWQgQCBVU0IwZGIwOjgzZWQpCmBgYAoKV2l0aCBQaXBlV2lyZS9X
aXJlUGx1bWJlciBmYWxsaW5nIGJhY2sgdG8gdGhlIGxlZ2FjeSBwcm9maWxlIG1hcHBpbmc6Cgot
IG9ubHkgUENNIDAgKHJlYXIgb3V0cHV0cykgYW5kIHRoZSBJRUM5NTggUENNIGFyZSBtYXBwZWQ7
IHRoZSBmcm9udC1wYW5lbAogIGhlYWRwaG9uZSBvdXRwdXQgKFBDTSAxKSBoYXMgbm8gc2luay9w
b3J0IGF0IGFsbCDihpIgZnJvbnQtcGFuZWwgaGVhZHBob25lcwogIGFyZSBjb21wbGV0ZWx5IHNp
bGVudDsKLSBqYWNrLXN0YXRlIGNoYW5nZXMgKHBsdWdnaW5nIGludG8gdGhlIGZyb250IHBhbmVs
KSBmbGlwIHByb2ZpbGUKICBhdmFpbGFiaWxpdHkgYW5kIGNhbiByZW1vdmUgdGhlIGFuYWxvZyBv
dXRwdXQgZW50aXJlbHkuCgojIyMgQ2FyZCB0b3BvbG9neQoKTWF0Y2hlcyBgUmVhbHRlay9BTEM0
MDgwLUhpRmkuY29uZmAgZXhhY3RseToKCi0gUGxheWJhY2sgUENNIDDigJMzIChQQ00gMCB1cCB0
byA0Y2gsIFBDTSAxIGZyb250IHBhbmVsIHVwIHRvIDM4NCBrSHosCiAgUENNIDMgUy9QRElGKSwg
Y2FwdHVyZSBQQ00gMOKAkzI7Ci0gSmFjayBjb250cm9scyB1c2UgdGhlIGV4YWN0IG5hbWVzIGZy
b20gdGhlIGhlYWRlciBjb21tZW50IG9mCiAgYEFMQzQwODAtSGlGaS5jb25mYDogYFNwZWFrZXIg
LSBPdXRwdXQgSmFja2AsIGBIZWFkcGhvbmUgLSBPdXRwdXQgSmFja2AsCiAgYE1pYyAtIElucHV0
IEphY2tgLCBgTGluZSAtIElucHV0IEphY2tgLCBgQW5hbG9nIEluIC0gSW5wdXQgSmFja2AuCgoj
IyMgVmVyaWZpZWQgZml4CgpMb2NhbCBkcm9wLWluIGB1Y20yL1VTQi1BdWRpby9jb25mLmQvMGRi
MC04M2VkLmNvbmZgOgoKYGBgCkRlZmluZS5Qcm9maWxlTmFtZSAiUmVhbHRlay9BTEM0MDgwIgpg
YGAKClNwZWFrZXIgLyBGcm9udCBIZWFkcGhvbmVzIC8gUy9QRElGIC8gTWljcm9waG9uZSBhbGwg
YXBwZWFyIHdpdGggd29ya2luZwpqYWNrIGRldGVjdGlvbiwgYW5kIGZyb250LXBhbmVsIGhlYWRw
aG9uZXMgcGxheSBhdWRpbyAoUGlwZVdpcmUgMS42LjkpLgoKRXF1aXZhbGVudGx5LCBhZGRpbmcg
dGhlIElEIHRvIHRoZSBBTEM0MDgwIGJsb2NrIHNob3VsZCBzdWZmaWNlOgoKYGBgZGlmZgogIyAw
ZGIwOjc2OTYgTVNJIE1BRyBCNjUwTSBNb3J0YXIgV2lmaQorIyAwZGIwOjgzZWQgTVNJIE1BRyBC
ODUwTSBNb3J0YXIgTWF4IFdpRmkKIC4uLgotICAgIHw3Njk2fDgyY1s0N118OGFmN3wKKyAgICB8
NzY5Nnw4MmNbNDddfDgzZWR8OGFmN3wKYGBgCgpIYXBweSB0byBzZW5kIGEgUFIgaWYgdGhhdCdz
IHRoZSBwcmVmZXJyZWQgcm91dGUuCgojIyMgVmVyc2lvbnMKCi0gYWxzYS11Y20tY29uZiAxLjIu
MTYuMS0xIChhYnNlbnQgZnJvbSBtYXN0ZXIgdG9vKQotIGFsc2EtbGliIDEuMi4xNi4xLCBrZXJu
ZWwgNy4yLjgsIFBpcGVXaXJlIDEuNi45LCBXaXJlUGx1bWJlciAwLjUuMTgsIENhY2h5T1MKCklz
c3VlIFVSTCAgICAgOiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNv
bmYvaXNzdWVzLzg2NQpSZXBvc2l0b3J5IFVSTDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJv
amVjdC9hbHNhLXVjbS1jb25mCg==
