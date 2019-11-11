Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13E3C43331
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 18:46:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B23D21655
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 18:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Yl5uWXMA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="wFvPAcnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B23D21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 360E142;
	Mon, 11 Nov 2019 19:45:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 360E142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573497964;
	bh=TOCeBCxvgkSzHDBuDP6thYAtF99a2ZYWxPzEeQ1K4ks=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yl5uWXMAQM4RvnxJd9+SHIZq7H1MgkmtnzqBBF2JjuE9PcvOJQJvVrKRVa2fQngun
	 /n2o8sd+RlhPMuIyPjuCZmlBe0mJJJqGGugSLoWnTZCEhKyDoYoiYiOblONLvUTg8I
	 HxOlLcDJ4Lcs8bL3djmzyZOsYG0ccTIY9Fvk5Vgs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE8F3F8045D;
	Mon, 11 Nov 2019 19:45:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7D65F804FF; Mon, 11 Nov 2019 19:45:11 +0100 (CET)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D1AEF802E0
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 19:45:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D1AEF802E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="wFvPAcnE"
Received: by mail-qk1-x743.google.com with SMTP id m125so12059935qkd.8
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 10:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vczrYQmFLSnI7y3gfgyEZtoX0+1mVfWQBgx353ITLf4=;
 b=wFvPAcnEQtm9WQlX+PvM+mZ0fKZ1Zdm4dY7vUauzktfLxtiOMBoaZIb5gl8smM4joX
 Gs9kjUrJ8jPc+oRnFazCUWHXnx7SyixvsqfqRzGgLbYSsD0AmcVhpG/7tX+39Lr3qWvK
 6BtDA2BTFef+Jpd42/uFr/EcNjKr+G9+dfSkN4Z3Tv3zeSLUKfABv7TuOxJA07IRth9w
 3227voB18wRau6i1NX5j5g6vq/6j/c24lm/Y2B7OW5kttqKdM44sMKV++iMnzuhegq++
 qKs2OwN1ieegBcYhn9EmZM7xSWNfrfFekxLLuZv14rid+t2pf+KTUUAuIKU0LJ9gQdTN
 MO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vczrYQmFLSnI7y3gfgyEZtoX0+1mVfWQBgx353ITLf4=;
 b=mJNCN+77jEPEWx1EMLahv17slCCD6qzJfz7Vgdr2f8Mwvhdjz19YNcd1XufmzPYQOD
 uKMqn45xRK4Bw4pyVYRIqOUzBNg2TE+ZxU8PFvSCNIiA0RIfoL11a5MqK/8hwWkO6AcZ
 bRdCPBwaWyhNoOQhcUBr0nQD3U8N+lmQVORntMOXtripn7nfXmFq2UACySpOY3vmBTvH
 mkG6hdtx2AmNF5cWdD3KG2l5240qJ8H/UM4aEfG14YBxFXJXi7wOmKU72JtAMeoF2LaL
 PhXE2qLK+/zUkp4+xZ/qS5ftrfKsKmLRPgif4p28BD+00SidWFfN0bAdHarzHf3/RrAl
 6APw==
X-Gm-Message-State: APjAAAU6/JhiobtNScdcJtrGtuS7hZP4e8SYtApQJGgdjFBMHenXBw+s
 Peg8N050k4BljzCAGEL22JiXM1+XvvApOd8nO7bDqw==
X-Google-Smtp-Source: APXvYqx8ZOyQHf5pCkW8y+kLOY2J8EpObN51Sb82L7bC/M7vroyKHsy0hCnjqWKTG3jN7/I8QGcFzfO6mr+6Q49VYuc=
X-Received: by 2002:a05:620a:13c2:: with SMTP id
 g2mr11169185qkl.158.1573497907022; 
 Mon, 11 Nov 2019 10:45:07 -0800 (PST)
MIME-Version: 1.0
References: <20191107015808.26844-1-cujomalainey@chromium.org>
 <20191107015808.26844-11-cujomalainey@chromium.org>
 <d13e70bd-4965-5dfd-2745-64b3f6130396@perex.cz>
In-Reply-To: <d13e70bd-4965-5dfd-2745-64b3f6130396@perex.cz>
From: Curtis Malainey <cujomalainey@google.com>
Date: Mon, 11 Nov 2019 10:44:56 -0800
Message-ID: <CAOReqxg9FnNEEK+o1N15zFbVzwKAfJTriGQSKzq=qW=kA70xQg@mail.gmail.com>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Curtis Malainey <cujomalainey@chromium.org>,
 Mark Brown <broonie@kernel.org>,
 ALSA development <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] [PATCH 11/11] ucm: docs: Add DefaultNodeGain
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

