Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401DECD8C9D
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:23:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12186601D3;
	Mon,  8 Jun 2026 14:23:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12186601D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780921395;
	bh=JB5tnF27Wt8w6pDu9vqXpyVTCewxsLRZdU3ghTH48jQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DS79QgB7whCl4tmZ8X+KyUg2txi/yFcsdEJvPfQBGd8326pyahxf+8hBa74yu8jpJ
	 FHUbQLj0Lvqt/Z6MpLgNZ8R33JTe7//XY0R0h3utoOVNyNhX5xg0VYU+VlLpnlMC+o
	 lYVGjNaW8L2NYgmgq75zQmXyTgg5X6AsR/VnzAWo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 24574F805FF; Mon,  8 Jun 2026 14:22:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A2BEEF805ED;
	Mon,  8 Jun 2026 14:22:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6A8A1F80423; Mon,  8 Jun 2026 14:22:35 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780921354;
	b=U03LeWa7BYS6Fi89uWzztvrlX3MK85egqaODC/rBRmLu7Xe0qaJC+T/hXLB/4i7bBYjJ
	 vLP8vgbonmHcrVwjZFVTXsl2PC9aRiwqdozZiRA752fA29unQkLJpegUhyuky9urBMxve
	 qYjIBdsWfVQV4ZgADi5vMfvvjWZDwmrjeHP8wE7Y+yAG/d7Frqs9GIk6EopLGvjR+rRFx
	 8owMI9/+eZKW212zTA7VqB+uIAoTWQgRsOgDQqvBFDNT20JUEmiPHXe3tP0hnBMSjc3rj
	 dS9+58lcDbBBgWbylfWQW5t4j+TmGcxnN84w5zd5x0epkvtMFMTPIz0zHQDQs7LTkGQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780921354;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=JB5tnF27Wt8w6pDu9vqXpyVTCewxsLRZdU3ghTH48jQ=;
	b=bNs25PbaGoWP0nVMhTng1B+5ZPADxrqqJTg2gBvYK0kiiqy5mYfJ4chIR8vNDYB28Cm0
	 B7vY0PyqxJz22HDOovKwcVKKM5lbjBdLzTNHXvo0JMd8FwW6NzEyGdxoJMdPtfth3qLB3
	 QTkw4kbQWKYGk0zMiiLcjJUMqWyF7Ohl+GZxh8sKFK6MGDFVtlj8KNpFqLhKo/AKs2Qy6
	 uBXXJZ/0Qzm3YBA/oNJS8w2/M6Rh5Td46fvdYQPUFa7fmyNVmyepsp9mOvMsLO49sG4bM
	 hYggwDM2fQYVIVZiF+zzr+YsTiLGZ3BaXA1XnydxEHUWt1dcJppUIV6TZaOilvfnUOg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id D53D0F80124
	for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2026 14:22:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D53D0F80124
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b71a88e7163000-webhooks-bot@alsa-project.org>
In-Reply-To: <18b71a88e6e8ce00-webhooks-bot@alsa-project.org>
References: <18b71a88e6e8ce00-webhooks-bot@alsa-project.org>
Subject: Add UCM2 profile for Lenovo Yoga Slim 7 15ITL05 (ALC287,
 subsystem 17aa:380a)
