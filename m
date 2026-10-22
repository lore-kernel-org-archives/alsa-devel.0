Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ACB606A31D
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=U9Mts4D1;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=vulncheck.com header.i=@vulncheck.com header.a=rsa-sha256 header.s=google header.b=VwbHqCyn
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 751CD601A6;
	Fri, 23 Oct 2026 09:11:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 751CD601A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792739494;
	bh=/6QPKf6htqMMQHMKy2YLx/7oUYuKkMuibIg20hNM+jU=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=U9Mts4D1OJJRPFxr7qqmnLLUQtnvmy9fUAPMHS7WvtLSL8dJrMuhxXrwSDo9Rmrmn
	 oUode6f5h2nTTljASTakxbJMUPu+MgGewO5CslegCiYiV278/mK51SzzC1l8rw4WFx
	 UHf0Z1hOhmkXxqxi3JGfJKyB0fvGddVf3OcWM/U8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8CF40F8075B; Fri, 23 Oct 2026 09:09:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EF77FF80793;
	Fri, 23 Oct 2026 09:09:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F873F804CC; Thu, 22 Oct 2026 15:38:24 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8423BF800F3
	for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2026 15:38:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8423BF800F3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=vulncheck.com header.i=@vulncheck.com
 header.a=rsa-sha256 header.s=google header.b=VwbHqCyn
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-843a4ca671eso994122a34.2
        for <alsa-devel@alsa-project.org>;
 Thu, 22 Oct 2026 06:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792676300; cv=none;
        d=google.com; s=arc-20260327;
        b=K1yr91a+/9+0MDdkNz+wBBg28kZqgCNoJXqOsHPuTgxbsbSbFixIrCUtuj/saLmM1/
         QeoRzy6Kd98j0wlzts/v2MWk7zeh8f9Al5C/ckCaQ5SVXU0hFXzgvoT6qRvd56ATPLYE
         y+ns51vx/ZDz4l0UA67GQsksRaZKmkazzhjDnS7N2so8nyIUbAojF21VUNJKH20GGkSI
         Ni7eDinNV3pJbtLOEL+qgcpmsxNlEopQ0xn9mhj7XbHt52wwuXCulu4LjMuRQckGhxhO
         4NxbfUxYxmWVuInF40zCO7hC918NdWdZZPMPfgWinw6lufJ4cHCXkAzKYKQYrCNHZD4O
         X6lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=G0MObgsFUGnjqapjP+6AHi28NWgWoGeP4/nQ9ZidtiI=;
        fh=0mKO+nZ7sxNzPmF3fuSb2WVqZFVM/tTv2IrB7cCiAxY=;
        b=eGhho+OCHU/kLg0U1RCh89b/J5L0p0cUMN3vJb87p/CCo0yCeSzAOPoJ/HxJ5R7yQ+
         DzOp/QyYGFnxYtaEEul5EbEsJNHpnp2PhF/bcsoAj01Fkxu3cYjvU4EfGEHqtS4Vp8cY
         v0s7kF5h1ezzZGeQwZQQPrcJK3baMMPtXI+l7Eg8a6Phi5ymdH66BLJXZrmMiy5cULuU
         O3TvQ1zMI6H3vD78pf1BHxae0zGnlXmP71QNS9orhmq5sUYz+gTHkENJnhU589NTkImY
         Y7EJoHJUqHAygTkayNVdOTYgzi9auGou8kzQO43B3UP0IFkX/DTmpPIEAmZd2/IjuYzg
         VjzA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vulncheck.com; s=google; t=1792676300; x=1793281100;
 darn=alsa-project.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G0MObgsFUGnjqapjP+6AHi28NWgWoGeP4/nQ9ZidtiI=;
        b=VwbHqCyntueGZLBbpBOPoTOrDfT5lBffltHtEePr9WCkKHh7Fu4exESu6zPlXdKoUI
         EactHp89aQTdHVIbMgnJFnj9ny37fDG1/zI3whI7qcLViFZR4GT7PnRF19Sb4YO9IlVg
         hY038htxDPoQppDRCCFXEUkAdfdoCmNFVWNK/HB9M5kE+hZRWAT7+t9vkJ/BkNF1S3Ej
         sYNIDzvAoaN8ymHvdSwIjW+Sjza53EYJZIpuIXLpEQPBnF6S3rWCxj+hmvbdqkzFShDS
         OW/O5cLhJN6Fi0YxVmfsoTTaaL+Resui0AIgJpW3loEHy/DJTz0js8QTKEblyeAsOBcU
         wKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676300; x=1793281100;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G0MObgsFUGnjqapjP+6AHi28NWgWoGeP4/nQ9ZidtiI=;
        b=WkzD5+nhoWXl2q/C7yVzVW1H2omIvt+nyi6uZNJ5cSPxeLUYFimWLvX3j6+6mlhEVV
         f7wBJNNrJO8z60R/4nehLoU1Lqkp9vOfJDIOwF5FKzWCwUluiryrr5bq10tcGii2VIIl
         iz8Ic3NogMYrkIXwczHDZ/pQOhCFpgLqJG1b+PW39gMa1aekcoVQpYocpUmymgLt+4K5
         ndzg/P7yJ+pSqiqxg5eSZnzBdiJPCuH1iwAS/iw9rnZxU01aopdptzyePQQHkMrJLeIm
         WU7YH/WCAS9YukGUS+wWJnEDJsgXbitFpzSXjDdQNB3CJ0e6f9hRQH7LN/GMBbFbsMtO
         2AaQ==
