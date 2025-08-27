Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9C9CAC583
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Sep 2025 12:10:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 464F260222;
	Tue,  9 Sep 2025 14:10:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 464F260222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1757419839;
	bh=h/HIr/WDt+yBoE732Qkwf9iKajO/p41H3NszMzEklZo=;
	h=Date:To:From:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=n0H1r9zO0XdIr5K8HeorlhjzjP45vtdVR0qXKsC6PlTfG/S+RRIUMUc+UF0KeNHR5
	 xRV4sKllnsCKbw7wdpD6UKoL9vXg3Z1Nvc3PHyypunBq01/lA+wLyDKS9K0a3UQLbf
	 XwSWJZYcz0aNQd1/ZZnsKm/ZprSKH5Lr/BhiiHDA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D603F8061B; Tue,  9 Sep 2025 14:09:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 20575F80616;
	Tue,  9 Sep 2025 14:09:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CC9A1F80495; Wed, 27 Aug 2025 03:44:47 +0200 (CEST)
Received: from mail-24431.protonmail.ch (mail-24431.protonmail.ch
 [109.224.244.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 40B54F80072
	for <alsa-devel@alsa-project.org>; Wed, 27 Aug 2025 03:44:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40B54F80072
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=ORvFrbec
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1756259083; x=1756518283;
	bh=gPXD+Hebhj/eTgCEy6ha70x0aUmHQUJimLvaKigtkDo=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ORvFrbecgBqwJy+ggGODck8tpXgOSCO3gtNvLzE0BbsKvbeH00+pmIWCh7LBgUC9z
	 krFnH5bbm83NAcd8e/PDBBymjiIA5a4/MiPl+G9tG8DOi1MVO24Z/Hy75LZS04c8bj
	 xo432mgxvlN1v2cxw0yW5GKhqraQhpCrq8Vpbphzd5lGjrhHsfdP6/7MVKCkULTfNP
	 2WOG8g4JoxvjKLCdfO/R0Tr4bffJsQtAIWOAgQtHwBIxsekGCX1j33x1peGcMcApiX
	 HPJEkGeTtE+c5x5EQqicr+Zq699x9wdjMAVJBjpaGOYremTTCvcKb3YU1uDqQGnVlW
	 FkTQgoHLUXDiQ==
Date: Wed, 27 Aug 2025 01:44:39 +0000
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
From: Sylvain Grenier <sylvain.gre@proton.me>
Subject: ADC Soundcard hack : Increase by 2 the number of channels for any adc
 soundcard
Message-ID: 
 <2rB-Dm8qwhRnjF4lJ6QeS3pjFEpm_NfKYaxgrNCjpFDgD1H7Kz2OifTgNSSWs-x9qDa76X8OxE0jq8BsJq0TU3stU7HDIVd4XGNegK5f1kI=@proton.me>
Feedback-ID: 157367353:user:proton
X-Pm-Message-ID: 85f595a35da364d47272c5b1c067a4bb73cb9336
MIME-Version: 1.0
X-MailFrom: sylvain.gre@proton.me
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: F7QI6I6VBID25O4NAHIHXEPG37NAVTXX
X-Message-ID-Hash: F7QI6I6VBID25O4NAHIHXEPG37NAVTXX
X-Mailman-Approved-At: Tue, 09 Sep 2025 12:09:17 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=utf-8
X-Content-Filtered-By: Mailman/MimeDel 3.3.9
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/F7QI6I6VBID25O4NAHIHXEPG37NAVTXX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGVsbG8gYWxzYSB0ZWFtLAoKVG8gYmVnaW4sIHRoYW5rIHlvdSBhbGwgdGhlIHRlYW0gZm9yIHdo
YXQgeW91IGRvLCB0aGUgYWxzYS1wcm9qZWN0IGlzIGEgd29uZGVyZnVsbCBvcGVuLXNvdXJjZSBw
cm9qZWN0IQpNeSBnb2FsIGlzIHRvIGluY3JlYXNlIHRoZSBudW1iZXIgb2YgY2hhbm5lbHMgb2Yg
bXkgYWRjIHNvdW5kY2FyZCBieSBzZXBhcmF0ZSBvbmNlIGFnYWluIGEgbGVmdC1yaWdodCBmb3Ig
b25lIGNoYW5uZWwuClVzaW5nIGEgc21hbGwgZWxlY3Ryb25pYyBzY2hlbWUgbGlrZSB0aGlzIChp
dCdzIGEgZmlyc3Qgc2ltdWxhdGlvbiB0cnksIEkgaGF2ZSB0byB0ZXN0IGFuZCBpbXByb3ZlKSwg
d2UgY2FuIG11bHRpcGx5IHRoZSBudW1iZXIgb2YgY2hhbm5lbHMgYnkgMi4KW2ltYWdlLnBuZ10K
T2YgY291cnNlLCB0aGUgc2FtcGxpbmcgZnJlcXVlbmN5IHdpbGwgYmUgZGVjcmVhc2VkIGJ5IDIg
dXNpbmcgdGhpcyBtZXRob2QuCldoZXJlIGNhbiBJIGJlZ2luIHdpdGggYWxzYSB0byBpbmNyZWFz
ZSB0aGUgbnVtYmVyIG9mIGNoYW5uZWxzIGFuZCBhZGp1c3QgdGhlIHNhbXBsaW5nIGZyZXF1ZW5j
eSA/ClNvbWV0aGluZyBsaWtlIGEgdmlydHVhbCBzb3VuZGNhcmQgbWF5YmUgPwpJIGhhdmUgc2tp
bGxzIGluIGRldiBidXQgZG9uJ3Qga25vdyB3aGVyZSBJIGhhdmUgdG8gc3RhcnQgd2l0aCBhbHNh
IGZvdCB0aGlzIGhhY2suLi4KCkJlc3QgcmVnYXJkcywKU3lsdmFpbiBHcmVuaWVy
