Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91477CD6E7D
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:55:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1DDB960266;
	Fri,  5 Jun 2026 17:55:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1DDB960266
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780674954;
	bh=FiwpoLgXnDvjM96Bu/96DKjeuHOnIfyaN9oKKExrtbo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=GjPFp31H8WgM0AChnaI8uybVcmgTssufKzR6+Ylt4vGF2VURBLn5lioVd1d56SVYm
	 UwvQpolM4kJVxhNMFBG2hgM+gmKhQEJbzqZvw5tw7InumftWC+/eSkP9TimTdpj3QL
	 TIb00bw5uPTPXt1xbFDrRGwldK2/BSQwrd6/kgYA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 750EFF805F3; Fri,  5 Jun 2026 17:55:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F197F805FF;
	Fri,  5 Jun 2026 17:55:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E32DBF8047D; Fri,  5 Jun 2026 17:55:14 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780674914;
	b=L+Epysf/GXtXxj0EuXjfsZ0acP6m2c7TKvJzcm1XYjZBKmzONuc2Leme7KKq9Ya8JRe+
	 HmFUv7UJ0NreadJHgAtneuh7V4DagcQmvcOiFCt1zJtntOPyXIRBBaDN+Z8ngq2PMnwM2
	 AvpN5YuGzsWLKE7Tk9F3cOEYVczm+3IMsXmNGjkPTE8IoAQ8a0MXqON9wvW0Nt1B2Rjcc
	 pGzxEZCK2fAAnRpGjDr3cRhGqMckWH5qFV2IPMzeiQNGAQQUbs4PXlbw1i3gyVUHIoCwN
	 0WPeOOOOSQw8U7BPtWSY2rjzvpi15yFWD9DWx9vUmvE0nyFh01pq1Ob7Md/UH71SUfg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780674914;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=FiwpoLgXnDvjM96Bu/96DKjeuHOnIfyaN9oKKExrtbo=;
	b=lw15zTr2YuxFFA7RaoNoi0+8y1quN3fU0NvBqcN0DdscYJY9ihOYFRKX1UbmX5dCnvUG
	 +1ua6JU14N+u3VuIdYOJaQ2oM7crzd+fOD8p3LhZ/5UehgWSjpnW1SwXUSh7ibBlnArP2
	 H0R7SkqV2pvjkKOTQI6vorF2nRlsIH9B3dFkeDeKbiE97WS4aa5ndtOyDw2jtRktZqEz3
	 zhJWOfac01vFH/8rIa5ONynud9YKk7UFxwcOimRkg00rBNYEBgOgGzsCHfKN+A/l1nYsN
	 NDjOk5hw89/21HvFWTHZgxVqk1NroNs9o8KH0UF7U6ZWkx0NfBMEgJ4hw6JkGxFJwCA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 113F9F80185
	for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2026 17:55:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 113F9F80185
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b63a660b12be00-webhooks-bot@alsa-project.org>
In-Reply-To: <18b63a660af36200-webhooks-bot@alsa-project.org>
References: <18b63a660af36200-webhooks-bot@alsa-project.org>
Subject: 1.2.16 upgrade: could not open configuration file
Date: Fri,  5 Jun 2026 17:55:14 +0200 (CEST)
Message-ID-Hash: TYHLVPNZASFTDPVGEGHF36BODUWGWB4D
X-Message-ID-Hash: TYHLVPNZASFTDPVGEGHF36BODUWGWB4D
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TYHLVPNZASFTDPVGEGHF36BODUWGWB4D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtbGliIGlzc3VlICM1MTAgd2FzIG9wZW5lZCBmcm9tIHRla3N0cnlk
ZXI6CgpBZnRlciB1cGdyYWRpbmcgdG8gdGhlIGxhdGVzdCB0YWdnZWQgcmVsZWFzZSBbdjEuMi4x
Nl0oaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25mL3JlbGVhc2Vz
L3RhZy92MS4yLjE2KSwgSSdtIHNlZWluZyB0aGUgZm9sbG93aW5nIGVycm9ycyBsb2dnZWQ6Cgpg
YGAKSnVuIDA0IDA4OjAxOjUzIGFsc2FjdGxbNzIxXTogYWxzYS1saWIgdXRpbHMuYzozNzI6KHVj
X21ncl9jb25maWdfbG9hZF9pbnRvKSBjb3VsZCBub3Qgb3BlbiBjb25maWd1cmF0aW9uIGZpbGUg
L3Vzci9zaGFyZS9hbHNhL3VjbTIvVVNCLUF1ZGlvL2NvbmYuZC8wZGIwLTFmZWIuY29uZgpKdW4g
MDQgMDg6MDE6NTMgYWxzYWN0bFs3MjFdOiBhbHNhLWxpYiBwYXJzZXIuYzo3OToodWNfbWdyX2Nv
bmZpZ19sb2FkX2ZpbGUpIGZhaWxlZCB0byBvcGVuIGZpbGUgL3Vzci9zaGFyZS9hbHNhL3VjbTIv
VVNCLUF1ZGlvL2NvbmYuZC8wZGIwLTFmZWIuY29uZjogLTIKSnVuIDA0IDA4OjA2OjAyIHBpcGV3
aXJlWzk4MV06IEFMU0EgbGliIHV0aWxzLmM6MzcyOih1Y19tZ3JfY29uZmlnX2xvYWRfaW50bykg
W2Vycm9yLnVjbV0gY291bGQgbm90IG9wZW4gY29uZmlndXJhdGlvbiBmaWxlIC91c3Ivc2hhcmUv
YWxzYS91Y20yL1VTQi1BdWRpby9jb25mLmQvMGRiMC0xZmViLmNvbmYKSnVuIDA0IDA4OjA2OjAy
IHBpcGV3aXJlWzk4MV06IEFMU0EgbGliIHBhcnNlci5jOjc5Oih1Y19tZ3JfY29uZmlnX2xvYWRf
ZmlsZSkgW2Vycm9yLnVjbV0gZmFpbGVkIHRvIG9wZW4gZmlsZSAvdXNyL3NoYXJlL2Fsc2EvdWNt
Mi9VU0ItQXVkaW8vY29uZi5kLzBkYjAtMWZlYi5jb25mOiAtMgpgYGAKClRoZSBkZXZpY2Ugd2Fz
IGludGVncmF0ZWQgaW50byBgLi4vdWNtMi9VU0ItQXVkaW8vVVNCLUF1ZGlvLmNvbmZgIGxvbmcg
YWdvLgoKTm8gc3VjaCBmaWxlIHNob3VsZCBiZSBzZWFyY2hlZCBmb3IgYnkgdGhlIHBhcnNlciBs
b2dpYyBpZiB0aGUgYC9jb25mLmRgIHBhdGggZG9lcyBub3QgZXhpc3QuCgpgYGAKL3Vzci9zaGFy
ZS9hbHNhIOKdryBncmVwIC1yIDFmZWIgICAgICAKdWNtMi9VU0ItQXVkaW8vVVNCLUF1ZGlvLmNv
bmY6ICMgMGRiMDoxZmViIE1TSSBFZGdlIFdpZmkgWjY5MAp1Y20yL1VTQi1BdWRpby9SZWFsdGVr
L0FMQzQwODAtSGlGaS5jb25mOiBSZWdleCAiVVNCKDBiMDU6KDE5OTZ8MWE1WzIzY10pfDBkYjA6
MWZlYikiCmBgYAoKTmV2ZXIgaGFkIGEgc2luZ2xlIGlzc3VlIHdpdGggdGhpcyBkZXZpY2UgZnVu
Y3Rpb25hbGl0eSBzaW5jZSB3ZSBmaXJzdCBnb3QgaXQgd29ya2luZyBpbiBodHRwczovL2dpdGh1
Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYvaXNzdWVzLzIxMCB5ZWFycyBhZ28uCgpo
dHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYvY29tbWl0LzFiYjA3
MzlhY2ZjOWJiZmU2MWZmYWY0NzA3ZWE5YTlkOThjZGI4MmIgc2VlbXMgcmVzcG9uc2libGU6Cgpg
YGAKL3Vzci9zaGFyZS9hbHNhIOKdryBncmVwIGNvbmYuZCAvdXNyL3NoYXJlL2Fsc2EvdWNtMi9V
U0ItQXVkaW8vVVNCLUF1ZGlvLmNvbmYKIyBPcHRpb25hbCBjb25maWd1cmF0aW9uIGNhbiBiZSBz
dG9yZWQgdG8gVVNCLUF1ZGlvL2NvbmYuZC97VkVORE9SfS17REVWSUNFfS5jb25mIGZpbGVzCkZp
bGUgIi9VU0ItQXVkaW8vY29uZi5kLyR7dmFyOlVTQklEMX0tJHt2YXI6VVNCSUQyfS5jb25mIgpg
YGAKCmh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZi9ibG9iL2Y4
NDZhOGJiYThmYzJkMjFkMjNjYWY3ZWFmYWI1ZjU2MGY5MTk2ZmEvdWNtMi9VU0ItQXVkaW8vVVNC
LUF1ZGlvLmNvbmYjTDI3OC1MMjgxCgpTaG91bGQgY2hlY2sgd2hldGhlciBmb2xkZXIgcGF0aCBg
Ii9VU0ItQXVkaW8vY29uZi5kLyJgIGV4aXN0cyBmaXJzdC4KClRoaXMgY2F1c2VzIHNwdXJpb3Vz
IGxvZyBub2lzZS4gVGhlIGRldmljZSBhdWRpbyBpcyB3b3JraW5nIGFzIGludGVuZGVkLgoKSXNz
dWUgVVJMICAgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS1saWIvaXNz
dWVzLzUxMApSZXBvc2l0b3J5IFVSTDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9h
bHNhLWxpYgo=
