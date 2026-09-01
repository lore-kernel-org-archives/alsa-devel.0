Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DF9C61DD3
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2026 14:51:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A08E601D5;
	Tue,  1 Sep 2026 16:51:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A08E601D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788274278;
	bh=w1KbPKIAy6qO1MAuelDPup4sUlGJOp2VkNUs82O4x1M=;
	h=From:Date:Cc:To:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=JXEGRJc0mVc/WTKFkX5FXiYnPxRr/iYmgcLvABe3EKVU1PgbONAaamO+ZpYESeOWG
	 9+ruwyk65qfYHWWthM2bMn5z7TZy9n3NCzNCuej7uBbdnptCddGwf1VUZUZDp8LG+I
	 KYuDg+EXRhjlcDMZQYjv6G9SjFXFuq8Gnre/6X/o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 459EAF805B2; Tue,  1 Sep 2026 16:50:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 69CECF80601;
	Tue,  1 Sep 2026 16:50:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83408F804CC; Tue,  1 Sep 2026 16:50:35 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=103.89.5.43
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788274231;
	b=jdlioxkBJQkGkw+l6mFN7Qqk7P8vVYTY76/0lLZ603xZs1mgg7AGQOva99CXOil/PSu+
	 KnEDtZocAtRMbVFiq2fmlADkn6Mxg/+k77Kx1rQEXtV7X9W5WKJR+F5TQXUjDvzyCI63X
	 i/DFzVuBiEj1iTdybD5EzG9r3EcVSFRzKvheSeg28xxfP25wDJ0l9IA0oElHgw7FaX4vJ
	 Y6R+edRi3mgHG2/UDNiPBgtywBrvlB7O+34k8a/FCTQLRFt23kcPjmiTmMobvx6QmPrkr
	 UyiwYoln/eyW5ouGy4G1LChu/jn5z52T3JIdKBEdLzml7uz8rQ3wodJ/lvkuBr0HbbA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788274231;
	h=DKIM-Signature:From:Date:To:MIME-Version:Message-ID:Subject;
	bh=x7gKXq/ksmgzDxLJvl5gU8n+ePWclYehWfaz/nnhvxo=;
	b=H5dBJJbttqC0a3lzZ/Wchz5Hm5rumLebGZ2GcaexS8m08QvYewUSMj2t4ep5SV77NMEw
	 WDohQhIRRmVMuLMTpylwB7mTKagf7DxDm1opRvLxQgQZXJeQSJTWw51wscAPYpimo1t6l
	 ZR4xiTaZWxQSLNHHEfwjxzLDlhnqcuqlOquTtwZteqX8cVUFh8cbXQ6m6rCAz24ArwgBE
	 wq+uFo7WUUjRkZLKRV4BTQDRZxenwUPdcB7NTTGsZlid/Wqrz4dd6ch1Ozl2PZ9M8YEQK
	 oLMMVIeXAPBmqxLO33jjsLGtLrWPyCAyuTLOJBycUmUw17y0v/2niGBacDxch7PjCmg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=n0th1ng.my.id header.i=@n0th1ng.my.id header.a=rsa-sha256
 header.s=dkim header.b=S9QGxO87;
	arc=none smtp.remote-ip=103.89.5.43
