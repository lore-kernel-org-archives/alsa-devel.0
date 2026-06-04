Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F901CD6E6D
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2026 16:24:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E0D436025E;
	Thu,  4 Jun 2026 18:24:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E0D436025E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780590253;
	bh=Xs+qgFoMOpBwestBkB25jjw2/YLmT73dzxn0HiB1z1w=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=NI9UVQ0ZdBujMFzMoszzBvRPpFncTo/5Vz5yyToYwG1Xkm203/107LTJ10AnRfvGM
	 Rskk4X6smjpEgHMHPRSpn1rDM2hnhoXNgdz8e3vHC/6WiqT99hmzUYnCVLIRONZwYT
	 rhoTH/d2ybyNbF0YrK70KMu4suZNYX9hwPryOHL8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2EB5F805F4; Thu,  4 Jun 2026 18:23:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 24370F805FF;
	Thu,  4 Jun 2026 18:23:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AEE46F804CC; Thu,  4 Jun 2026 18:23:32 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780590212;
	b=mFjjf8TSL00jc+k+KnFCPNh6u/lHgRPuhlsrWBQe3fFqeW0nlhim5CwiO5NfvNYtyaD2
	 rBIjVIqv9EI6wVZRGFXwiWTWcG7ZSaMccECthtiCsGiPyNTHcw4F/89q14Kvk0YkdmKfe
	 vdQ6SNmT9h0u6X6L+8vkv+Snk7oYLgb+Du44uX5YPMUHoR1A8CE5UO9Prl7AX22Se1G9c
	 u+ru0ra5fBCEvccXVmpWAMwrdKHGhtlj4g9zdufsUUNMA8z9IugAPXpvD91z5KfDn+bjm
	 ulP4tRCLhLbvwMYunGZR8M/60EBb5Q2QyDdgYydiaj1CJkgrx9tyzdWAnVUVWBP9g1w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780590212;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=Xs+qgFoMOpBwestBkB25jjw2/YLmT73dzxn0HiB1z1w=;
	b=AiTHpjOeB8GT0pPicn14Bo3TxHFeSSvvWeSwsK+tLt+gCEIOBcOXAFw6M2tg7V4VxUjt
	 hA9KjO9aRRzqSvZE49hJ92oZO4orb187k++5AqQv34HFIyTBOS+8Gipnofcq/RQUpyNOX
	 B9Jxe70WWKQqBFya2zbNPhWXg6mXwZdknaCnxu7aJbreH6qQVxm2RYLguvs2EE2F98lA9
	 bR1BmQGZVtf9GNsT+sK3f1hytXyCS/xWzLceuRBt6RLdRgEh5PSMCYrLwYOzWyYrjWX8A
	 MhZ0i7gVSNNSgfc8wXA50nDwOLfFn4e+4M6wXgOiup34T9qlVKaPUErUHzTFIhGht8g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id ED242F8047D
	for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2026 18:23:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ED242F8047D
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b5ed5cc3e28900-webhooks-bot@alsa-project.org>
In-Reply-To: <18b5ed5cc3d66800-webhooks-bot@alsa-project.org>
References: <18b5ed5cc3d66800-webhooks-bot@alsa-project.org>
Subject: 1.2.16 upgrade: could not open configuration file
Date: Thu,  4 Jun 2026 18:23:32 +0200 (CEST)
Message-ID-Hash: WJQH4YWPKXJQYZPRE5ZKMGDSXZCYHJLZ
X-Message-ID-Hash: WJQH4YWPKXJQYZPRE5ZKMGDSXZCYHJLZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WJQH4YWPKXJQYZPRE5ZKMGDSXZCYHJLZ/>
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
YS91Y20yL1VTQi1BdWRpby9jb25mLmQvMGRiMC0xZmViLmNvbmY6IC0yCmBgYAoKTm8gc3VjaCBm
aWxlIHNob3VsZCBiZSBuZWVkZWQsIG9yIHNlYXJjaGVkLCBmb3IgYnkgdGhlIHBhcnNlciBsb2dp
Yy4KClRoZSBkZXZpY2UgaXMgaW50ZWdyYXRlZCBpbnRvIGAuLi91Y20yL1VTQi1BdWRpby9VU0It
QXVkaW8uY29uZmAgbG9uZyBhZ28uCgpgYGAKL3Vzci9zaGFyZS9hbHNhIOKdryBncmVwIC1yIDFm
ZWIgICAgICAKdWNtMi9VU0ItQXVkaW8vVVNCLUF1ZGlvLmNvbmY6ICMgMGRiMDoxZmViIE1TSSBF
ZGdlIFdpZmkgWjY5MAp1Y20yL1VTQi1BdWRpby9SZWFsdGVrL0FMQzQwODAtSGlGaS5jb25mOiBS
ZWdleCAiVVNCKDBiMDU6KDE5OTZ8MWE1WzIzY10pfDBkYjA6MWZlYikiCmBgYAoKTmV2ZXIgaGFk
IGEgc2luZ2xlIGlzc3VlIHdpdGggdGhpcyBkZXZpY2UgZnVuY3Rpb25hbGl0eSBzaW5jZSB3ZSBm
aXJzdCBnb3QgaXQgd29ya2luZyBpbiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fs
c2EtdWNtLWNvbmYvaXNzdWVzLzIxMCB5ZWFycyBhZ28uCgpodHRwczovL2dpdGh1Yi5jb20vYWxz
YS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYvY29tbWl0LzFiYjA3MzlhY2ZjOWJiZmU2MWZmYWY0NzA3
ZWE5YTlkOThjZGI4MmIgc2VlbXMgcmVzcG9uc2libGU6CgpgYGAKL3Vzci9zaGFyZS9hbHNhIOKd
ryBncmVwIGNvbmYuZCAvdXNyL3NoYXJlL2Fsc2EvdWNtMi9VU0ItQXVkaW8vVVNCLUF1ZGlvLmNv
bmYKIyBPcHRpb25hbCBjb25maWd1cmF0aW9uIGNhbiBiZSBzdG9yZWQgdG8gVVNCLUF1ZGlvL2Nv
bmYuZC97VkVORE9SfS17REVWSUNFfS5jb25mIGZpbGVzCkZpbGUgIi9VU0ItQXVkaW8vY29uZi5k
LyR7dmFyOlVTQklEMX0tJHt2YXI6VVNCSUQyfS5jb25mIgpgYGAKCmh0dHBzOi8vZ2l0aHViLmNv
bS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZi9ibG9iL2Y4NDZhOGJiYThmYzJkMjFkMjNjYWY3
ZWFmYWI1ZjU2MGY5MTk2ZmEvdWNtMi9VU0ItQXVkaW8vVVNCLUF1ZGlvLmNvbmYjTDI3OC1MMjgx
CgpTaG91bGQgY2hlY2sgd2hldGhlciBgIi9VU0ItQXVkaW8vY29uZi5kLyJgIGV4aXN0cyBmaXJz
dC4KClRoaXMgY2F1c2VzIHNwdXJpb3VzIGxvZyBub2lzZS4gVGhlIGRldmljZSBhdWRpbyBpcyB3
b3JraW5nIGFzIGludGVuZGVkLgoKSXNzdWUgVVJMICAgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9h
bHNhLXByb2plY3QvYWxzYS11Y20tY29uZi9pc3N1ZXMvNzc2ClJlcG9zaXRvcnkgVVJMOiBodHRw
czovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYK
