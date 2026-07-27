Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D86C54F51
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:58:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A43360201;
	Wed, 29 Jul 2026 10:57:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A43360201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785315477;
	bh=qTt4reaJox/JlanPoird3biBn3kcnt330Fz+bp5OWj0=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=HQkgw6wFeUlrauv5jTeN7Sj4g36oDiOfOy35sMV5KevAerC6PdcUq9EjwbLSEmzne
	 2qFtYuDfkkrOhhqjnx0uEqi60xvUoFR+o5LKJJuSHCtT1KvabQ964derNLQzgFZdd1
	 z6uvNvwEw4SfPDzDF2sQ8r//w6moKJOUFJwXFLRw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 26F3EF805FA; Wed, 29 Jul 2026 10:57:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9EA10F805FF;
	Wed, 29 Jul 2026 10:57:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3E773F800BA; Mon, 27 Jul 2026 09:20:30 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1785136823;
	b=rIt0lXKuT6geezmjBjpJneuypbsTybPcBGFMkzzIKs4ubD1tjwmh1mu79J7mDwLwrPtm
	 cBuBTkxWlqX2cwo1CfKyxHl0R4SWUczMITsACkIYv7Hg3RMSJyNAa8jewcSa3Vu3MXLSr
	 DfxAEVzvK5b4Xo3IwbFaDrT8q6zvfFFH4VmyX2cuDE0jRy23m3sRMCvKQjsUHW+qdKwij
	 1ROqCSg4VYUZ3xSW1/Vtky2byHQw2wM4VHPYHAX4SCz0w6fDh5omVEjnAtGfwcQjVolhy
	 co12tXo0tSo9siR4Bl5XXCEMTBUPB+6oMZQJhc9ZosoveWCG3Ryesas4ZsyLt7Zv4+w==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785136823;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=ytfeds/g1FJOZVEkS5B4LFW7G9+2fAS3IKmLPfg9mpg=;
	b=k2f63kUHuvOHl38MCibDKuwCGGgwrFo5aZEX4JK0pFYlCFboM0neP4H6NHdvwGuVVToS
	 6lzV0A7WFlSQbgWEe0Ka8UVp6Kf4wss8OlROGYNH0C8Dyy+Ge8//j/3Z//rJUObPy3u00
	 /PGS14AjVv0NzdLVDC37IUvk2GoIjAo7JaK1w6TDkFgzaT43Sb6o6xg196dNehjTwv8lN
	 ddLCPxh4bgv9VjOwoTnnZyTLTWuESN3rHXjE9p/B+bYdE5TGeXvg81qhGDMo5VMb3PX58
	 KXKnZRmNYmuu8RDQVaweoAGMqcw5/rVt5RnN8Jyig8gohkI1kExn+fC71AUUbo7/9yw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jJgNni8o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3A988F800BA
	for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2026 09:20:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A988F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jJgNni8o
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso2280826b3a.0
        for <alsa-devel@alsa-project.org>;
 Mon, 27 Jul 2026 00:20:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785136820; cv=none;
        d=google.com; s=arc-20260327;
        b=MOtqyZ9R5wV86tnGuJnSlvvc/Avg/YuZy7xSosFUXks5lDjbsf2du7Idn9SEDuc64e
         yyGHMVojB6+IQsF0bDjlUZFrnUTnZ8F1lLoq1N07/GYyUsg89WheV7L7UEKMXO/uqFk/
         aEtBEtpj3qZBiXKDPIaWOfn0hF0gIaUUKdLNRf0GoL+tKB4h1FyrVOK24I3b/w5UthoJ
         XyE7FZAJVIMdoKnpuHFnSXyuxAANoZDTTHnrpXNHJ6hlXHNruVPs4a8bLhfUJoFgd/9w
         qMrmGVG+KX4PuXtrXjb4GachJk9Jq/eXzFRUzSCmL4WM4BzBoPnJzZRv6P4eI2Lh0ixG
         JqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ytfeds/g1FJOZVEkS5B4LFW7G9+2fAS3IKmLPfg9mpg=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=BsZy5MFRko8fgZbcuBVKvY3AJIzvBgiJeY8+pMU+7I7zLXuoF92gX6qgKkQG2UiBTP
         qIzuB4mkHYXIPrzSc8qN+ooOhiY5HDwOn5gPb7Daf9v95mnOO7jwaMSA+kKCrKbQZ7pg
         LxNhK0p7WiOt6KbgTzul8zPtwcuTxLoY40r66dpcaC9dadMLcA/dXk75omH8qsSTpHco
         5P+hqj58Y6AqP/NT0NgChfvkJB156uXIXumKyS62hax0ftduUOkFfJ2tnHPrABHRoVOR
         n879GnXgG1qGaX4EUMWVuGTNy6Fqda74sOAGHCLTdP5vVI+pcF0gCUEyzgqgd7cCraKB
         rj6w==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785136820; x=1785741620;
 darn=alsa-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ytfeds/g1FJOZVEkS5B4LFW7G9+2fAS3IKmLPfg9mpg=;
        b=jJgNni8o7RLiVJ6XoIPkwW4t3KV/dMi9LCfG3q+EGQj0XCf8/xS3g2nn7EwNLdAakV
         ZoKvOFIYg2ldAqVeVBo9gqyF3JMACMRsnCirIITUkxDIOiIxuUM4TVr/rIqndHYCaKF8
         S0abgYo7pW7UnyBwma9kouVzAox9MOTLz+WMVl90iGLRSRONqnWd4Oywlv4Lw9emsveH
         kW83LoFfqZ3kACipCEt6Wnbo95zG8DGdtjQ/7qzTjkdCDzWVRX3lNz6zRvaIHezp2K2O
         tMPo6xrWIHEtWfu6dgJa0Ox/3GGf20EI3gbnrSGH6F/rCmnj8PGVrzADqN9+0+eAZXpc
         Tc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785136820; x=1785741620;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ytfeds/g1FJOZVEkS5B4LFW7G9+2fAS3IKmLPfg9mpg=;
        b=IYLZLcjPLPXtqM97uGmXgZ5vNreFZndFJG1YJx+rnI+/r0v3RAEMlTAxUpEl0IrBZq
         Pu30LHDai2TqFbGC/ZbrTwPtneIfni4XQ/rlRUNFuO+lo78TXluA6bPbSZUMaaiUxPL2
         yeqZA+VLl6DnM9rfvih6xD4wMKfzyeHvBhtHn15hJhrSjV6a+lWAtUA55KnkWJ8T+01A
         oFrhpVRgpV9xqgRS7dvF75c4+m8h/hUorrgoVYqA3kIoAAPqgPaoxYvcG7gYjyOLsSue
         9pcVgvJKlIU8l1D9rKWz538JcQNVcOMTiOONlDv3Js2xKD//Sl9/AWsDLJ4aO48ZqMux
         Yz1Q==
