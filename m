Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451A3CD8CA8
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:30:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28F6A601FD;
	Tue,  9 Jun 2026 13:30:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28F6A601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781004621;
	bh=65MwHsB/8MHnO8IR/pVY4i6AAHTxr6H3QWZ0uHVyMe4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cE2TcLjYXaRBOJSZB2AxQDeqWxN+umkvMGx5nKmgCYlxX3USxfROLaJs8KD+l5VWe
	 mnJyQNe98B4r/cDapDCGsdBgY4jW07DeWPfu2PCAZdLPPB21d2dWUEX+UYTxMQO0aT
	 zfstC5cTh37tAzCE2/J0wgS8NnE6xa/8Jc8Ts4p0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CC906F805F8; Tue,  9 Jun 2026 13:29:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 61151F805F8;
	Tue,  9 Jun 2026 13:29:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1BC7DF80496; Tue,  9 Jun 2026 10:06:36 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1780992395;
	b=RaszJpbYGGPzFiTgAf6c0E1yUkiZTvX7kwyXq6n76LYFp7+Q8kgkNZttIY2V2DTioWgt
	 sTLxCbN1olR6Qf3E1vve2QDpkgnhMksYsDnX7INn7t8cUhmEZIokOfmFQBYatzqjLGBIC
	 LUinRGQHRQe4iMK8OGwQa3RjW3yUUIbABU4bED+5gYn6WQEYmrBd3Yd7gHLN9nN1zW33s
	 /CaVrUATRH5+tikwpYekbnaKQc14e1OfGIwbZWc8aUpdCdwZCodMmpmmMvyjxT4ke6v0I
	 KsqcDqXeUnUT6AzUrWke0ojN6PxrlCBTpN68AWiTOB1iOjJrKdAThu1mS8OnsubisCA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780992395;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=rHTC5HtxEGYQsBxGEbKeAbc45SrLwkFOSO63A/4cCVw=;
	b=nZdsux3WuVgQCnp19SZIrv6zUFWiPw81FKsJYCmZszCrlQr1HUXxNEqwJEqr9iIgj8dS
	 v3qsZz+BmZI0mz8qQbQYweN2Yc8R4pctD7huHl3eNAoxP9bnS/5oztp5Qquz6hHhJSScO
	 Yt9DxZ5XAeMxA2L4Lo83vVxCQ47sMKe3VpP3WPe3GCnidnOQgVTCKW3P+HHKFYBMUB4je
	 55st68nDVoRRscs1Vue4F4+tENZCXUaZmrc6aPwukwIpi5rro7ZwHvPbTgaw8P6UAopIL
	 2hUYPPIbXOtm+MCFlzGvNkXYZlp/ptyucD4uUI+3zrtvQcQEksXNeNefMB2zVTgNPmg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=aisle.com header.i=@aisle.com header.a=rsa-sha256
 header.s=google header.b=BLRKLIE6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 21D22F8001F
	for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2026 10:06:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21D22F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=aisle.com header.i=@aisle.com header.a=rsa-sha256
 header.s=google header.b=BLRKLIE6
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-beb2a97cc9aso838573466b.2
        for <alsa-devel@alsa-project.org>;
 Tue, 09 Jun 2026 01:06:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780992393; cv=none;
        d=google.com; s=arc-20240605;
        b=Us2uLvpYeo4sdFtWZxcR8Uz8026YLt6/1cE3aGjLByYNcjGrHf1ROPZvNvzoliDgkl
         quCEGC9Osm258I0raE9S/1DhVC2pkC2f0DEVAePNw3vBiZvNBaJzKccXnM5nk8aGPxwN
         MuzMAc6Ys5HT3HZ5F7JQeD+rn5VeEfCpPHqfQXb8PAjXFmDhDL0huHuUp0EoucBmDqqP
         ySWXP9hJq945yc8pVNdDXEZhTUca8A0VSY8eY5nBLhi6WVxnYHidmC507qIfn2JdRdx3
         rK7xTQUUQ2/Q5UdQyD0DxD+HLjUFtAsdsHdT++k/n4SQ367p8WNwvBcoqhVjMnXlyHwM
         qdpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WAlzi0gWXJbFUAVJhWS/zKPmM8TB5uoMJpCjIZQmHYU=;
        fh=KoInqMEZriL8X0m4mrJMSMyMy6ZH5jAZXSwsP5xkdlE=;
        b=CkfvDZ2rrHHUY4EgMi+AHKrOypHkAjJwzbFtYHtoJguo0ZZSHeDoCho/SVCmwK/sj1
         5sPuM95T1E6vyVLPtHMxufikqr4HQa+SgxZaUHhFSvj26AG6KIICtMeXNxcMLuEMvyV3
         4A4obaLSABj5k1KNbouvYBHbqyC7rv9mKKc7HKs4JMsAY6t6H+2hreQ9mfLRM1lUt1xJ
         RDyKkzdZy4mgS90c5AEFQ+ODXOtgIDVuMPtDGmHS90GwkWooGWiHnuD3wLumGjngAtM0
         Gf7VtiIAizdTWVvF52t6c91atdoLKsopEi3YQvXIDkikQwmGq23XdNb+EuRpituDxDq7
         LKbg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1780992393; x=1781597193;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WAlzi0gWXJbFUAVJhWS/zKPmM8TB5uoMJpCjIZQmHYU=;
        b=BLRKLIE6i0NJYWiGz8v+5B8bApWgvClvB/AvZEeRwuN6IR4IoVyGCGTF8qw87S8HtB
         QZonC7CVhrnTCcGZfNX1Mll89ohKpdpSbun+UcrDjUd2RIqDIUqb7+na0Q0qhvfvDVX0
         1gnXN3kXyttkfPIGeKNCpERU1S0TYH4umsw6cq0LNmyzE8o93gxiiAmoba9EFvNdf4V0
         OrIqA2VkaGho4BBIdqdxBkxYulThkJl1xqL/eq7GepWxClyS1H3BuezwvOhB9HWoPNFD
         IRmjwU3lnmHBXs2ch1ibrnYl1t+wi9KS+cWJiWc21sMAAkb3WfPf1NZeFy9RzVMhFevG
         ya4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780992393; x=1781597193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAlzi0gWXJbFUAVJhWS/zKPmM8TB5uoMJpCjIZQmHYU=;
        b=GOv2KZHeeaiu6ErKXhWWBGa4n9LyW57mzHw7w2aO/7CnSLTh+Dnx5d6/wIkQ+SVWo/
         uuhherh28hV1KhVN6EaBB4rAo/CAXOJT0nZY5x4GDS7CcgwTwynz/kM75N4CtfstsxV8
         1WwygcuJSi7zx7BKeVYYmAWlyPFNQlnH9Ubwtr49QcTj2PMzMwBOQJf9Xhi7rCAR1+Yw
         h84jlQELKRcNFFVBMRgJXYQVvXJA+0L2Y/beosWovGyre7UWtwNFCwUM76yyRK7HfJlj
         q4XfvnXgKZScitMYDcCElvOxvVIEI3QBvEumwienZyuDtR6BgbrnuVJ/K4gqaU23oy9p
         wQ8g==
