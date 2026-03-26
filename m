Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20E010F284C
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:06:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 93EB360206;
	Fri, 27 Mar 2026 17:06:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 93EB360206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774627589;
	bh=Q6/vCtONgdoELga5JJF1VEkO3fdT1DGy67Sxrhlz/pU=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=W7MyJwoBJC8URXWskHygOeTylFa2uTQLR8oLyGbTJ3ZOUJsV05GK9D/JgDDjfxzR5
	 j1D6hc3M9/0vtiKnhjKMmz0COxHdYCHUofiOtbO8HISTvXpSOCT/vRn3yIJGuQuXTd
	 fc45gZKCRewTDC8A4qqrG2CDF6fbAW9Tbc13UMIs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5E055F80609; Fri, 27 Mar 2026 17:05:46 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E701AF8060B;
	Fri, 27 Mar 2026 17:05:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D8DBEF80525; Thu, 26 Mar 2026 04:00:57 +0100 (CET)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B6BBFF800AC
	for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2026 04:00:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6BBFF800AC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ieZKTNo1
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-56adf76631cso288885e0c.1
        for <alsa-devel@alsa-project.org>;
 Wed, 25 Mar 2026 20:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774494053; cv=none;
        d=google.com; s=arc-20240605;
        b=I90p+PDTIyz4bty1luFSHhEqoO8UY6aDFXntjW8GoR9IsCyvbF0VRi3mMfqK3IBgx5
         pTB6uKqdM7BY+pYcy54/HjAz9ATCZjxG82roNoqZs99nMkgAZdErNy7QCb8St/4KgU0m
         VTi5e1ElXi6clxJ18jGtlMPfJejjqkquixLr6vX1f4lN/wUd5BjdsBSksOXU4S5dwnN7
         UxWmOG6BrkLXZRpf7R7No3FGYnM7LAmIK3HbBG4cgOjjIo4ptUN+pk8T06a5WimFUslp
         zYYb4upqiu2b2mVmh85jEZ6JZIsuiJAe+uw1vb5OOpmeUDkDW+8tPd3tUXfJZuqdULPv
         ezWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=n2RJ9GVC4U+IIz5ol7TdTW3S4m3YkxYMqncYQCN50Xk=;
        fh=dBSINSrh+dZtWEP0pR2323P8G/MRu1im4fhQaZzZhOY=;
        b=BRisxraQ7Ve6l7sYvnpg8ZrH1xBGjb3jXujpeYSTfEqTdGB8iCqKA1O3y9z2InkOdp
         asuH93ljWirgHS5OoLs4q4Z6Ysohp1gaP/XhwNEAa5nqD9GKkfk06+hW6ZwZx4jyoGaE
         UC4aWifgVd8QNFk9BbtJLnExLSUE/nJ8CPHFqm/mD77UsJ2qFgOD0ldsdSCVIRKQZfqk
         SIYibctHyVkcZATaBc6KUBHEdt70ZG/u78QYLxbXdfEnRSuaTZDOGjBELFLPYZnCGKaQ
         yb5En4Ls2YDUXiREZChZd2kTfjGivaTuzA11hju4wXjHR6AraTJXsB+T6sSuZy1MYNnK
         kj/Q==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774494053; x=1775098853;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n2RJ9GVC4U+IIz5ol7TdTW3S4m3YkxYMqncYQCN50Xk=;
        b=ieZKTNo1nzXbUPWKAdilirUorhHfxvcehvB8Au/ZYOHqqzEVFkeqQpDSqXHBmDT8lR
         H4tBVYnHVMylFgd6wNYPEb/8/at+w8PLKBZlSGRit7+xWcZ0cSPEdcF/yj9YXNQWEOT/
         EsfUuOMVYKMLORs79+yuQ2pnPePY56wInwR5xV9n5BbAB3zeWD0tZ8jzBzQv2kY7nPn1
         egKsytW5K19vKgJxHCaYLKqwqnm0EEetEnX04RbeEI5HyohbkWXLhQ96/fUXZV3oArqz
         OjbjKlKeH9WMMbofv9A/L8eWuxqanxcy+/j784QOIfyDj07+37WzMd4cYvQoWssDTSK9
         QyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774494053; x=1775098853;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2RJ9GVC4U+IIz5ol7TdTW3S4m3YkxYMqncYQCN50Xk=;
        b=anCSWa4prB/5eNSHlByOGIdvua4HStMGkjyyHftdYJQfl+jxjdBkggD9Erp5ve9CEc
         4ZOJYYAeVjDrxFdZDb2wwBjoiBNICxwDCVttd85Y3uFnh8FZwjuLyzIrgcSA/5MUBmZb
         RVXJ4rMzDOJ2IPWRDePJmZjQaN8ux5eyw+ixEVVxRtk9mGJOklIOhTMKsGwcodDBDoNl
         yCYQU/vtEya0YYS6jp+fCi4CpbAbs170KQl4x3+DqKFGichCgGmBqXyEZCqguGqn2mCU
         U0l16+7aJ/+n8Q6m+eYMGa/l0UqCmc9FWj2ks/eejeO2ziA6GVTH5EWFdEmBRO/JzAU8
         3VMw==
