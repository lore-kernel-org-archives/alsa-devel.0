Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001A3CC6B2D
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:54:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F9C360205;
	Thu, 15 Oct 2026 01:54:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F9C360205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792022051;
	bh=Lq8IhiYwz+nBf58OogaO2nyzxnV8/cHfqbXIuQeJnmI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=d71twjollFWK7n4/0qsn1i0PughMLa0AizfEDS0q6oVpK5I2O4fKJQljj6qkSnRsg
	 piczkI4dNub/Ek3TNBHdZd9WgBD3YhuXLgdBAY3f7/dtFTOg81TA97z04uEWzKKx4a
	 ZW1bloHMuVoCX28z2FfRMfsldMPkkOXKof0vaRKY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C1236F805FE; Thu, 15 Oct 2026 01:53:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E8B45F80553;
	Thu, 15 Oct 2026 01:53:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5C40FF804CF; Thu, 15 Oct 2026 01:53:29 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792022008;
	b=CfndniL/E7RWhL/YK+BQU8xnQMIijNo4CW5pu/S0cVHi3ZYMShsTpXELDT0V02dhHOJL
	 qL3CihgF55HOGDiOofAd0R5iIaDyxxRuQFD10g9tFTeoWj4qC7RPOYgsk7xZmyNc/hh2i
	 o1Io/In+xbwMV+l02Bx6uSUHk/xC02fpWT2nSB9dc5gXw5V0lkaAP40rNgOt0Byfi3HI4
	 Ke5Za7WXiUWBCUWcuTpJlnAm7nFCubw1gp1OTOG+KNt75bVQil0i0yao81CcXMukC8wIa
	 1f3Dk6gyY+7OJECnnthARYTENffFGUjmo8JE2+Ct1+vD6j5ZP0bEZ1eMR5Xw1MGu2IA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792022008;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=Lq8IhiYwz+nBf58OogaO2nyzxnV8/cHfqbXIuQeJnmI=;
	b=J9dtF4KHHkmRKdJHZVqmhEgigo48iUt8FXQpaEfuQu4EN6IaO7PBw5xLEChGTQ4Q5UCh
	 oxtJQrnVIcDWRA/l4MxAKTOKQqp/s9riL1KeEgCnvIp8QR5aDOPCEXqa29MQ2sBPrkV0T
	 PInmqr9eUzs9zFIetbQfMp3AtMwft0UqYzVZML8R4FKq56mvcqPIQaaxn2WQJLm9PEISu
	 54LluUiF4TGCRDZBIvtWCiFHqcql9mmRUjJqZr1fdzTm06ygfOqN0HuuhtVTqhAV9d2kI
	 z8eNlmE5AtoM3q3xyWh911MTpUylUDiJMOs42/68i22DtwtrJ7wsjMPzUPHTt8RjcNg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DCAEF8026D
	for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2026 01:53:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9DCAEF8026D
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18de8a854e183700-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/533@alsa-project.org>
References: <alsa-project/alsa-lib/pr/533@alsa-project.org>
Subject: conf: USB-Audio: Add ASUS ROG Zenith II S/PDIF device mapping
Date: Thu, 15 Oct 2026 01:53:29 +0200 (CEST)
Message-ID-Hash: FKGEJ4YHECSIEBKGRSB6AD6PPI7DJLUV
X-Message-ID-Hash: FKGEJ4YHECSIEBKGRSB6AD6PPI7DJLUV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FKGEJ4YHECSIEBKGRSB6AD6PPI7DJLUV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtbGliIHB1bGwgcmVxdWVzdCAjNTMzIHdhcyBvcGVuZWQgZnJvbSBi
eXJjb2xpbjoKCkZpeGVzICM1MzIKCkFkZHMgdGhlIHR3byBvbmJvYXJkIFVTQiBhdWRpbyBjb2Rl
Y3Mgb2YgdGhlIEFTVVMgUk9HIFplbml0aCBJSSBFeHRyZW1lIChUUlg0MCkgdG8gdGhlIGBVU0It
QXVkaW8ucGNtLmllYzk1OF9kZXZpY2VgIHRhYmxlOgoKLSBgIlplbml0aCBJSSBNYWluIEF1ZGlv
IiAxYCAoYDBiMDU6MTkxNmAsIFJlYWx0ZWsgQUxDMTIyMC1WQik6IFMvUERJRiBpcyBQQ00gZGV2
aWNlIDE7IGRldmljZSAwIGlzIHRoZSA4LWNoYW5uZWwgYW5hbG9nIG91dHB1dC4gV2l0aG91dCB0
aGlzLCBgaWVjOTU4OmAgb3BlbmVkIGRldmljZSAwIGFuZCB0aGUgSUVDOTU4IG91dHB1dCBpbiBQ
aXBlV2lyZS9QdWxzZUF1ZGlvIHBsYXllZCB0byB0aGUgYW5hbG9nIGphY2tzLgotIGAiWmVuaXRo
IElJIEZyb250IEhlYWRwaG9uZSIgOTk5YCAoYDBiMDU6MTkxNWApOiBhbmFsb2ctb25seSBjb2Rl
YyB3aXRoIG5vIGRpZ2l0YWwgb3V0cHV0LCBzbyBgaWVjOTU4OmAgc2hvdWxkIG5vdCBvcGVuIGl0
LgoKVGVzdGVkIG9uIEFsbWFMaW51eCAxMC4yIChhbHNhLWxpYiAxLjIuMTUuMywgUGlwZVdpcmUg
MS40LjExKTogYGllYzk1ODpDQVJEPUF1ZGlvYCBvcGVucyBgaHc6MCwxYCwgYXVkaW8gcGxheXMg
b3ZlciBvcHRpY2FsIFMvUERJRiwgYW5kIHRoZSBmcm9udCBoZWFkcGhvbmUgY29kZWMgc2hvd3Mg
dXAgYXMgYW5hbG9nIHN0ZXJlbyBvbmx5LgoKVGhpcyBjaGFuZ2Ugd2FzIGNyZWF0ZWQgYnkgQ2xh
dWRlIChBbnRocm9waWMncyBDbGF1ZGUgT3B1cyA1LjUsIGhpZ2ggZWZmb3J0KSB2aWEgQ2xhdWRl
IENvZGUgYW5kIHRlc3RlZCBhcyB3b3JraW5nIG9uIHRoZSBhZmZlY3RlZCBoYXJkd2FyZSBieSBD
b2xpbiBCeXJuZS4KCvCfpJYgR2VuZXJhdGVkIHdpdGggW0NsYXVkZSBDb2RlXShodHRwczovL2Ns
YXVkZS5jb20vY2xhdWRlLWNvZGUpCgpSZXF1ZXN0IFVSTCAgIDogaHR0cHM6Ly9naXRodWIuY29t
L2Fsc2EtcHJvamVjdC9hbHNhLWxpYi9wdWxsLzUzMwpQYXRjaCBVUkwgICAgIDogaHR0cHM6Ly9n
aXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLWxpYi9wdWxsLzUzMy5wYXRjaApSZXBvc2l0b3J5
IFVSTDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLWxpYgo=