X-Gm-Message-State: AOJu0Ywe74Uqeod00kCp6uMLAMsSc4mR0x0vjpvK3QXQg84f/WsExgAQ
	dBfRfMvcrN4rxjZ/s9YEOVKrfhY5gYlWI+bCbhEoAzWZdZoGKLWkZ9uy+FbRyQM7y1xduEGzHuX
	q3qmbg2gaVug+89e49pVqIOMgpD2DCtGMawUzYPnLefNUaiLrIHe7wguQLMJd
X-Gm-Gg: Acq92OFFW24U4akDnE5EaKv10hFjbNZQOGQxOgo7klnuHUV515REsujxDXBkvTD2fXJ
	a0oWqjdPq8FuIWXmCtxWaRWi1IcfPXolvSAJpMS3d5tGykp+iyOhPxkeGmpZVfY+ENsE0ndn1C+
	5QT72jnxGJ6cBM8XS/T/LNWodClRuwdnF4w9GIb2S+7ne87ccKDH6jKsB/oUb+eOheQU2dp0ITY
	BV6ETzYFUlTTAqNF46T8hlEU7BxPolAb+UzIxjbL6bBAjqgE0wgyjPsTNQNOKfn5xzW4g+u0E4D
	uE6nMYcR7p3HcblsBBJh+UigV8czhzY=
X-Received: by 2002:a17:906:d552:b0:bd9:2b46:99b0 with SMTP id
 a640c23a62f3a-bf93a00a5c3mr75151266b.49.1780992392824; Tue, 09 Jun 2026
 01:06:32 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAGt8pqBU0p2voB+qHxWGcNJrKHAcBhAyHUUBPLBN-Yj_SiV6MQ@mail.gmail.com>
 <3bc19b9c-77f1-443f-88d9-d78508cbfa28@perex.cz>
In-Reply-To: <3bc19b9c-77f1-443f-88d9-d78508cbfa28@perex.cz>
From: Luigino Camastra <luigino.camastra@aisle.com>
Date: Tue, 9 Jun 2026 10:06:19 +0200
X-Gm-Features: AVVi8CdSMONFjyCaYsMcH7aubxseW84XdCSAYzzU2tsymIZo6DP5UvBtzJIrlsk
Message-ID: 
 <CAGt8pqAPnn_omR+zscHsfgGq8hpP_g-T0_rMowQ2TY+Gr37CpQ@mail.gmail.com>
