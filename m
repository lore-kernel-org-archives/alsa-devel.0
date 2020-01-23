Return-Path: <SRS0=ePgV=3M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF5AC2D0DB
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:11:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361CA2051A
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RF7qg2y2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361CA2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=feix.family
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 79589166D;
	Thu, 23 Jan 2020 15:10:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 79589166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579788692;
	bh=Fvmz7ixT3GdxW5dXBxOhKyLM5CGEMcqay42uRgJsCM4=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RF7qg2y2wG+gpgJ3DM85qY1+NQR0CEFwx3AmJAyVoM4aj67Mf30FayEb18QksGLrd
	 QSRunEDxNcNLGgKepoZJycVNucLwjMK8Jyx/TuuYWdjq7otK8Q0FOVrMdkLnNBuaG1
	 +Eqsn6VMFGWicUobmNOy5GghaDTgfsXLcY8wQu3o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA921F8015B;
	Thu, 23 Jan 2020 15:10:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5D52BF801D9; Thu, 23 Jan 2020 15:10:40 +0100 (CET)
Received: from server.feix.family (server.feix.family [80.240.19.227])
 by alsa1.perex.cz (Postfix) with ESMTP id 8FDF7F80112
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2020 15:10:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8FDF7F80112
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <ebe959a0-5272-e7bd-6001-1ce598f7f6be@feix.family>
 <44ba763e-f3d2-3fa2-eea6-9ebb7317a3bd@linux.intel.com>
From: Michal Feix <michal@feix.family>
Message-ID: <cc4fc82d-5b01-d5f9-7771-ba2b5daa5829@feix.family>
Date: Thu, 23 Jan 2020 15:10:36 +0100
MIME-Version: 1.0
In-Reply-To: <44ba763e-f3d2-3fa2-eea6-9ebb7317a3bd@linux.intel.com>
Content-Language: en-US
Subject: Re: [alsa-devel] ASUS T100TAM UCM
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