T24gTW9uLCBOb3YgMTEsIDIwMTkgYXQgNzozNCBBTSBKYXJvc2xhdiBLeXNlbGEgPHBlcmV4QHBl
cmV4LmN6PiB3cm90ZToKPgo+IERuZSAwNy4gMTEuIDE5IHYgMjo1OCBDdXJ0aXMgTWFsYWluZXkg
bmFwc2FsKGEpOgo+ID4gQWxsb3cgdWNtIHRvIHNwZWNpZnkgYSBkZWZhdWx0IGhhcmR3YXJlIGdh
aW4gdG8gb3ZlcmlkZSBvbiB0aGUgcmVzcGVjdGl2ZSBub2RlLgo+ID4KPiA+IFNpZ25lZC1vZmYt
Ynk6IEN1cnRpcyBNYWxhaW5leSA8Y3Vqb21hbGFpbmV5QGNocm9taXVtLm9yZz4KPiA+IC0tLQo+
ID4gICBpbmNsdWRlL3VzZS1jYXNlLmggfCAyICsrCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91c2UtY2FzZS5oIGIvaW5j
bHVkZS91c2UtY2FzZS5oCj4gPiBpbmRleCBlZTZlZTVlMC4uZDBlODIxZDUgMTAwNjQ0Cj4gPiAt
LS0gYS9pbmNsdWRlL3VzZS1jYXNlLmgKPiA+ICsrKyBiL2luY2x1ZGUvdXNlLWNhc2UuaAo+ID4g
QEAgLTM0Nyw2ICszNDcsOCBAQCBpbnQgc25kX3VzZV9jYXNlX2dldF9saXN0KHNuZF91c2VfY2Fz
ZV9tZ3JfdCAqdWNfbWdyLAo+ID4gICAgKiAgIC0gU29mdHdhcmVHYWluCj4gPiAgICAqICAgICAg
LSBTcGVjaWZ5IHRoZSBzb2Z0d2FyZSBnYWluIGluIDAuMDFkQi4gRS5nLiAiMjAiIG1lYW5zIHRo
ZXJlIHdpbGwgYmUKPiA+ICAgICogICAgICAgIDAuMiBkQiBzb2Z0d2FyZSBnYWluIG9uIHRoaXMg
bm9kZS4KPiA+ICsgKiAgIC0gRGVmYXVsdE5vZGVHYWluCj4gPiArICogICAgICAtIENoYW5nZSB0
aGUgZGVmYXVsdCBub2RlIGdhaW4uIEUuZzog4oCcLTcwMOKAnSB0byBzZXQgLTcgZEIgb24gdGhp
cyBub2RlCj4gPiAgICAqICAgLSBEaXNhYmxlU29mdHdhcmVWb2x1bWUKPiA+ICAgICogICAgICAt
IFNldCB0byAiMSIgdG8gZm9yY2UgdXNlcnNwYWNlIHRvIHVzZSBoYXJkd2FyZSB2b2x1bWUgY29u
dHJvbHMKPiA+ICAgICovCj4gPgo+Cj4gSSBkb24ndCBzZWUgdGhlIHVzYWdlLiBDb3VsZCB5b3Ug
ZWxhYm9yYXRlIGEgYml0IHdoaWNoIHB1cnBvc2UgaXMgZm9yIHRoaXMgdmFsdWU/Cj4KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSmFyb3NsYXYKPgpUaGlzIGFsb25n
IHdpdGggc29mdHdhcmUgZ2FpbiBhY3R1YWxseSBzaG91bGQgYmUgZHJvcHBlZCBmcm9tIHRoZQpw
YXRjaHNldC4gV2UgYXJlIG1vZGlmeWluZyBvdXIgdXNlIGNhc2UgdG8gbWFrZSBpdCBtb3JlIGNv
bmZpZ3VyYWJsZQpmb3IgbXVsdGktc3RyZWFtIHVzZS4gVGhlIG9yaWdpbmFsIHVzZSBjYXNlIGlz
IGZvciBzeXN0ZW1zIGxpa2UKaG90d29yZCBjYXB0dXJlIHN0cmVhbXMuCj4gLS0KPiBKYXJvc2xh
diBLeXNlbGEgPHBlcmV4QHBlcmV4LmN6Pgo+IExpbnV4IFNvdW5kIE1haW50YWluZXI7IEFMU0Eg
UHJvamVjdDsgUmVkIEhhdCwgSW5jLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbHNhLWRldmVsCg==
