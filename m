Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F05C4451C
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2026 15:15:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C574601EB;
	Fri, 17 Jul 2026 17:14:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C574601EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784301305;
	bh=rX/rlNE/8I73wh1XyCSFComq0iaZ+QxD1RtHCG4rK3o=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=OrvBWMGGzkXeadDaW1NlezBUg3R5TMwLg0U0LBG4SmYKAIOfipIx8fQF8z5gWYWC8
	 X9PasUz+Bli2RS5IYuzRoC32cBlGZbSCxCF13xFHK9VXThVb3tOsTMynObsFTzYT41
	 xY0g8L1cU3rmszPUYrumrv+WwHFdpfo/qNu/EOUs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4E317F8025A; Fri, 17 Jul 2026 17:14:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EFF3CF80600;
	Fri, 17 Jul 2026 17:14:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C23BAF80526; Fri, 17 Jul 2026 17:14:23 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1784301262;
	b=mWIp2MjhCBaqYxa5FrPNXS74e/kbP4Usqghr+Hln2fRzwBBPdWWuC40Weghl5HTI6rTe
	 Wiop1eU8dw3IjL4AulnsRdbWxFiIQfrJvs9nIZEbZXZcW6iOswxoCG3LWtHJbmrEG4Oa3
	 SaGeVmhi35WEtcO21CU67lJv8XHDCMjVVdKZYDxYN2cGJn/ZNe/XM0ZXKMQ7LqkEFRjCx
	 W1+L2P+N0uxMQn+nS8OlLFyN7uRkOjl/EjNc8FknMh5fyxXWy0CxxJM8mX2BasTp8eojW
	 wC04MfXtrzyXXGp7D/mKRZ31ul1urIDQz1ZmxThEkhq4enSSxSJ0Czc+0rUJf0N/AAA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784301262;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=bnnLA4JVCP4/Hwep38HS+P9XipdJXGu1HJhHdWYnHxo=;
	b=a/K4VxDwJ+qh0J3z8v+zOLRxTp8KCET03yoImO3u7zKovZmwVarj3lh/M7bhPL2d/SUF
	 qAAfbhKIo60nN8u8rI19Bb9XdEFePwYR4TP4neGL5dZEfKsmJFwKStvoyPTBSr3egDQ14
	 Z2JY65KnU6vTKfCA+0KCit0hePeK2wLkRDclgSbfnuEOy6Swg8Ce8ROwxtMc8kn+JbQCh
	 20FL0DRouwsh8HfSWTMfUo/ZB900LXGy9Iksr2rQ/cMDBUaZv+UPhBKP/yT5ZkF7YfEH7
	 6aJfQzDI8k4JncZn0heq0lLtUKyv2joZrwsgaQ+mmixEkHcFuIpdnKEV8HX4jCOioWA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=IJQYyRNP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B6D38F8047D
	for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2026 17:14:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6D38F8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=IJQYyRNP
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2cab1f435afso14967895ad.2
        for <alsa-devel@alsa-project.org>;
 Fri, 17 Jul 2026 08:14:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784301259; cv=none;
        d=google.com; s=arc-20260327;
        b=WckuhchZRF1ZJuRTNipZFt57xFgBMUz1mKsMWnsSEFqJyXRC4UUJh4TtATAXkd6cGN
         ugs9jMzSBZXzdhVnu2Fmbq8FNx5NxKJR+rboDPyDjBMzB86vL+Fm9kkC0Jarxo7q+VDx
         WejWVrDpRDxPaJP03QjVq8EOkS54uwhnfdbkj9RDPZfwth74InvRJypAJPxhNcO46PUk
         pqi7iWQ+FYeQBU5JYD6SVzLnsbwXsFhU1Bboz23ehZVoBcbJDPzw9H7dVTwdciwU6ABw
         xublP6KdyduAkmIyU1Zoa2q/cSvLqKE43FNWDtiYD6IPH5jdkmT0tmaWK0/I/lEpuWtH
         zctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=JZuh6Yy7cyeM2V8NndYTRl0JrZMsWMLRemEYVK5KgTU=;
        fh=+Ze04VPT5qbxKO/UZIoGNm+tS+O0IHH4ohBHWziwaDo=;
        b=MbXmzp7ipzQwwZC+hW1dp6mXAAFpfYafkKULBxHRDWsnMOUXSn/90XivWbX6KrvxKn
         z75YahO8ZuZn1cAjxfloYLK5xiK3LHoMrypoYfi8jXlnGmY9O5091ZWukdrfNJ2YTvaA
         8r+TF3uXnpjeYajXZ3alT9I3PCJgkigaElCMM4ksKk5fkJyJ58u5SFoyQ5NVtEGvC5Fx
         Gi7tWPm4kLIwdn7s/c/LTAfHyX0/Ujxr5UgO37JIQhuPYWf7KqRi5ywoKKyYwd2AhXqt
         hSB7OItNdHUsWpuEa6qF6CF4oSva+cz9ZCx1xSXZstio1OsumIiXBKB1chB1cgyfjHXR
         NDpw==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784301259; x=1784906059;
 darn=alsa-project.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JZuh6Yy7cyeM2V8NndYTRl0JrZMsWMLRemEYVK5KgTU=;
        b=IJQYyRNP/L1n8d0YywxZvy0iDG14Z/KjNifsYs0UGhWUkSQtBj6RiAhlvF3LiQ7ALD
         9x6N+niqoXg4JnJEoKScWwOt1VPXdOPdZBNkfBJ67iGkfYdFl4qq88OAgNkYuO2sRW0F
         tSUuxl1AcynLS87jM6fWUtw8lGEi3QnFmRyGbCc4Ap1IKMFSm8Yfr958TNXtwwuWDf0e
         kNs19r3xULxICElMvdBbPMHBqOPEu6lL5rQCWoRdhERSrBhdh0axbddvolJzPOc4QLV3
         NhWk7J02yiYhpMqecNbcTB7bB5PIIEY7suAc8KlPCfG8kJ5F0b16pgNJOO6XtTbc2D2l
         PS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784301259; x=1784906059;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JZuh6Yy7cyeM2V8NndYTRl0JrZMsWMLRemEYVK5KgTU=;
        b=Mv2+rqAg2bmhcH1bj57kLNIesFfYM56qfU7+FxyrCVWYF1QkUP4eXJxsAZ6w4ER8Bv
         RSC6k/V1mV0BCQkN5bQ9obyWtz4JJTWHABT95Qg8qoCfnWPeKeZGeHf7vTJpUPD2ULZV
         DeaR4cy6t34CSQuBIpdSHQ+y2bHzclZGHCaDTPQOgXINivhkILqORVFNxjwMp7HzT2cl
         mvpXHA5HipHXe+sj2ijoLpjYBl/H8zm6WN/LwiFa3TKWnSwSwTwPjlapaN2xvu9yr2sj
         UQVms6fritGd1olUByrthuurgABN3tgf3LB2xJG25SguzhwpTF+aPQTmafxP8LhM0kP6
         zyOw==