Received: from mail.n0th1ng.my.id (mail.n0th1ng.my.id [103.89.5.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5E6BBF801F5
	for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2026 16:50:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E6BBF801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=n0th1ng.my.id header.i=@n0th1ng.my.id
 header.a=rsa-sha256 header.s=dkim header.b=S9QGxO87
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPA id 4799180724;
	Tue, 01 Sep 2026 21:50:09 +0700 (WIB)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n0th1ng.my.id;
	s=dkim; t=1788274212;
	h=from:subject:date:message-id:to:cc:mime-version:content-type;
	bh=x7gKXq/ksmgzDxLJvl5gU8n+ePWclYehWfaz/nnhvxo=;
	b=S9QGxO87cQZ3YX7xpPy6LXETXRwPbEdPtdohYYn1jrQ8CHVhG9JYvHoBzCPbxBlhShNPYj
	3jl07LL+PgFsUL14M1mSLAGZU5K77qY05HZpVbn0Q+n62f8GwwSPK2q0yDdWg8CMqXzqct
	yh0fF4LSsbGlPZxHFNIS6UxoQ1RKTY1Ho25DxHBZP4vATctehv2a4nE1BiIxjuIPwY13Zl
	MIaZ45aqu7osIjMRFy+Kcda8JkKIW0yZoCTBcP2h4ApLFBHtyJnOTlk44vlKpxPNt1FzeU
	SqeLHBQ5xvsbg78ZxuTZtf3nRCSUjSEqqYjMFO9kPwEgfa0OwDy6Ot+kLVyJjg==
From: "epreinhad" <epreinhad@n0th1ng.my.id>
Date: Tue, 01 Sep 2026 21:50:09 +0700
Cc: linux-usb@vger.kernel.org
To: alsa-devel@alsa-project.org
MIME-Version: 1.0
Message-ID: <28694f1b-93b7-5606-7fc9-0411c28d23a3@n0th1ng.my.id>
Subject: [Bug Report] snd-usb-audio playback stuttering on Realtek USB Audio
 =?utf-8?q?(0bda=3A483e)?=
User-Agent: SOGoMail 5.12.9
X-Last-TLS-Session-Version: None
Message-ID-Hash: DHFKMHRFSEDGUJBRKMDBYXWOODDPXUF6
X-Message-ID-Hash: DHFKMHRFSEDGUJBRKMDBYXWOODDPXUF6
X-MailFrom: epreinhad@n0th1ng.my.id
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=utf-8
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DHFKMHRFSEDGUJBRKMDBYXWOODDPXUF6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

DQpEZWFyIEFMU0EgYW5kIEtlcm5lbCBEZXZlbG9wZXJzLA0KSSBhbSB3cml0aW5nIHRvIHJlcG9y
dCBhIHBlcnNpc3RlbnQgYXVkaW8gc3R1dHRlcmluZyBhbmQgYnVmZmVyIHVuZGVycnVuIGlzc3Vl
IG9jY3VycmluZyB3aXRoIGEgUmVhbHRlayBVU0IgQXVkaW8gZGV2aWNlIChWSUQ6IDBiZGEsIFBJ
RDogNDgzZSwgU2FkZXMgRGlhYmxvIGdhbWluZyBoZWFkc2V0KSBhY3Jvc3MgbXVsdGlwbGUgTGlu
dXggZGlzdHJpYnV0aW9ucyAoaW5jbHVkaW5nIENhY2h5T1MpIGFuZCBBbmRyb2lkLiBUaGUgZGV2
aWNlIHdvcmtzIGNvbXBsZXRlbHkgYXMgZXhwZWN0ZWQgb24gV2luZG93cy4NClN5c3RlbSBFbnZp
cm9ubWVudDoNCiAqIA0KT1M6IENhY2h5T1MgKEFyY2ggTGludXggYmFzZWQpIC8gQW5kcm9pZCAq
IA0KS2VybmVsOiA3LjIuMi0xLWNhY2h5b3MgKiANCkFyY2hpdGVjdHVyZTogeDg2XzY0DQpQcm9i
bGVtIERlc2NyaXB0aW9uOiBEdXJpbmcgc3RhbmRhcmQgcGxheWJhY2ssIHRoZSBkZXZpY2UgZXhw
ZXJpZW5jZXMgY29uc2lzdGVudCBhdWRpbyBzdHV0dGVyaW5nLiBEaXJlY3QgQUxTQSB0ZXN0aW5n
IHVzaW5nIHNwZWFrZXItdGVzdCAtRCBodzoyLDAgLWMgMiAtciA0ODAwMCAtRiBTMTZfTEUgb2Nj
YXNpb25hbGx5IHRocm93cyBhIC01IElucHV0L291dHB1dCBlcnJvci4gSG93ZXZlciwgZG1lc2cg
c2hvd3Mgbm8geEhDSSBob3N0IGVycm9ycywgVVNCIGRpc2Nvbm5lY3RzLCBvciBkcm9wcGVkIFVS
QnMgZHVyaW5nIHRoZXNlIGRyb3BvdXRzLiBUaGlzIHBvaW50cyB0byBhIHByb3RvY29sIGNvbXBs
aWFuY2UgaXNzdWUgb3IgYW4gaXNvY2hyb25vdXMgYWRhcHRpdmUgZW5kcG9pbnQgc3luY2hyb25p
emF0aW9uIHF1aXJrIGluIHRoZSBkZXZpY2UgZmlybXdhcmUgdGhhdCBXaW5kb3dzIHRvbGVyYXRl
cywgYnV0IHNuZC11c2ItYXVkaW8gZG9lcyBub3QuDQpUcm91Ymxlc2hvb3RpbmcgUGVyZm9ybWVk
Og0KICogDQpEaXNhYmxlZCBVU0IgYXV0b3N1c3BlbmQgKHVzYmNvcmUuYXV0b3N1c3BlbmQ9LTEp
LiAqIA0KVGVzdGVkIHNuZC11c2ItYXVkaW8gcGFyYW1ldGVyIGltcGxpY2l0X2ZiPTAuICogDQpC
eXBhc3NlZCBQaXBlV2lyZS9QdWxzZUF1ZGlvIHRvIHRlc3QgcmF3IEFMU0EgaGFyZHdhcmUuICog
DQpTd2l0Y2hlZCBwaHlzaWNhbCBwb3J0cyBiZXR3ZWVuIFVTQiAyLjAgYW5kIFVTQiAzLnggY29u
dHJvbGxlcnMuDQpEaWFnbm9zdGljIExvZ3M6DQogKiANCkFMU0EgSW5mb3JtYXRpb24gU2NyaXB0
IG91dHB1dDogaHR0cHM6Ly9hbHNhLXByb2plY3Qub3JnL2RiLz9mPWM1MGUxMjAyYjM3MzA5ZjQ2
M2FlMzEwZDJlYWZjYjMyZjI3YTQxZjNodHRwczovL2Fsc2EtcHJvamVjdC5vcmcvZGIvP2Y9YzUw
ZTEyMDJiMzczMDlmNDYzYWUzMTBkMmVhZmNiMzJmMjdhNDFmMw0KUGxlYXNlIGxldCBtZSBrbm93
IGlmIGFueSBhZGRpdGlvbmFsIGxvZ3Mgb3IgdGVzdHMgYXJlIHJlcXVpcmVkIHRvIGFkZHJlc3Mg
dGhpcyBjb21wYXRpYmlsaXR5IGlzc3VlLg0KQmVzdCByZWdhcmRzLA0KZXByZWluaGFkDQrCoA0K