X-Gm-Message-State: AFq9FYLp4Y3YClxBsghLfxhTbjZwrMJW9wlKF6CBwsuBGQUSo3CjSUob
	+TlhP7FKu0JoXq648ReOVc+63WtY+VsUSSVV+w8PoQxc8gwJsWL5pP/4eB0CY03U0BG08y7kroP
	bQPT4tm507EbMhetsa5In/fvTXuEC1wGCQtdZ7S+30NMaEJMhC/oubWNQpg==
X-Gm-Gg: AYBFou0Rz1Hff/vqRjIT7lT4lMNQsDhxBpRVmXUbOms6bKDNs/7qnA5D+PpvQ79tnQe
	QLQ+hnK8VPxdB22JTTxoVWQOWbcivszfl7bZqOWCfDsIGUo79BE6euJKROeRgFj9Hy+gf2MgAvp
	OmarWS/K9AXys26oI7XBKYUmvd5FG56o7OTYf4EbOco6omotuleTrHDVpDodRmtKg9dksi0yI38
	D8qiELxs2D52VJxAL3RlJOvVwo3Itu/X1v3b6vgrxaLxWqpIrSvuWb+28PvHCuHNs2hxwSzC4vX
	eqWhEL9E/RhHnvv6MuZ+SzJbhsZIEnqeJTrgdwMf0SODUB9dz1GLo5DhH6bSltZyRUCP9l52TjE
	6x07c1L/GsoI4J2g0QukT1ntPELLOpdKOHuKELbdv41h2vRxh/9g5SOUVVUaXVEPUIvE=
X-Received: by 2002:a05:6808:1686:b0:4b5:b13a:9001 with SMTP id
 5614622812f47-5535857a84emr3905738b6e.14.1792676299770; Thu, 22 Oct 2026
 06:38:19 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: 
 <CAOH03+3bBSMrvVdxH5qQB8nvnejJAtnS3gnH4b5mO2fPugeZuw@mail.gmail.com>
In-Reply-To: 
 <CAOH03+3bBSMrvVdxH5qQB8nvnejJAtnS3gnH4b5mO2fPugeZuw@mail.gmail.com>
From: Brandon Tarr <btarr@vulncheck.com>
Date: Thu, 22 Oct 2026 09:38:08 -0400
X-Gm-Features: AclHuK9Qs44cng6_RFeQjkmKXM3n-CHPIufyyN5XBZWaW3O2uxtQzhOxmFhS2y4
Message-ID: 
 <CAOH03+1jCjOGA_UHv1YSR6wgUZs7H43o34noCQ3JKOtvu+LSOA@mail.gmail.com>
Subject: Re: Coordinated Vulnerability Disclosure - ALSA Project /
 tinycompress
To: alsa-devel@alsa-project.org, Disclosures <disclosure@vulncheck.com>
X-MailFrom: btarr@vulncheck.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: WIDDE3SPPUE3D3NBV2PWK73Y7PVUDXQK
X-Message-ID-Hash: WIDDE3SPPUE3D3NBV2PWK73Y7PVUDXQK
X-Mailman-Approved-At: Fri, 23 Oct 2026 07:08:20 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WIDDE3SPPUE3D3NBV2PWK73Y7PVUDXQK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

