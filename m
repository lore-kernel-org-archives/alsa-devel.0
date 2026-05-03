Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9F7FF886F
	for <alsa-devel@archiver.kernel.org>; Sun,  3 May 2026 23:14:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6AD6601D7;
	Mon,  4 May 2026 01:14:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6AD6601D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777850076;
	bh=GJww0+6mJA+19hSTWAHE9pjfB8E4W1o2r1JsyMfcom8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=oACyg7X9ZINoxPlPFfIDu1Zm1/94S6BWwjCQUHcGEvAwobHOZrP5pS0LVzqSuVXCF
	 H3E6IPTQR3QUH6aLHovoHuH30O7mrKTKXCCALod+3qYdLm8xU36758snLq90QeIFQg
	 mfgk2ThF5ZVqG+TcJmk793WUTRGD6A8J98wXljgI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EB464F805F1; Mon,  4 May 2026 01:14:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F16DF805F1;
	Mon,  4 May 2026 01:14:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A4D47F8021D; Mon,  4 May 2026 01:13:54 +0200 (CEST)
Received: from crane.ash.relay.mailchannels.net
 (crane.ash.relay.mailchannels.net [23.83.222.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E7BDAF800C1
	for <alsa-devel@alsa-project.org>; Mon,  4 May 2026 01:13:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7BDAF800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=mungewell.org header.i=@mungewell.org
 header.a=rsa-sha256 header.s=default header.b=ZtAEJOL9
X-Sender-Id: idigitalinternetinc|x-authuser|simon@mungewell.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 24EAA3E04D6
	for <alsa-devel@alsa-project.org>; Sun, 03 May 2026 23:13:48 +0000 (UTC)
Received: from barmail4.idig.net (trex-green-9.trex.outbound.svc.cluster.local
 [100.97.183.230])
	(Authenticated sender: idigitalinternetinc)
	by relay.mailchannels.net (Postfix) with ESMTPA id 921463E158F
	for <alsa-devel@alsa-project.org>; Sun, 03 May 2026 23:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1777850027;
	b=z0mShq+0x5VK8UwUF4YBpWPJOPqtfG15qqovBqPiQzBD6EyybztiVstCIg/+sqciGmlkyQ
	elzcXFAau7rFkdxPYEB39NWj0Ey9VNxYEUhMTDOVx6LXy7JugEtCAvLACCUFUoOnuVuu17
	41W3IO0XPnkPb/dn2IDpk73f63kEVoFsnpFtreHcSeDKajI8czFY1mgz9phhIr/Ve8wGn7
	SA7ubvarFWDq1wUlRi4EfK69UOGcfcyZgYP9N0a/cdkLFl7jpm79uJ0NyByMjGYWsz0v5Q
	HNjAVEs9QdsBtOYXxT0eFE5siLPpkAwEnvdhN+Atw5+j+Wu4MMOHaO+ystSsjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1777850027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gGE7sDVvHTEMWz7HTofdu/IUlQqL3Pnl5oTjU/dOs3I=;
	b=UE2wLfajFHxMGiyNZMBwaec4yzDCzFb/UFWXHcvpBQiKDYsuUDaYK8247Fb0iRqpU8zNIe
	V+fNh1HE50FheFD/BigvcivRTHTBNQx4Stig/R+UooUbRkH0RGhAsfUI+KSywplTGqnJxy
	poZdgvkmLHb0i/J1T/vEccQ8gNtjx4FqkwA25XeCcXZuKnjn0/NKQKg/HqykzL4HRbbQeR
	GkAiFUW2HxXbwqh27rVIx8lZ1VRHl1BKmINnHYoA5F5R+fqXbjiEKlYBY6nRZdzFAUgf69
	GaP1Kyqbt6wQYvi+lpteCHYH82YraXKVTSPRHdJ72s0rcL25bvcewPtRNJ3clQ==
ARC-Authentication-Results: i=1;
	rspamd-859c89884f-cjkgv;
	auth=pass smtp.auth=idigitalinternetinc smtp.mailfrom=simon@mungewell.org
X-Sender-Id: idigitalinternetinc|x-authuser|simon@mungewell.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: idigitalinternetinc|x-authuser|simon@mungewell.org
X-MailChannels-Auth-Id: idigitalinternetinc
X-Name-Versed: 617758bf6d77561e_1777850027798_839236601
X-MC-Loop-Signature: 1777850027798:1127142371
X-MC-Ingress-Time: 1777850027797
Received: from barmail4.idig.net (barmail4.idig.net [104.36.151.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.183.230 (trex/7.1.5);
	Sun, 03 May 2026 23:13:47 +0000
Received: from cwh28.canadianwebhosting.com (cwh28.canadianwebhosting.com
 [66.85.29.119]) by barmail4.idig.net with ESMTP id fvMAoZMfECPREiZA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Sun, 03 May 2026 16:13:47 -0700 (PDT)
X-Barracuda-Envelope-From: simon@mungewell.org
X-Barracuda-Effective-Source-IP: cwh28.canadianwebhosting.com[66.85.29.119]
X-Barracuda-Apparent-Source-IP: 66.85.29.119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mungewell.org; s=default; h=Content-Type:Message-ID:References:In-Reply-To:
	Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gGE7sDVvHTEMWz7HTofdu/IUlQqL3Pnl5oTjU/dOs3I=; b=ZtAEJOL9DyE00nzyVvUkvj6CZ4
	Mr4RhPYOl7Ao3Corop1UQbOgz2khUjozDXdgnKyFWPpGDcb4AdedJrXjvMY8hWRAsLoA0dbc8Di0f
	uIjOWRmzlDQlaBsnXsj9ZTO0PUy0hMrktiJtDID16il2MuNhHvh0weThoZN50SE7AlswmUWPkbhJW
	dPGhW1wCxuEbmo2gbofZbV2X3V5mtcILrCpK/HlE1ywfHonjtkvKakLMON4VviXMr/sFvrqJVZUZT
	qYPJi6qqDn85xPwcTmrdnlV0qO1Hc3S6y0Py0a/bKnQ77IgpPMZfRH/AvnYtpJKmV3sOlmdu5sI73
	+htTEm4g==;
Received: from [::1] (port=38672 helo=cwh28.canadianwebhosting.com)
	by cwh28.canadianwebhosting.com with esmtpa (Exim 4.99.1)
	(envelope-from <simon@mungewell.org>)
	id 1wJg0Q-00000007f39-2fuS;
	Sun, 03 May 2026 19:13:46 -0400
MIME-Version: 1.0
Date: Sun, 03 May 2026 19:13:46 -0400
From: simon@mungewell.org
To: alsa-devel@alsa-project.org
Cc: Eldad Zack <eldad@fogrefinery.com>
Subject: RFC: M-Audio FT C600 - control for disabling the Output Gain Knob
In-Reply-To: <ed7a49ad09c2534813de239b8e7ff85d@mungewell.org>
X-ASG-Orig-Subj: RFC: M-Audio FT C600 - control for disabling the Output Gain
 Knob
References: <dba75d85bdff152847ef0ee91a9872d0@mungewell.org>
 <afUWW3v7iUpqFM2l@pandaemonium>
 <ed7a49ad09c2534813de239b8e7ff85d@mungewell.org>
User-Agent: Roundcube Webmail/1.6.15
Message-ID: <238004e257377814c5695d30ea258a5c@mungewell.org>
X-Sender: simon@mungewell.org
Content-Type: multipart/mixed;
 boundary="=_a996c390d579a32c2e163356b9f6052a"
X-AuthUser: simon@mungewell.org
X-Barracuda-Connect: cwh28.canadianwebhosting.com[66.85.29.119]
X-Barracuda-Start-Time: 1777850026
X-Barracuda-Encrypted: TLS_AES_256_GCM_SHA384
X-Barracuda-URL: https://104.36.151.218:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at idig.net
X-Barracuda-Scan-Msg-Size: 591
X-Barracuda-BRTS-Status: 0
X-ASG-Debug-ID: 1777850026-0d2e7037b30b6e0001-UKjUFf
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No,
 SCORE=0.00 using global scores of TAG_LEVEL=3.5 QUARANTINE_LEVEL=8.0
 KILL_LEVEL=4.0 test= 
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125474
	Rule breakdown below
	  pts rule name              description
	 ---- ----------------------
 --------------------------------------------------
	 0.00 NO_REAL_NAME           From: does not include a real name
Message-ID-Hash: TXKNEMOJ4DFUNABBWMB24AE2S6NK2HYS
X-Message-ID-Hash: TXKNEMOJ4DFUNABBWMB24AE2S6NK2HYS
X-MailFrom: simon@mungewell.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TXKNEMOJ4DFUNABBWMB24AE2S6NK2HYS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--=_a996c390d579a32c2e163356b9f6052a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII;
 format=flowed

Hi all,
Managed to pull a small patch together to enabling/disabling the Output 
Gain Knob, as is done in the Windows driver/control application. The 
outputs act in stereo pairs (1/2, 3/4, 5/6), the device defaults to all 
'adjusted' with the knob and you can now select any combination (or 
none).

This code likely works on the C400 as well, but I do not have that 
device to test/confirm. Tested against Linux 6.8.0, as that's what I run 
locally.

I can formally sign/submit a patch if there's no comments. Is that done 
here or on the kernel mailing lists?
Cheers,
Simon.
--=_a996c390d579a32c2e163356b9f6052a
Content-Transfer-Encoding: base64
Content-Type: text/x-diff;
 name=c600_out_gain_knob_disable.patch
Content-Disposition: attachment;
 filename=c600_out_gain_knob_disable.patch;
 size=2540

ZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9taXhlcl9xdWlya3MuYyBiL3NvdW5kL3VzYi9taXhlcl9x
dWlya3MuYwppbmRleCAwNjVhNGJlMGQ3NzEuLjFlYzk4NzE2Yzg3MSAxMDA2NDQKLS0tIGEvc291
bmQvdXNiL21peGVyX3F1aXJrcy5jCisrKyBiL3NvdW5kL3VzYi9taXhlcl9xdWlya3MuYwpAQCAt
MTA0Miw3ICsxMDQyLDcgQEAgc3RhdGljIGludCBzbmRfZnR1X2VmZl9zd2l0Y2hfaW5pdChzdHJ1
Y3QgdXNiX21peGVyX2ludGVyZmFjZSAqbWl4ZXIsCiAKIAllcnIgPSBzbmRfdXNiX2N0bF9tc2co
ZGV2LCB1c2JfcmN2Y3RybHBpcGUoZGV2LCAwKSwgVUFDX0dFVF9DVVIsCiAJCQkgICAgICBVU0Jf
UkVDSVBfSU5URVJGQUNFIHwgVVNCX1RZUEVfQ0xBU1MgfCBVU0JfRElSX0lOLAotCQkJICAgICAg
cHZhbCAmIDB4ZmYwMCwKKwkJCSAgICAgIChwdmFsICYgMHhmZjAwKSB8ICgocHZhbCAmIDB4ZmYw
MDAwKSA+PiAxNiksCiAJCQkgICAgICBzbmRfdXNiX2N0cmxfaW50ZihtaXhlci0+Y2hpcCkgfCAo
KHB2YWwgJiAweGZmKSA8PCA4KSwKIAkJCSAgICAgIHZhbHVlLCAyKTsKIAlpZiAoZXJyIDwgMCkK
QEAgLTEwNzYsNyArMTA3Niw3IEBAIHN0YXRpYyBpbnQgc25kX2Z0dV9lZmZfc3dpdGNoX3VwZGF0
ZShzdHJ1Y3QgdXNiX21peGVyX2VsZW1fbGlzdCAqbGlzdCkKIAkJCSAgICAgIHVzYl9zbmRjdHJs
cGlwZShjaGlwLT5kZXYsIDApLAogCQkJICAgICAgVUFDX1NFVF9DVVIsCiAJCQkgICAgICBVU0Jf
UkVDSVBfSU5URVJGQUNFIHwgVVNCX1RZUEVfQ0xBU1MgfCBVU0JfRElSX09VVCwKLQkJCSAgICAg
IHB2YWwgJiAweGZmMDAsCisJCQkgICAgICAocHZhbCAmIDB4ZmYwMCkgfCAoKHB2YWwgJiAweGZm
MDAwMCkgPj4gMTYpLAogCQkJICAgICAgc25kX3VzYl9jdHJsX2ludGYoY2hpcCkgfCAoKHB2YWwg
JiAweGZmKSA8PCA4KSwKIAkJCSAgICAgIHZhbHVlLCAyKTsKIAlzbmRfdXNiX3VubG9ja19zaHV0
ZG93bihjaGlwKTsKQEAgLTE0OTEsNiArMTQ5MSw0NCBAQCBzdGF0aWMgaW50IHNuZF9jNDAwX2Ny
ZWF0ZV9lZmZlY3RfcmV0X3ZvbF9jdGxzKHN0cnVjdCB1c2JfbWl4ZXJfaW50ZXJmYWNlICptaXhl
cgogCXJldHVybiAwOwogfQogCisvKiBvdXRwdXQgZ2FpbiBrbm9iIHNlbGVjdGl2ZWx5IGFkanVz
dHMgb3V0cHV0cyBhcyBzdGVyZW8gcGFpcnMgKi8KKy8qIHJldXNlcyBmdW5jdGlvbnMgZnJvbSBG
VFUgZWZmZWN0IHN3aXRjaCAqLworc3RhdGljIGludCBzbmRfYzQwMF9rbm9iX3N3aXRjaF9pbmZv
KHN0cnVjdCBzbmRfa2NvbnRyb2wgKmtjb250cm9sLAorCQkJCQlzdHJ1Y3Qgc25kX2N0bF9lbGVt
X2luZm8gKnVpbmZvKQoreworCXN0YXRpYyBjb25zdCBjaGFyICpjb25zdCB0ZXh0c1s4XSA9IHsK
KwkJIk5vbmUiLCAiMS8yIiwgIjMvNCIsICIxLzIgMy80IiwKKwkJIjUvNiIsICIxLzIgNS82Iiwg
IjMvNCA1LzYiLCAiMS8yIDMvNCA1LzYiCisJfTsKKworCXJldHVybiBzbmRfY3RsX2VudW1faW5m
byh1aW5mbywgMSwgQVJSQVlfU0laRSh0ZXh0cyksIHRleHRzKTsKK30KKworc3RhdGljIGludCBz
bmRfYzQwMF9jcmVhdGVfa25vYl9zd2l0Y2goc3RydWN0IHVzYl9taXhlcl9pbnRlcmZhY2UgKm1p
eGVyLAorCWludCB2YWxpZHgsIGludCBiVW5pdElEKQoreworCXN0YXRpYyBzdHJ1Y3Qgc25kX2tj
b250cm9sX25ldyB0ZW1wbGF0ZSA9IHsKKwkJLmlmYWNlID0gU05EUlZfQ1RMX0VMRU1fSUZBQ0Vf
TUlYRVIsCisJCS5uYW1lID0gIk91dHB1dCBHYWluIEtub2IiLAorCQkuaW5kZXggPSAwLAorCQku
YWNjZXNzID0gU05EUlZfQ1RMX0VMRU1fQUNDRVNTX1JFQURXUklURSwKKwkJLmluZm8gPSBzbmRf
YzQwMF9rbm9iX3N3aXRjaF9pbmZvLAorCQkuZ2V0ID0gc25kX2Z0dV9lZmZfc3dpdGNoX2dldCwK
KwkJLnB1dCA9IHNuZF9mdHVfZWZmX3N3aXRjaF9wdXQKKwl9OworCXN0cnVjdCB1c2JfbWl4ZXJf
ZWxlbV9saXN0ICpsaXN0OworCWludCBlcnI7CisKKwllcnIgPSBhZGRfc2luZ2xlX2N0bF93aXRo
X3Jlc3VtZShtaXhlciwgYlVuaXRJRCwKKwkJCQkJIHNuZF9mdHVfZWZmX3N3aXRjaF91cGRhdGUs
CisJCQkJCSAmdGVtcGxhdGUsICZsaXN0KTsKKwlpZiAoZXJyIDwgMCkKKwkJcmV0dXJuIGVycjsK
KwlsaXN0LT5rY3RsLT5wcml2YXRlX3ZhbHVlID0gKHZhbGlkeCA8PCA4KSB8IGJVbml0SUQ7CisJ
c25kX2Z0dV9lZmZfc3dpdGNoX2luaXQobWl4ZXIsIGxpc3QtPmtjdGwpOworCXJldHVybiAwOwor
fQorCiBzdGF0aWMgaW50IHNuZF9jNDAwX2NyZWF0ZV9taXhlcihzdHJ1Y3QgdXNiX21peGVyX2lu
dGVyZmFjZSAqbWl4ZXIpCiB7CiAJaW50IGVycjsKQEAgLTE1MjMsNiArMTU2MSwxMCBAQCBzdGF0
aWMgaW50IHNuZF9jNDAwX2NyZWF0ZV9taXhlcihzdHJ1Y3QgdXNiX21peGVyX2ludGVyZmFjZSAq
bWl4ZXIpCiAJaWYgKGVyciA8IDApCiAJCXJldHVybiBlcnI7CiAKKwllcnIgPSBzbmRfYzQwMF9j
cmVhdGVfa25vYl9zd2l0Y2gobWl4ZXIsIDB4MDkwMCwgMHgyMCk7CisJaWYgKGVyciA8IDApCisJ
CXJldHVybiBlcnI7CisKIAlyZXR1cm4gMDsKIH0KIAo=
--=_a996c390d579a32c2e163356b9f6052a--
