Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C32BCD8CAD
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:28:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D7CE6601CE;
	Tue,  9 Jun 2026 13:28:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D7CE6601CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781004515;
	bh=AyXebXIn/2fmEHnPdbduA56s7V9aBOSfrsbHbOUPOx8=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=rIvGy9VO4FCIodujrsCXFcBNOqr56YNuZV91DeDDnP3FK1yYOXkf+QKfdl5z6ich8
	 hUT51Mcm9fVNVyJbA5lfXNvrd9WCll5vMkSoxm8Xmjym+Ju5j/xV913HfZUsPKpPuz
	 u5DQtzY4DnTEWi1GSuAYOP9BEAYM8TR6Fn1ygeW4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9E401F805FA; Tue,  9 Jun 2026 13:28:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EA2BF805FF;
	Tue,  9 Jun 2026 13:28:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 06FDCF80423; Mon,  8 Jun 2026 13:38:10 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780918688;
	b=M+rRzM8LUwaGvlKz9YzZ7vwhn8kwB7j6STb8a17a2hn/pk5CKAn5NrY3NJdyvKN+Zrjp
	 gDLbj+8s9H6IhH1G41YCb4obdv4Gqe/l+JfCK/14l/Q/kN/h9KPSbpv/TsoouMCrumdev
	 cpa/5PWggLHSuRW2m0A921TlEH8VkbAVhIufmDQEWws2RtjQqL8PA/D4Uc1TZocjEJwsB
	 QTkckiwv1Z1p1gDG41O5q5llT3Vw33TRdJbNQ2bSj3MGkLrcwsJxs602C1QiapXNNPqxY
	 RTHErHfOBaWwcOrmVhK2dkf7hWgfGHB6aS9vR9ntTQDm7uFZNjoe9h6tNmvNyS3m8LQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780918688;
	h=DKIM-Signature:Date:From:To:Subject:MIME-Version:Message-ID;
	bh=o+/fSOot4Zu78qrBuDoiNo6kYrn+FzJqTKRv6ZnDG0Y=;
	b=eaceo/DQYth/SMIUIcu2JN17kCPOoy39NUk+81jZD2Ktj5HD4/efoRddLQ4GloLmwjjW
	 TNp5t3iWLjp+/6FuKevIeypUbAOBbnrL5no2jPhfFusFwAj7OteVGSsrDK/JPwHw4KdFC
	 QC8u+8HWhok/3E5MPSljA0QKOyIXCK9PfHYOTUTlbZzhZRK+ZP6iSAELaZCsfE0FJz4Xw
	 XWwlLj78+oXF9AsdI2Iw7aEGwv2CKGMhbu1SP0RhJnaeOEHtKv0jmltQkfdg0ZRN5VCL4
	 NZfRiw3zMV72ZMKnpyaIqHZgBDvQLayl3AmeNBPuNvSGZ7yY82vzYDP7MTHdXwb5I+w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=GsFzAerj;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 00C65F80153
	for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2026 13:38:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00C65F80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=GsFzAerj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=o+/fSOot4Zu78qrBuDoiNo6kYrn+FzJqTKRv6ZnDG0Y=; b=G
	sFzAerjAgDPYt8vo3vgsrme7sLzwO6SutcpwiROLx9l6ZibSCQ5Bmm8Fr5WmBMzK
	ijhjimBvs+vyRyzs1E/2MTjWu30jXSlowkMCiftBeIbouyv5RNbhXysQbTIDAU59
	1toCOmPaafyokysYAH/E66O2EpqnqbNLAvyk2GKiog=
Received: from ks002278$163.com ( [101.241.83.252] ) by
 ajax-webmail-wmsvr-40-109 (Coremail) ; Mon, 8 Jun 2026 19:38:02 +0800 (CST)
X-Originating-IP: [101.241.83.252]
Date: Mon, 8 Jun 2026 19:38:02 +0800 (CST)
From: "thomas.kuang" <ks002278@163.com>
To: alsa-devel@alsa-project.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [alsa-devel] [BUG] Lenovo ThinkBook 16 G7 QOY (Snapdragon X) - No
 soundcards detected
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260403(27802f6d) Copyright (c) 2002-2026 www.mailtech.cn 163com
X-NTES-SC: 
 AL_Qu2TAvWat04j5CWbZekcnEobges3WcG2uP8m1Ydfc+IEmx3o+SI7XEdRNkXX4s2FMg+cjT22fQZj0cRRXoJjbb0XmkVz3vk7uNDaOPME+w==
