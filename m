Return-Path: <SRS0=rTHd=XI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C7CC4CEC5
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Sep 2019 16:55:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 432E820830
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Sep 2019 16:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fhaG7IGf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jAt8COlc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432E820830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 049301658;
	Fri, 13 Sep 2019 18:54:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 049301658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568393711;
	bh=i+dsGWpRQPEhnStKDX8fzagCOJ5WlLaq6r2HFq5jzH4=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fhaG7IGfmueAwYl+NCEZDSpDJsMlxS+AHcgAO/Kex0qof70CsH/tD9yGJoU5JQBQn
	 9FWkLRsGzKHod2mpSkXyzk/6Fa4rzELLmS1MMIHNo7MyUQml7/G74qmz89eIwCYj7t
	 3Y/tsCfxgyfIjZnmTfxuUt85Qa+2Uc/fbvpDGzok=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F725F802DF;
	Fri, 13 Sep 2019 18:54:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 046F2F8036A; Fri, 13 Sep 2019 18:54:19 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 409CBF80143
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2019 18:54:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 409CBF80143
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="jAt8COlc"
Received: by mail-wr1-x42d.google.com with SMTP id a11so23025878wrx.1
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2019 09:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1Hed53U9AhOFBUrYxwrsrO5NPjkarrXj2PqlmVUzBGg=;
 b=jAt8COlcz/5O5QIiou3KMqLy5us00vqdgx90LA9ZtkNPkEJQBJ8/rvqc4rATkOzr2y
 isEBgBP1HqYbPFJRYKnd7feWe7dBj49jLvXWzJ3t8aaoItwzuXHHWteLM7mqanbD7Hlw
 k1uyRxm6zv6Jg5AWK+BIQSUOKuKOk2XgoNhrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1Hed53U9AhOFBUrYxwrsrO5NPjkarrXj2PqlmVUzBGg=;
 b=MR2HstrJYAZDJ8fk1eS9LPT0DobAsL3MAzlDg5i/XHpeVRJ8vtaDo3Av5AXPdbE90K
 O9DJaxsFykW8Fy6thMHKF0eucRGQT+svvocMJgFFjf5sREYaTVQH/sE4I1dKJAGokjLp
 87zUi7KKeYxvNVdp5Pt493KGKjTAIz+g2GJNMh6Cbap7OO/nqG3JczYHQZzA1Hs+MsRK
 VF2B7x9jlHWlhAx5yMkyJLf7xl/1OA/YnU50swCG06pO+fAOKmghLE1vfKA2sQPMxa6x
 8XF9IbrXPxZ9eMX+gl1MHU6mGJMQz7HTRHwOKDdD0lIaV0cj7QuQkVJiqmtSwi8My5TO
 9tpA==
X-Gm-Message-State: APjAAAW6KvYpDNzlxyXZniQi+HqKfcGledxfJf7PA06JU/d1Xm3uv7ay
 J6f2MNJsyFlfAN22OBCojXbrMQtVVX1b1CUyyE0HsQ==
X-Google-Smtp-Source: APXvYqwZhGa9xRI6LmKpDMYFkGkNos4aHAGTwaJowekHVzts8BOXAOyJHjeP1ySgoPIrckQjtmxdybu7lwGU8WhSvrE=
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr1219440wrv.248.1568393655367; 
 Fri, 13 Sep 2019 09:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <1000767908.8406503.1568280868516@mail.yahoo.com>
In-Reply-To: <1000767908.8406503.1568280868516@mail.yahoo.com>
From: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date: Sat, 14 Sep 2019 00:54:04 +0800
Message-ID: <CAGvk5PpTPppjz70oND=TkVm05VzQDp7RvRDH+8JXrDMrAS8LPg@mail.gmail.com>
To: htl10@users.sourceforge.net
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] alsa compliance test: H340 (USB audio) playback /
 capture rate asymmetry bug?
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

