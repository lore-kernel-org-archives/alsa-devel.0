Return-Path: <SRS0=vz66=XD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1E7C433EF
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Sep 2019 20:40:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F667206A1
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Sep 2019 20:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="X+79JoK2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F667206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B5F19F6;
	Sun,  8 Sep 2019 22:39:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B5F19F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567975217;
	bh=/i4OE7l9xFTt9QrO2Ozu2hh41Ybt8wvuaO5QHR6dAqY=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X+79JoK2GnMDhGW/xOso6g52gwjmm+aJ2j3Af+PQNpYbTy5NtHUDKUT2YSpuketsh
	 3dv84Lx64ykZPqRSujyGIzm508gWGhWuaZegOkhYGa0xK6oONO1IUO4lMNZNKzOKc3
	 Kvo7Noft3blXM43dD07m17LKKjHNGpDlrHuIzIbw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B830F80157;
	Sun,  8 Sep 2019 22:39:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CEB5CF80368; Sun,  8 Sep 2019 22:39:23 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BDAFDF80157
 for <alsa-devel@alsa-project.org>; Sun,  8 Sep 2019 22:39:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BDAFDF80157
Received: from 110.8.30.213.rev.vodafone.pt ([213.30.8.110] helo=[10.93.14.17])
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1i73xv-00036n-Iw; Sun, 08 Sep 2019 20:39:19 +0000
To: Jaroslav Kysela <jkysela@redhat.com>
References: <15679391594432724-alsa-devel@perex.cz>
From: Hui Wang <hui.wang@canonical.com>
Message-ID: <6afc8d25-08d0-44fe-f9c0-79b5a963c1af@canonical.com>
Date: Mon, 9 Sep 2019 04:39:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <15679391594432724-alsa-devel@perex.cz>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Licence change for your alsa-lib UCM commits (Hui
 Wang: 2 total)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Ck9uIDIwMTkvOS84IOS4i+WNiDY6NDAsIEphcm9zbGF2IEt5c2VsYSB3cm90ZToKPiBBcyBkaXNj
dXNzZWQsIHdlIHdvdWxkIGxpa2UgdG8gbW92ZSB0aGUgVUNNIGNvbmZpZ3VyYXRpb24gZmlsZXMg
ZnJvbSB0aGUKPiBhbHNhLWxpYiByZXBvc2l0b3J5IHRvIG5ldyBhbHNhLXVjbS1jb25mIHJlcG9z
aXRvcnkgd2l0aCB0aGUgbGljZW5jZSBjaGFuZ2UKPiBmcm9tIExHUEwtMi4xIHRvIEJTRC0zLUNs
YXVzZS4KPgo+IEkgd291bGQgbGlrZSB0byBjaGVjaywgaWYgeW91IGFncmVlIHdpdGggdGhpcyBs
aWNlbmNlIGNoYW5nZS4gUGxlYXNlLCBhbnN3ZXIKPiB0byB0aGlzIGUtbWFpbCBhbmQgd3JpdGUg
eW91ciBhZ3JlZW1lbnQgLyBkaXNhZ3JlZW1lbnQgKGtlZXAgQ0MgdG8KPiB0aGUgYWxzYS1kZXZl
bCBtYWlsaW5nIGxpc3QgZm9yIHRoZSBhcmNoaXZpbmcgcHVycG9zZXMpLgo+Cj4gVGhhbmsgeW91
IGZvciB5b3VyIHRpbWUgYW5kIGNvLW9wZXJhdGlvbi4KPgo+IFJlZmVyZW5jZTogIGh0dHBzOi8v
bWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL3BpcGVybWFpbC9hbHNhLWRldmVsLzIwMTktSnVseS8x
NTMyNTcuaHRtbAo+Cj4gTGlzdCBvZiB5b3VyIGNvbW1pdChzKToKPgo+ICAgIDgxZGIyNzZmOGMy
MjM1YWRjODNlOTY5OGIwMTc0MjY1ZjY0ODI2NTUKPiAgICAgIGNvbmYvdWNtOiBpbmNyZWFzZSB0
aGUgaW5wdXQgdm9sdW1lIGZvciBMaW5lSW4KPiAgICAwNWFhYjhkZWFiNTcyYzFjNDQwNzU3M2U2
MGEyMTdiODBjY2Q3ZmM1Cj4gICAgICBjb25mL3VjbToga2JscnQ1NjYwOiBBZGQgdWNtIHNldHRp
bmcgZm9yIERlbGwgRWRnZSBJb1QgcGxhdGZvcm0KCkkgYW0gZmluZSB3aXRoIHRoaXMgbGljZW5z
ZSBjaGFuZ2UuCgpUaGFua3MsCgpIdWkuCgo+Cj4gLS0tCj4gSmFyb3NsYXYgS3lzZWxhIDxwZXJl
eEBwZXJleC5jej4KPiBMaW51eCBTb3VuZCBNYWludGFpbmVyOyBBTFNBIFByb2plY3Q7IFJlZCBI
YXQsIEluYy4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+IEFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0Cj4gQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3Jn
Cj4gaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNh
LWRldmVsCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
QWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHBz
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