MIME-Version: 1.0
Message-ID: <73177fda.a297.19ea70683aa.Coremail.ks002278@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: bSgvCgDnn3iaqSZqRCgFAA--.643W
X-CM-SenderInfo: dnvqijqsxyqiywtou0bp/xtbDABq0VWomqZqzMwAA3E
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-MailFrom: ks002278@163.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: XNWMRWRKWCJHCX5CSHOVT3VJNRK4NRXF
X-Message-ID-Hash: XNWMRWRKWCJHCX5CSHOVT3VJNRK4NRXF
X-Mailman-Approved-At: Tue, 09 Jun 2026 11:27:56 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XNWMRWRKWCJHCX5CSHOVT3VJNRK4NRXF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGFyZHdhcmU6IExlbm92byBUaGlua0Jvb2sgMTYgRzcgUU9ZIChRdWFsY29tbSBTbmFwZHJhZ29u
IFggLyBYIFBsdXMgLyBYIEVsaXRlKQpLZXJuZWwgdmVyc2lvbjogNy4wLjAtMjItZ2VuZXJpYyAo
VWJ1bnR1IDI2LjA0IExUUykKQXJjaGl0ZWN0dXJlOiBhYXJjaDY0CgpQcm9ibGVtIERlc2NyaXB0
aW9uOgotLS0tLS0tLS0tLS0tLS0tLS0tCkF1ZGlvIGlzIG5vdCB3b3JraW5nIG9uIHRoaXMgU25h
cGRyYWdvbiBYLWJhc2VkIGxhcHRvcC4gVGhlIHN5c3RlbSBmYWlscyB0byBkZXRlY3QgYW55IHNv
dW5kY2FyZHMsCmV2ZW4gdGhvdWdoIHRoZSBRdWFsY29tbSBhdWRpbyBkcml2ZXIgbW9kdWxlcyBh
cmUgbG9hZGVkLgoKU3ltcHRvbXM6Ci0tLS0tLS0tLQotIGBhcGxheSAtbGAgc2hvd3M6ICJubyBz
b3VuZGNhcmRzIGZvdW5kLi4uIgotIGBjYXQgL3Byb2MvYXNvdW5kL2NhcmRzYCBzaG93czogIi0t
LSBubyBzb3VuZGNhcmRzIC0tLSIKLSBgL2Rldi9zbmQvYCBvbmx5IGNvbnRhaW5zIHNlcSBhbmQg
dGltZXIgZGV2aWNlcywgbm8gcGNtIGRldmljZXMKClJlbGV2YW50IFN5c3RlbSBJbmZvcm1hdGlv
bjoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKJCB1bmFtZSAtYQpMaW51eCBrcy1UaGlu
a0Jvb2stMTYtRzctUU9ZIDcuMC4wLTIyLWdlbmVyaWMgIzIyLVVidW50dSBTTVAgUFJFRU1QVF9E
WU5BTUlDIE1vbiBNYXkgMjUgMTU6Mzc6NDkgVVRDIDIwMjYgYWFyY2g2NCBHTlUvTGludXgKCiQg
Y2F0IC9wcm9jL3ZlcnNpb24KTGludXggdmVyc2lvbiA3LjAuMC0yMi1nZW5lcmljIChidWlsZGRA
Ym9zMDMtYXJtNjQtMDgzKSAoYWFyY2g2NC1saW51eC1nbnUtZ2NjIChVYnVudHUgMTUuMi4wLTE2
dWJ1bnR1MSkgMTUuMi4wLCBHTlUgbGQgKEdOVSBCaW51dGlscyBmb3IgVWJ1bnR1KSAyLjQ2KSAj
MjItVWJ1bnR1IFNNUCBQUkVFTVBUX0RZTkFNSUMgTW9uIE1heSAyNSAxNTozNzo0OSBVVEMgMjAy
NgoKJCBjYXQgL3N5cy9kZXZpY2VzL3ZpcnR1YWwvZG1pL2lkL3Byb2R1Y3RfbmFtZQoyMU5ICgok
IGNhdCAvc3lzL2RldmljZXMvdmlydHVhbC9kbWkvaWQvcHJvZHVjdF92ZXJzaW9uClRoaW5rQm9v
ayAxNiBHNyBRT1kKCiQgY2F0IC9zeXMvZGV2aWNlcy92aXJ0dWFsL2RtaS9pZC9zeXNfdmVuZG9y
CkxFTk9WTwoKTG9hZGVkIEF1ZGlvIE1vZHVsZXM6Ci0tLS0tLS0tLS0tLS0tLS0tLS0tCiQgbHNt
b2QgfCBncmVwIC1pIHFjb20gfCBncmVwIC1pIHNvdW5kCnNuZF9zb2NfcWNvbV9zZHcgICAgICAg
IDEyMjg4ICAxIHNuZF9zb2NfeDFlODAxMDAKc25kX3NvY19xY29tX2NvbW1vbiAgICAgMTYzODQg
IDEgc25kX3NvY194MWU4MDEwMApzb3VuZHdpcmVfcWNvbSAgICAgICAgICAzNjg2NCAgMAoKJCBs
c21vZCB8IGdyZXAgc25kX3NvY194MWU4MDEwMApzbmRfc29jX3gxZTgwMTAwICAgICAgICAxNjM4
NCAgMAoKUGxhdGZvcm0gRGV2aWNlczoKLS0tLS0tLS0tLS0tLS0tLS0KJCBscyAvc3lzL2J1cy9w
bGF0Zm9ybS9kZXZpY2VzLyB8IGdyZXAgYXVkaW8KYXVkaW8tY29kZWMKaGRtaS1hdWRpby1jb2Rl
Yy42LmF1dG8KaGRtaS1hdWRpby1jb2RlYy43LmF1dG8KaGRtaS1hdWRpby1jb2RlYy44LmF1dG8K
ClBpcGVXaXJlIFN0YXR1czoKLS0tLS0tLS0tLS0tLS0tLQqh8SBwaXBld2lyZS5zZXJ2aWNlIC0g
UGlwZVdpcmUgTXVsdGltZWRpYSBTZXJ2aWNlCiAgICAgTG9hZGVkOiBsb2FkZWQgKC91c3IvbGli
L3N5c3RlbWQvdXNlci9waXBld2lyZS5zZXJ2aWNlOyBlbmFibGVkOyBwcmVzZXQ6IGVuYWJsZWQp
CiAgICAgQWN0aXZlOiBhY3RpdmUgKHJ1bm5pbmcpIHNpbmNlIE1vbiAyMDI2LTA2LTA4IDE4OjQw
OjUwIENTVDsgMzBtaW4gYWdvCgqh8SBwaXBld2lyZS1wdWxzZS5zZXJ2aWNlIC0gUGlwZVdpcmUg
UHVsc2VBdWRpbwogICAgIExvYWRlZDogbG9hZGVkICgvdXNyL2xpYi9zeXN0ZW1kL3VzZXIvcGlw
ZXdpcmUtcHVsc2Uuc2VydmljZTsgZW5hYmxlZDsgcHJlc2V0OiBlbmFibGVkKQogICAgIEFjdGl2
ZTogYWN0aXZlIChydW5uaW5nKSBzaW5jZSBNb24gMjAyNi0wNi0wOCAxODo0MDo1MCBDU1Q7IDMw
bWluIGFnbwoKofEgd2lyZXBsdW1iZXIuc2VydmljZSAtIE11bHRpbWVkaWEgU2VydmljZSBTZXNz
aW9uIE1hbmFnZXIKICAgICBMb2FkZWQ6IGxvYWRlZCAoL3Vzci9saWIvc3lzdGVtZC91c2VyL3dp
cmVwbHVtYmVyLnNlcnZpY2U7IGVuYWJsZWQ7IHByZXNldDogZW5hYmxlZCkKICAgICBBY3RpdmU6
IGFjdGl2ZSAocnVubmluZykgc2luY2UgTW9uIDIwMjYtMDYtMDggMTg6NDA6NTAgQ1NUOyAzMG1p
biBhZ28KCkFkZGl0aW9uYWwgTm90ZXM6Ci0tLS0tLS0tLS0tLS0tLS0tClRoaXMgYXBwZWFycyB0
byBiZSBzaW1pbGFyIHRvIGlzc3VlcyByZXBvcnRlZCBvbiBvdGhlciBTbmFwZHJhZ29uIFggRWxp
dGUgZGV2aWNlcwooRGVsbCBMYXRpdHVkZSA3NDU1LCBEZWxsIFhQUyAxMyA5MzQ1KS4gVGhlIGF1
ZGlvIGRyaXZlciBtb2R1bGVzIGxvYWQgY29ycmVjdGx5LApidXQgdGhlIHNvdW5kIGNhcmQgcmVn
aXN0cmF0aW9uIGZhaWxzLgoKQSB3b3JrYXJvdW5kIG1lbnRpb25lZCBpbiBjb21tdW5pdHkgZGlz
Y3Vzc2lvbnMgaXMgdG8gYWRkOgogIHNuZC1zb2MteDFlODAxMDAuaV9hY2NlcHRfdGhlX2Rhbmdl
cj0xCnRvIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lLCB3aGljaCBzdWdnZXN0cyB0aGlzIG1heSBi
ZSByZWxhdGVkIHRvIHNwZWFrZXIKcHJvdGVjdGlvbiBtZWNoYW5pc21zIG5vdCBiZWluZyBmdWxs
eSBpbXBsZW1lbnRlZCBmb3IgdGhpcyBwbGF0Zm9ybS4KCkFueSBoZWxwIG9yIGd1aWRhbmNlIHdv
dWxkIGJlIGdyZWF0bHkgYXBwcmVjaWF0ZWQuCgpCZXN0IHJlZ2FyZHMsCnRob21hcy5rdWFuZwoK
