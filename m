Return-Path: <SRS0=j9WI=Y4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A97CA9EB5
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Nov 2019 13:52:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A01921D7F
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Nov 2019 13:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="m3rbi6KP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wa5OwO9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A01921D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 321861757;
	Mon,  4 Nov 2019 14:51:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 321861757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572875557;
	bh=F66tsKijxlNK5ma0f/KnJ6nZ4xDDqaB53jxf5XucmZQ=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m3rbi6KPv8TUJjtGkiZSWMhlS3z99MrSVZWV0Hmc7gUyVkvSp34LxQnjmyGkbwAR0
	 mx85U+qvFtjCJtGZyT3VifjR06QXrtDzmeXEXBAgYC6uPYkuU1jl9Llse2xTEcgheV
	 8qk2jmkquA8Tx2tQ/ErL8iYF53wYYMDkxAxLQfFo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C789F800F3;
	Mon,  4 Nov 2019 14:51:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53A16F803F4; Mon,  4 Nov 2019 14:51:45 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7279F800F3
 for <alsa-devel@alsa-project.org>; Mon,  4 Nov 2019 14:51:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7279F800F3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="wa5OwO9y"
Received: from localhost (unknown [62.119.166.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F075821744;
 Mon,  4 Nov 2019 13:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572875499;
 bh=RMjBbcJSX/BFL942aPuRy8u04vdxeLErter4JodBkgs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wa5OwO9yWDZ+m4tm147ehFCtVz7pQqLDS8HUpuWjPiRxj5UUWjwSgI5Zh4aPtG1p0
 fvUXZ6Xvt7EQIBzrtiCcJYqhCdOg8zkaDKYXzdQCZVGt4gen9SegcAhX8f+TPsY5Tf
 1m3LhVVTmtXL0lOqeuRoL+WQxbqLJ/lSalfZtklg=
Date: Mon, 4 Nov 2019 14:51:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20191104135135.GA2162401@kroah.com>
References: <cki.1210A7ECB0.BD9Q3APV4K@redhat.com>
 <2029139028.10333037.1572874551626.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2029139028.10333037.1572874551626.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: alsa-devel@alsa-project.org, Memory Management <mm-qe@redhat.com>,
 Linux Stable maillist <stable@vger.kernel.org>,
 Jaroslav Kysela <jkysela@redhat.com>, CKI Project <cki-project@redhat.com>,
 LTP Mailing List <ltp@lists.linux.it>
Subject: Re: [alsa-devel]
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5?=
 =?utf-8?q?=2E3=2E9-rc1-dfe283e=2Ecki_=28stable=29?=
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

T24gTW9uLCBOb3YgMDQsIDIwMTkgYXQgMDg6MzU6NTFBTSAtMDUwMCwgSmFuIFN0YW5jZWsgd3Jv
dGU6Cj4gCj4gCj4gLS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLQo+ID4gCj4gPiBIZWxsbywK
PiA+IAo+ID4gV2UgcmFuIGF1dG9tYXRlZCB0ZXN0cyBvbiBhIHJlY2VudCBjb21taXQgZnJvbSB0
aGlzIGtlcm5lbCB0cmVlOgo+ID4gCj4gPiAgICAgICAgS2VybmVsIHJlcG86Cj4gPiAgICAgICAg
Z2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51
eC1zdGFibGUtcmMuZ2l0Cj4gPiAgICAgICAgICAgICBDb21taXQ6IGRmZTI4M2U5ZmRhYyAtIExp
bnV4IDUuMy45LXJjMQo+ID4gCj4gPiBUaGUgcmVzdWx0cyBvZiB0aGVzZSBhdXRvbWF0ZWQgdGVz
dHMgYXJlIHByb3ZpZGVkIGJlbG93Lgo+ID4gCj4gPiAgICAgT3ZlcmFsbCByZXN1bHQ6IEZBSUxF
RCAoc2VlIGRldGFpbHMgYmVsb3cpCj4gPiAgICAgICAgICAgICAgTWVyZ2U6IE9LCj4gPiAgICAg
ICAgICAgIENvbXBpbGU6IE9LCj4gPiAgICAgICAgICAgICAgVGVzdHM6IEZBSUxFRAo+ID4gCj4g
PiBBbGwga2VybmVsIGJpbmFyaWVzLCBjb25maWcgZmlsZXMsIGFuZCBsb2dzIGFyZSBhdmFpbGFi
bGUgZm9yIGRvd25sb2FkIGhlcmU6Cj4gPiAKPiA+ICAgaHR0cHM6Ly9hcnRpZmFjdHMuY2tpLXBy
b2plY3Qub3JnL3BpcGVsaW5lcy8yNjIzODAKPiA+IAo+ID4gT25lIG9yIG1vcmUga2VybmVsIHRl
c3RzIGZhaWxlZDoKPiA+IAo+ID4gICAgIHg4Nl82NDoKPiA+ICAgICAg4p2MIExUUCBsaXRlCj4g
Pgo+IAo+IE5vdCBhIDUuMyAtc3RhYmxlIHJlZ3Jlc3Npb24uCj4gCj4gRmFpbHVyZSBjb21lcyBm
cm9tIHRlc3QgdGhhdCBzYW5pdHkgY2hlY2tzIGFsbCAvcHJvYyBmaWxlcyBieSBkb2luZwo+IDFr
IHJlYWQgZnJvbSBlYWNoLiBUaGVyZSBhcmUgY291cGxlIGlzc3VlcyBpdCBoaXRzIHdydC4gc25k
X2hkYV8qLgo+IAo+IEV4YW1wbGUgcmVwcm9kdWNlcjoKPiAgIGRkIGlmPS9zeXMva2VybmVsL2Rl
YnVnL3JlZ21hcC9oZGF1ZGlvQzBEMy1oZGF1ZGlvL2FjY2VzcyBvZj1vdXQudHh0IGNvdW50PTEg
YnM9MTAyNCBpZmxhZz1ub25ibG9jawoKVGhhdCdzIG5vdCBhIHByb2MgZmlsZSA6KQoKPiBJdCdz
IHNsb3cgYW5kIHRyaWdnZXJzIHNvZnQgbG9ja3VwcyBbMV0uIEFuZCBpdCBhbHNvIHJlcXVpcmVz
IGxvdAo+IG9mIG1lbW9yeSwgdHJpZ2dlcmluZyBPT01zIG9uIHNtYWxsZXIgVk1zOgo+IDB4MDAw
MDAwMDAyNGYwNDM3Yi0weDAwMDAwMDAwMWEzMmIxYzggMTA3Mzc0NTkyMCBzZXFfcmVhZCsweDEz
MS8weDQwMCBwYWdlcz0yNjIxNDQgdm1hbGxvYyB2cGFnZXMgTjA9MjYyMTQ0Cj4gCj4gSSdtIGxl
YW5pbmcgdG93YXJkcyBza2lwcGluZyBhbGwgcmVnbWFwIGVudHJpZXMgaW4gdGhpcyB0ZXN0Lgo+
IENvbW1lbnRzIGFyZSB3ZWxjb21lZC4KClJhbmRvbWx5IHBva2luZyBhcm91bmQgaW4gZGVidWdm
cyBpcyBhIHN1cmUgd2F5IHRvIGNhdXNlIGNyYXNoZXMgYW5kCm1ham9yIHByb2JsZW1zLiAgQWxz
bywgZGVidWdmcyBmaWxlcyBhcmUgTk9UIHN0YWJsZSBhbmQgb25seSBmb3IKZGVidWdnaW5nIGFu
ZCBzaG91bGQgbmV2ZXIgYmUgZW5hYmxlZCBvbiAicmVhbCIgc3lzdGVtcy4KClNvIHdoYXQgZXhh
Y3RseSBpcyB0aGUgdGVzdCB0cnlpbmcgdG8gZG8gaGVyZT8KCnRoYW5rcywKCmdyZWcgay1oCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4u
YWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