Subject: Re: Security: double-free / invalid pointer dereference in alsa-lib
 config parser (`parse_def`) via crafted configuration text
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
X-MailFrom: luigino.camastra@aisle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: SR5QEPFXVJG75AJLEPNZR27PFDJOSWLJ
X-Message-ID-Hash: SR5QEPFXVJG75AJLEPNZR27PFDJOSWLJ
X-Mailman-Approved-At: Tue, 09 Jun 2026 11:29:41 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SR5QEPFXVJG75AJLEPNZR27PFDJOSWLJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGkgSmFyb3NsYXYsDQoNCkdyZWF0LCB0aGFua3MgZm9yIHRoZSBxdWljayBmaXguIEFyZSB5b3Ug
Z2VuZXJhdGluZyBDVkVzIGZvciB0aGlzIGlzc3VlPw0KDQpCZXN0DQoNCkx1aWdpbm8NCg0KT24g
TW9uLCBKdW4gOCwgMjAyNiBhdCAyOjUw4oCvUE0gSmFyb3NsYXYgS3lzZWxhIDxwZXJleEBwZXJl
eC5jej4gd3JvdGU6DQoNCj4gT24gNi84LzI2IDEyOjA1LCBMdWlnaW5vIENhbWFzdHJhIHdyb3Rl
Og0KPiA+IERlYXIgQUxTQSBtYWludGFpbmVycywNCj4gPg0KPiA+IEkgYW0gd3JpdGluZyB0byBy
ZXBvcnQgYSBtZW1vcnktc2FmZXR5IGlzc3VlIGluICoqYWxzYS1saWIqKidzDQo+ID4gY29uZmln
dXJhdGlvbiBwYXJzZXIgKGBzcmMvY29uZi5jYCkuIFRoZSBidWcgd2FzIGZvdW5kIGJ5IGZ1enpp
bmcgdGhlDQo+ID4gcHVibGljIEFQSSBgc25kX2NvbmZpZ19sb2FkX3N0cmluZygpYCwgYW5kIGlz
IHJlYWNoYWJsZSBmcm9tIGFueQ0KPiA+IGFwcGxpY2F0aW9uIHRoYXQgbG9hZHMgYXR0YWNrZXIt
aW5mbHVlbmNlZCBBTFNBIGNvbmZpZ3VyYXRpb24gdGV4dCBvcg0KPiBmaWxlcw0KPiA+IChgc25k
X2NvbmZpZ19sb2FkYCwgYHNuZF9jb25maWdfbG9hZF9zdHJpbmdgLCBgc25kX2NvbmZpZ191cGRh
dGVgLA0KPiA+IGB+Ly5hc291bmRyY2AsIGV0Yy4pLg0KPiA+DQo+ID4gIyMgU3VtbWFyeQ0KPiA+
DQo+ID4gV2hlbiBwYXJzaW5nIGEgbmVzdGVkIGNvbXBvdW5kIChgeyDigKYgfWApIG9yIGFycmF5
IChgWyDigKYgXWApLA0KPiBgcGFyc2VfZGVmKClgDQo+ID4gY2FsbHMgYHBhcnNlX2RlZnMoKWAg
LyBgcGFyc2VfYXJyYXlfZGVmcygpYCBidXQgKipkb2VzIG5vdCBjaGVjayB0aGVpcg0KPiA+IHJl
dHVybiB2YWx1ZSBiZWZvcmUgY29udGludWluZyoqLiBPbiBhIHBhcnNlIGVycm9yIGZyb20gdGhl
IG5lc3RlZCBjYWxsLA0KPiA+IHRoZSBpbm5lciBsZXZlbCBoYXMgYWxyZWFkeSBkZWxldGVkIChh
bmQgdW5saW5rZWQpIGl0cyBub2RlIHZpYQ0KPiA+IGBzbmRfY29uZmlnX2RlbGV0ZShuKWA7IGBw
YXJzZV9kZWYoKWAgdGhlbiBmYWxscyB0aHJvdWdoIGFuZCBjYWxscw0KPiA+IGBzbmRfY29uZmln
X2RlbGV0ZShuKWAgYWdhaW4gb24gYW4gYWxyZWFkeS1mcmVlZCAvIHVubGlua2VkIG5vZGUgZHVy
aW5nDQo+ID4gZXJyb3IgY2xlYW51cC4gVGhpcyBjb3JydXB0cyB0aGUgY29uZmlndXJhdGlvbiBu
b2RlIGxpc3QgYW5kIGxlYWRzIHRvIGENCj4gPiAqKmRvdWJsZSBmcmVlIC8gaW52YWxpZCBwb2lu
dGVyIGRlcmVmZXJlbmNlKiouDQo+DQo+IFRoYW5rIHlvdSBmb3IgdGhpcyByZXBvcnQuIEkndmUg
Zml4ZWQgdGhpcyBpc3N1ZSBpbiBjb21taXQgNTM2ZGQ2ZjgNCj4gKCJjb25mOg0KPiBhZGQgbWlz
c2luZyByZXR1cm4gdmFsdWUgY2hlY2sgaW4gcGFyc2VfZGVmKCkiKSAuDQo+DQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgSmFyb3NsYXYNCj4NCj4gLS0NCj4gSmFyb3NsYXYgS3lz
ZWxhIDxwZXJleEBwZXJleC5jej4NCj4gTGludXggU291bmQgTWFpbnRhaW5lcjsgQUxTQSBQcm9q
ZWN0OyBSZWQgSGF0LCBJbmMuDQo+DQo=
