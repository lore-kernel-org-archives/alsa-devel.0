Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A08C5DF81
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2026 01:04:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73DEF602A6;
	Tue, 25 Aug 2026 03:04:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73DEF602A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787619851;
	bh=pl6n2TLkP4pjaQuyVJjkGCQXmNvOtFjCMgA7Ba1zks8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=QhpevecKoPwTmQp0KmIO7TNFHy9lMccGSNbe1mhn1daZuMpjW2d+A5HUHfBGJekvD
	 DfWa7m9sCep4XJoXTkdh+qppsRnaupK6H7qR0zxHyzBMSm1v62oaRAjL2GBUMclDa2
	 VVSRBGWlXROPTaeVXiQXvmjSLIwRXXXn5/yx7vRA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F153DF805FC; Tue, 25 Aug 2026 03:03:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B8A9F80600;
	Tue, 25 Aug 2026 03:03:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 154E0F8027B; Tue, 25 Aug 2026 03:03:29 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787619807;
	b=WuM3JkmUFsOtCAVbaQA0qDWnNe1VifpWsJzMErHG5ma4a2/xslEUbwK1mdkI0PUQVmiE
	 81SdI8NeVkwxdv3ljfLsF6EZ7iLVC8hpAJi+4YZJRMKQsnJNAEx1pQXcI9qZiK5uuIlDs
	 sLM4vwX1/mnFQYF2CdRex52v/hFxAZ1WFh3WeS2fwN8zFhfahZFCDC7FOH+4eh3G8geeW
	 tIC0c6reK0If0Sd3Rn4yhfSvewM8vXbcHifEWaYtRdpE3a8HMkhFcUDc3oFRkW+rU1tit
	 DHWYhWZR35tpClGT3oukh6vMThiTFWmFXUiq1TnROApHcQD08eZz4MYej2e76ggMA8w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787619807;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=pl6n2TLkP4pjaQuyVJjkGCQXmNvOtFjCMgA7Ba1zks8=;
	b=DvAzzu0+CjgZBZteUhuPUsIhq+dLlm0d/3/crZPH9LuRPjTMDBADN9jzs6Ga4UYUwXS3
	 NkYlLbf4hlsAeOIcyxEaRGa1ve2J+jGd1jHBGeHFEggqpQur+nE7VKxrI+aWv+Erho/pl
	 Hm6UOrGsfaY8F/b99Z0Mi/sI+0/woW7lkRDNPkDfbumk/tkw/7+NZ10/ckLxk4tZnUYLt
	 gB0PWSOp0twYe2qzftHm2ddq4/exA1oaCxolPOeKm1SC6VXPTr4bAD+iTE3ucbgbOfVYb
	 0yguPzl1VjW4geuGQKR5sO8wKjnMXiOqbJkyKkYXlChAf2+GJTkBwLEIsUHc07Gp8sw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id D31FAF800B6
	for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2026 03:03:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D31FAF800B6
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18cee6be141c6b00-webhooks-bot@alsa-project.org>
In-Reply-To: <18cee6be137d8f00-webhooks-bot@alsa-project.org>
References: <18cee6be137d8f00-webhooks-bot@alsa-project.org>
Subject: Why does the ALSA AAF plugin transmit more than 96,000 AVTP packets
 per second?
