Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7A2CD98E1
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2026 21:16:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 11434601E5;
	Tue, 16 Jun 2026 23:16:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 11434601E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781644571;
	bh=Zjm50/SizSTa2ABkHqP28fXVVgiZDnwSMeazLKHKqW0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=JJe+55F5K/jXCFsD9BwdEnNBv8Q+L205qVJIw/AlIE9IOWJBQBWMIom7AdT3p1KFH
	 RHcDTaw1ZyCS6vEaNwzcU8p2OWg8yRftcwjX5zA13qC1ALvH4EFM2LVs89AIAoqOdk
	 dcXJLKLvgiQySENFVceOedp66/aYEF15VEX/bSH4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E6910F805F4; Tue, 16 Jun 2026 23:15:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 89D62F805FC;
	Tue, 16 Jun 2026 23:15:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 12A7EF80495; Tue, 16 Jun 2026 23:15:32 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781644531;
	b=be1z1pBl7KYlpXNImaARMJbb7bLbp3kdz0LDy2aKLaC6SDaUYb7rx0d6hWhqVZWauVog
	 CHoSGb21Rp/Utp0uYxXaKC5IJLNFAAmmnzhvgYNhO6851ZNlnRqJVa9yxUYkkRCxnOL3y
	 xX+m/rTcWi+muG4izOscyGg+mOuwxVS0D12bdsfC2Df9jQTE1t9X9PN4Vqp2eCGR4BfBu
	 qrz37gmRIuzqy/TeE1eisr/Kl8+8kPkoMn6f6kTm9HYqhNG51EkuJoNLD7ZaAQGtlysHy
	 sHjp9gZb9kqYAHatzirCGx3+X1ixUQX94SzNpK1DKP7zu11LjH/wACZKpD2mLI+yKaQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781644531;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=Zjm50/SizSTa2ABkHqP28fXVVgiZDnwSMeazLKHKqW0=;
	b=Yacy9tmGdiKqo/cIFyJZEnlKePjQdKkL+4c4RMF+cKkrbSmxQsZCJEgCXY44WXfTrSlj
	 TCiGbvyD9TgBXl0wzjFwz7r3uW9K8c/FmYbs1CqetBpTV0BKFeP5Cxyi6jjWysN7gbbkj
	 RAQJCLlBZMj/rRDk0bc+1irncfpjU4F8wYdkIZ7CdTCY5qQHMqX8wiHTObVtP/twu/m2z
	 Cab2GQ7dW7TaFj+atwWyyUu9+hY7CU4PmqAIMmK4v9wLqABpTJEZs+grng4T1+QZmdZ5W
	 BPodYbzzGndUzPZEYMpriYszFmb7bgHMDwxJh/8nAhoX0+0zK+NAq+EF4IutkFwPbWQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D4CAF800C1
	for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2026 23:15:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D4CAF800C1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - reopened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b9ac428edbff00-webhooks-bot@alsa-project.org>
In-Reply-To: <18b9ac428ea57200-webhooks-bot@alsa-project.org>
References: <18b9ac428ea57200-webhooks-bot@alsa-project.org>
Subject: HDA/HiFi-mic.conf: Internal mic incorrectly gated by external Mic
 Jack on ALC287 without Input Source enum
Date: Tue, 16 Jun 2026 23:15:32 +0200 (CEST)
Message-ID-Hash: EE3WKJJAL6T4K2ZCP27X23MZCDLRJRVM
X-Message-ID-Hash: EE3WKJJAL6T4K2ZCP27X23MZCDLRJRVM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EE3WKJJAL6T4K2ZCP27X23MZCDLRJRVM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzc4NSB3YXMgcmVvcGVuZWQgZnJvbSBm
YWJpYW5tYXJ0aW5zOgoKIyMjIE1hY2hpbmUKLSAqKk1vZGVsOioqIExlbm92byBMZWdpb24gUHJv
IDcgMTZJQVgxMEggKERNSSBwcm9kdWN0IG5hbWU6IDgzRjUpCi0gKipDb2RlYzoqKiBSZWFsdGVr
IEFMQzI4NyAoVmVuZG9yIElkOiAweDEwZWMwMjg3LCBTdWJzeXN0ZW0gSWQ6IDB4MTdhYTM5MDYp
Ci0gKipEcml2ZXI6Kiogc29mLWhkYS1kc3AKLSAqKkJJT1M6KiogUTdDTjQ0V1cKLSAqKmFsc2Et
dWNtLWNvbmYgdmVyc2lvbjoqKiAxLjIuMTYKCiMjIyBQcm9ibGVtCgpPbiB0aGlzIG1hY2hpbmUs
IHRoZSBpbnRlcm5hbCBtaWNyb3Bob25lIChOb2RlIDB4MTIsIFBpbiBEZWZhdWx0IDB4OTBhNjAx
NDA6IGBbRml4ZWRdIE1pYyBhdCBJbnQgTi9BYCkgaXMgcmVwb3J0ZWQgYXMgdW5hdmFpbGFibGUg
YnkgUGlwZVdpcmUvV2lyZVBsdW1iZXIgYmVjYXVzZSB0aGUgVUNNIGNvbmZpZ3VyYXRpb24gYXNz
aWducyB0aGUgd3JvbmcgYEphY2tDb250cm9sYC4KClRoZSBjb2RlYyBleHBvc2VzOgotIGBJbnRl
cm5hbCBNaWMgUGhhbnRvbSBKYWNrYCA9IG9uIChhbHdheXMtb24sIGludGVybmFsIG1pYyBwcmVz
ZW50KQotIGBNaWMgSmFja2AgPSBvZmYgKGV4dGVybmFsIDMuNW1tIGphY2ssIG5vdGhpbmcgcGx1
Z2dlZCBpbikKLSAqKk5vKiogYElucHV0IFNvdXJjZWAgb3IgYENhcHR1cmUgU291cmNlYCBlbnVt
IGNvbnRyb2wKCiMjIyBSb290IENhdXNlCgpJbiBgdWNtMi9IREEvSGlGaS1taWMuY29uZmAsIHRo
ZSBgSWYubWljc2V0dXBgIGNvbmRpdGlvbiBjaGVja3MgZm9yIGFuIGBJbnB1dCBTb3VyY2VgIC8g
YENhcHR1cmUgU291cmNlYCBlbnVtLiBXaGVuIG5laXRoZXIgZXhpc3RzLCBpdCBlbnRlcnMgdGhl
IGBUcnVlYCBicmFuY2ggd2hpY2ggdW5jb25kaXRpb25hbGx5IHNldHM6CgpgYGAKRGV2aWNlTWlj
SmFjayAiTWljIEphY2siCmBgYAoKVGhpcyBhc3NvY2lhdGVzIHRoZSBpbnRlcm5hbCBtaWMgZGV2
aWNlIHdpdGggdGhlIGV4dGVybmFsIGphY2sncyBhdmFpbGFiaWxpdHkuIFNpbmNlIGBNaWMgSmFj
a2AgPSBvZmYgKG5vIGV4dGVybmFsIG1pYyBwbHVnZ2VkIGluKSwgUGlwZVdpcmUncyBBQ1AgbWFy
a3MgdGhlIG1pYyByb3V0ZSBhcyBgYXZhaWxhYmxlOiBub2AsIGFuZCBHTk9NRSByZXBvcnRzIG5v
IG1pY3JvcGhvbmUgYXZhaWxhYmxlLgoKVGhlIGludGVybmFsIG1pYyBoYXJkd2FyZSB3b3JrcyBw
ZXJmZWN0bHkg4oCUIGRpcmVjdCBBTFNBIHJlY29yZGluZyAoYGFyZWNvcmQgLUQgaHc6MSwwYCkg
c3VjY2VlZHMuCgojIyMgRXhwZWN0ZWQgQmVoYXZpb3IKClRoZSBpbnRlcm5hbCBtaWMgc2hvdWxk
IGhhdmUgbm8gYEphY2tDb250cm9sYCAob3IgdXNlIGBJbnRlcm5hbCBNaWMgUGhhbnRvbSBKYWNr
YCkgc28gaXRzIGF2YWlsYWJpbGl0eSBpcyBub3QgdGllZCB0byB0aGUgZXh0ZXJuYWwgamFjayBz
dGF0ZS4KCiMjIyBQcm9wb3NlZCBGaXgKCkluIHRoZSBgVHJ1ZWAgYnJhbmNoIG9mIGBJZi5taWNz
ZXR1cGAgKHRoZSAibm8gc291cmNlIHNlbGVjdG9yIGVudW0iIGZhbGxiYWNrKSwgYWRkIGEgY29u
ZGl0aW9uOiBpZiBgSW50ZXJuYWwgTWljIFBoYW50b20gSmFja2AgZXhpc3RzLCBkb24ndCBhc3Np
Z24gYERldmljZU1pY0phY2sgIk1pYyBKYWNrImAuIFNvbWV0aGluZyBsaWtlOgoKYGBgClRydWUg
ewogICAgRGVmaW5lIHsKICAgICAgICBEZXZpY2VNaWNOYW1lICJNaWMiCiAgICAgICAgRGV2aWNl
TWljQ29tbWVudCAiU3RlcmVvIE1pY3JvcGhvbmUiCiAgICAgICAgRGV2aWNlTWljSmFjayAiTWlj
IEphY2siCiAgICAgICAgRGV2aWNlTWljUHJpb3JpdHkgMjAwCiAgICB9CgogICAgSWYuaW50ZXJu
YWxtaWNfcGhhbnRvbSB7CiAgICAgICAgQ29uZGl0aW9uIHsKICAgICAgICAgICAgVHlwZSBDb250
cm9sRXhpc3RzCiAgICAgICAgICAgIENvbnRyb2wgImlmYWNlPUNBUkQsbmFtZT0nSW50ZXJuYWwg
TWljIFBoYW50b20gSmFjayciCiAgICAgICAgfQogICAgICAgIFRydWUuRGVmaW5lLkRldmljZU1p
Y0phY2sgIiIKICAgIH0KfQpgYGAKClRoaXMgcHJlc2VydmVzIHRoZSBleGlzdGluZyBiZWhhdmlv
ciBmb3IgbWFjaGluZXMgd2l0aCBvbmx5IGFuIGV4dGVybmFsIG1pYyBqYWNrLCB3aGlsZSBjb3Jy
ZWN0bHkgaGFuZGxpbmcgbWFjaGluZXMgd2hlcmUgdGhlIHNvbGUgY2FwdHVyZSBkZXZpY2UgaXMg
dGhlIGludGVybmFsIG1pYy4KCiMjIyBDb2RlYyBEdW1wIChyZWxldmFudCBleGNlcnB0KQoKYGBg
Ck5vZGUgMHgxMiBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAwNDBiOiBTdGVyZW8gQW1wLUluCiAg
UGluY2FwIDB4MDAwMDAwMjA6IElOCiAgUGluIERlZmF1bHQgMHg5MGE2MDE0MDogW0ZpeGVkXSBN
aWMgYXQgSW50IE4vQQogICAgQ29ubiA9IERpZ2l0YWwsIENvbG9yID0gVW5rbm93bgogICAgRGVm
QXNzb2NpYXRpb24gPSAweDQsIFNlcXVlbmNlID0gMHgwCiAgICBNaXNjID0gTk9fUFJFU0VOQ0UK
Ck5vZGUgMHgxOSBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAwNDhiOiBTdGVyZW8gQW1wLUluCiAg
UGluY2FwIDB4MDAwMDM3MjQ6IElOIERldGVjdAogICAgVnJlZiBjYXBzOiBISVogNTAgR1JEIDgw
IDEwMAogIFBpbiBEZWZhdWx0IDB4MDNhMTEwMzA6IFtKYWNrXSBNaWMgYXQgRXh0IExlZnQKICAg
IENvbm4gPSAxLzgsIENvbG9yID0gQmxhY2sKICAgIERlZkFzc29jaWF0aW9uID0gMHgzLCBTZXF1
ZW5jZSA9IDB4MApgYGAKCiMjIyBBTFNBIENvbnRyb2xzCgpgYGAKSW50ZXJuYWwgTWljIFBoYW50
b20gSmFjazogdmFsdWVzPW9uCk1pYyBKYWNrOiB2YWx1ZXM9b2ZmCihObyAnSW5wdXQgU291cmNl
JyBvciAnQ2FwdHVyZSBTb3VyY2UnIGNvbnRyb2wgZXhpc3RzKQpgYGAKCklzc3VlIFVSTCAgICAg
OiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYvaXNzdWVzLzc4
NQpSZXBvc2l0b3J5IFVSTDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVj
bS1jb25mCg==