X-Gm-Message-State: AOJu0YyH5P/ay5Kez8y8zTbCbF8LMk4e69FPZYwLm3ntpA5r5XswxXfy
	Nx5lzJSC0RcBhHO4EX6KKc4OkCIskPaZ0xXDbdEFFz2kWwSPW+khZ5D42Nk251MkmqseejQSCig
	SyT3a0Ms/IyWWYDXcy3buFMGxMNeCZgmJPmezog4=
X-Gm-Gg: AR+sD1138ZQg1ajWCYu76yilsxxTsB74v7P1Y9pPsdUkJKvjeRpBmPo6XhAwXWDfWzi
	ho5nEmwhlLUsSQPnEOWqOnYyf2FmGCfwC3PgVKsun5HHw2alWHgLsFWt973QvB/Y0B+IaIG8zn9
	BUbCzZxViCBDh5sMRCklnjIzzFEsDDPNbEBscjfrLnIsOhYEVPB6MCIYbjqfguvc1uXtItiCEih
	EGFcysYNhcso30OjunRjP18vwj5GVH8j41NXzWlPJSgwrdnDLdcuhDKxkTfIw==
X-Received: by 2002:a05:6a20:4323:b0:3c0:9c19:65b1 with SMTP id
 adf61e73a8af0-3c67e1780bemr6808791637.73.1785136819345; Mon, 27 Jul 2026
 00:20:19 -0700 (PDT)