Date: Mon,  8 Jun 2026 14:22:35 +0200 (CEST)
Message-ID-Hash: 3TRZ7AM3ULFSXA7LTEENVRC64R6BOYEY
X-Message-ID-Hash: 3TRZ7AM3ULFSXA7LTEENVRC64R6BOYEY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3TRZ7AM3ULFSXA7LTEENVRC64R6BOYEY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzc4MiB3YXMgb3BlbmVkIGZyb20gQWIw
bGlzaDoKCkxlbm92byBZb2dhIFNsaW0gNyAxNUlUTDA1LCBzb2YtaGRhLWRzcCwgZHVhbC1EQUMg
aXNzdWUgKG5vZGUgMHgxNyByZWNlaXZpbmcgYm90aCBEQUMxK0RBQzIgd2l0aCBubyBjcm9zc292
ZXIpCgpIYXJkd2FyZTogTGVub3ZvIFlvZ2EgU2xpbSA3IDE1SVRMMDUKQ29kZWM6IFJlYWx0ZWsg
QUxDMjg3LCBzdWJzeXN0ZW0gSUQgMHgxN2FhMzgwYQpEcml2ZXI6IHNvZi1oZGEtZHNwIChzb2Yt
ZmlybXdhcmUpCktlcm5lbDogNi4xMiAoRGViaWFuIDEzKQoKUHJvYmxlbToKU3BlYWtlcnMgc291
bmQgaG9sbG93IGFuZCBtZXRhbGxpYy4gTm8gVUNNMiBwcm9maWxlIGV4aXN0cyBmb3IgdGhpcyBo
YXJkd2FyZSBzbyB0aGUgZ2VuZXJpYyBIREEgcHJvZmlsZSBpcyB1c2VkLgoKUm9vdCBjYXVzZSBp
ZGVudGlmaWVkOgpUaGUgY29kZWMgaGFzIHR3byBEQUNzIGFuZCB0d28gc3BlYWtlciBwaW4gZ3Jv
dXBzIChxdWFkLXNwZWFrZXIsIERvbGJ5IEF0bW9zKToKLSBOb2RlIDB4MTQgKGJhc3Mvd29vZmVy
cyk6IGNvbm5lY3RlZCB0byBEQUMyICgweDAyKSBvbmx5IOKckwotIE5vZGUgMHgxNyAodHdlZXRl
cnMpOiBjb25uZWN0ZWQgdG8gQk9USCBEQUMxICgweDAzKSBhbmQgREFDMiAoMHgwMikg4pyXCgpC
b3RoIERBQ3MgcmVjZWl2ZSB0aGUgc2FtZSBmdWxsLXJhbmdlIHNpZ25hbCB3aXRoIG5vIGNyb3Nz
b3ZlciBmaWx0ZXJpbmcsIGNhdXNpbmcgYWNvdXN0aWMgcGhhc2UgaW50ZXJmZXJlbmNlIGJldHdl
ZW4gdGhlIHR3ZWV0ZXIgYW5kIHdvb2ZlciBwYWlycy4gT24gV2luZG93cywgdGhlIERvbGJ5IEF0
bW9zIGRyaXZlciBhcHBsaWVzIGEgY3Jvc3NvdmVyIGluc2lkZSB0aGUgU09GIERTUC4KCkV4cGVj
dGVkIGJlaGF2aW91cjoKLSBOb2RlIDB4MTcgKHR3ZWV0ZXJzLCBEZWZBc3NvY2lhdGlvbj0weDEg
U2VxdWVuY2U9MHgwKSDihpIgREFDMSBvbmx5Ci0gTm9kZSAweDE0ICh3b29mZXJzLCAgRGVmQXNz
b2NpYXRpb249MHgxIFNlcXVlbmNlPTB4MSkg4oaSIERBQzIgb25seQoKQ29kZWMgZHVtcCBhdHRh
Y2hlZC4KClthbGMyODcteW9nYS1zbGltNy1jb2RlYy1kdW1wLnR4dF0oaHR0cHM6Ly9naXRodWIu
Y29tL3VzZXItYXR0YWNobWVudHMvZmlsZXMvMjg3MDcxMTgvYWxjMjg3LXlvZ2Etc2xpbTctY29k
ZWMtZHVtcC50eHQpCgpJc3N1ZSBVUkwgICAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJv
amVjdC9hbHNhLXVjbS1jb25mL2lzc3Vlcy83ODIKUmVwb3NpdG9yeSBVUkw6IGh0dHBzOi8vZ2l0
aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZgo=