R3JlZXRpbmdzIEFMU0EgU2VjdXJpdHkgVGVhbSwNCg0KDQpUaGlzIGlzIHRoZSAqc2Vjb25kIG91
dHJlYWNoKiBhdHRlbXB0IGZvciB0aGlzIGNhc2UuIEhhcyB0aGVyZSBiZWVuIGFueQ0KbW92ZW1l
bnQgb3IgY2FuIHlvdSBwcm92aWRlIGFueSB1cGRhdGVzIG9uIHRoZSBwcm9ncmVzcz8NCg0KDQpU
aGFuayB5b3UsDQoNCk9uIE1vbiwgU2VwIDIxLCAyMDI2IGF0IDE6MjLigK9QTSBCcmFuZG9uIFRh
cnIgPGJ0YXJyQHZ1bG5jaGVjay5jb20+IHdyb3RlOg0KDQo+IEdyZWV0aW5ncyBBTFNBIFNlY3Vy
aXR5IFRlYW0sDQo+DQo+DQo+IEknbSBhIHZ1bG5lcmFiaWxpdHkgYW5hbHlzdCBhdCBWdWxuQ2hl
Y2sgPGh0dHBzOi8vd3d3LnZ1bG5jaGVjay5jb20vPiBhbg0KPiBleHBsb2l0IGludGVsbGlnZW5j
ZSBjb21wYW55IGFuZCByZXNlYXJjaCBDVkUgTnVtYmVyaW5nIEF1dGhvcml0eSAoQ05BKSwNCj4g
d2hlcmUgSSdtIG9uZSBvZiBzZXZlcmFsIGZvbGtzIHdobyBtYW5hZ2Ugb3VyIGNvb3JkaW5hdGVk
IHZ1bG5lcmFiaWxpdHkNCj4gZGlzY2xvc3VyZSAoQ1ZEKSBwcm9ncmFtLg0KPg0KPiBBbiBleHRl
cm5hbCBzZWN1cml0eSByZXNlYXJjaGVyIHJlY2VudGx5IHJlcG9ydGVkDQo+IDxodHRwczovL3d3
dy52dWxuY2hlY2suY29tL2Fkdmlzb3JpZXMvcmVwb3J0PiBhIHBvdGVudGlhbCB2dWxuZXJhYmls
aXR5DQo+IGltcGFjdGluZyBBTFNBIFByb2plY3QgLyB0aW55Y29tcHJlc3MNCj4gPGh0dHBzOi8v
Z2l0aHViLmNvbS9hbHNhLXByb2plY3QvdGlueWNvbXByZXNzPiBhbmQgVnVsbkNoZWNrIGlzIGFj
dGluZyBhcw0KPiB0aGUgaW50ZXJtZWRpYXJ5IGFuZCBjb29yZGluYXRvci4NCj4NCj4gVnVsbkNo
ZWNrIGZvbGxvd3MgYSAxMjAtZGF5IGRpc2Nsb3N1cmUgcG9saWN5DQo+IDxodHRwczovL3d3dy52
dWxuY2hlY2suY29tL3Z1bG5lcmFiaWxpdHktZGlzY2xvc3VyZS1wb2xpY3k+LCBtZWFuaW5nIHdl
DQo+IGFmZm9yZCB2ZW5kb3JzL21haW50YWluZXJzIHVwIHRvIDEyMCBkYXlzIGZyb20gdGhlIHRp
bWUgb2YgcmVjZWl2aW5nIHRoZQ0KPiByZXBvcnQgdG8gYWRkcmVzcyB0aGUgaXNzdWUgYmVmb3Jl
IHB1YmxpY2F0aW9uIG9mIGEgQ1ZFIHJlY29yZCBhbmQNCj4gdGhpcmQtcGFydHkgYWR2aXNvcnku
IEZvciB0aGlzIHZ1bG5lcmFiaWxpdHksIHRoYXQgMTIwLWRheSBkZWFkbGluZSBmYWxscw0KPiBv
biAqSmFudWFyeSAxOSwgMjAyNyAoMDEvMTkvMjAyNykqLiBPZiBub3RlLCBwYXRjaCBwdWJsaWNh
dGlvbg0KPiBjb25zdGl0dXRlcyBwdWJsaWMgZGlzY2xvc3VyZSDigJQgaWYgYSBwYXRjaCBpcyBp
c3N1ZWQsIHdlIHdpbGwgcHVibGlzaCB0aGUNCj4gQ1ZFIHJlY29yZCBhdCB0aGF0IHRpbWUgcmF0
aGVyIHRoYW4gd2FpdGluZyBmb3IgdGhlIGZ1bGwgMTIwLWRheSB3aW5kb3cuDQo+DQo+IFRoZSBy
ZXNlYXJjaGVyIGhhcyBwcm92aWRlZCB1cyB3aXRoIGEgY29tcHJlaGVuc2l2ZSB0ZWNobmljYWwg
cmVwb3J0LA0KPiB3aGljaCB3ZSBoYXZlIGF0dGFjaGVkIHRvIHRoaXMgZW1haWwuIExldCB1cyBr
bm93IGlmIHlvdSBoYXZlIGFueSBxdWVzdGlvbnMNCj4gZm9yIHVzIGFib3V0IHRoZSBDVkQgcHJv
Y2VzcyBvciBmb3IgdGhlIHJlc2VhcmNoZXIgcmVnYXJkaW5nIHRoZSByZXBvcnRlZA0KPiB2dWxu
ZXJhYmlsaXR5Lg0KPg0KPiAtLQ0KPiBUaGFuayB5b3UsDQo+DQo+IDxodHRwczovL3d3dy52dWxu
Y2hlY2suY29tLz4NCj4NCj4gQnJhbmRvbiBUYXJyDQo+IFZ1bG5DaGVjaw0KPg0KDQoNCi0tIA0K
VGhhbmsgeW91LA0KDQo8aHR0cHM6Ly93d3cudnVsbmNoZWNrLmNvbS8+DQoNCkJyYW5kb24gVGFy
cg0KVnVsbkNoZWNrDQo=