MIME-Version: 1.0
From: Andriy Voronych <voronych.av@gmail.com>
Date: Mon, 27 Jul 2026 10:20:08 +0300
X-Gm-Features: AUfX_mz6qeWmTfeFyVeW46aS9jLtfU5mqJJ1jnGWb5p3W8fIW3C32qxk-SViWN0
Message-ID: 
 <CAPuLnRDN2=8ZM3d+r00QuiKKzy4R4385X4zyS3KJAA5FLLtOqg@mail.gmail.com>
Subject: =?UTF-8?Q?No_sound_from_internal_speakers_on_Realtek_ALC235_=28E?=
	=?UTF-8?Q?mdoor_OEM_boards=2C_e=2Eg=2E_Thunderobot_Aibook_14_Air=2C_subsys_0x2?=
	=?UTF-8?Q?782=3A0xA244=29_=E2=80=94_exhaustive_negative_results=2C_requesting_guid?=
	=?UTF-8?Q?ance?=
To: alsa-devel@alsa-project.org
X-MailFrom: voronych.av@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: PAT5BNA47A2ZDOHC2QQAEDBTVXBQMKII
X-Message-ID-Hash: PAT5BNA47A2ZDOHC2QQAEDBTVXBQMKII
X-Mailman-Approved-At: Wed, 29 Jul 2026 08:57:16 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PAT5BNA47A2ZDOHC2QQAEDBTVXBQMKII/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGkgYWxsLA0KDQpJJ3ZlIGJlZW4gaW52ZXN0aWdhdGluZyBzaWxlbnQgaW50ZXJuYWwgc3BlYWtl
cnMgb24gYSBUaHVuZGVyb2JvdCBBaWJvb2sgMTQNCkFpciAoRW1kb29yIE9FTSBib2FyZCksIFJl
YWx0ZWsgY29kZWMgdmVuZG9yIElEIDB4MTBlYzAyMzUgKHJlcG9ydGVkIGFzDQpBTEMyMzMsIGFj
dHVhbGx5IEFMQzIzNSBwZXIgdGhlIFdpbmRvd3MgSU5GKSwgc3Vic3lzdGVtIDB4Mjc4MjoweEEy
NDQuDQpIZWFkcGhvbmVzIHdvcmsgY29ycmVjdGx5OyBvbmx5IHRoZSBpbnRlcm5hbCBzcGVha2Vy
cyBhcmUgYWZmZWN0ZWQuIFdpbmRvd3MNCjExIG9uIHRoZSBzYW1lIGhhcmR3YXJlIHdvcmtzIGZp
bmUgdmlhIFJlYWx0ZWsncyBnZW5lcmljDQpoZHhhY3BlbWRvb3IuaW5mL1JUQUlPREFULkRBVCBk
cml2ZXIuDQoNClRoaXMgbG9va3MgY2xvc2VseSByZWxhdGVkIHRvIGJ1Z3ppbGxhLmtlcm5lbC5v
cmcgIzIyMTY4OSAoSW5maW5peCBYQk9PSw0KQjE1LCBzYW1lIEVtZG9vciBib2FyZCBmYW1pbHks
IHN1YnN5c3RlbSAweDI3ODJBMjRBLCBzYW1lIGNvZGVjKSDigJQgb24gdGhhdA0KcmVwb3J0IGhl
YWRwaG9uZXMgYWxzbyBmYWlsLCBzbyBpdCBtYXkgYmUgdGhlIHNhbWUgcm9vdCBjYXVzZSBvciBh
DQpyZWxhdGVkLWJ1dC1kaXN0aW5jdCBvbmUuDQoNCkkndmUgZG9uZSBhIGZhaXJseSB0aG9yb3Vn
aCBpbnZlc3RpZ2F0aW9uIGFuZCB3YW50ZWQgdG8gY2hlY2sgd2hldGhlcg0KYW55b25lIHJlY29n
bml6ZXMgdGhpcyBwYXR0ZXJuIGJlZm9yZSBJIGtlZXAgZ3Vlc3NpbmcgYmxpbmRseS4gRnVsbCB3
cml0ZXVwDQp3aXRoIHJlZ2lzdGVyIGR1bXBzL3NjcmlwdHM6DQpodHRwczovL2dpdGh1Yi5jb20v
UzFOUzIyNy9haWJvb2sxNC1haXItbGludXgtYXVkaW8NCg0KU3VtbWFyeSBvZiB3aGF0J3MgcnVs
ZWQgb3V0Og0KLSBFdmVyeSBjb2RlYyByZWdpc3RlciBpbiB0aGUgREFDLT5taXhlci0+cGluIHNp
Z25hbCBwYXRoIChub2RlIDB4MDIsIDB4MGMsDQoweDE0KSBpcyBhbHJlYWR5IGNvcnJlY3RseSB1
bm11dGVkL3Bvd2VyZWQvRUFQRC1lbmFibGVkDQotIENPRUYgcmVnaXN0ZXJzIGV4dHJhY3RlZCBm
cm9tIFdpbmRvd3MnIFJUQUlPREFULkRBVCBkZWZhdWx0IEFMQzIzNSBpbml0DQpibG9jayAoMHgz
NiwgMHgyNCwgMHgzNykgd2VyZSBsaXZlLXdyaXR0ZW4gZHVyaW5nIGFjdGl2ZSBwbGF5YmFjayAo
bm90IGp1c3QNCmJlZm9yZSwgaW4gY2FzZSBvcmRlcmluZyBtYXR0ZXJlZCkg4oCUIG5vIGVmZmVj
dCwgaW5kaXZpZHVhbGx5IG9yIGNvbWJpbmVkDQotIEFDUEkgRFNEVDogYm90aCB0aGUgSERBIGNv
ZGVjIGFuZCBBTUQgQUNQIFBDSSBmdW5jdGlvbnMgYXJlIGJhcmUgX0FEUg0Kc3R1YnMsIG5vIF9Q
UzAvX0RTTSBsb2dpYywgemVybyBHcGlvSW8vR3Bpb0ludCBkZXNjcmlwdG9ycyBhbnl3aGVyZQ0K
LSBBTUQgQUNQIGNvcHJvY2Vzc29yIGVuYWJsZXMgYnV0IHJlZ2lzdGVycyBubyBzb3VuZCBjYXJk
ICh1bnVzZWQgSTJTIGJsb2NrKQ0KLSBSYXcgQU1EIEZDSCBHUElPIGNvbnRyb2xsZXI6IDkgb3V0
cHV0LWNvbmZpZ3VyZWQgbGluZXMsIG5vbmUgY2hhbmdlIHN0YXRlDQpvbiBhIHJlYWwgaGVhZHBo
b25lIGphY2sgaW5zZXJ0aW9uIGV2ZW50DQotIFRoaXJkLXBhcnR5IHRlYXJkb3duIG9mIHRoaXMg
bW9kZWwgc2hvd3MgYSBwbGFpbiAyLXdpcmUgcGFzc2l2ZSBzcGVha2VyDQpjb25uZWN0aW9uIOKA
lCBubyBzZXBhcmF0ZSBzbWFydC1hbXAgSUMNCg0KU2luY2UgaGVhZHBob25lcyB3b3JrIGNvcnJl
Y3RseSBvbiB0aGUgc2FtZSBjb2RlYywgdGhlIGdlbmVyYWwNCkhEQS9qYWNrLXNlbnNlIHBhdGgg
Y2xlYXJseSBpc24ndCBicm9rZW4g4oCUIHNvbWV0aGluZyBzcGVjaWZpYyB0byB0aGUNCnNwZWFr
ZXItZW5hYmxlIHBhdGggaXNuJ3QgdmlzaWJsZSB0aHJvdWdoIGFueSBpbnRlcmZhY2UgSSd2ZSBj
aGVja2VkLiBEb2VzDQphbnlvbmUgaGF2ZSBpbnNpZ2h0IGludG8gaG93IEFMQzIzNSBzcGVha2Vy
LWFtcCBlbmFibGUgZGlmZmVycyBmcm9tDQpBTEMyNTYvQUxDMjgzIG9uIEVtZG9vciBPRU0gYm9h
cmRzLCBvciBzdWdnZXN0aW9ucyBmb3Igd2hhdCBlbHNlIHRvIGNoZWNrPw0KSGFwcHkgdG8gdGVz
dCBhbnl0aGluZyDigJQgSSBoYXZlIGZ1bGwgcGh5c2ljYWwgYWNjZXNzIGFuZCByb290Lg0KDQpU
aGFua3MsDQpTMU5TMjI3DQo=