Date: Tue, 25 Aug 2026 03:03:29 +0200 (CEST)
Message-ID-Hash: ATN5FMSHRC74IOEULBLCUH45NFVGVRJ4
X-Message-ID-Hash: ATN5FMSHRC74IOEULBLCUH45NFVGVRJ4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ATN5FMSHRC74IOEULBLCUH45NFVGVRJ4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdXRpbHMgaXNzdWUgIzMzNCB3YXMgb3BlbmVkIGZyb20gbGl1eXEw
NTA5LXV4OgoKUXVlc3Rpb24KCkknbSB1c2luZyBhbiBBTFNBIEFBRiBQQ00gcGx1Z2luIHRvIHRy
YW5zbWl0IGF1ZGlvIG92ZXIgQVZUUC4KCk15IGF1ZGlvIGNvbmZpZ3VyYXRpb24gaXM6CgpTYW1w
bGUgcmF0ZTogICAgICA0ODAwMCBIegpGb3JtYXQ6ICAgICAgICAgICBTMTZfQkUKQ2hhbm5lbHM6
ICAgICAgICAgMgpmcmFtZXNfcGVyX3BkdTogICAxMgoKQWNjb3JkaW5nIHRvIG15IHVuZGVyc3Rh
bmRpbmcsIGZyYW1lc19wZXJfcGR1ID0gMTIgbWVhbnMgZWFjaCBBVlRQIEFBRiBwYWNrZXQgY29u
dGFpbnMgMTIgYXVkaW8gZnJhbWVzLgoKVGhlcmVmb3JlLCB0aGUgZXhwZWN0ZWQgcGFja2V0IHJh
dGUgc2hvdWxkIGJlOgoKNDgwMDAgLyAxMiA9IDQwMDAgcGFja2V0cy9zCgpIb3dldmVyLCB3aGVu
IEkgcnVuOgoKc3BlYWtlci10ZXN0IC1wIDI1MDAwIFwKICAgIC1GIFMxNl9CRSBcCiAgICAtYyAy
IFwKICAgIC1yIDQ4MDAwIFwKICAgIC1EIGFhZjAKCmFuZCBjYXB0dXJlIHRoZSB0cmFmZmljIHdp
dGggdGNwZHVtcCwgSSBzZWUgbW9yZSB0aGFuIDk2LDAwMCBBVlRQIHBhY2tldHMgcGVyIHNlY29u
ZC4KClRoaXMgaXMgbXVjaCBoaWdoZXIgdGhhbiB0aGUgZXhwZWN0ZWQgNCwwMDAgcGFja2V0cy9z
LgoKRm9yIGV4YW1wbGU6CgpFeHBlY3RlZDoKNDgwMDAgZnJhbWVzL3MgLyAxMiBmcmFtZXMvUERV
ID0gNDAwMCBBVlRQIHBhY2tldHMvcwoKT2JzZXJ2ZWQ6Cj4gOTYwMDAgQVZUUCBwYWNrZXRzL3MK
Ckkgd291bGQgbGlrZSB0byB1bmRlcnN0YW5kIHdoZXJlIHRoaXMgcGFja2V0IHRyYW5zbWlzc2lv
biByYXRlIGlzIGNvbWluZyBmcm9tLgoKUXVlc3Rpb25zCkRvZXMgc3BlYWtlci10ZXN0IGNvbnRy
b2wgdGhlIGFjdHVhbCBBVlRQIHBhY2tldCB0cmFuc21pc3Npb24gcmF0ZT8KSXMgc3BlYWtlci10
ZXN0IC1wIDI1MDAwIHJlbGF0ZWQgdG8gdGhlIEFWVFAgcGFja2V0IHRyYW5zbWlzc2lvbiBpbnRl
cnZhbCwgb3IgZG9lcyBpdCBvbmx5IGNvbnRyb2wgdGhlIEFMU0EgUENNIHBlcmlvZCBzaXplPwpX
aXRoOgo0OCBrSHoKMiBjaGFubmVscwpmcmFtZXNfcGVyX3BkdSA9IDEyCgpzaG91bGQgdGhlIEFB
RiBwbHVnaW4gbm9ybWFsbHkgdHJhbnNtaXQgYXBwcm94aW1hdGVseToKCjQwMDAgQVZUUCBwYWNr
ZXRzL3MKCnJlZ2FyZGxlc3Mgb2YgdGhlIHNwZWFrZXItdGVzdCBwZXJpb2Qgc2V0dGluZz8KCklm
IEkgb2JzZXJ2ZSBtb3JlIHRoYW4gOTYsMDAwIHBhY2tldHMvcywgY291bGQgdGhlIEFBRiBwbHVn
aW4gYmUgc2VuZGluZyB0aGUgc2FtZSBhdWRpbyBkYXRhIHJlcGVhdGVkbHksIG9yIGNvdWxkIHRo
ZXJlIGJlIG11bHRpcGxlIHBhY2tldHMgZ2VuZXJhdGVkIGZvciBlYWNoIEFMU0EgZnJhbWUvcGVy
aW9kPwpXaGF0IGlzIHRoZSByZWNvbW1lbmRlZCB3YXkgdG8gZGV0ZXJtaW5lIHdoaWNoIGNvbXBv
bmVudCBjb250cm9scyB0aGUgYWN0dWFsIEFWVFAgdHJhbnNtaXNzaW9uIHRpbWluZyDigJQgc3Bl
YWtlci10ZXN0LCBBTFNBLCBvciB0aGUgQUFGIFBDTSBwbHVnaW4/CgpJIGhhdmUgY29uZmlybWVk
IHRoYXQgdGhlIGNhcHR1cmVkIHBhY2tldHMgYXJlIEFWVFAgQUFGIHBhY2tldHMuIEkgd291bGQg
YXBwcmVjaWF0ZSBhbnkgZXhwbGFuYXRpb24gb2YgaG93IHRoZSBBTFNBIEFBRiBwbHVnaW4gZGV0
ZXJtaW5lcyB0aGUgQVZUUCBwYWNrZXQgdHJhbnNtaXNzaW9uIGludGVydmFsLgoKSXNzdWUgVVJM
ICAgICA6IGh0dHBzOi8vZ2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11dGlscy9pc3N1ZXMv
MzM0ClJlcG9zaXRvcnkgVVJMOiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2Et
dXRpbHMK