PiBPbiAxLzIzLzIwIDY6NDkgQU0sIE1pY2hhbCBGZWl4IHdyb3RlOgo+PiBIZWxsbywKPj4KPj4g
dGhlcmUgaXMgbm8gc291bmQgd29ya2luZyB2aWEgc3BlYWtlcnMgb3IgaGVhZHBob25lcyBqYWNr
IG9uIEFzdXMgVDEwMFRBTS4gU291bmQgd29ya3MgY29ycmVjdGx5IHZpYSBIRE1JIG9yIEJsdWV0
b290aCBoZWFkcGhvbmVzLiBUaGUgY2hpcCBvbiB0aGlzIEJheXRyYWlsIG1hY2hpbmUgaXMgY29y
cmVjdGx5IHJlY29nbml6ZWQgYXMgYnl0Y3JfcnQ1NjQwLiDCoEZyb20gZG1lc2c6Cj4+Cj4+IGJ5
dGNyX3J0NTY0MCBieXRjcl9ydDU2NDA6IHF1aXJrIERNSUMxX01BUCBlbmFibGVkCj4+IGJ5dGNy
X3J0NTY0MCBieXRjcl9ydDU2NDA6IHF1aXJrIHJlYWx0ZWssamFjay1kZXRlY3Qtc291cmNlIDMK
Pj4gYnl0Y3JfcnQ1NjQwIGJ5dGNyX3J0NTY0MDogcXVpcmsgcmVhbHRlayxvdmVyLWN1cnJlbnQt
dGhyZXNob2xkLW1pY3JvYW1wIDIwMDAKPj4gYnl0Y3JfcnQ1NjQwIGJ5dGNyX3J0NTY0MDogcXVp
cmsgcmVhbHRlayxvdmVyLWN1cnJlbnQtc2NhbGUtZmFjdG9yIDEKPj4gYnl0Y3JfcnQ1NjQwIGJ5
dGNyX3J0NTY0MDogcXVpcmsgTUNMS19FTiBlbmFibGVkCj4+IGJ5dGNyX3J0NTY0MCBieXRjcl9y
dDU2NDA6IHNuZC1zb2MtZHVtbXktZGFpIDwtPiBtZWRpYS1jcHUtZGFpIG1hcHBpbmcgb2sKPj4g
Ynl0Y3JfcnQ1NjQwIGJ5dGNyX3J0NTY0MDogc25kLXNvYy1kdW1teS1kYWkgPC0+IGRlZXBidWZm
ZXItY3B1LWRhaSBtYXBwaW5nIG9rCj4+IGJ5dGNyX3J0NTY0MCBieXRjcl9ydDU2NDA6IHJ0NTY0
MC1haWYxIDwtPiBzc3AyLXBvcnQgbWFwcGluZyBvawo+PiBpbnB1dDogYnl0Y3ItcnQ1NjQwIEhl
YWRzZXQgYXMgL2RldmljZXMvcGxhdGZvcm0vODA4NjBGMjg6MDAvYnl0Y3JfcnQ1NjQwL3NvdW5k
L2NhcmQwL2lucHV0MTcKPj4KPj4gQWZ0ZXIgYm9vdHVwLCBrZXJuZWwgbG9nIGlzIGZpbGxlZCB3
aXRoOiAiQmF5dHJhaWwgQXVkaW8gUG9ydDogQVNvQzogbm8gYmFja2VuZCBEQUlzIGVuYWJsZWQg
Zm9yIEJheXRyYWlsIEF1ZGlvIFBvcnQiIG1lc3NhZ2VzLiBJIGRvIHVuZGVyc3RhbmQgdGhpcyBp
cyBkdWUgdG8gdGhlIG1pc3NpbmcgVUNNIHByb2ZpbGUgZm9yIHRoZSBtYWNoaW5lLgo+IAo+IHdo
YXQgZG8geW91IG1lYW4gd2l0aCAnbWlzc2luZyBVQ00gcHJvZmlsZSc/IEl0J3MgYmVlbiBhdmFp
bGFibGUgZm9yIG1hbnkgbW9vbnMsIGFuZCB3ZSB3b3JrZWQgd2l0aCBKYXJvc2xhdi9IYW5zIHRv
IHVwZGF0ZSBmb3IgVUNNdjIuCj4gCj4gWW91IHNob3VsZCBiZSBhYmxlIHRvIHVzZSBhbHNhLXVj
bSBhbmQgY29uZmlndXJlIHRoaW5ncyBtYW51YWxseSwgZS5nLgo+IAo+IGFsc2F1Y20gLWMgYnl0
Y3ItcnQ1NjQwIHNldCBfdmVyYiBIaUZpIHNldCBfZW5hZGV2IEhlYWRwaG9uZXMKPiAKPiBhbHNh
dWNtIC1jIGJ5dGNyLXJ0NTY0MCBzZXQgX3ZlcmIgSGlGaSBzZXQgX2VuYWRldiBTcGVha2VyCj4g
CgpUaGFua3MgUGllcnJlLiBJJ20gYXdhcmUgb2YgdGhlIHdvcmsgZG9uZSBwcmV2aW91c2x5IG9u
IEFzdXMgVDEwMC4gTm90IHN1cmUsIGlmIEFzdXMgVDEwMFRBTSBpcyBhbnkgc2lnbmlmaWNhbnRs
eSBkaWZmZXJlbnQuIEp1c3QgdHJpZWQgeW91ciBzdWdnZXN0ZWQgY29tbWFuZHMgYXMgcm9vdCB1
c2VyOgoKIyBhbHNhdWNtIC1jIGJ5dGNyLXJ0NTY0MCBzZXQgX3ZlcmIgSGlGaSBzZXQgX2VuYWRl
diBIZWFkcGhvbmVzCkFMU0EgbGliIHVjbV9zdWJzLmM6MjE1Oih1Y19tZ3JfZ2V0X3N1YnN0aXR1
dGVkX3ZhbHVlKSB2YXJpYWJsZSAnJHtDYXJkQ29tcG9uZW50c30nIGlzIG5vdCBkZWZpbmVkIGlu
IHRoaXMgY29udGV4dCEKQUxTQSBsaWIgbWFpbi5jOjk2MDooc25kX3VzZV9jYXNlX21ncl9vcGVu
KSBlcnJvcjogZmFpbGVkIHRvIGltcG9ydCBieXRjci1ydDU2NDAgdXNlIGNhc2UgY29uZmlndXJh
dGlvbiAtMjIKYWxzYXVjbTogZXJyb3IgZmFpbGVkIHRvIG9wZW4gc291bmQgY2FyZCBieXRjci1y
dDU2NDA6IEludmFsaWQgYXJndW1lbnQKCiMgYWxzYXVjbSAtYyBieXRjci1ydDU2NDAgc2V0IF92
ZXJiIEhpRmkgc2V0IF9lbmFkZXYgU3BlYWtlcgpBTFNBIGxpYiB1Y21fc3Vicy5jOjIxNToodWNf
bWdyX2dldF9zdWJzdGl0dXRlZF92YWx1ZSkgdmFyaWFibGUgJyR7Q2FyZENvbXBvbmVudHN9JyBp
cyBub3QgZGVmaW5lZCBpbiB0aGlzIGNvbnRleHQhCkFMU0EgbGliIG1haW4uYzo5NjA6KHNuZF91
c2VfY2FzZV9tZ3Jfb3BlbikgZXJyb3I6IGZhaWxlZCB0byBpbXBvcnQgYnl0Y3ItcnQ1NjQwIHVz
ZSBjYXNlIGNvbmZpZ3VyYXRpb24gLTIyCmFsc2F1Y206IGVycm9yIGZhaWxlZCB0byBvcGVuIHNv
dW5kIGNhcmQgYnl0Y3ItcnQ1NjQwOiBJbnZhbGlkIGFyZ3VtZW50CgpJIGFsc28gdHJpZWQgdGhp
czoKCiMgYWxzYXVjbSBsaXN0Y2FyZHMKQUxTQSBsaWIgdXRpbHMuYzoyNjE6KHVjX21ncl9jb25m
aWdfbG9hZCkgY291bGQgbm90IG9wZW4gY29uZmlndXJhdGlvbiBmaWxlIC91c3Ivc2hhcmUvYWxz
YS91Y20yL0hEQSBJbnRlbCBQQ0gvSERBIEludGVsIFBDSC5jb25mCmFsc2F1Y206IGVycm9yIGZh
aWxlZCB0byBnZXQgY2FyZCBsaXN0OiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CgpUaGVyZSBy
ZWFsbHkgaXMgbm8gc3VjaCBmaWxlICJIREEgSW50ZWwgUENILmNvbmYiIGluIEhEQSBJbnRlbCBQ
Q0ggZGlyZWN0b3J5LCBidXQgSSBkbyBub3Qgc2VlIGFueSBzdWNoIGZpbGUgaW4gdGhlIGFsc2Et
dWNtLWNvbmYgcGFja2FnZSBkb3dubG9hZGVkIGZyb20gb3JpZ2luIEFsc2Egc2l0ZS4KCi0tCk1p
Y2hhbCBGZWl4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
czovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
