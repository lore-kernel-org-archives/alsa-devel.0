Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8975DF3ED5C
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Apr 2026 20:26:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EBE9860201;
	Sat, 11 Apr 2026 22:26:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EBE9860201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775939176;
	bh=uJXrkjI9FWH1ZvFLp13CGcSKPqeRrIdogDVkiVtfBoU=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Irs/l5QbiR0G0xP7dA2ODs+dO9826tVA/ofcDsjmB5wC1zKBWda1E6ZNelu54Lizm
	 2rLpD0FqataTtJjgs9uRaTkERBcjd1wKo+02EGlAgONEqEwGDXStCqwaVQ7LwosgAa
	 3t9vjcTO1+tOTV0nxTMumHAlBwh+9cgDuwqO+Fu8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E4C53F805FA; Sat, 11 Apr 2026 22:25:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5BDBEF805EA;
	Sat, 11 Apr 2026 22:25:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E6FB7F80527; Sat, 11 Apr 2026 08:47:39 +0200 (CEST)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com
 [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F1359F80087
	for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2026 08:47:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1359F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Xe+quC9L
Received: by mail-oo1-f52.google.com with SMTP id
 006d021491bc7-66f747175d8so1375627eaf.0
        for <alsa-devel@alsa-project.org>;
 Fri, 10 Apr 2026 23:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775890051; cv=none;
        d=google.com; s=arc-20240605;
        b=h7VhGY2Ch9M8vawuFnysi71ylbrpTo9Yw7bvBXErYGBJ8UO1lgEvqe3fNhU3UtS+d2
         w4dVWMkol6/8PDr6JwqbBJzKoSEQgslN+XfKPwWqYsrzVCUAukmtlcZoY1tkCNSj0/px
         hVqXwz5YAyYIsBDFyUVb9YFD9KFWYlxQ5Bi2G3x181PG0ZG5Jvt6If3wXr2AkpF0T2TR
         xIaeSeiF8gRoeXiionMfeVq5HXJYdPGSOgGhkYkqD+KQVyd6xUsYOi35o1R3oaE9PmWB
         Y2PZ11SC00pijmXOudZ2FA3aVX+68ZFw/lXpyM5a9L76BenR+MNJy3N7xq7hXjhH2GC7
         rSzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=LbMSlyiv0qEJPARA42+uW31hxuiI61biwt625aoKdo8=;
        fh=LLVbHwCF4ZF16HNd2h3XbtUNy4ht64SI2+l9ThXsSXA=;
        b=jSebVwf/Q9f/hdyUR6Rd95aHYdlPUBBDxwwJJdjki+iQTRJ18+sUly/AIvKqmB3UuE
         iJ2IxA5iiNjJwv3PPL7rtS9b7HtxApdSLE9up6m54SuqIF5araZe39dI9TUPKAgrMcvZ
         ydyHGRCTzarSSE9XUxosPeaIwRZl3CvgCHhiCVvWjv9niYgE6amKS5VX017WJpVVSyGD
         T+zWGMHX+I1Lo2UhV5yXj9tHawNJxwnpisVagGhdBbT0MpzgA8kVAPz2GXl+5ZCIZ2He
         VJuWS21S3LBB2uUmO+5qcwifD/LGh5zQ+XhCf4AKOtYG1m7WLXwYATF/3xXY9juo3Uuf
         OB5Q==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775890051; x=1776494851;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LbMSlyiv0qEJPARA42+uW31hxuiI61biwt625aoKdo8=;
        b=Xe+quC9LoQi98FUyz3SbzziHNAxleTXrrX3AGo0hWpuvksFwy9XOIDpW7gYy8qI4lu
         YcKbZ93C+xj7qFj6OowTfE2/hlLNnh85mAW3jrY5ShULZJJAy2OhMg6saekZSTtMqtUE
         vItyDKb5ERf4IGtumxNGOrl2E0QNPNViAXk91apS7yWoljlRzKQ+JiMtIcWJ4BELz2D4
         z65KRuBbv4ZNPtc/XTHE7EfQHqWyhhpl+3MjbR5wFc5SWv6bE5a1lJkbRU102QEtyhss
         v1y8iHRf84YCEE/fEuHlLp++g2vuAz35jLNLSBZNnYTkJqCrqr4IJfuvCFt5+f+RUHvY
         4fSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890051; x=1776494851;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbMSlyiv0qEJPARA42+uW31hxuiI61biwt625aoKdo8=;
        b=TkXzf+7phntQCbgInmfn9BACxinz/xH7N1stcPJ547NpgvW3WQ4gOfYKnMY9TTBNfG
         TeOnIXNgMtrgo7ilYT2qGI1YFw6CoeYHVwXiVOGGgfUCa6PBu4XekUw3J/rKFr4d3qHT
         +UHGl0uTHJR930lUgVpZkvO/SkyWRRGFYkaKIoeLil1v3OeBzW1/zQxCv+j3paQwf/o1
         24hePPyi5moL7GjaO2qrzzomHbDx4F8hOwTePGGJj2MtNevHAF2uoaiMdUiEeD2PBTdy
         jBODLRaovkWrtlRYMoUq7p46eAW61ba6HpqzuDvGPhSU4sydcqKWaIDKQkcsnK7FBNLj
         +qWQ==
X-Gm-Message-State: AOJu0Ywr40sqPgIjg+htEEb/ahGdfvwo+BXgwh8c88vD58DrN9a3flME
	GlfzmoYXGIy+kdpYzrc7tVTMvkE/yGzYgAx0BUpfyb3O6ikmIrv5FdKX/EV+OphHJ12SkBTSO3C
	IzPCbkwYax6Tq8rT/rZNc3kkCqP5Tkc+3brJl
X-Gm-Gg: AeBDiesbpObLnyVVesuARS83AjsXerR1+16PMpLMXEtBew7J2ahcN5qsE7pcBf1aBb2
	q+4UVMuvuej21Cyhll9o/X4KBRci2sM1c3pQX3xqL05f/9LerENxEyRtLiafROcxWwChRMuVBFi
	E5v7/xeEw4+IjUb0XZyvE5J6DybxrAJt5QjysRBW9UEzb2v0r6nOEeYr3MCWELqHwChnweO2Uc1
	idYBOJ26MJoR/SSTjY8mt/YfvOqc5B8vQ2ly6GQ3cjTeL3LzjWaEI9D8X6QUx6rY8gu792TfgO1
	Ydw79FVxI5oabKIoawB/4J+F1nkG8yt+CKQjb1Fs3fBI2S1UuaZjM8a8NO8k5MDqQz03
X-Received: by 2002:a05:6820:4b97:b0:67e:366b:53b7 with SMTP id
 006d021491bc7-68be88e3d56mr3032584eaf.53.1775890050744; Fri, 10 Apr 2026
 23:47:30 -0700 (PDT)
MIME-Version: 1.0
From: Moe Ali <moegts@gmail.com>
Date: Sat, 11 Apr 2026 09:47:20 +0300
X-Gm-Features: AQROBzAxjAnOTBg0hlf4GmQW7x3yfEIgIERqMEe5OryJiP_0Qhy35DB1gMrssm4
Message-ID: 
 <CAMaXRwQJh9Jf4MLEfAo_5-u-qBWbhNsStdj62pMSJOESYG5KDg@mail.gmail.com>
Subject: CS35L41 HDA SPI: GPIO chip-select not functional on Intel LPSS /
 pxa2xx-spi (ASUS ZenBook Pro Duo UX582ZM, SSID 10431A8F)
To: alsa-devel@alsa-project.org
Cc: linux-spi@vger.kernel.org
X-MailFrom: moegts@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: SHIOOIEDLT4P3LQZ233B6LVM52WU7HTC
X-Message-ID-Hash: SHIOOIEDLT4P3LQZ233B6LVM52WU7HTC
X-Mailman-Approved-At: Sat, 11 Apr 2026 20:25:37 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SHIOOIEDLT4P3LQZ233B6LVM52WU7HTC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

KlN5c3RlbToqIEFTVVMgWmVuQm9vayBQcm8gRHVvIFVYNTgyWk0gKFVYNTgyWk0gMS4wKQ0KKktl
cm5lbDoqIDcuMC4wLTEzLWdlbmVyaWMgKFVidW50dSAyNi4wNCkNCipBdWRpbzoqIFJlYWx0ZWsg
QUxDMjk0IChzdWJzeXN0ZW0gSUQgMTA0MzFhOGYpICsgMnggQ2lycnVzIExvZ2ljIENTMzVMNDEN
CihTUEksIEFDUEkgSElEIENTQzM1NTEpDQoqU1BJIGNvbnRyb2xsZXI6KiBJbnRlbCBBbGRlciBM
YWtlIExQU1MgU1BJIChweGEyeHgtc3BpIC8NCnNwaS1weGEyeHgtcGxhdGZvcm0pDQoNCipQcm9i
bGVtKg0KDQpUaGUgQVNVUyBVWDU4MlpNIGhhcyB0d28gQ1MzNUw0MSBzcGVha2VyIGFtcGxpZmll
cnMgb24gU1BJIGJ1cyAwLiBUaGUgZmlyc3QNCmFtcCAoaW5kZXggMCkgdXNlcyBuYXRpdmUgY2hp
cC1zZWxlY3QgQ1MwIGFuZCB3b3JrcyBjb3JyZWN0bHkuIFRoZSBzZWNvbmQNCmFtcCAoaW5kZXgg
MSkgcmVxdWlyZXMgYSBHUElPIGNoaXAtc2VsZWN0IChBQ1BJIEdwaW9JbyByZXNvdXJjZSBpbmRl
eCAxLA0KcGluIDB4MDEzMSwgUHVsbERvd24pIG1hbmFnZWQgdmlhIGBzcGlfc2V0X2NzZ3Bpb2Qo
KWAuDQoNClRoZSBzZWNvbmQgYW1wIGFsd2F5cyBmYWlscyB3aXRoOg0KDQpjczM1bDQxLWhkYSBz
cGkwLUNTQzM1NTE6MDAtY3MzNWw0MS1oZGEuMTogRmFpbGVkIHdhaXRpbmcgZm9yIE9UUF9CT09U
X0RPTkUNCg0KDQpTUEkgcmVhZHMgdG8gYW1wIDEgcmV0dXJuIGFsbCB6ZXJvcyAoMHgwMDAwMDAw
MCksIGluZGljYXRpbmcgdGhlIGRldmljZSBpcw0Kbm90IGJlaW5nIHNlbGVjdGVkIGR1cmluZyB0
cmFuc2ZlcnMuDQoNCg0KKldoYXQgSSd2ZSB2ZXJpZmllZCoNCjEuICpUaGUgR1BJTyBJUyB0aGUg
Y29ycmVjdCBDUyBwaW4uKiBXaGVuIEkgc2V0IGBjc19ncGlvX2luZGV4ID0gLTFgDQooZGlzYWJs
ZSBHUElPIENTIGhhbmRsaW5nKSwgdGhlIEdQSU8gZGVmYXVsdHMgdG8gTE9XIChQdWxsRG93biks
IGFtcCAxDQpzdGF5cyBwZXJtYW5lbnRseSBzZWxlY3RlZCwgYW5kIHRoaXMgY2F1c2VzIGJ1cyBj
b250ZW50aW9uIHRoYXQgYnJlYWtzIGFtcA0KMCB0b28g4oCUIGJvdGggYW1wcyByZXR1cm4gREVW
SUQ9MHgwMDAwMDAwMC4gUmVzdG9yaW5nIEdQSU8gQ1MgaGFuZGxpbmcNCih3aGljaCBkcml2ZXMg
dGhlIEdQSU8gSElHSCBmb3IgYW1wIDAncyB0cmFuc2ZlcnMpIG1ha2VzIGFtcCAwIHdvcmsgYWdh
aW4uDQpUaGlzIHByb3ZlcyBwaW4gMHgwMTMxIGlzIHdpcmVkIHRvIGFtcCAxJ3MgQ1MuDQoNCjIu
ICpgc3BpX3NldF9jc2dwaW9kYCArIGBzcGlfc2V0dXBgIGRvZXMgbm90IHdvcmsuKiBBZnRlcg0K
YHNwaV9zZXRfY3NncGlvZChzcGksIDAsIGNzX2dwaW9kKWAgYW5kIGBzcGlfc2V0dXAoc3BpKWAs
IFNQSSByZWFkcyBzdGlsbA0KcmV0dXJuIDB4MDAwMDAwMDAuIEV2ZW4gbWFudWFsbHkgZHJpdmlu
ZyB0aGUgR1BJTyBMT1cgd2l0aA0KYGdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChjc19ncGlvZCwg
MClgIGJlZm9yZSBhIGByZWdtYXBfcmVhZGAgZG9lcyBub3QNCmhlbHAg4oCUIHRoZSByZWFkIHN0
aWxsIHJldHVybnMgYWxsIHplcm9zLg0KDQozLiAqQ2hhbmdpbmcgYHNwaS0+Y2hpcF9zZWxlY3Rb
MF1gIGZyb20gMSB0byAwIGJlZm9yZSBgc3BpX3NldF9jc2dwaW9kYA0KYWxzbyBkb2VzIG5vdCBo
ZWxwLioNCg0KNC4gKkFtcCAwIHdvcmtzIHBlcmZlY3RseSogd2l0aCBuYXRpdmUgQ1MwIChmaXJt
d2FyZSBsb2Fkcywgc3BlYWtlcg0KcHJvdGVjdGlvbiBEU1AgcnVucywgY2FsaWJyYXRpb24gYXBw
bGllZCwgYXVkaW8gb3V0cHV0IGNvbmZpcm1lZCkuDQoNCg0KKkFDUEkgR1BJTyByZXNvdXJjZXMg
KGZyb20gU1BLUkFNUFMvQ1NDMzU1MSBfQ1JTKSoNCg0KR3Bpb0lvWzBdID0gcGluIDB4MDAxNywg
T3V0cHV0LCBQdWxsVXAgICAg4oaSIFJlc2V0IChzaGFyZWQpDQo+IEdwaW9Jb1sxXSA9IHBpbiAw
eDAxMzEsIE91dHB1dCwgUHVsbERvd24gICDihpIgQ2hpcCBTZWxlY3QgKGFtcCAxKQ0KPiBHcGlv
SW9bMl0gPSBwaW4gMHgwMTJFLCBJbnB1dCwgUHVsbFVwICAgICAg4oaSIFNwZWFrZXIgSUQNCj4g
R3Bpb0lvWzNdID0gcGluIDB4MDEyRiwgSS9PLCBQdWxsVXAgICAgICAgIOKGkiBJbnRlcnJ1cHQN
Cg0KDQoNCipDb25maWcgdGFibGUgZW50cnkgYWRkZWQgdG8gY3MzNWw0MV9oZGFfcHJvcGVydHku
YyoNCg0KeyAiMTA0MzFBOEYiLCAyLCBJTlRFUk5BTCwgeyBDUzM1TDQxX0xFRlQsIENTMzVMNDFf
UklHSFQsIDAsIDAgfSwgMCwgMiwgMSwNCj4gMTAwMCwgNDUwMCwgMjQgfSwNCg0KDQoocmVzZXRf
Z3Bpbz0wLCBzcGtpZF9ncGlvPTIsIGNzX2dwaW89MSwgYm9vc3Q6IDEwMDBuSC80NTAwbUEvMjR1
RikNCg0KKldvcmthcm91bmQqDQoNCkkgYWRkZWQgYSBgcHJvYmVfZmFpbGVkYCBmbGFnIHRvIGBz
dHJ1Y3QgY3MzNWw0MV9oZGFgLiBXaGVuDQpgY3MzNWw0MV93YWl0X2Jvb3RfZG9uZSgpYCBmYWls
cywgdGhlIGRyaXZlciBzdGlsbCBjYWxscyBgY29tcG9uZW50X2FkZCgpYA0Kd2l0aCBhIHN0dWIg
dGhhdCBoYXMgbm8gcGxheWJhY2sgaG9va3MuIFRoaXMgdW5ibG9ja3MgdGhlIEhEQSBjb2RlYydz
DQpjb21wb25lbnQgYmluZGluZyAod2hpY2ggd2FpdHMgZm9yIGJvdGggYW1wcykgYW5kIGFsbG93
cyBhbXAgMCB0byBwcm9kdWNlDQphdWRpbyBmcm9tIHRoZSBsZWZ0IHNwZWFrZXIuDQoNCg0KKlN1
c3BlY3RlZCByb290IGNhdXNlKg0KVGhlIEludGVsIExQU1MgU1BJIGNvbnRyb2xsZXIgKHB4YTJ4
eC1zcGkpIGRvZXMgbm90IHByb3Blcmx5IGhhbmRsZSBHUElPDQpjaGlwLXNlbGVjdHMgc2V0IHZp
YSBgc3BpX3NldF9jc2dwaW9kKClgLiBFaXRoZXI6DQotIFRoZSBjb250cm9sbGVyJ3MgYHNldF9j
c2AgY2FsbGJhY2sgc3RpbGwgYXNzZXJ0cyBuYXRpdmUgQ1MgYWxvbmdzaWRlIHRoZQ0KR1BJTyBD
UywgY2F1c2luZyBidXMgY29udGVudGlvbg0KLSBPciB0aGUgR1BJTyBpcyBub3QgYmVpbmcgdG9n
Z2xlZCBkdXJpbmcgYWN0dWFsIFNQSSB0cmFuc2ZlcnMgZGVzcGl0ZQ0KYmVpbmcgcmVnaXN0ZXJl
ZA0KDQpUaGlzIG1heSBhZmZlY3QgYWxsIEFTVVMgbGFwdG9wcyB1c2luZyBDUzM1TDQxIG92ZXIg
U1BJIHdpdGggR1BJTw0KY2hpcC1zZWxlY3Qgb24gSW50ZWwgQWxkZXIgTGFrZSBwbGF0Zm9ybXMu
DQoNCg0KKmRtZXNnIChyZWxldmFudCBsaW5lcykqDQoNCnNuZF9oZGFfc2NvZGVjX2NzMzVsNDE6
IGxvYWRpbmcgb3V0LW9mLXRyZWUgbW9kdWxlIHRhaW50cyBrZXJuZWwuDQo+IGNzMzVsNDEtaGRh
IHNwaTAtQ1NDMzU1MTowMC1jczM1bDQxLWhkYS4wOiBBZGRpbmcgRFNEIHByb3BlcnRpZXMgZm9y
DQo+IDEwNDMxQThGDQo+IGNzMzVsNDEtaGRhIHNwaTAtQ1NDMzU1MTowMC1jczM1bDQxLWhkYS4w
OiBDaXJydXMgTG9naWMgQ1MzNUw0MSAoMzVhNDApLA0KPiBSZXZpc2lvbjogQjINCj4gY3MzNWw0
MS1oZGEgc3BpMC1DU0MzNTUxOjAwLWNzMzVsNDEtaGRhLjE6IEFkZGluZyBEU0QgcHJvcGVydGll
cyBmb3INCj4gMTA0MzFBOEYNCj4gY3MzNWw0MS1oZGEgc3BpMC1DU0MzNTUxOjAwLWNzMzVsNDEt
aGRhLjE6IFJlc2V0IGxpbmUgYnVzeSwgYXNzdW1pbmcNCj4gc2hhcmVkIHJlc2V0DQo+IGNzMzVs
NDEtaGRhIHNwaTAtQ1NDMzU1MTowMC1jczM1bDQxLWhkYS4xOiBGYWlsZWQgd2FpdGluZyBmb3Ig
T1RQX0JPT1RfRE9ORQ0KPiBjczM1bDQxLWhkYSBzcGkwLUNTQzM1NTE6MDAtY3MzNWw0MS1oZGEu
MTogQm9vdCBmYWlsZWQgKC0xMTApLCByZWdpc3RlcmluZw0KPiBzdHViIGNvbXBvbmVudA0KPiBj
czM1bDQxLWhkYSBzcGkwLUNTQzM1NTE6MDAtY3MzNWw0MS1oZGEuMDogQ1MzNUw0MSBCb3VuZCAt
IFNTSUQ6IDEwNDMxQThGLA0KPiBCU1Q6IDAsIFZTUEs6IDAsIENIOiBMLCBGVyBFTjogMSwgU1BL
SUQ6IDANCj4gY3MzNWw0MS1oZGEgc3BpMC1DU0MzNTUxOjAwLWNzMzVsNDEtaGRhLjE6IENTMzVM
NDEgc3R1YiBib3VuZCAoYW1wIDENCj4gZmFpbGVkIHByb2JlLCBza2lwcGluZykNCg0KDQoNCltp
bWFnZTogTWFpbHN1aXRlXSBTZW50IHdpdGggTWFpbHN1aXRlIENSTSAgwrcgIFVuc3Vic2NyaWJl
DQo8aHR0cHM6Ly91Lmxpc3QtcHJlZmVyZW5jZXMuY29tL2VuL3ByaXZhY3kvb3B0LW91dC91bnN1
YnNjcmliZS82ODU1MWM2ODY2MDIyZGNlMmFiNjI1OWU0MzM0YzFjZGMyOWNlMjUwLzQ5YjNkMTIz
ODliODcxYTJhNjJmMzgwOGE2NThlODdkMTZmNDVlNGFmM2I3OTU1ZWJlMDdlOGRkMGI2M2UxZDYy
ZjY1YTBkZjg1MjMyMjIwODAwNWUwZTY3MTQ1ZWQ4YmMwODMxMzc4MjdkODAyODZlNGM3YTM0MTk3
MGZiMjM5Pg0KMDQvMTEvMjYsIDA5OjQ1OjM3IEFNDQo=
