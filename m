Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205AECAC5A5
	for <alsa-devel@archiver.kernel.org>; Sat, 20 Sep 2025 13:26:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DBD7D601D5;
	Sat, 20 Sep 2025 15:25:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DBD7D601D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1758374769;
	bh=bonOByLdIMVHMcrfE7I8dq9kGxoxT8qbUJHSw8lGH3E=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=igt3v8C4L5cQOZgmrDC570fRi5qp6m/OyERFtyRMq5uLJHgr9LC9Zs0CVEeIPUjMN
	 h9WZJa2qVDIrNz/bfhIHlYFAAlBdspOgT66XfcI66FtgTCrIAeC0wTSzz9p+nQLoZc
	 V8G+geYxuRCkN9ZmkYO1Hc0xSTsmktMXhPJtsU3U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 41698F805D8; Sat, 20 Sep 2025 15:25:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 84532F805D3;
	Sat, 20 Sep 2025 15:25:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8146BF8032D; Sat, 20 Sep 2025 15:25:04 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 624C8F800B8
	for <alsa-devel@alsa-project.org>; Sat, 20 Sep 2025 15:25:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 624C8F800B8
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18670079ba805f00-webhooks-bot@alsa-project.org>
In-Reply-To: <18670079ba795500-webhooks-bot@alsa-project.org>
References: <18670079ba795500-webhooks-bot@alsa-project.org>
Subject: 
 =?utf-8?q?Lenovo_83KF_with_Realtek_ALC287_=E2=80=93_bass_speaker_not_exposed_=28only_treble_on_Linux=2C_Dolby_works_on_Windows=29?=