X-Gm-Message-State: AOJu0Yx4rvsXeLjVolxNRfAbJGm+fhoCL5nncKECbdhcgaqRFGioewBG
	4wm8BTK/8oQ3NOhMj2aEqtnGcWds/QQuQCcfxxH4Uw9hUXPKT5RU5SzNYoMeyrlI44xDe1suqTH
	9Ub0l83/VO1r/pb8fqsAbONMOO/sNOWmyAg==
X-Gm-Gg: AfdE7ck6iMwChEshXJiTeDdfWoQe22jEq1eLIplkKh4YBYixkR1Ijbb+YINVn0YFgza
	cJKXuoZ5VA3lQhgUiZiqVkkWSTMxHQnIBV5fYwRZIzojB8aseLH7V+oUz4uWmO1QRoIJ6b14BTO
	SU0hrikkuTDRQN0NRcjs6KBdFWIh1tlEycgrfgUIwMUvVz6RfLuYswGMb1FLfts+Z2dajF5kXba
	a7hjDcT+Y25PAY59Qwa/5P0sZDeAuODAfi8pb/4riXtD2r8jBEBQ0JniFU048zY0WS7mhn1ps0B
	aDmN/T+Rxroe6PxYDpZC+1Q=
X-Received: by 2002:a17:903:8c7:b0:2ca:6885:8a06 with SMTP id
 d9443c01a7336-2cf349c533amr26920385ad.5.1784301259306; Fri, 17 Jul 2026
 08:14:19 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CACckToUv2Y-T8xjeJ7_+39jPuQ1u5yksoMd=dFC=--n1s2ymhw@mail.gmail.com>