X-Gm-Message-State: AOJu0YyULC/eynz5U6ERyLHLB0tBH86AitxdpF/kjqQeGQ6SqIELUkEg
	20EVimk7B2WkmVYgE1DL9Q/mhJfUAdO7z71UmpLU3O4W5ykSNDUvUyd08VnNjlJO64l+9E0raUg
	G+y+Fr4ULMw/Hb0M1N85hKaEiNuGLkA6+iNqy
X-Gm-Gg: ATEYQzzZgmyGIOKEgP1vVgeeEM8EU+fwZRB0DI9mcUvKo7OJPb8sMeCdcI6DtZwv+Xm
	au3XMQaOFzZa/HXMSF45AdyCOfCuS+WHzpnpJXSPzPJx1LBmZzVKapTiToXq7Fj1FT6V7M6i6b0
	Dv2azhumIw6hDobRHcwU3GIqQOP6tXf96V6nFXdp7SZwjUY1LTO5JR4/mjRQUtdmrUZ6W4gdlRE
	E1bCu9GpsL+8G5iTf+Y5enhuIuL91uq3ImBTrIbMDrG1G173fmVv2x8Ryo8ZG9DXbIWv3Q1W7Cu
	SklFd0a+R5KbXhTat24y64ut/2+X6wLHhqYMwvEmS5HCEtuR6zPmJXIzgvExk4c4CiJYlA==
X-Received: by 2002:a05:6122:1c09:b0:56c:c71a:e09a with SMTP id
 71dfb90a1353d-56d220f11aamr2876585e0c.14.1774494053032; Wed, 25 Mar 2026
 20:00:53 -0700 (PDT)
MIME-Version: 1.0
From: Phanor Castillo <castillophanor40@gmail.com>
Date: Wed, 25 Mar 2026 22:00:40 -0500
X-Gm-Features: AQROBzC3Ffhw74OvgHGoWd1uCh4SkLMPeoyqWoW4xM7WUrzuo97iMdAmgXw-LJs
Message-ID: 
 <CANk0dgEoHD7L8NAwKmiCqDHK-ww+0K38XUPGrzBFuEtDgoJ2ZA@mail.gmail.com>