SGluLVRhayBMZXVuZyA8aHRsMTBAdXNlcnMuc291cmNlZm9yZ2UubmV0PiDmlrwgMjAxOeW5tDnm
nIgxMuaXpSDpgLHlm5sg5LiL5Y2INTozNOWvq+mBk++8mgo+Cj4gSSBhbSB1c2luZyBUYWthc2hp
IEl3YWkncyB0cmVlIGdyYWZ0ZWQgb250byBtYWlubGluZSBhcyBES01TICggYXMgaW4KPiBodHRw
czovL2dpdGh1Yi5jb20vSGluVGFrL3NvdW5kLXVzYi1ka21zICkuCj4KPiBSdW5uaW5nIHRoZSBh
bHNhIGNvbXBsaWFuY2UgdGVzdAo+IGNvbW1pdCBmNjE2N2ViNzdkMDM4YjViN2EwZDM5NjQ1ZTdm
MmFlN2ZlZTZmZGMwIChvcmlnaW4vc3RhYmlsaXplLTEyNDY0LkIsIG9yaWdpbi9yZWxlYXNlLVI3
OC0xMjQ5OS5CKQo+Cj4gQ2FwdHVyZSBhbGwgcGFzc2VkLCBidXQgcGxheSBiYWNrIGZhaWxlZCBh
IGNvdXBsZSwgcmVnYXJkaW5nIHRoZSBzYW1wbGUgcmF0ZS4KPiBJdCBpcyBhIHNtYWxsIGhlYWQg
c2V0IHdpdGggc3RlcmVvIGhlYWQgcGhvbmUgYW5kIGEgbWljLgo+IElEIDA0NmQ6MGEzOCBMb2dp
dGVjaCwgSW5jLiBIZWFkc2V0IEgzNDAKPgo+IFRoZSBxdWVzdGlvbiBpcywgZm9yIHN1Y2ggYSBj
aGVhcCBoZWFkc2V0LCB3aHkgd291bGQgdGhlIHBsYXliYWNrIHJhdGUgYW5kIHRoZSBjYXB0dXJl
IHJhdGUgdG8gYmUgZGlmZmVyZW50PyBGb3IgbWFueSBhcHBsaWNhdGlvbnMvIHVzYWdlcywgd2l0
aCBhIGRldmljZSB0aGF0J3MgbW9zdCBjYXB0dXJlIGFuZCBwbGF5YmFjayBjYXBhYmxlLCB3ZSB3
b3VsZCBsaWtlIHRoZSByYXRlcyB0byBhZ3JlZSAtIGJvdGggcGFzcywgb3IgYm90aCBmYWlsIGlu
IHRoZSBzYW1lIGRpcmVjdGlvbj8KPgo+IElzIHRoaXMgYSBoYXJkd2FyZSBvciBzb2Z0d2FyZSBp
c3N1ZT8gT3IsIHNvbWVib2R5IHN1Z2dlc3RlZCwgSSBoYXZlbid0IGxvb2tlZCwgaXNzdWUgd2l0
aCB0aGUgYWxzYSBjb21wbGlhbmNlIHRlc3QgaXRzZWxmLCBwb3NzaWJseSByZWdhcmRpbmcgZnJh
bWUgY291bnRzIG9mIHVzYiBkZXZpY2VzPwo+Cj4gZGV0YWlsIGJlbG93Lgo+Cj4gNSBwYXNzZWQs
IDAgZmFpbGVkCj4gRGV2aWNlIEluZm9ybWF0aW9uCj4gICAgICAgICBOYW1lOiBodzpDQVJEPUgz
NDAKPiAgICAgICAgIFN0cmVhbTogQ0FQVFVSRQo+ICAgICAgICAgRm9ybWF0OiBbJ1MxNl9MRSdd
Cj4gICAgICAgICBDaGFubmVscyByYW5nZTogWzIsIDJdCj4gICAgICAgICBSYXRlOiBbNDQxMDBd
Cj4gICAgICAgICBQZXJpb2Rfc2l6ZSByYW5nZTogWzQ1LCAxMzEwNzJdCj4gICAgICAgICBCdWZm
ZXJfc2l6ZSByYW5nZTogWzkwLCAyNjIxNDRdCj4gVGVzdCBQYXJhbXMKPiAgICAgICAgIFNldCBj
aGFubmVscyAyOiBwYXNzCj4gICAgICAgICBTZXQgZm9ybWF0IFMxNl9MRTogcGFzcwo+ICAgICAg
ICAgU2V0IHJhdGUgNDQxMDA6IHBhc3MKPiBUZXN0IFJhdGVzCj4gICAgICAgICBTZXQgcmF0ZSA0
NDEwMDogcGFzcwo+IFRlc3QgQWxsIFBhaXJzCj4gICAgICAgICBTZXQgY2hhbm5lbHMgMiwgZm9y
bWF0IFMxNl9MRSwgcmF0ZSA0NDEwMDogcGFzcwo+Cj4gMyBwYXNzZWQsIDIgZmFpbGVkCj4gRGV2
aWNlIEluZm9ybWF0aW9uCj4gICAgICAgICBOYW1lOiBodzpDQVJEPUgzNDAKPiAgICAgICAgIFN0
cmVhbTogUExBWUJBQ0sKPiAgICAgICAgIEZvcm1hdDogWydTMTZfTEUnXQo+ICAgICAgICAgQ2hh
bm5lbHMgcmFuZ2U6IFsyLCAyXQo+ICAgICAgICAgUmF0ZTogWzQ0MTAwXQo+ICAgICAgICAgUGVy
aW9kX3NpemUgcmFuZ2U6IFs0NSwgMTMxMDcyXQo+ICAgICAgICAgQnVmZmVyX3NpemUgcmFuZ2U6
IFs5MCwgMjYyMTQ0XQo+IFRlc3QgUGFyYW1zCj4gICAgICAgICBTZXQgY2hhbm5lbHMgMjogcGFz
cwo+ICAgICAgICAgU2V0IGZvcm1hdCBTMTZfTEU6IHBhc3MKPiAgICAgICAgIFNldCByYXRlIDQ0
MTAwOiBwYXNzCj4gVGVzdCBSYXRlcwo+ICAgICAgICAgU2V0IHJhdGUgNDQxMDA6IGZhaWwgLSBF
eHBlY3RlZCByYXRlIGlzIDQ0MTAwLjAwMDAwMCwgbWVhc3VyZSA0NDA5Mi45MTgzNjIsIGRpZmZl
cmVuY2UgNy4wODE2MzggPiB0aHJlc2hvbGQgNC40MTAwMDAKPiBUZXN0IEFsbCBQYWlycwo+ICAg
ICAgICAgU2V0IGNoYW5uZWxzIDIsIGZvcm1hdCBTMTZfTEUsIHJhdGUgNDQxMDA6IGZhaWwgLSBF
eHBlY3RlZCByYXRlIGlzIDQ0MTAwLjAwMDAwMCwgbWVhc3VyZSA0NDA5My4wNDkxOTIsIGRpZmZl
cmVuY2UgNi45NTA4MDggPiB0aHJlc2hvbGQgNC40MTAwMDAKClRoYW5rcyBmb3IgdGhlIGZlZWRi
YWNrISBJdCBzZWVtcyB0aGF0IHRoZXJlIGlzIGEgc21hbGwgZGlmZmVyZW5jZQpiZXR3ZWVuIHRo
ZSBtZWFzdXJlZCByYXRlIGFuZCB0aGUgZXhwZWN0ZWQgcmF0ZS4gNyBmcmFtZXMgZGlmZmVyZW5j
ZQptZWFucyBpZiB3ZSB1c2UgdGhhdCBkZXZpY2UgdG8gcGxheSBhdWRpbyBhYm91dCA0NDEwMC83
ID0gNjMwMApzZWNvbmRzLCBpdCB3aWxsIGJlIG9uZSBzZWNvbmQgZGVsYXkuIChJdCBjYW4gYmUg
Zml4ZWQgaWYgYW4gYXVkaW8Kc2VydmljZSBoYXMgdGhlIHJhdGUgZXN0aW1hdGlvbiBvciBvdGhl
ciBzaW1pbGFyIGhhbmRsZXJzLikgSSdtIG5vdApzdXJlIGl0IGlzIHRoZSBoYXJkd2FyZSBvciBz
b2Z0d2FyZSBpc3N1ZS4gTWF5YmUgeW91IGNhbiB0cnkgdG8gdGVzdApvdGhlciBVU0IgZGV2aWNl
cyBvciB0ZXN0IGl0IHdpdGhvdXQgREtNUyBtb2R1bGVzIGFuZCB0aGVuIGNvbXBhcmUgdGhlCnJl
c3VsdHMuIEJlc2lkZXMsIGluIG15IGV4cGVyaWVuY2UsIHBsYXliYWNrIGFuZCBjYXB0dXJlIGhh
dmluZwpkaWZmZXJlbnQgcmVzdWx0cyBpcyBub3JtYWwuIFRoZXkgbWF5ICBnbyB0aHJvdWdoIGRp
ZmZlcmVudCBwYXRocyBhbmQKY29kZWNzLgoKRm9yIG1vcmUgZGV0YWlscywgdGhlIG1lYXN1cmVk
IHJhdGUgaXMgY29tcHV0ZWQgYnkgbGluZWFyIHJlZ3Jlc3Npb24KZm9yIGVhY2ggcG9pbnQgd2hl
biB0aGUgZGV2aWNlIGNvbnN1bWVzIGF1ZGlvIHNhbXBsZXMuIFlvdSBjYW4gdXNlCiJhbHNhX2Nv
bmZvcm1hbmNlX3Rlc3QgLVAge0RFVklDRV9OQU1FfSAtciA0NDEwMCAtYyAyIC1mIFMxNl9MRSAt
ZCAxCi0tZGVidWciIHRvIHNlZSB3aGVuIGEgZGV2aWNlIGNvbnN1bWVzIHNhbXBsZXMoVElNRV9E
SUZGKSBhbmQgaG93IG1hbnkKc2FtcGxlcyBpdCBwbGF5cyhESUZGKS4gSWYgeW91IHdhbnQgdG8g
ZmluZCBvdXQgdGhlIHJvb3QgY2F1c2UsIHRoaXMKaW5mb3JtYXRpb24gbWF5IGJlIGhlbHBmdWwu
CgpGZWVsIGZyZWUgdG8gY29udGFjdCBtZSBpZiB5b3Ugc3RpbGwgaGF2ZSBxdWVzdGlvbnMuIFRo
YW5rcy4KCkJlc3QsCll1LUhzdWFuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9q
ZWN0Lm9yZwpodHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2Fsc2EtZGV2ZWwK