In-Reply-To: 
 <CACckToUv2Y-T8xjeJ7_+39jPuQ1u5yksoMd=dFC=--n1s2ymhw@mail.gmail.com>
From: Grant Diffey <gdiffey@gmail.com>
Date: Sat, 18 Jul 2026 01:14:06 +1000
X-Gm-Features: AUfX_mxrOgJlehr61aWHBjQFi7S59gqZT8NhsQpPhYuzfwzCOWBCdmkCXQ9nSNA
Message-ID: 
 <CACckToWxesw8-i-GvRKNTUqUo3BSKAWTDdqVLj9eKvQ_0DTwkg@mail.gmail.com>
Subject: [PATCH 2/2] Adding for fast track ultra 8r as well
To: ALSA development <alsa-devel@alsa-project.org>
Message-ID-Hash: MASTHIQNQNP7TNPPIS54BMAQV5X4CDXP
X-Message-ID-Hash: MASTHIQNQNP7TNPPIS54BMAQV5X4CDXP
X-MailFrom: gdiffey@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MASTHIQNQNP7TNPPIS54BMAQV5X4CDXP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

VGhlIHF1aXJrcyBpbiB0aGUgcHJldmlvdXMgcGF0Y2ggZm9yIHRoZSBmYXN0IHRyYWNrIHVsdHJh
IGFyZSBhbG1vc3QNCmNlcnRhaW5seSBhbHNvIHJlcXVpcmVkIGZvciB0aGUgRmFzdCB0cmFjayB1
bHRyYSA4UiBhcyB0aGUgZGV2aWNlIGlzDQphbG1vc3QgaWRlbnRpY2FsIG90aGVyIHRoYW4gYW5h
bG9nIGNvbXBvbmVudHMuDQotLS0NCnNvdW5kL3VzYi9xdWlya3MuYyB8IDIgKysNCjEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL3NvdW5kL3VzYi9xdWlya3Mu
YyBiL3NvdW5kL3VzYi9xdWlya3MuYw0KaW5kZXggYWI1ZDAwOGEyNzQ4Li4yYmFmMTAxNzY2ZmQg
MTAwNjQ0DQotLS0gYS9zb3VuZC91c2IvcXVpcmtzLmMNCisrKyBiL3NvdW5kL3VzYi9xdWlya3Mu
Yw0KQEAgLTIzMjIsNiArMjMyMiw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdXNiX2F1ZGlvX3F1
aXJrX2ZsYWdzX3RhYmxlDQpxdWlya19mbGFnc190YWJsZVtdID0gew0KICAgICAgICAgICAgICAg
ICAgUVVJUktfRkxBR19HRU5FUklDX0lNUExJQ0lUX0ZCKSwNCiAgICAgICBERVZJQ0VfRkxHKDB4
MDc2MywgMHgyMDgwLCAvKiBNLUF1ZGlvIEZhc3QgVHJhY2sgVWx0cmEgKi8NCiAgICAgICAgICAg
ICAgICAgIFFVSVJLX0ZMQUdfTUlYRVJfR0VUX0NVUl9CUk9LRU4gfA0KUVVJUktfRkxBR19HRU5F
UklDX0lNUExJQ0lUX0ZCKSwNCisgICAgICAgREVWSUNFX0ZMRygweDA3NjMsIDB4MjA4MSwgLyog
TS1BdWRpbyBGYXN0IFRyYWNrIFVsdHJhICovDQorICAgICAgICAgICAgICAgICAgUVVJUktfRkxB
R19NSVhFUl9HRVRfQ1VSX0JST0tFTiB8DQpRVUlSS19GTEFHX0dFTkVSSUNfSU1QTElDSVRfRkIp
LA0KICAgICAgIERFVklDRV9GTEcoMHgwN2ZkLCAweDAwMGIsIC8qIE1PVFUgTSBTZXJpZXMgMm5k
IGhhcmR3YXJlIHJldmlzaW9uICovDQogICAgICAgICAgICAgICAgICBRVUlSS19GTEFHX0NUTF9N
U0dfREVMQVlfMU0pLA0KICAgICAgIERFVklDRV9GTEcoMHgwOGJiLCAweDI3MDIsIC8qIExpbmVY
IEZNIFRyYW5zbWl0dGVyICovDQotLQ0KMi41My4wDQoNCg0KDQpPbiBTYXQsIEp1bCAxOCwgMjAy
NiBhdCAxOjA54oCvQU0gR3JhbnQgRGlmZmV5IDxnZGlmZmV5QGdtYWlsLmNvbT4gd3JvdGU6DQoN
Cj4NCj4gR0VUX0NVUiBkb2Vzbid0IHdvcmsgb24gdGhlIGZhc3QgdHJhY2sgdWx0cmENCj4gLS0t
DQo+IHNvdW5kL3VzYi9xdWlya3MuYyB8IDIgKysNCj4gMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvc291bmQvdXNiL3F1aXJrcy5jIGIvc291bmQvdXNi
L3F1aXJrcy5jDQo+IGluZGV4IDQxMTQ5NTYxYWEwNi4uYWI1ZDAwOGEyNzQ4IDEwMDY0NA0KPiAt
LS0gYS9zb3VuZC91c2IvcXVpcmtzLmMNCj4gKysrIGIvc291bmQvdXNiL3F1aXJrcy5jDQo+IEBA
IC0yMzIwLDYgKzIzMjAsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHVzYl9hdWRpb19xdWlya19m
bGFnc190YWJsZQ0KPiBxdWlya19mbGFnc190YWJsZVtdID0gew0KPiAgICAgICAgICAgICAgICAg
ICBRVUlSS19GTEFHX0dFTkVSSUNfSU1QTElDSVRfRkIpLA0KPiAgICAgICAgREVWSUNFX0ZMRygw
eDA3NjMsIDB4MjAzMSwgLyogTS1BdWRpbyBGYXN0IFRyYWNrIEM2MDAgKi8NCj4gICAgICAgICAg
ICAgICAgICAgUVVJUktfRkxBR19HRU5FUklDX0lNUExJQ0lUX0ZCKSwNCj4gKyAgICAgICBERVZJ
Q0VfRkxHKDB4MDc2MywgMHgyMDgwLCAvKiBNLUF1ZGlvIEZhc3QgVHJhY2sgVWx0cmEgKi8NCj4g
KyAgICAgICAgICAgICAgICAgIFFVSVJLX0ZMQUdfTUlYRVJfR0VUX0NVUl9CUk9LRU4gfA0KPiBR
VUlSS19GTEFHX0dFTkVSSUNfSU1QTElDSVRfRkIpLA0KPiAgICAgICAgREVWSUNFX0ZMRygweDA3
ZmQsIDB4MDAwYiwgLyogTU9UVSBNIFNlcmllcyAybmQgaGFyZHdhcmUgcmV2aXNpb24NCj4gKi8N
Cj4gICAgICAgICAgICAgICAgICAgUVVJUktfRkxBR19DVExfTVNHX0RFTEFZXzFNKSwNCj4gICAg
ICAgIERFVklDRV9GTEcoMHgwOGJiLCAweDI3MDIsIC8qIExpbmVYIEZNIFRyYW5zbWl0dGVyICov
DQo+IC0tDQo+IDIuNTMuMA0KPg0KPg0K