Subject: [ALSA] ALC256 internal microphone not working on ASUS VivoBook
 X513IA/M513IA (subsystem 0x10431d2e)
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
X-MailFrom: castillophanor40@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: KGA5H2V2IFF2XYJGBYRJN4KRHQJ4DTRX
X-Message-ID-Hash: KGA5H2V2IFF2XYJGBYRJN4KRHQJ4DTRX
X-Mailman-Approved-At: Fri, 27 Mar 2026 16:05:38 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KGA5H2V2IFF2XYJGBYRJN4KRHQJ4DTRX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGVsbG8sDQoNCkkgYW0gcmVwb3J0aW5nIGFuIGlzc3VlIHdpdGggdGhlIGludGVybmFsIG1pY3Jv
cGhvbmUgb24gYW4gQVNVUyBWaXZvQm9vaw0KWDUxM0lBIC8gTTUxM0lBIGxhcHRvcCBydW5uaW5n
IEFyY2ggTGludXggd2l0aCBrZXJuZWwgNi4xOS45LWFyY2gxLTEuDQoNClRoZSBpbnRlcm5hbCBt
aWNyb3Bob25lIHByb2R1Y2VzIG9ubHkgc3RhdGljIG5vaXNlIGFuZCBubyBhY3R1YWwgYXVkaW8g
aXMNCmNhcHR1cmVkLiBUaGUgbWljcm9waG9uZSBwaW5zIGRvIG5vdCByZXRhaW4gdGhlaXIgY29u
ZmlndXJhdGlvbiBhZnRlciBiZWluZw0Kc2V0IG1hbnVhbGx5IHdpdGggaGRhLXZlcmIuDQoNCi0t
LSBTeXN0ZW0gSW5mb3JtYXRpb24gLS0tDQpMYXB0b3AgbW9kZWw6IEFTVVMgVml2b0Jvb2sgWDUx
M0lBIC8gTTUxM0lBDQpLZXJuZWw6IDYuMTkuOS1hcmNoMS0xDQpDb2RlYzogUmVhbHRlayBBTEMy
NTYNClZlbmRvciBJRDogMHgxMGVjMDI1Ng0KU3Vic3lzdGVtIElEOiAweDEwNDMxZDJlDQpSZXZp
c2lvbiBJRDogMHgxMDAwMDINCkRyaXZlcjogc25kX2hkYV9pbnRlbCAoc25kX2hkYV9jb2RlY19h
bGMyNjkpDQpBdWRpbyBzZXJ2ZXI6IFBpcGVXaXJlIDEuNi4yICsgV2lyZVBsdW1iZXINCg0KLS0t
IERldGVjdGVkIHBpbnMgKGZyb20gZG1lc2cpIC0tLQ0KVGhlIGtlcm5lbCBkZXRlY3RzIHR3byBp
bnRlcm5hbCBtaWNyb3Bob25lIHBpbnM6DQogIEludGVybmFsIE1pYyA9IDB4MTMNCiAgSGVhZHNl
dCBNaWMgID0gMHgxOQ0KICBJbnRlcm5hbCBNaWMgPSAweDFiDQoNClRoZSBrZXJuZWwgbG9nIHNo
b3dzOg0KICBzbmRfaGRhX2NvZGVjX2FsYzI2OSBoZGF1ZGlvQzFEMDogQUxDMjU2OiBwaWNrZWQg
Zml4dXAgKHBpbiBtYXRjaCkNCg0KSG93ZXZlciwgcXVlcnlpbmcgdGhlIHBpbiB3aWRnZXQgY29u
dHJvbCBmb3IgMHgxMyBhbmQgMHgxYiBhZnRlciBib290DQpyZXR1cm5zIHZhbHVlID0gMHgwIChk
aXNhYmxlZCksIGFuZCBzZXR0aW5nIHRoZW0gbWFudWFsbHkgd2l0aCBoZGEtdmVyYg0KZG9lcyBu
b3QgcGVyc2lzdCDigJQgdGhleSByZXR1cm4gdG8gMHgwIGltbWVkaWF0ZWx5Lg0KDQotLS0gU3Rl
cHMgYWxyZWFkeSB0cmllZCAtLS0NCi0gc29mLWZpcm13YXJlIGluc3RhbGxlZCAobm8gZWZmZWN0
KQ0KLSBtb2RlbD1hc3VzLXZpdm9ib29rLCBtb2RlbD1hc3VzLXplbmJvb2ssIG1vZGVsPWxhcHRv
cC1hbWljLA0KbW9kZWw9bGFwdG9wLWRtaWMsIG1vZGVsPWludi1kbWljIChhbGwgcHJvZHVjZSBv
bmx5IHN0YXRpYykNCi0gaGRhamFja3JldGFzayBwaW4gb3ZlcnJpZGUgaW5zdGFsbGVkIGFzIGJv
b3QgZmlybXdhcmUgKG5vIGVmZmVjdCkNCi0gTWFudWFsIGhkYS12ZXJiIGNvbW1hbmRzIHRvIGFj
dGl2YXRlIHBpbnMgMHgxMyBhbmQgMHgxYiAodmFsdWVzIGRvIG5vdA0KcGVyc2lzdCkNCg0KLS0t
IFBpbiBjb25maWd1cmF0aW9uIGZyb20gaGRhamFja3JldGFzayAtLS0NCjB4MTIgMHg0MDAwMDAw
MA0KMHgxMyAweDkwYTYwMTYwDQoweDE0IDB4OTAxNzAxMTANCjB4MTggMHg0MTExMTFmMA0KMHgx
OSAweDA0YTExMTIwDQoweDFhIDB4NDExMTExZjANCjB4MWIgMHg5MGE3MDEzMA0KMHgxZCAweDQw
NDcxYTZkDQoweDFlIDB4NDExMTExZjANCjB4MjEgMHgwMzIxMTAyMA0KDQpUaGUgc3Vic3lzdGVt
IElEIDB4MTA0MzFkMmUgZG9lcyBub3QgYXBwZWFyIHRvIGhhdmUgYSBkZWRpY2F0ZWQgZml4dXAg
ZW50cnkNCmluIHBhdGNoX3JlYWx0ZWsuYy4gSSBiZWxpZXZlIHRoaXMgbGFwdG9wIHJlcXVpcmVz
IGEgbmV3IGZpeHVwIGVudHJ5LA0KbGlrZWx5IHNpbWlsYXIgdG8gQUxDMjU2X0ZJWFVQX0FTVVNf
TUlDX05PX1BSRVNFTkNFIHVzZWQgZm9yIG90aGVyIEFTVVMNClZpdm9Cb29rIG1vZGVscy4NCg0K
UGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIGFueSBhZGRpdGlvbmFsIGluZm9ybWF0aW9u
LCBzdWNoIGFzIGZ1bGwNCmNvZGVjIGR1bXBzIG9yIEFMU0EgZGVidWcgbG9ncy4NCg0KVGhhbmsg
eW91IGZvciB5b3VyIHRpbWUuDQoNCkJlc3QgcmVnYXJkcw0K
