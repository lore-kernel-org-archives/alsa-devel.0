Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927C0F99C81
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Apr 2026 19:58:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B544560205;
	Sat, 18 Apr 2026 21:58:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B544560205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776542314;
	bh=6Aabfrj5bDybbcro0BrLqd8+VVzs4SITLnTQnxkrwGY=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=i4eaJfRT6ZU8iAwMayn5Cf/OVxf8RYkBEE09f0aX4T50SF/5kefhM6+oD7OGzdkTu
	 L7JNIfCGUBue7+m4jJG4j2+Y58ot6oMm3ELDEyVfb8FK0QdyRRDfeAmdKsgycNJTR6
	 VhHf8tY8xLhvGhbTiMERJy4ssHFibqgiwhQaUB+U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3FFD2F80580; Sat, 18 Apr 2026 21:58:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D8612F805F2;
	Sat, 18 Apr 2026 21:58:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C6A0F8049C; Thu, 16 Apr 2026 21:00:18 +0200 (CEST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0CB47F80212
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2026 21:00:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CB47F80212
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RFq5xH/6
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-479932ccab1so373381b6e.0
        for <alsa-devel@alsa-project.org>;
 Thu, 16 Apr 2026 12:00:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776366013; cv=none;
        d=google.com; s=arc-20240605;
        b=NNf1Kbu0dpYp7oxyP5uP/2RzDpmDg0vm+SL2MMwEPBbuXJIgyuiEtnjDnCE8GLMws7
         WP93cwJhIweeGGDITQ2obk9BAWsK0GayJII4hWmZRJmAZhkMKLaVDAo/IF0OW6xiZIpt
         xS+lON3ug7dXvtGGpf4HPqTK8rB5LSH2kPIhQowkG3yKy3HDh2V6yNKPuz2R2l4meCAx
         MdpPJPSkDzwTYRDm+YFE1/lV8uYdiYsXR8E6gUztuA0Tdf68bRjyeyCJBLx1x1OBUGEn
         amcgwnPWOQFEZbUh681eJQ3ZmWkBfgKgJctm5Z84g6vt1QukGP5AfEW8VQmO5uxA4udE
         yc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=6h/IJYFj8Y63baV8llOfLwGFXJCUdgEKQB4ePq0yVag=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=QWoho6sX6RZ1Dt1PyrfP42n3YYYkqCPPS2XbmYH87uP3+HA5DVCL2Fp8mvDOfReBST
         EnrEOKANQrcxXOtcsOnLiMxtpHMzwuXJC6MrS1Ue8cWTnWp46Co1wQChk6c1B0WMgTr3
         3Be4GOcjpr3Hd6v/MDzX9f4lERe0Adm4imaMDrs6jhxE7esj+ESzlzy4/swnD2FHyfQ2
         IC336fXHR2REDxt9+Mygb6OllwG7WI4N8d8wyzbI0BqaUKuTlh5cxGfl1yZtla9Lx5rZ
         E7gSGyrf2MtaHi5oyA/2HFIF5W8VmW4vpXmqRLreRSBC+1LBbMgNaUd/4D25uoWdLCCx
         Wyhw==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776366013; x=1776970813;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6h/IJYFj8Y63baV8llOfLwGFXJCUdgEKQB4ePq0yVag=;
        b=RFq5xH/670KP5rNCkehzAkBLKm85be20uoKB1Ks3HgIE0I0ScDHMsKe0Bn3xPvvLny
         uKBU2FVmMlX7mGIgig6J+pmaMvheQmP08gkgQkgczmi75mF3WUlClf4V/0s+TWT0zids
         jQzUkqWA1XT9i0ri+AInOgJOmkTRqA+4XKwec/uHr+ClhX4776QzSTLBlnaMqdlEXSNQ
         iWYwLrVMz4bVO7iMKt3JifNc5/Tvd9Tn0NiWt3G8UqHiIuGzPHxOz0PMBWzqyrF9ewC5
         hiPyYgtDDQsv0yfVpWG9TsHAyDn3rylOXFX2od54mb39n9V4/o1qucfzXhe+fZzGL36G
         l8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776366013; x=1776970813;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6h/IJYFj8Y63baV8llOfLwGFXJCUdgEKQB4ePq0yVag=;
        b=EJT0G5mc0V7Jc5Fur1MyWsgkQVVZJorjEoumFKYCZKxlYEpv9+GSRpDwf002wUQWOm
         3OzZSiryzq9mbBjPRO9NahRiAhtHiBmCBkOjl5jiPgyIcX+IfGN095YB9qgXZltjF66S
         QWhKCSHJLyq6IrjFJ+WJW3VFYifhDdpb+wDObv4/hC0cDKprBCFpIOucqseM7EumOiF3
         GOuVUwR+3R96Jm+VXopTtNTzf2IW/2Hisj/zPc7M+aun6DaKWi68PPFELnkTGC/fx+6k
         9xU2TGd9oV7hmW2UreHIy1blY3Lk35AS1k9vUdpLpmB3Tv9Dr44mN1t2voTbprrbb5F8
         NTjg==
X-Gm-Message-State: AOJu0YxJoABAvOnS3hAMLUxW9AZ2F87opYSFXcFpCXQIcvdN4NarFTVF
	DK+7/7ZRopSC/hCEHqrbjt9YyVdPu2s/wChdtW2XLp7DbQXnOj2rCL2uhAkVOwkutLfNRGgWn0m
	JyhSfQkN3pIEo6N5fUer7UHSCQbm7WvMPL265
X-Gm-Gg: AeBDievRmkHSFBvU3cdkS72PlXN5xHyS79qr0RR3etfUwnsFW0Rl/U4mGXU4JIVnkYa
	pbiz7SbJdAYhUc7VbrZfkOwvyaZT7y2mGol6zLbTQQ62yRRAtAVXOQAG9WbAKMR051mOjFV3hHt
	wPEJrqHnx+FwWsreWlHD/NhC3xmbYRe+dMT+HGujrBsc9nevcCL5s0tYOrv2PdwdJBM3gBP/O5D
	8+miFqw3EM3ItuXeJqgVshdGSp2aj2XXSnBD6T36WxfAQTfBVY7WMvupikk9ROWuQA0n3Esb+9N
	ogpUiCBLo1l01XIgenkzsO4m+V/+SG92RxnY/4/1pGJzw1MeMFFwBibwZdD27wW5Cyh618TYAn9
	FzN0llQ==
X-Received: by 2002:a05:6820:308a:b0:68b:b62a:a4eb with SMTP id
 006d021491bc7-69461a9092bmr231993eaf.24.1776366012496; Thu, 16 Apr 2026
 12:00:12 -0700 (PDT)
MIME-Version: 1.0
From: Sergio Boglione <sboglione@gmail.com>
Date: Thu, 16 Apr 2026 16:00:01 -0300
X-Gm-Features: AQROBzDXtdSRVAl-_p8O5HiYSJQIwUJ0lHQZ8a-N_4yjNkLIWyV-_C--ypae064
Message-ID: 
 <CABuY3nF8GUvXukpzAcLGU+qyYbNX7M-5cqWwFzeenaaXsGL1uA@mail.gmail.com>
Subject: ALSA: hda/realtek: Add quirk for HP 250 G10 (ALC236,
 subsystem 103c:8b34)
To: alsa-devel@alsa-project.org
X-MailFrom: sboglione@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: J22Y3KTATXZLHSZSDX2VX6NQEJ2RSOHJ
X-Message-ID-Hash: J22Y3KTATXZLHSZSDX2VX6NQEJ2RSOHJ
X-Mailman-Approved-At: Sat, 18 Apr 2026 19:57:56 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/J22Y3KTATXZLHSZSDX2VX6NQEJ2RSOHJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGVsbG8sDQoNClRoZSBIUCAyNTAgMTUuNiBpbmNoIEcxMCBOb3RlYm9vayBQQyBoYXMgbm8gc291
bmQgZnJvbSBpbnRlcm5hbCBzcGVha2Vycw0Kb3IgaGVhZHBob25lIGphY2sgdW5kZXIgTGludXgu
IEJsdWV0b290aCBhdWRpbyB3b3JrcyBjb3JyZWN0bHkuDQoNClRoZSByb290IGNhdXNlIGlzIHRo
YXQgdGhlIFBDSSBzdWJzeXN0ZW0gcmVwb3J0cyBTU0lEIDEwM2M6MDAwMCBpbnN0ZWFkDQpvZiB0
aGUgY29ycmVjdCAxMDNjOjhiMzQgKHdoaWNoIGlzIGNvcnJlY3RseSByZXBvcnRlZCBieSB0aGUg
Y29kZWMgaXRzZWxmKS4NCkFzIGEgcmVzdWx0LCB0aGUgd3JvbmcgZml4dXAgaXMgc2VsZWN0ZWQg
YW5kIHNwZWFrZXJfb3V0cz0wLg0KDQpIYXJkd2FyZSBpbmZvOg0KICBNYWNoaW5lOiAgIEhQIDI1
MCAxNS42IGluY2ggRzEwIE5vdGVib29rIFBDDQogIENvZGVjOiAgICAgUmVhbHRlayBBTEMyMzYN
CiAgVmVuZG9yIElkOiAweDEwZWMwMjM2DQogIFN1YnN5c3RlbSBJZCAoY29kZWMpOiAweDEwM2M4
YjM0DQogIFN1YnN5c3RlbSBJZCAoUENJKTogICAweDEwM2MwMDAwICA8LS0gd3JvbmcsIHJlcG9y
dGVkIGJ5IEJJT1MNCiAgUENJIElkOiAgICA4MDg2OjUxY2EgKEludGVsIFJhcHRvciBMYWtlLVAv
VS9IIGNBVlMsIHJldiAwMSkNCiAgS2VybmVsOiAgICA2LjE3LjAtMjAtZ2VuZXJpYyAoVWJ1bnR1
KQ0KDQpkbWVzZyBzaG93czoNCiAgc25kX2hkYV9jb2RlY19hbGMyNjk6IEFMQzIzNjogcGlja2Vk
IGZpeHVwIGZvciBQQ0kgU1NJRCAxMDNjOjAwMDANCiAgYXV0b2NvbmZpZyBmb3IgQUxDMjM2OiBs
aW5lX291dHM9MSAoMHgxNCkgdHlwZTpzcGVha2VyDQogIHNwZWFrZXJfb3V0cz0wDQogIGhwX291
dHM9MSAoMHgyMSkNCg0KUGluIGNvbmZpZzoNCiAgMHgxNDogUGluIERlZmF1bHQgMHg5MDE3MDEx
MDogW0ZpeGVkXSBTcGVha2VyIGF0IEludCBOL0ENCiAgMHgyMTogUGluIERlZmF1bHQgMHgwMzIx
MTA0MDogW0phY2tdIEhQIE91dCBhdCBFeHQgTGVmdA0KDQpUaGUgZml4IHNob3VsZCBiZSBhZGRp
bmcgYSBxdWlyayBlbnRyeSBmb3IgMTAzYzo4YjM0IGluIHBhdGNoX3JlYWx0ZWsuYywNCnNpbWls
YXIgdG8gbmVpZ2hib3JpbmcgSFAgUHJvQm9vay9FbGl0ZUJvb2sgZW50cmllczoNCg0KICBTTkRf
UENJX1FVSVJLKDB4MTAzYywgMHg4YjM0LCAiSFAgMjUwIEcxMCIsIEFMQzIzNl9GSVhVUF9IUF9H
UElPX0xFRCksDQoNClRoaXMgd291bGQgbWF0Y2ggZW50cmllcyBsaWtlOg0KICBTTkRfUENJX1FV
SVJLKDB4MTAzYywgMHg4YWEzLCAiSFAgUHJvQm9vayA0NTAgRzkiLA0KQUxDMjM2X0ZJWFVQX0hQ
X0dQSU9fTEVEKSwNCiAgU05EX1BDSV9RVUlSSygweDEwM2MsIDB4OGFhYiwgIkhQIEVsaXRlQm9v
ayA2NTAgRzkiLA0KQUxDMjM2X0ZJWFVQX0hQX0dQSU9fTEVEKSwNCg0KVGhlIFBDSSBTU0lEIGlz
c3VlICgxMDNjOjAwMDApIGFwcGVhcnMgdG8gYmUgYSBCSU9TIGJ1ZyBvbiB0aGlzIEhQIG1vZGVs
DQp0aGF0IG90aGVyIEhQIG1vZGVscyB3aXRoIHRoZSBzYW1lIGNvZGVjIGRvIG5vdCBleGhpYml0
Lg0KDQpQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IG5lZWQgYWRkaXRpb25hbCBpbmZvcm1hdGlv
bi4NCg0KVGhhbmtzLg0KDQotLSANClNlcmdpbyBCb2dsaW9uZQ0K
