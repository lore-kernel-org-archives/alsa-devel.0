Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12534CCF2C4
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Oct 2026 19:54:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B92260202;
	Fri, 16 Oct 2026 21:54:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B92260202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792180466;
	bh=wPkvs5vRrcYnRGYDwKONn2hWgWXkpXrWJE5LgsQAhXA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=pw9wwgEdNtfUVnKRyWODPCezrXawu6hljNZH4H8Ysf19bgxnjXzl5xIGhn+/Cr2Es
	 FjtvoUj1Aaz5qQDavz4Bgs0DabQIcjjvwSNYZhoi8+wsyzfD0Kci1yuPWi2j61TNYJ
	 TGYJixgJFITQG6Lxek0lwB0l541E7ZKD7jXsyzCk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EB271F805F5; Fri, 16 Oct 2026 21:53:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 893BDF80600;
	Fri, 16 Oct 2026 21:53:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A1BECF80423; Fri, 16 Oct 2026 21:53:44 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792180423;
	b=iSAJD84u/zPp6FuqfBcMnTMnyfF3M9NSVbDq/0mzm13cKRQ6KQEwUPuEa0k3geX8qEFM
	 UjGpMiixOeGEySiYOLfgzH1V1Kg8/NAlzxxWHS6TlG1xx5fu73w0uN0XgDgoaNlyo52ja
	 0h66vUhYMgEyRVzhniLvPffdUxRL7rCewgxQsrTBDaztng56eEbwnrXTzM+7R4K1ZiTLx
	 G51HQNjcdRpFLZx/IeYkRdF1Z5gZKYkgGs4cBrHRbL3h42v26/pHqXUBNlGAP0r1XyUho
	 wJU6eVP+OnMeT7RZU2Wtlgh/68obD4J2NO7GYI1tdooj+Psz/qzeSG/hzNYdeJH9wBg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792180423;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=wPkvs5vRrcYnRGYDwKONn2hWgWXkpXrWJE5LgsQAhXA=;
	b=AUEH2Py2pOEOxLF4Acl1RNJJtRv28FVEnKNjanAUUo3/W/2Swv1vqqOIIdQRTUMVQmLi
	 jRbSewsZF/xOwSGTy7x/vOwgLhSpRAXt5ThnZ/3fZM9UJ+TwCdvzA1yz/rUfq58Pu5c6A
	 /l14vJ2YZs4EeQ7wcQIn8Zkbes0VhrsKHfTBp+npUMsDEDrpaBRwYUabkUsCqeCQPJCWl
	 xsvANeZRZSNtBCi/q+9OLWyMNwmIlChwOf3KewUT9fOZgjbJ5eTDl1JyTwOYvXmtNsHp1
	 xuqr9MeXaq5siz5I0sRDYKmqQe935fHLtmpzbqXuPIK8dwhwPJ4bMXudcvCpmFQ9u1A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 94356F80212
	for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2026 21:53:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94356F80212
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18df1a993092cc00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/534@alsa-project.org>
References: <alsa-project/alsa-lib/pr/534@alsa-project.org>
Subject: conf: USB-Audio: use PCM device 1 for IEC958 on C-Media HIFI Decode
 Audio
Date: Fri, 16 Oct 2026 21:53:44 +0200 (CEST)
Message-ID-Hash: URZMVPM47P5Q2HASWFAPU4GLT4DBDZ3A
X-Message-ID-Hash: URZMVPM47P5Q2HASWFAPU4GLT4DBDZ3A
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/URZMVPM47P5Q2HASWFAPU4GLT4DBDZ3A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtbGliIHB1bGwgcmVxdWVzdCAjNTM0IHdhcyBvcGVuZWQgZnJvbSBi
cGtyb3RoOgoKVGhlIEMtTWVkaWEgIkhJRkkgRGVjb2RlIEF1ZGlvIiBVU0IgZGV2aWNlIChgMGQ4
YzowMDg5YCkgcHV0cyBpdHMgb3B0aWNhbCBTL1BESUYgb3V0cHV0IG9uIFBDTSBkZXZpY2UgMSwg
YnV0IGBVU0ItQXVkaW8uY29uZmAgbWFwcyBgaWVjOTU4YCB0byBkZXZpY2UgMCB1bmxlc3MgdGhl
IGNhcmQgaXMgbGlzdGVkIGluIGBVU0ItQXVkaW8ucGNtLmllYzk1OF9kZXZpY2VgLgpBcyBhIHJl
c3VsdCwgdGhlICJEaWdpdGFsIFN0ZXJlbyAoSUVDOTU4KSIgb3V0cHV0IGluIFBpcGVXaXJlL1B1
bHNlQXVkaW8gcGxheXMgdGhyb3VnaCB0aGUgYW5hbG9nIGphY2sgYW5kIHRoZSBvcHRpY2FsIG91
dHB1dCBzdGF5cyBzaWxlbnQuCgpgL3Byb2MvYXNvdW5kL2NhcmROL3N0cmVhbSpgIG9uIHRoaXMg
ZGV2aWNlOgoKLSBgc3RyZWFtMGAgKGludGVyZmFjZSAxLCBQQ00gZGV2aWNlIDApOiBTMTYvUzI0
L1MzMiBwbHVzIERTRCwgNDQuMSB0byA3Njgga0h6LiBUaGlzIGlzIHRoZSBhbmFsb2cgREFDLgot
IGBzdHJlYW0xYCAoaW50ZXJmYWNlIDIsIFBDTSBkZXZpY2UgMSk6IFMxNi9TMjQsIDQ0LjEgdG8g
MTkyIGtIei4gVGhpcyBpcyB0aGUgb3B0aWNhbCBTL1BESUYgb3V0cHV0LgotIGBzdHJlYW0yYCAo
aW50ZXJmYWNlIDIsIGFsdHNldCAzLCBQQ00gZGV2aWNlIDIpOiB0aGUgbm9uLVBDTSBhbHRlcm5h
dGUgc2V0dGluZyBvZiB0aGUgc2FtZSBTL1BESUYgZW5kcG9pbnQuCgpUZXN0ZWQgb24gVWJ1bnR1
IDI2LjA0IChhbHNhLWxpYiAxLjIuMTUuMywgUGlwZVdpcmUgMS42LjIsIGtlcm5lbCA3LjApLgpg
c3BlYWtlci10ZXN0IC1EIHBsdWdodzpDQVJEPUF1ZGlvLERFVj0xYCBwbGF5cyB0aHJvdWdoIHRo
ZSBvcHRpY2FsIG91dHB1dC4KV2l0aCB0aGUgc2FtZSBlbnRyeSBpbiBgfi8uYXNvdW5kcmNgLCB0
aGUgUGlwZVdpcmUgSUVDOTU4IHNpbmsgcGxheXMgdGhyb3VnaCBvcHRpY2FsIHRvby4KCvCfpJYg
R2VuZXJhdGVkIHdpdGggW0NsYXVkZSBDb2RlXShodHRwczovL2NsYXVkZS5jb20vY2xhdWRlLWNv
ZGUpCgpSZXF1ZXN0IFVSTCAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNh
LWxpYi9wdWxsLzUzNApQYXRjaCBVUkwgICAgIDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJv
amVjdC9hbHNhLWxpYi9wdWxsLzUzNC5wYXRjaApSZXBvc2l0b3J5IFVSTDogaHR0cHM6Ly9naXRo
dWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLWxpYgo=
