Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B456CD6E75
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2026 18:33:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04CC860260;
	Thu,  4 Jun 2026 20:33:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04CC860260
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780598006;
	bh=eRqItCkfa/s2wBPVlRZjwQWX60RS5wDqc2z8rV5VrAg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Gxp5EiUOEWcWzNpAyt1y5uaDbtMKGJi7N28j80iNGLbtV5Iu1MFPcrJNgWqnFXBi/
	 dqgzJctXfLbcls2/p8+APoKdMmNfFmAUoFw+gO3YWaLF2Indq2q2d1ab5jK4nPJst/
	 vpwzR/qxIaXZpKcVmOLRKOzNQZ5QXhXc6GS58+8Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 12B42F805F6; Thu,  4 Jun 2026 20:32:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CCF7DF805FF;
	Thu,  4 Jun 2026 20:32:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D5319F8012B; Thu,  4 Jun 2026 20:32:46 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780597966;
	b=h+GYLhLCHaV542qZLnV+k9f7jII9lB2U9hzCyDKpByRgZkDijiVrhTGwIctEFHpk8x2q
	 Hd9b1D6gUi647L+UFCIANpQ8/n8xJ956BHqqncRJi/eJeJjql+1r94W8HoD2Lf/iFqPBb
	 SGxp6PXNmwRaZKyIUv5x8FeMaUHLXnd2MOG+6hut7En4UhLhJxQn7Ofbhko8yvBksT/vV
	 jyiV7RbgjJrJCPIvKgEFOWJyq8C8W/YLpzGJvU0KWa/GrbjWpeZ7wLmCgOaoshoJSkNzx
	 46v1CWYCWToaXUb34cc0V4nrEjaV5cN8KeOpNE8SFjnX76NxeNFbd5CzvnosVYpL0wQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780597966;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=eRqItCkfa/s2wBPVlRZjwQWX60RS5wDqc2z8rV5VrAg=;
	b=jxP9fi2+M6TCkFh6qy8I51uzQlfiTRnU2HTjFzjAVzK6QX1eBW6n6tJ4W1emu374B0tj
	 fnTKxbAkSfBYF9/lx4o3tkSAwmXKpsrRwYfaQJ+rS3JRE8Cv4Y2a2HSu1U5Q8K7JULEdK
	 +1YBuJ7ncJ2W1zHA2P/cnhH98KcvxaAAMNT48UCbjQNj0DIsBQIWdKUrusuYDogeFU1xY
	 577wfo2YOYyCbNTtMbsBgWSXTXUfELqaf/bG1twHo7NEQcv+iQoobQOeyN2RKNQhGmI0S
	 loCwye9JumrQWbw4H/3iclMpJ8q8t2uMbJtGj8wi8teV1o1mODeYbHYAUAzOioLWlGQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 0FEB1F8012B
	for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2026 20:32:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0FEB1F8012B
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b5f46a295c8600-webhooks-bot@alsa-project.org>
In-Reply-To: <18b5f46a29504200-webhooks-bot@alsa-project.org>
References: <18b5f46a29504200-webhooks-bot@alsa-project.org>
Subject: 1.2.16 upgrade: could not open configuration file
Date: Thu,  4 Jun 2026 20:32:46 +0200 (CEST)
Message-ID-Hash: ACAZEIATZTOMA3GXVOMLS2ATP2SBVLEL
X-Message-ID-Hash: ACAZEIATZTOMA3GXVOMLS2ATP2SBVLEL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ACAZEIATZTOMA3GXVOMLS2ATP2SBVLEL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzc3NiB3YXMgZWRpdGVkIGZyb20gdGVr
c3RyeWRlcjoKCkFmdGVyIHVwZ3JhZGluZyB0byB0aGUgbGF0ZXN0IHRhZ2dlZCByZWxlYXNlIFt2
MS4yLjE2XShodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYvcmVs
ZWFzZXMvdGFnL3YxLjIuMTYpLCBJJ20gc2VlaW5nIHRoZSBmb2xsb3dpbmcgZXJyb3JzIGxvZ2dl
ZDoKCmBgYApKdW4gMDQgMDg6MDE6NTMgYWxzYWN0bFs3MjFdOiBhbHNhLWxpYiB1dGlscy5jOjM3
MjoodWNfbWdyX2NvbmZpZ19sb2FkX2ludG8pIGNvdWxkIG5vdCBvcGVuIGNvbmZpZ3VyYXRpb24g
ZmlsZSAvdXNyL3NoYXJlL2Fsc2EvdWNtMi9VU0ItQXVkaW8vY29uZi5kLzBkYjAtMWZlYi5jb25m
Ckp1biAwNCAwODowMTo1MyBhbHNhY3RsWzcyMV06IGFsc2EtbGliIHBhcnNlci5jOjc5Oih1Y19t
Z3JfY29uZmlnX2xvYWRfZmlsZSkgZmFpbGVkIHRvIG9wZW4gZmlsZSAvdXNyL3NoYXJlL2Fsc2Ev
dWNtMi9VU0ItQXVkaW8vY29uZi5kLzBkYjAtMWZlYi5jb25mOiAtMgpKdW4gMDQgMDg6MDY6MDIg
cGlwZXdpcmVbOTgxXTogQUxTQSBsaWIgdXRpbHMuYzozNzI6KHVjX21ncl9jb25maWdfbG9hZF9p
bnRvKSBbZXJyb3IudWNtXSBjb3VsZCBub3Qgb3BlbiBjb25maWd1cmF0aW9uIGZpbGUgL3Vzci9z
aGFyZS9hbHNhL3VjbTIvVVNCLUF1ZGlvL2NvbmYuZC8wZGIwLTFmZWIuY29uZgpKdW4gMDQgMDg6
MDY6MDIgcGlwZXdpcmVbOTgxXTogQUxTQSBsaWIgcGFyc2VyLmM6Nzk6KHVjX21ncl9jb25maWdf
bG9hZF9maWxlKSBbZXJyb3IudWNtXSBmYWlsZWQgdG8gb3BlbiBmaWxlIC91c3Ivc2hhcmUvYWxz
YS91Y20yL1VTQi1BdWRpby9jb25mLmQvMGRiMC0xZmViLmNvbmY6IC0yCmBgYAoKVGhlIGRldmlj
ZSB3YXMgaW50ZWdyYXRlZCBpbnRvIGAuLi91Y20yL1VTQi1BdWRpby9VU0ItQXVkaW8uY29uZmAg
bG9uZyBhZ28uCgpObyBzdWNoIGZpbGUgc2hvdWxkIGJlIHNlYXJjaGVkIGZvciBieSB0aGUgcGFy
c2VyIGxvZ2ljIGlmIHRoZSBgL2NvbmYuZGAgcGF0aCBkb2VzIG5vdCBleGlzdC4KCmBgYAovdXNy
L3NoYXJlL2Fsc2Eg4p2vIGdyZXAgLXIgMWZlYiAgICAgIAp1Y20yL1VTQi1BdWRpby9VU0ItQXVk
aW8uY29uZjogIyAwZGIwOjFmZWIgTVNJIEVkZ2UgV2lmaSBaNjkwCnVjbTIvVVNCLUF1ZGlvL1Jl
YWx0ZWsvQUxDNDA4MC1IaUZpLmNvbmY6IFJlZ2V4ICJVU0IoMGIwNTooMTk5NnwxYTVbMjNjXSl8
MGRiMDoxZmViKSIKYGBgCgpOZXZlciBoYWQgYSBzaW5nbGUgaXNzdWUgd2l0aCB0aGlzIGRldmlj
ZSBmdW5jdGlvbmFsaXR5IHNpbmNlIHdlIGZpcnN0IGdvdCBpdCB3b3JraW5nIGluIGh0dHBzOi8v
Z2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZi9pc3N1ZXMvMjEwIHllYXJzIGFn
by4KCmh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZi9jb21taXQv
MWJiMDczOWFjZmM5YmJmZTYxZmZhZjQ3MDdlYTlhOWQ5OGNkYjgyYiBzZWVtcyByZXNwb25zaWJs
ZToKCmBgYAovdXNyL3NoYXJlL2Fsc2Eg4p2vIGdyZXAgY29uZi5kIC91c3Ivc2hhcmUvYWxzYS91
Y20yL1VTQi1BdWRpby9VU0ItQXVkaW8uY29uZgojIE9wdGlvbmFsIGNvbmZpZ3VyYXRpb24gY2Fu
IGJlIHN0b3JlZCB0byBVU0ItQXVkaW8vY29uZi5kL3tWRU5ET1J9LXtERVZJQ0V9LmNvbmYgZmls
ZXMKRmlsZSAiL1VTQi1BdWRpby9jb25mLmQvJHt2YXI6VVNCSUQxfS0ke3ZhcjpVU0JJRDJ9LmNv
bmYiCmBgYAoKaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25mL2Js
b2IvZjg0NmE4YmJhOGZjMmQyMWQyM2NhZjdlYWZhYjVmNTYwZjkxOTZmYS91Y20yL1VTQi1BdWRp
by9VU0ItQXVkaW8uY29uZiNMMjc4LUwyODEKClNob3VsZCBjaGVjayB3aGV0aGVyIGZvbGRlciBw
YXRoIGAiL1VTQi1BdWRpby9jb25mLmQvImAgZXhpc3RzIGZpcnN0LgoKVGhpcyBjYXVzZXMgc3B1
cmlvdXMgbG9nIG5vaXNlLiBUaGUgZGV2aWNlIGF1ZGlvIGlzIHdvcmtpbmcgYXMgaW50ZW5kZWQu
CgpJc3N1ZSBVUkwgICAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVj
bS1jb25mL2lzc3Vlcy83NzYKUmVwb3NpdG9yeSBVUkw6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNh
LXByb2plY3QvYWxzYS11Y20tY29uZgo=