Date: Sat, 20 Sep 2025 15:25:04 +0200 (CEST)
Message-ID-Hash: DU7BZTF2CJY6FZ2QZGFY4IVTJEFWQNHB
X-Message-ID-Hash: DU7BZTF2CJY6FZ2QZGFY4IVTJEFWQNHB
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DU7BZTF2CJY6FZ2QZGFY4IVTJEFWQNHB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzYxNCB3YXMgZWRpdGVkIGZyb20gUHJh
andhbC1QcmF0aGlrc2g6Cgo+IFshSU1QT1JUQU5UXQo+ICoqSSBqdXN0IHN0YXJ0ZWQgZ2V0dGlu
ZyBpbnRvIExpbnV4LCBhbmQgSSdtIG5vdCBldmVuIHN1cmUgaWYgdGhpcyBpcyB0aGUgcmlnaHQg
cGxhY2UgdG8gYmUgcG9zdGluZyB0aGlzIGlzc3VlLiBJJ20gbW9yZSB0aGFuIHdpbGxpbmcgdG8g
bGVhcm4gb3IgaW1wcm92ZSBpZiBJIG5lZWQgdG8gYmUgZG9pbmcgc29tZXRoaW5nIGVsc2Ugb3Ig
cmVhY2hpbmcgb3V0IGVsc2V3aGVyZSA6IikqKgoKIyMjIFN5c3RlbQotIE1hbnVmYWN0dXJlcjog
ICAgICBMRU5PVk8KLSBQcm9kdWN0IE5hbWU6ICAgICAgODNLRgotIFByb2R1Y3QgVmVyc2lvbjog
ICBZb2dhIFBybyA3IDE0SUFIMTAKLSBGaXJtd2FyZSBWZXJzaW9uOiAgUUdDTjI4V1cKLSBTeXN0
ZW0gU0tVOiAgICAgICAgTEVOT1ZPX01UXzgzS0ZfQlVfaWRlYV9GTV9Zb2dhIFBybyA3IDE0SUFI
MTAKLSBCb2FyZCBWZW5kb3I6ICAgICAgTEVOT1ZPCi0gQm9hcmQgTmFtZTogICAgICAgIExOVk5C
MTYxMjE2Ci0gS2VybmVsOiA2LjE2LjgtYXJjaDEtMQotIFBhY2thZ2VzOgogIC0gc29mLWZpcm13
YXJlIDIwMjUuMDUuMS0xCiAgLSBhbHNhLXVjbS1jb25mIDEuMi4xNC0yCiAgLSBhbHNhLXV0aWxz
IDEuMi4xNC0xCiAgLSBBdWRpbyBzdGFjazogUGlwZVdpcmUgKEFyY2ggTGludXgpCgojIyMgUHJv
YmxlbQotIE9uIFdpbmRvd3Mgd2l0aCBEb2xieSBBdG1vcywgbGFwdG9wIHNwZWFrZXJzIHByb2R1
Y2UgcmljaCBzb3VuZCB3aXRoIGJhc3MuCi0gT24gTGludXggKEFyY2gpLCBzb3VuZCBpcyB0aGlu
L3RyZWJsZS1vbmx5LiBObyBiYXNzIHNwZWFrZXIgb3V0cHV0LgotIEluIGBhbHNhbWl4ZXJgLCBv
bmx5IGBTcGVha2VyYCBjb250cm9sIGlzIHZpc2libGUuCi0gQ29kZWMgZHVtcCBzaG93czoKICAt
IDB4MTQ6IFtGaXhlZF0gSW50ZXJuYWwgU3BlYWtlciAocGxheXMgc291bmQsIHRyZWJsZSBvbmx5
KQogIC0gMHgxNy8weDFiLzB4MWU6IFtOL0FdIFNwZWFrZXIgYXQgRXh0IFJlYXIgKGRvIG5vdCBv
dXRwdXQgYXVkaW8pCgojIyMgV2hhdCBJIHRyaWVkCi0gVXBkYXRlZCBgc29mLWZpcm13YXJlYCAr
IGBhbHNhLXVjbS1jb25mYC4KLSBSYWlzZWQgbWl4ZXIgbGV2ZWxzLgotIFRlc3RlZCB3aXRoIGBo
ZGEtdmVyYmAgdG8gZW5hYmxlIDB4MTcvMHgxYiBhcyBvdXRwdXQsIHNldCBnYWluLCBFQVBELCBh
bmQgY29ubmVjdCB0byBEQUMg4oaSIG5vIHNvdW5kLgotIENvbmZpcm1lZCB3aXRoIGBzcGVha2Vy
LXRlc3QgLXQgc2luZSAtZiA4MGAgYW5kIGF1ZGlvIHRyYWNrcyBmcm9tIFlvdVR1YmUuCgojIyMg
TG9ncwpBdHRhY2hpbmcgZmlsZXMKLSBbYWxzYS1pbmZvLnR4dF0oaHR0cHM6Ly9naXRodWIuY29t
L3VzZXItYXR0YWNobWVudHMvZmlsZXMvMjI0NDA4ODYvYWxzYS1pbmZvLnR4dCkKLSBbYW1peGVy
X2NvbnRlbnRzLnR4dF0oaHR0cHM6Ly9naXRodWIuY29tL3VzZXItYXR0YWNobWVudHMvZmlsZXMv
MjI0NDA4ODMvYW1peGVyX2NvbnRlbnRzLnR4dCkKLSBbYW1peGVyX3NpbXBsZS50eHRdKGh0dHBz
Oi8vZ2l0aHViLmNvbS91c2VyLWF0dGFjaG1lbnRzL2ZpbGVzLzIyNDQwODg1L2FtaXhlcl9zaW1w
bGUudHh0KQotIFtjb2RlY19kdW1wLnR4dF0oaHR0cHM6Ly9naXRodWIuY29tL3VzZXItYXR0YWNo
bWVudHMvZmlsZXMvMjI0NDA4ODQvY29kZWNfZHVtcC50eHQpCgpJc3N1ZSBVUkwgICAgIDogaHR0
cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25mL2lzc3Vlcy82MTQKUmVw
b3NpdG9yeSBVUkw6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29u
Zgo=
