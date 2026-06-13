Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6ED3CD98CF
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Jun 2026 22:18:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E06C060201;
	Sun, 14 Jun 2026 00:18:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E06C060201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781389100;
	bh=0pY4TUA91kj79tecbP0sDYKuoWv4Tvg/BZo/98C13zg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=bgm6k7jXWSYR5B76hOLBm959PmoGJYrhsUKVZEZemo8uaNnWjuJ4woTNLb5mVqfx7
	 2JHKnFNc5gKA66qmCrOrV0+774EAxPpaVFR6Uj0kAoq/M+2ZeWWAeOT4zFbUyn5tQZ
	 2c8z5IMyGajnDoJC3FZ7CvZvNHQsoFNKt4+ELGOs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3B5A0F805FB; Sun, 14 Jun 2026 00:17:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A732BF805F7;
	Sun, 14 Jun 2026 00:17:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 224C3F804F2; Sun, 14 Jun 2026 00:17:40 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781389055;
	b=VA/O3vCWGc8TIXVfeI+A7tE6ItYMN/0v+87q9IpMXyDFP4FkMFGy5tstjasZc1E1zyN+
	 tfMuE3qQTN/WQSGROUDIbxbAni6vOg8oazGxFIne7ijQnVFG7bz+TaHtxeNFKFkroeIOQ
	 0soFAv4HYWkjyMhh/wwoixH70ZRy4dXaoIk8SQ3wO+FwccEk1OFg+hLUKoaVL7qG0mter
	 WY25UfGAU4bZdMHQv0c7No+o90tsB2vUeKIyDwSHZhVJA/BNHLKP21uQuyQ0n0u2XEomD
	 pinR16HHYH2NPHHxI2CaTKiDPKDcysogNDYfRfer/pwh2zXjfsZ3NxOhcPqIMhaJodQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781389055;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=0pY4TUA91kj79tecbP0sDYKuoWv4Tvg/BZo/98C13zg=;
	b=UEGAKxFUhhATc0+BeOHmc176EgDtgtkIuvW1oEiZOaxbPXVlniNwtkiljplnLxL/ddh9
	 Tq7S6oN5tnnhkq8tKg5Cmah5rUB0qRmxh/BvjU266c3gSorDTxP7a8LZkvM5YF+X9YfiE
	 qIqJBwN1Sx7TFRTi4L2V6YcX0Sl0HyM1FHV3sTL946xvxRjagzO6sLBs4PKUz/S7Ttori
	 MdqP8mbvuLkmPfL/Jn/JRhwzuAStwomyD3hDx8aCDB3SfyTit/ke0RqavMmSzwauJGSeB
	 +ftHuckQZu9Rh8mo60+5i1q3MoLrRGJ/MvT/ghfiYmDemMit4GqeZBXpuBWnhT7jOWw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id C89B3F80100
	for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2026 00:17:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C89B3F80100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b8c3e80270aa00-webhooks-bot@alsa-project.org>
In-Reply-To: <18b8c3e802365700-webhooks-bot@alsa-project.org>
References: <18b8c3e802365700-webhooks-bot@alsa-project.org>
Subject: Missing UCM profile for Fifine SC3 (3142:0c33) causes PCM volume to
 reset to 0 on every boot
Date: Sun, 14 Jun 2026 00:17:40 +0200 (CEST)
Message-ID-Hash: RG65YDBZMJMGGMRCEV7FCBGHV3A6VA2P
X-Message-ID-Hash: RG65YDBZMJMGGMRCEV7FCBGHV3A6VA2P
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RG65YDBZMJMGGMRCEV7FCBGHV3A6VA2P/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzc4OCB3YXMgb3BlbmVkIGZyb20gamFj
eGVsNDI6Cgo+IE5vdGU6IFRoaXMgaXNzdWUgZGVzY3JpcHRpb24gd2FzIGRyYWZ0ZWQgd2l0aCB0
aGUgaGVscCBvZiBhbiBBSSBhc3Npc3RhbnQgYmFzZWQgb24gdHJvdWJsZXNob290aW5nIHN0ZXBz
IGFuZCBjb21tYW5kIG91dHB1dCBmcm9tIG15IHN5c3RlbS4gSSd2ZSBkb25lIGEgY3Vyc29yeSBj
aGVjayBhbmQgYmVsaWV2ZSBpdCdzIGFjY3VyYXRlLCBidXQgSSdtIG5vdCB2ZXJ5IGZhbWlsaWFy
IHdpdGggQUxTQS9VQ00gaW50ZXJuYWxzLCBzbyBwbGVhc2UgbGV0IG1lIGtub3cgaWYgYW55dGhp
bmcgZG9lc24ndCBtYWtlIHNlbnNlIG9yIG5lZWRzIGNsYXJpZnlpbmcg4oCUIGhhcHB5IHRvIHJ1
biBmdXJ0aGVyIGNvbW1hbmRzIG9yIHRlc3RzLgoKIyMjIFN1bW1hcnkKClRoZSBGaWZpbmUgU0Mz
IFVTQiBhdWRpbyBpbnRlcmZhY2UgKGAzMTQyOjBjMzNgKSBoYXMgbm8gVUNNIHByb2ZpbGUgKGB1
Y20yL1VTQi1BdWRpby9jb25mLmQvMzE0Mi0wYzMzLmNvbmZgIGRvZXMgbm90IGV4aXN0KS4gQXMg
YSByZXN1bHQsIGBhbHNhLXJlc3RvcmUuc2VydmljZWAgZmFpbHMgdG8gcmVzdG9yZSB0aGUgc2F2
ZWQgUENNIG1peGVyIHN0YXRlIG9uIGJvb3QsIGFuZCB0aGUgYFBDTWAgcGxheWJhY2sgdm9sdW1l
IGRlZmF1bHRzIHRvIGAwYCBldmVyeSB0aW1lIHRoZSBzeXN0ZW0gc3RhcnRzIOKAlCBlZmZlY3Rp
dmVseSBtdXRpbmcgdGhlIGRldmljZSB1bnRpbCBtYW51YWxseSBjb3JyZWN0ZWQuCgojIyMgSGFy
ZHdhcmUKCi0gRGV2aWNlOiBGaWZpbmUgU0MzIChVU0IgYXVkaW8gbWl4ZXIvaW50ZXJmYWNlKQot
IFVTQiBJRDogYDMxNDI6MGMzM2AgKE1WLVNJTElDT04pCi0gYGFwbGF5IC1sYCBzaG93cyBpdCBh
cyBgY2FyZCAxOiBTQzMgW2ZpZmluZSBTQzNdLCBkZXZpY2UgMDogVVNCIEF1ZGlvIFtVU0IgQXVk
aW9dYAoKIyMjIFN5bXB0b20KCk9uIGV2ZXJ5IGJvb3Q6Ci0gYGFsc2FtaXhlciAtYyBTQzNgIHNo
b3dzIGBQQ01gIGF0IGAwYAotIERlc2t0b3Agdm9sdW1lIGNvbnRyb2xzIGFwcGVhciBmdW5jdGlv
bmFsICh2b2x1bWUgc2xpZGVyIG1vdmVzLCBtdXRlIHRvZ2dsZSB3b3JrcykgYnV0IHByb2R1Y2Ug
bm8gYXVkaWJsZSBvdXRwdXQsIGJlY2F1c2UgdGhlIHVuZGVybHlpbmcgQUxTQSBQQ00gbGV2ZWwg
aXMgYXQgMCByZWdhcmRsZXNzIG9mIHdoYXQgUGlwZVdpcmUvV2lyZVBsdW1iZXIgcmVwb3J0Ci0g
TWFudWFsbHkgcnVubmluZyBgYWxzYW1peGVyYCBhbmQgcmFpc2luZyBgUENNYCB0byBgMTAwYCBp
bW1lZGlhdGVseSByZXN0b3JlcyBhdWRpbywgYnV0IHRoaXMgZG9lcyBub3QgcGVyc2lzdCBhY3Jv
c3MgcmVib290cwoKIyMjIFJvb3QgY2F1c2UKCmBhbHNhLXJlc3RvcmUuc2VydmljZWAgbG9ncyB0
aGUgZm9sbG93aW5nIG9uIGV2ZXJ5IGJvb3Q6CgpgYGAKYWxzYS1saWIgdXRpbHMuYzozNzI6KHVj
X21ncl9jb25maWdfbG9hZF9pbnRvKSBjb3VsZCBub3Qgb3BlbiBjb25maWd1cmF0aW9uIGZpbGUg
L3Vzci9zaGFyZS9hbHNhL3VjbTIvVVNCLUF1ZGlvL2NvbmYuZC8zMTQyLTBjMzMuY29uZgphbHNh
LWxpYiBwYXJzZXIuYzo3OToodWNfbWdyX2NvbmZpZ19sb2FkX2ZpbGUpIGZhaWxlZCB0byBvcGVu
IGZpbGUgL3Vzci9zaGFyZS9hbHNhL3VjbTIvVVNCLUF1ZGlvL2NvbmYuZC8zMTQyLTBjMzMuY29u
ZjogLTIKYGBgCgpCZWNhdXNlIG5vIFVDTSBwcm9maWxlIGV4aXN0cyBmb3IgdGhpcyBkZXZpY2Us
IGBhbHNhY3RsIHJlc3RvcmVgIGRvZXMgbm90IHByb3Blcmx5IGluaXRpYWxpc2UvcmVzdG9yZSB0
aGUgYFBDTWAgbWl4ZXIgY29udHJvbCwgZXZlbiB0aG91Z2ggYGFsc2FjdGwgc3RvcmVgIGNvcnJl
Y3RseSBzYXZlcyBgUENNIFBsYXliYWNrIFZvbHVtZWAgYXQgdGhlIGRlc2lyZWQgbGV2ZWwgKDQw
OTYvNDA5NiwgMTAwJSkgaW4gYC92YXIvbGliL2Fsc2EvYXNvdW5kLnN0YXRlYC4KCiMjIyBDb25m
aXJtZWQgc2ltcGxlIG1peGVyIGNvbnRyb2xzCgpgYGAKJCBhbWl4ZXIgLWMgU0MzIHNjb250cm9s
cwpTaW1wbGUgbWl4ZXIgY29udHJvbCAnUENNJywwClNpbXBsZSBtaXhlciBjb250cm9sICdNaWMn
LDAKCiQgYW1peGVyIC1jIFNDMyBjb250cm9scwpudW1pZD0zLGlmYWNlPU1JWEVSLG5hbWU9J1BD
TSBQbGF5YmFjayBTd2l0Y2gnCm51bWlkPTQsaWZhY2U9TUlYRVIsbmFtZT0nUENNIFBsYXliYWNr
IFZvbHVtZScKbnVtaWQ9NSxpZmFjZT1NSVhFUixuYW1lPSdNaWMgQ2FwdHVyZSBTd2l0Y2gnCm51
bWlkPTYsaWZhY2U9TUlYRVIsbmFtZT0nTWljIENhcHR1cmUgVm9sdW1lJwpudW1pZD0yLGlmYWNl
PVBDTSxuYW1lPSdDYXB0dXJlIENoYW5uZWwgTWFwJwpudW1pZD0xLGlmYWNlPVBDTSxuYW1lPSdQ
bGF5YmFjayBDaGFubmVsIE1hcCcKYGBgCgojIyMgQ3VycmVudCB3b3JrYXJvdW5kCgpBIHVkZXYg
cnVsZSB0aGF0IHJ1bnMgYGFtaXhlciAtYyBTQzMgc3NldCAnUENNJyAxMDAlYCB3aGVuZXZlciB0
aGUgZGV2aWNlIGlzIGRldGVjdGVkIChgQUNUSU9OPT0iYWRkIiwgU1VCU1lTVEVNPT0ic291bmQi
LCBBVFRSU3tpZFZlbmRvcn09PSIzMTQyIiwgQVRUUlN7aWRQcm9kdWN0fT09IjBjMzMiYCkgcmVz
b2x2ZXMgdGhlIGlzc3VlLCBidXQgYSBwcm9wZXIgVUNNIHByb2ZpbGUgd291bGQgZml4IHRoaXMg
Zm9yIGFsbCB1c2VycyB3aXRob3V0IHJlcXVpcmluZyBhIG1hbnVhbCB3b3JrYXJvdW5kLgoKIyMj
IEVudmlyb25tZW50CgotIE9TOiBCYXp6aXRlIExpbnV4IChGZWRvcmEgQXRvbWljIC8gVW5pdmVy
c2FsIEJsdWUgYmFzZWQpCi0gQXVkaW8gc3RhY2s6IFBpcGVXaXJlICsgV2lyZVBsdW1iZXIgKGRl
dmljZSBydW5zIGluIHByby1hdWRpbyBwcm9maWxlKQoKIyMjIFJlcXVlc3QKCkNvdWxkIGEgVUNN
IHByb2ZpbGUgYmUgYWRkZWQgZm9yIGAzMTQyOjBjMzNgIChGaWZpbmUgU0MzKSB0aGF0IGNvcnJl
Y3RseSBpbml0aWFsaXNlcy9yZXN0b3JlcyB0aGUgYFBDTWAgbWl4ZXIgY29udHJvbCBvbiBib290
PyBGdWxsIGBhbHNhLWluZm8uc2hgIG91dHB1dCBhdHRhY2hlZC9saW5rZWQgc2VwYXJhdGVseS4g
SGFwcHkgdG8gdGVzdCBhbnkgcHJvcG9zZWQgY29uZmlnLgoKClthbHNhLWluZm8udHh0XShodHRw
czovL2dpdGh1Yi5jb20vdXNlci1hdHRhY2htZW50cy9maWxlcy8yODkxOTUxMC9hbHNhLWluZm8u
dHh0KQoKSXNzdWUgVVJMICAgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxz
YS11Y20tY29uZi9pc3N1ZXMvNzg4ClJlcG9zaXRvcnkgVVJMOiBodHRwczovL2dpdGh1Yi5jb20v
YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYK
