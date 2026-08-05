Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADB7C55822
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2026 10:30:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EABE060213;
	Wed,  5 Aug 2026 12:30:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EABE060213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785925821;
	bh=gXC0TcyGbfXDlEz1XYAHRqxnATDnQ1fAbfUKGxlv+4A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uuVupyHAt+7k54wDFQ+Mc0KkVpXUktDMPRLbzdscwWfugvn9vcYp3+Xf8ftSjHvO+
	 iR2WkXoBWlQYwAicJ8t+lqJPunYkM3l0xUKFHNwRorbleu4qCXvwdZ1g4++xhPhtC7
	 h208s33Acs8dZ5qfFH9v/pE3UNsU/CPxhoSJz6LQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CE3FAF8060C; Wed,  5 Aug 2026 12:29:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 75EEDF80684;
	Wed,  5 Aug 2026 12:29:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6DFB9F8027B; Wed,  5 Aug 2026 11:36:33 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1785922591;
	b=sSlde8YZCj2x1NmmLb6Y8fYWQfUQHwPfoDveFryd7dG59KrZjMDMmZebp/v1QdS/8mwm
	 rhc+VUYp/hjPtk+FjWREjDm6eXlFPjyakadhgVnybmwQfswZRu9pmZwqOa56rK8MqcvOy
	 NU96rMhSYYMrcAVjgvIy5/vKfU8ZeJI9XqDWkCFtai5QIQYmOvHQp8kYQWp33DlS8LHFM
	 I3+i4EjQGJccAcJOk0IJsMoFzjKgElEnZXeDLZvJsTY+cKdFA0TAKfxXEeD1Xkf31D4T9
	 vmD+R0Bg3tbGYhobPXfrWdh0GQ8Hhdf9t1unZSmzlFwj2JaFOen5/CpidQOZaNFoNzg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785922591;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=nBgpGG+e+CFqtPTmHeNANcZWh04cB64r8RFSneX3WtE=;
	b=ZgcXJPGF2G7rE1++8h0rYHgyVgL3Yms4MZ6EtbOH3Ua2YMb6xXLTQAUXFDaP/FEX1i5T
	 14lCUYRzORgISekWYd/hz8wdrpP+DqnnSL26Byk6zc/KEgmy61Lf4D7HVs6aW7L9avRot
	 L8U46LP0HrHK/13Xox/HnPk1BtCMzU03u7L/lGFegyMS2kjlIqhyrCNOV2eL62AsOMmS3
	 AzYWP6Kr957MSxpWbyR9V7DiPDDCmLcj8yE5IgMSo0qSKlI/kMRROWcA/RKbvuLCWlWnN
	 vYVST/GfZDPX8qxMUngptfGJBc9Xvw1+ynrtL5QOeYD1WbfgSX8dF/o6OJw2tBP+QMQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gQOKbrNb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com
 [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6E676F800AE
	for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2026 11:36:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E676F800AE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gQOKbrNb
Received: by mail-oo1-f47.google.com with SMTP id
 006d021491bc7-6ae542c486eso373919eaf.0
        for <alsa-devel@alsa-project.org>;
 Wed, 05 Aug 2026 02:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785922588; cv=none;
        d=google.com; s=arc-20260327;
        b=YbWuyD8fTo+Goqr/XYKEf18WWIO769tk0MLlxo0i5sunrBKRE2sf+XLoMebyxPcJfP
         RKnKI/kfcA7ncehftsgTcKS82uHynKWwq7e5vl+k80nONR0440gemYpM5tsmcxQyq+Wb
         5D6ycHNQSZt2dFuzLpRb1ThUUfuAXBrNJ8En/5gQSzXmAWpyCOEXGf2RGE3ur7h9yh1N
         6Ef0aMJ55FQw0TSBTvKZ+AMRdkbn9kN62aGTAUsC81mMrJSxWllmgH8uPGKnUS2XQ48R
         agnKQChjGvbJRVCRgRa6hMMcDFebuVD5Pkg5+RFnFtzbYIMxIuaLeakxV7fUUafTycFC
         chrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6ix7RGeuZzlK2EiBW461W0zUYARdkQh+kTpYVjAF48Y=;
        fh=XPV/bbtjoBgCd9owE88iikMz+YQwe8zZgjv56XuOSvU=;
        b=Z/LZKepS+Ykbk2KhRnWf19WpvgNk5cSCucCL2vZY4RlNYOK8QWuQ+kxn+yZL1XVDx9
         bWtW7olIvzGAPji7n1heqZJQs4xnvt3WFOxJT6LUX7jf8XcveFCp0Q00sViAPTCbvXC5
         QeRhtCxA/0gpxE8QzgAz65rHvG7zNPb0M6zfXc1sEIreH8pFO/QwZivsYrWjBSwjPhIq
         0V9MDvPS45268tAlQ+UDJhhelPMB+wCthG5o4KFvnIZcJWA1N8csNlEXALebfEJIgv8t
         5WPCb0dnSVt6rv/TxVsGKAGO0R3GXcFiK7/kJ/Hc0XJRdtZ0PPQz+G73USNHFG6BfqpK
         kqkQ==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785922588; x=1786527388;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ix7RGeuZzlK2EiBW461W0zUYARdkQh+kTpYVjAF48Y=;
        b=gQOKbrNb3OUIW2CaIWP4Qg1vOy3FupLKhYYvq9tAYJVzXC7+X2P4Fw2Fzg9oOjtxkr
         UqIaNVyWmNyZBPDKpvAyooDIs9zKgPvEAMc/83G+RKP3Bfb6HyLUA/cusBO9G0Yx0mX4
         FHXeiCAealC6XRU8w/2GeZZ8+0ZQHCDzXWpZXsWzP0o+a4Rek00n2POEcVd5Ba1jQ7pW
         vAvOzoLjwI1CkeipAnJ/sHAxLIYLf5hqYWpNobb76AKKd0UtrV5QSiSvjG0cqC04D4c5
         Tp8aR1D1kCXlCte8F0kkd9IUoHhsK8WT5f9Ccee1onoyBVT+5Fsny+QHDip9XFWRzOSA
         EpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785922588; x=1786527388;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6ix7RGeuZzlK2EiBW461W0zUYARdkQh+kTpYVjAF48Y=;
        b=nncOdv6QEJZbXWvD9NRUqpp6ACkVmV/qjFuKoXkKKehpyCyLUh8O5Ljp0DoFtWzSo+
         xfe3JbJpfgzB/AYDbTarjG8tGDfE6m4t8VyC5dqCOQ+KC5dcsXHu6loXO5e5NS7rNo4F
         yDyXQFrTquxd3f0JqhapKzwayMzNDJMGjx5bTjcOklshbG1dVnLB3dyb+8N5Wekzkt2H
         Kvo13AyIDT5/3z4BDLGUAv8bIpWonMXDqqeq0jD7MSX7VfwDVXC+8DGGd8bk+uWULQ2Q
         O9ZWwZV8B6oARqnYUghKpC5FhQn59IZCY5ev0B2OuHBNHEpPyyDZgfJAvPs2IhrF32cR
         8eSQ==
X-Gm-Message-State: AOJu0Yy+b7Uv47vJtjyvUBz+pasUokHWc+iLXBJvyZ7siZU4rPRnGonl
	h199AZwn0DfN51PtFZEJqYdBNQHGKal9ra+5opwzES4NXj75oNfEhvvWsqxnWo4M1GZjNlEaaUj
	WBNBaxLFBOhbLgEt1E/f1Zgxe+M7loL8=
X-Gm-Gg: AR+sD11sLUACYk9FZkfwwzMai2FnkIDkEUGzJ8C1aL4HPJfahaxQz1Y1Gs6zyqQUBeT
	bwU0Pz1Eo+JIV6hmPNzP0LFJaIwBQ5Ax3xvTw0ZgPvqCY7Cdqy/3wHxHEYcOjY8kYfc8bjLBjwr
	PCAgcvnR1XQCrBfYfxWooFU1L5Zc2bxB860DvEVljMFbJq14Qo+r0jbpzINFfzUtg8tDhpUMBsR
	mi7gxG4VrnPZ3eo18+Z1UiKZ0Xrumajdxxls+uGXUtF07/IT3wSZs2yzos26nVDBNnGUlwZs6Va
	iUc6nPNHUXjG7P8mev8N3TryHFcrHbqeZj8Ijm7ryVI=
X-Received: by 2002:a4a:edce:0:b0:6aa:d860:afad with SMTP id
 006d021491bc7-6ae96ce17c0mr2921764eaf.15.1785922588023; Wed, 05 Aug 2026
 02:36:28 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAEoG+NRpPip1Eymi1ZSgG7FdYH2UkRneat2GJRWXL_M38xfD9w@mail.gmail.com>
 <8733wshq3t.wl-tiwai@suse.de>
In-Reply-To: <8733wshq3t.wl-tiwai@suse.de>
From: =?UTF-8?B?5byg5bu6?= <soldierjazz2013@gmail.com>
Date: Wed, 5 Aug 2026 17:36:19 +0800
X-Gm-Features: AUfX_mwsQnCgFUpIVBJASPnAHfd4NpXLGJE9fsqyrlFWKp1o-2jmFrPJ7YMrnZU
Message-ID: 
 <CAEoG+NTPOoKfbJMvcnfsM2f-3GUrpcw5_LSnpXvAPWUZZJg7mA@mail.gmail.com>
Subject: Re: [BUG REPORT] sound/usb: Fix Use-After-Free in snd-usb-audio
 error_timer during device disconnect
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
X-MailFrom: soldierjazz2013@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: LM3XYSRZ6GJHQNZVA3M6Z2Q3OIBJQJZ3
X-Message-ID-Hash: LM3XYSRZ6GJHQNZVA3M6Z2Q3OIBJQJZ3
X-Mailman-Approved-At: Wed, 05 Aug 2026 10:29:14 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LM3XYSRZ6GJHQNZVA3M6Z2Q3OIBJQJZ3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGkgVGFrYXNoaSwNCg0KV2UgY2FuIG9ubHkgdGVzdCB0aGUgTGludXggZHJpdmVyIG9uIG90aGVy
IHByb2Nlc3NvcnMgKG5vbi1RdWFsY29tbQ0KcHJvY2Vzc29ycyksIGFuZCBubyBwcm9ibGVtcyBv
Y2N1ciB1bmRlciB0aGVzZSBjb25kaXRpb25zLiBUaGVyZWZvcmUsIHdlDQpzdXNwZWN0IGl0J3Mg
cmVsYXRlZCB0byB0aGUgY2FsbGJhY2sgdmFsdWUgc2VudCB0byB0aGUgVVJCIHdoZW4gYSBVU0IN
CmRldmljZSBpcyBkaXNjb25uZWN0ZWQgb24gYSBRdWFsY29tbSBDUFUuDQoNClRoYW5rcyENCg0K
VGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRlPiDkuo4yMDI25bm0OOaciDXml6XlkajkuIkgMTc6
MzDlhpnpgZPvvJoNCg0KPiBPbiBXZWQsIDA1IEF1ZyAyMDI2IDExOjE5OjU0ICswMjAwLA0KPiDl
vKDlu7ogd3JvdGU6DQo+ID4NCj4gPg0KPiA+IEhpIFRha2FzaGkgYW5kIExpbnV4IFVTQi9BTFNB
IG1haW50YWluZXJzLA0KPiA+DQo+ID4gV2UgaWRlbnRpZmllZCBhIHJlcHJvZHVjaWJsZSBVc2Ut
QWZ0ZXItRnJlZSAoVUFGKSBrZXJuZWwgcGFuaWMgaW4NCj4gc291bmQvdXNiLw0KPiA+IG1pZGku
YyBkdXJpbmcgVVNCIE1JREkgZGV2aWNlIGhvdC11bnBsdWcgdW5kZXIgYWN0aXZlIFVSQiB0cmFu
c2ZlcnMuDQo+ID4NCj4gPiBUaGUgaXNzdWUgd2FzIHJlcHJvZHVjZWQgb24gUXVhbGNvbW0gcGxh
dGZvcm1zIChTbmFwZHJhZ29uIDggR2VuIDMgTGludXgNCj4gPiA2LjEuMTQ1IC8gQW5kcm9pZCAx
NCwgU25hcGRyYWdvbiA4IEVsaXRlIExpbnV4IDYuNi43NyAvIEFuZHJvaWQxNiBldGMuKS4NCj4g
VGhlDQo+ID4gY3Jhc2ggY29uc2lzdGVudGx5IGhpdHMgX19ydW5fdGltZXJzICh0aW1lciBzb2Z0
aXJxKSBkZXJlZmVyZW5jaW5nIHBvaXNvbg0KPiA+IHBvaW50ZXIuDQo+ID4NCj4gPiBDcmFzaCBU
cmFjZQ0KPiA+DQo+ID4gWyAgMTY5LjQ5MzkwN10gSVsgMTogc3VyZmFjZWZsaW5nZXI6IDE3OTRd
IEludGVybmFsIGVycm9yOiBPb3BzIC0gQ0ZJOg0KPiAwMDAwMDAwMGYyMDA4MjM0IFsjMV0gUFJF
RU1QVCBTTVANCj4gPiBbICAxNjkuNDkzOTQxXSBJWyAxOiBzdXJmYWNlZmxpbmdlcjogMTc5NF0g
c2VjLHFjLXJzdF9leGluZm8NCj4gc29jOnNhbXN1bmcscWNvbS1yc3RfZXhpbmZvOiBmYXVsdCBo
YW5kbGVyIDogdW5rbm93bg0KPiA+IFsgIDE2OS40OTU0NDJdIElbIDE6IHN1cmZhY2VmbGluZ2Vy
OiAxNzk0XSBDUFU6IDEgUElEOiAxNzk0IENvbW06DQo+IHN1cmZhY2VmbGluZ2VyIFRhaW50ZWQ6
IEcgUyAgICAgIFdDIE8NCj4gNi4xLjE0NS1hbmRyb2lkMTQtMTEtMzI1NDc0My1hYlM5MjgwWkNT
NkRaRjIgIzENCj4gPiBbICAxNjkuNDk1NDQ3XSBJWyAxOiBzdXJmYWNlZmxpbmdlcjogMTc5NF0g
SGFyZHdhcmUgbmFtZTogU2Ftc3VuZyBFM1ENCj4gUFJPSkVDVCAoYm9hcmQtaWQsMDkpIChEVCkN
Cj4gPiBbICAxNjkuNDk1NDU1XSBJWyAxOiBzdXJmYWNlZmxpbmdlcjogMTc5NF0gcHN0YXRlOiAw
MjQwMDAwNSAobnpjdiBkYWlmDQo+ICtQQU4gLVVBTyArVENPIC1ESVQgLVNTQlMgQlRZUEU9LS0p
DQo+ID4gWyAgMTY5LjQ5NTQ2NF0gSVsgMTogc3VyZmFjZWZsaW5nZXI6IDE3OTRdIHBjIDogY2Fs
bF90aW1lcl9mbisweDQ0LzB4MjZjDQo+ID4gWyAgMTY5LjQ5NTQ3MV0gSVsgMTogc3VyZmFjZWZs
aW5nZXI6IDE3OTRdIGxyIDogX19ydW5fdGltZXJzKzB4MWI4LzB4MzBjDQo+ID4gWyAgMTY5LjQ5
NTQ3NV0gSVsgMTogc3VyZmFjZWZsaW5nZXI6IDE3OTRdIHNwIDogZmZmZmZmYzAwODAwYmU0MA0K
PiA+IFsgIDE2OS40OTU0ODBdIElbIDE6IHN1cmZhY2VmbGluZ2VyOiAxNzk0XSB4Mjk6IGZmZmZm
ZmMwMDgwMGJlNDAgeDI4Og0KPiBkZWFkMDAwMDAwMDAwMTIyIHgyNzogMDAwMDAwMDAwMDAwMDAw
MA0KPiA+IFsgIDE2OS40OTU0OTBdIElbIDE6IHN1cmZhY2VmbGluZ2VyOiAxNzk0XSB4MjY6IGZm
ZmZmZmMwMDgwMGJlOTAgeDI1Og0KPiAwMDAwMDAwMDAwMDAwMDAxIHgyNDogZmZmZmZmOGE3MTMz
MTJiMA0KPiA+IFsgIDE2OS40OTU1MDFdIElbIDE6IHN1cmZhY2VmbGluZ2VyOiAxNzk0XSB4MjM6
IGZmZmZmZmMwMGE0MjcwMDAgeDIyOg0KPiBmZmZmZmY4ODY4YTcwMDAwIHgyMTogZmZmZmZmODA0
YzQ4NWM0MA0KPiA+IFsgIDE2OS40OTU1MTFdIElbIDE6IHN1cmZhY2VmbGluZ2VyOiAxNzk0XSB4
MjA6IGZmZmZmZjgwNGM0ODVjNTggeDE5Og0KPiAwMDAwMDAwMDAwMDAwMTAwIHgxODogMDAwMDAw
MDAwMDAwMDAwMA0KPiA+IFsgIDE2OS40OTU1MjJdIElbIDE6IHN1cmZhY2VmbGluZ2VyOiAxNzk0
XSB4MTc6IDAwMDAwMDAwOTFiNGE4M2EgeDE2Og0KPiAwMDAwMDAwMDAwMDAwMDAwIHgxNTogMDAw
MDAwMDAwMDAwMDAwMA0KPiA+IFsgIDE2OS40OTU1MzJdIElbIDE6IHN1cmZhY2VmbGluZ2VyOiAx
Nzk0XSB4MTQ6IGZmZmZmZjgwNGM0ODVjNDAgeDEzOg0KPiAwMDAwMDAwMDAwMDAwMDBkIHgxMjog
MDAwMDAwMDAwMDAwMDAyOA0KPiA+IFsgIDE2OS40OTU1NDJdIElbIDE6IHN1cmZhY2VmbGluZ2Vy
OiAxNzk0XSB4MTE6IGZmZmZmZmMwMDgwMGJlOTggeDEwOg0KPiBmZmZmZmY4YTcxMzMxMjQwIHg5
IDogMDAwMDAwMDEwMDAwMDEwMA0KPiA+IFsgIDE2OS40OTU1NTNdIElbIDE6IHN1cmZhY2VmbGlu
Z2VyOiAxNzk0XSB4OCA6IDAwMDAwMDAxMDAwMDAxMDAgeDcgOg0KPiAwMDAwMDAyNzc2NDk3NzM2
IHg2IDogMDAwMDAwMjc3NjQ5NzczNg0KPiA+IFsgIDE2OS40OTU1NjNdIElbIDE6IHN1cmZhY2Vm
bGluZ2VyOiAxNzk0XSB4NSA6IDAwMDAwMDI3NzY0OTc3MzYgeDQgOg0KPiAwMDAwMDAwMDAwMDAw
MDAxIHgzIDogMDAwMDAwMDAwMDAwMDljNA0KPiA+IFsgIDE2OS40OTU1NzNdIElbIDE6IHN1cmZh
Y2VmbGluZ2VyOiAxNzk0XSB4MiA6IDAwMDAwMDAwZmZmZjgwOGQgeDEgOg0KPiBmZmZmZmY4MDRj
NDg1YzU4IHgwIDogZmZmZmZmODA0YzQ4NWM0MA0KPiA+IFsgIDE2OS40OTU1ODRdIElbIDE6IHN1
cmZhY2VmbGluZ2VyOiAxNzk0XSBDYWxsIHRyYWNlOg0KPiA+IFsgIDE2OS40OTU1OTFdIElbIDE6
IHN1cmZhY2VmbGluZ2VyOiAxNzk0XSAgY2FsbF90aW1lcl9mbisweDQ0LzB4MjZjDQo+ID4gWyAg
MTY5LjQ5NTU5OF0gSVsgMTogc3VyZmFjZWZsaW5nZXI6IDE3OTRdICBfX3J1bl90aW1lcnMrMHgx
YjgvMHgzMGMNCj4gPiBbICAxNjkuNDk1NjA1XSBJWyAxOiBzdXJmYWNlZmxpbmdlcjogMTc5NF0g
IHJ1bl90aW1lcl9zb2Z0aXJxKzB4MjQvMHg0Yw0KPiA+IFsgIDE2OS40OTU2MTRdIElbIDE6IHN1
cmZhY2VmbGluZ2VyOiAxNzk0XSAgaGFuZGxlX3NvZnRpcnFzKzB4MTIwLzB4M2UwDQo+ID4gWyAg
MTY5LjQ5NTYyMV0gSVsgMTogc3VyZmFjZWZsaW5nZXI6IDE3OTRdICBfX2RvX3NvZnRpcnErMHgx
NC8weDIwDQo+ID4gWyAgMTY5LjQ5NTYyOF0gSVsgMTogc3VyZmFjZWZsaW5nZXI6IDE3OTRdICBf
X19fZG9fc29mdGlycSsweDEwLzB4MjANCj4gPiBbICAxNjkuNDk1NjM1XSBJWyAxOiBzdXJmYWNl
ZmxpbmdlcjogMTc5NF0gIGNhbGxfb25faXJxX3N0YWNrKzB4M2MvMHg3NA0KPiA+IFsgIDE2OS40
OTU2NDFdIElbIDE6IHN1cmZhY2VmbGluZ2VyOiAxNzk0XQ0KPiBkb19zb2Z0aXJxX293bl9zdGFj
aysweDFjLzB4MmMNCj4gPiBbICAxNjkuNDk1NjQ4XSBJWyAxOiBzdXJmYWNlZmxpbmdlcjogMTc5
NF0gIF9faXJxX2V4aXRfcmN1KzB4NTQvMHhiNA0KPiA+IFsgIDE2OS40OTU2NTVdIElbIDE6IHN1
cmZhY2VmbGluZ2VyOiAxNzk0XSAgaXJxX2V4aXRfcmN1KzB4MTAvMHgxYw0KPiA+IFsgIDE2OS40
OTU2NjVdIElbIDE6IHN1cmZhY2VmbGluZ2VyOiAxNzk0XSAgZWwwX2ludGVycnVwdCsweDU0LzB4
MTc0DQo+ID4gWyAgMTY5LjQ5NTY3MV0gSVsgMTogc3VyZmFjZWZsaW5nZXI6IDE3OTRdDQo+IF9f
ZWwwX2lycV9oYW5kbGVyX2NvbW1vbisweDE4LzB4MjgNCj4gPiBbICAxNjkuNDk1Njc3XSBJWyAx
OiBzdXJmYWNlZmxpbmdlcjogMTc5NF0gIGVsMHRfNjRfaXJxX2hhbmRsZXIrMHgxMC8weDFjDQo+
ID4gWyAgMTY5LjQ5NTY4M10gSVsgMTogc3VyZmFjZWZsaW5nZXI6IDE3OTRdICBlbDB0XzY0X2ly
cSsweDFhNC8weDFhOA0KPiA+IFsgIDE2OS40OTU2OTBdIElbIDE6IHN1cmZhY2VmbGluZ2VyOiAx
Nzk0XSBDb2RlOiA3Mjk1MDc1MSA3MmIyMzY5MQ0KPiA2YjExMDIxZiA1NDAwMDA0MCAoZDQzMDQ2
ODApDQo+ID4gWyAgMTY5LjQ5NTY5Nl0gSVsgMTogc3VyZmFjZWZsaW5nZXI6IDE3OTRdIC0tLVsg
ZW5kIHRyYWNlDQo+IDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiA+DQo+ID4gUm9vdCBDYXVzZSAm
IFJhY2UgQ29uZGl0aW9uDQo+ID4NCj4gPiBUaGVyZSBpcyBhIHNlcXVlbmNlIGRlZmVjdCBpbiBz
bmRfdXNibWlkaV9kaXNjb25uZWN0KCkgY29tYmluZWQgd2l0aCB0aGUNCj4gVVJCDQo+ID4gY29t
cGxldGlvbiBoYW5kbGVyOg0KPiA+DQo+ID4gIDEuIEluIHNuZF91c2JtaWRpX2Rpc2Nvbm5lY3Qo
KSwgZGVsX3RpbWVyX3N5bmMoJnVtaWRpLT5lcnJvcl90aW1lcikgaXMNCj4gPiAgICAgaW52b2tl
ZCBCRUZPUkUga2lsbGluZyBpbi1mbGlnaHQgSU4gVVJCcyB2aWEgdXNiX2tpbGxfdXJiKCkuDQo+
ID4NCj4gPiAgMi4gUHJpb3IgdG8gdXNiX2tpbGxfdXJiKCkgZmluaXNoaW5nLCBhbiBpbi1mbGln
aHQgSU4gVVJCIGNvbXBsZXRlcw0KPiB3aXRoIGFuDQo+ID4gICAgIHVuY29udmVudGlvbmFsIGVy
cm9yIHN0YXR1cyAoZS5nLiwgLUVQSVBFKSB3aGVuIFVTQiBkaXNjb25uZWN0Lg0KPiA+DQo+ID4g
IDMuIHNuZF91c2JtaWRpX2luX3VyYl9jb21wbGV0ZSgpIGNhbGxzIHNuZF91c2JtaWRpX3VyYl9l
cnJvcih1cmIpLiBXaGVuDQo+ID4gICAgIHJlY2VpdmluZyBub24tZGlzY29ubmVjdCBlcnJvciBj
b2RlcyAoVGhpcyBlcnJvciBjb2RlIGlzIG91dHNpZGUgdGhlDQo+IHNjb3BlDQo+ID4gICAgIG9m
IHRoZSBlcnJvciBjb2RlcyBoYW5kbGVkIGJ5IHNuZF91c2JtaWRpX3VyYl9lcnJvci4pLCBpdCBp
bnZva2VzDQo+ID4gICAgIG1vZF90aW1lcigmZXAtPnVtaWRpLT5lcnJvcl90aW1lciwgLi4uKSB3
aXRob3V0IGNoZWNraW5nIHVtaWRpLT4NCj4gPiAgICAgZGlzY29ubmVjdGVkLg0KPiA+DQo+ID4g
IDQuIFRoaXMgcmUtYXJtcyBlcnJvcl90aW1lciBBRlRFUiBkZWxfdGltZXJfc3luYygpIGhhcyBh
bHJlYWR5IGV4ZWN1dGVkLg0KPiA+DQo+ID4gIDUuIHNuZF91c2JtaWRpX2Rpc2Nvbm5lY3QoKSBj
b21wbGV0ZXMgYW5kIGZyZWVzIHN0cnVjdCBzbmRfdXNiX21pZGkgaW4NCj4gPiAgICAgc25kX3Vz
Ym1pZGlfZnJlZS4NCj4gPg0KPiA+ICA2LiBMYXRlciB3aGVuIGVycm9yX3RpbWVyIGZpcmVzIG9u
IGRlYWxsb2NhdGVkIG1lbW9yeSwgbGVhZGluZyB0byBhIFVBRg0KPiBwYW5pYw0KPiA+ICAgICBp
biBfX3J1bl90aW1lcnMuDQo+ID4NCj4gPiBQbGVhc2UgbGV0IHVzIGtub3cgeW91ciB0aG91Z2h0
cyBvbiB0aGlzIGlzc3VlLg0KPg0KPiBDb3VsZCB5b3UgdmVyaWZ5IHRoZSBpc3N1ZSB3aXRoIHRo
ZSB2ZXJ5IGxhdGVzdCBMaW51cyB0cmVlLCB0b28/DQo+DQo+DQo+IHRoYW5rcywNCj4NCj4gVGFr
YXNoaQ0KPg0K
