Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7E9606A31C
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=UTKSsKoe;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qyRvpD4a
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5EEE260210;
	Mon,  9 Nov 2026 16:01:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5EEE260210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794236474;
	bh=D48IuXo5N//Ny7iwd9I3WlEynMzcA02+swXkIWownBE=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=UTKSsKoeixz2zuOW9gHNeWcFBbIGcdraRdIjuUdYJScpvgg3an1JyQOOo3H+BNhap
	 VKjOxcJeK8YrUrRy3rsqbRwd1YDGFJzzZBWsss/vFwStE9kQxjQ17UpYcl7RU1kQQD
	 Svw9Kb9G5QLkG4/v1QUIBOPl9A2MovZ7jOm7YTMM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29D37F806B1; Mon,  9 Nov 2026 15:59:50 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A78CEF806B6;
	Mon,  9 Nov 2026 15:59:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A889F804FF; Thu,  5 Nov 2026 09:16:19 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.228.74
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1793866577;
	b=TfC1EiV2U3Re+/eQW68Edu6bfGF8DVm00DHPSKfdUGRQAbraUuD/AJEr+wzhCc4h0d0y
	 nojF7YPytFBpodabT3XxIAr37UbQ5zKDRX9R6NpPgKWQ7hhHvwEyy0DBpHEj2qgUwGKpQ
	 72fotTXJlM/i1vsNtCw5JuShY9yKI00T+cl5KLwVqx3SnZZbsGYdRAdSloiQdCggjHhT4
	 uLi4sH+aSNmb/AU0d9b4K2drfrWt/3fazCasmxWmG+/kWutxXtXkz5EDc0XRb1bSQALV8
	 OhccZAPkOj/dzShgPeY0WmSAtaznh1Yx+X/hR+On2kq1gls4O5SBO3xZHV0o+89C2Eg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793866577;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=/z2t8dp7ZKI7k3zwGj9a5VteYA5rCSVPLaMLA0ubafU=;
	b=gUPKVVhiaUfoYS/kftAOiLHejBfyGzSB6n2zhHA4axPDI4vK0f4p5P0Zrtyzjut0gYdC
	 LgZ88/xx/pFkosmg8PTmvPFHO/QBq474OfB0lYkJ/5e9AzmyKwTrUaaSKJ+lKIpZMZ8un
	 xCcDz7WPALmIY2j6AgnA1M0VCvwfsAlLhywz6yKyAhFX1XNdcqGrGSD0FqGTYPuTJzQjq
	 JDzVhMjw6eLbMQSOOH6PHaxp1qyikITeddM2lMr7J3kBADmmyMhyWYqN57cr8MqKy+ueb
	 YDpVZAVf/5filXGCvLR3e224hRJHC1IklCXnAXlsh3+8OLmafH4oKuTCiuQcB6TF58A==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=qyRvpD4a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.228.74
Received: from mail-ed2-f10.google.com (mail-ed2-f10.google.com
 [74.125.228.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 95B7EF800EE
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2026 09:16:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95B7EF800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=qyRvpD4a
Received: by mail-ed2-f10.google.com with SMTP id
 4fb4d7f45d1cf-6a14f2e937cso975634a12.1
        for <alsa-devel@alsa-project.org>;
 Thu, 05 Nov 2026 00:16:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793866576; cv=none;
        d=google.com; s=arc-20260327;
        b=gQ8yrd1BWfQnc8eb6AIv2OOJSK8B3uL+eFZdxd0GOffG0OG9E+J28FrZVTM+NXlDQ+
         N0NpuPv1TvLMGpdJqGDTMmpklCCSMS6jlloFj6iMOBnYEUoUrHo5okzVmNxw/NWF3/PD
         ujvzdHYuWuje6s0kvJ81Kpkqyl7fNO/k2UYkGtP9yYDP26jYp8W0NWwnL4GsCZOWAWIW
         QaN8SjjBamDNDkIHTT47RQXRPOBhLmmL8IzWIk23x48iKab6ApgoaJP/wdDsm7/w+TPW
         b+VVEENWqZ7dUKrtHgYNC1p9MuCa3+N8yuqCn/xyPnAsK60mkfFSqBjNQ92a2fqrWkkl
         r+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=peKYm7GEYXyIvVfCEPj1VmUn4Ptvf9M/JgfQwqZyu3k=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=IG2Hl3xBBALNeoVPB9AOpTJnROFPggL3QHmceHcjbUxqz5zvGrtol7oO2IY8zdijn4
         YCPeafgGK6iC9BZy3kI4xx/1ZgSqcbF99TpscCOZlguOABD0JTrTbrvxjCLpOi1iF5AZ
         tKJGorkGCm4I0NoPEgohil0r6nT57CGbI8x4e/9+BYsRNdBtxoGROC7m8NKf/h4ey3v+
         sWBIz/GIIdSGtbIWirpjdmIN3zkCmcad/GL0y69Adkp3qgDoXixeiE9ufsYW+Jz0M7m5
         h3JbpJSqnpfd+yhPP2v5v30lMO7sWJqA4pdHFHGEnJDhtH0esFWxzNBsUA5ou/mnRUEO
         vvKA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793866575; x=1794471375;
 darn=alsa-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=peKYm7GEYXyIvVfCEPj1VmUn4Ptvf9M/JgfQwqZyu3k=;
        b=qyRvpD4aGLX6NPbWOqGm+2iYW+oc9O6bp+S4NIAwYltrrie0Wj3SmI25n3O0/twdKy
         HohRlidreSya7Wsf3Zj122Icy3K8rUNkfAPwo3hdhn9MvTdOTGhhFzpCctXxIT8K9/L8
         whQyzPi6nYyrkan2oglPl0j3q9F97YMeNy+025SC+QjWru0Grji3BVzjFqWHkzL6nGX8
         RVjTMMKxn9BuRrAy8P/GGO0ETI5PTBaS6kha2hiHRo/eeM9oQXemH3difJumCSsnwOWK
         kM+wzAbELE+sQm/EbZ3iGHcqAyhQBCzyu6oPOID/JbzRCgFpm3RBHix6rNtPzHRrLv7H
         bjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866576; x=1794471376;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=peKYm7GEYXyIvVfCEPj1VmUn4Ptvf9M/JgfQwqZyu3k=;
        b=uOeRaeq5siYrSM4mkNcYtB1KX6YceRtcxrNtSqQms0qmUziA2Roc8jJFTC3ut/IIZ1
         Pe8ubUrluJNOGaEldFq5RhiU0FFVUvkSUQ0XEu9cQU5cRbMuNfTpQ7Y2remgrzG9kCzC
         VmV7uIECRCqIVbocCmVHRhNQsUCf/aPMKLMkMoNhfLdqfiQUu79dRkHpf0R1bZCnb4jj
         fr/22PDRulJ3O7mUt3cv7nzIJdDNoZ23kQ05YmZDP4T3huIby9+cWZVk4AktBR21OIRZ
         0T2ABCDYmtrKO0fh85zrCvIc6HFcRRZe39K9DsY97F+QMtJNMqByZrQ61jW5g9LSg9qj
         HSRA==
X-Gm-Message-State: APuU4Z8SXTuZCUIyquPWFRpMdJBzOATYtkjMySVrwRiCLJXSRzLDb9lf
	PFZXLrrp+SaTr2VIs9EygMn0kZrDC+9Ciqsere6et8d6xoKdCo8RcJtanhj5YTC+oTsImDFN3tu
	goOPLSRgOeTv6BfmacjlSjr+5VtZ0081VKuqxXtY=
X-Gm-Gg: AYBFou3P+4tMAoSSQeZmuDzbO2d2tL8uFv/znQzRhBXlBNp6xFU/fmcIKCM35Lyfled
	csbgBc8sLrhnG7aiOg5h9DCS9lDA1NanrkA0z6HwvCOm1iy4sdDUNvP3/Yebrwf3HSiSlCfdBp0
	49cipNyvkYorLsdtp35aH02Yv17BufASVNRjx5X1Lk6Kmuw09Bwp5Yp2LOoCLiMOVauoXWU/QXa
	x1GqcrvOOBsEtuzkffCykK28T50mCRO+RP77/7oRle+OO2d9f9YpD4+x4Wdqw7IkPD7qFNbXjPP
	QpbYdW86fwDDs7gIFQ1cCIg4kXbUcOwsAUFsJSPeRyU3+IqGZpg7Q92anh3mvljstxPMn8b6XIG
	dY7tz2rMQTxYPAw4QGMfBQmPcRFsLlxy+KEtMKNkVCpj63JonFnMs2dwTv+ehjBs6pSSFShdwPo
	TEBBHhb9/xLCkz9g==
X-Received: by 2002:aa7:c1cc:0:b0:6b3:f840:59b5 with SMTP id
 4fb4d7f45d1cf-6b4d4c71d29mr10166579a12.27.1793866575422; Thu, 05 Nov 2026
 00:16:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: addi <addinoy509@gmail.com>
Date: Thu, 5 Nov 2026 13:46:03 +0530
X-Gm-Features: AclHuK_BRrskKbJdnjNrJ2uv4mHKBuFHFMztAcPE-vwWrCYV724H3ssMi_Ccu8c
Message-ID: 
 <CAGiaURRZ8wXdYrLpYnDavH5A9GQUNQ7puUDg-pA4m1Cv6zNfMg@mail.gmail.com>
Subject: Subject: [ALC256] ASUS VivoBook X513EA (1043:1032): internal speakers
 silent, mic and USB audio work
To: alsa-devel@alsa-project.org
X-MailFrom: addinoy509@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: MTLGLHO5XEL5M6B4HDMDHKJDY5UZTFCB
X-Message-ID-Hash: MTLGLHO5XEL5M6B4HDMDHKJDY5UZTFCB
X-Mailman-Approved-At: Mon, 09 Nov 2026 14:59:25 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MTLGLHO5XEL5M6B4HDMDHKJDY5UZTFCB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

SGFyZHdhcmUgLSBBU1VTIFZpdm9Cb29rIFg1MTNFQSwgQklPUyBYNTEzRUEuMzE4ICgyMDI0LTAz
LTI4KSwgQ29yZQ0KaTMtMTExNUc0IC0gQXVkaW86IEludGVsIDUwMCBTZXJpZXMgUENIIEhEQSAo
ODA4NjphMGM4KSwgY29kZWMgUmVhbHRlaw0KQUxDMjU2ICgxMGVjMDI1NiwgcmV2IDB4MTAwMDAy
KSwgU1NJRCAxMDQzOjEwMzIgLSBLZXJuZWw6DQo3LjIuOS0yLWNhY2h5b3MtYm9yZS1sdG8gKENh
Y2h5T1MsIEFyY2gtYmFzZWQpLCB0aGUgb25seSBPUyBpbnN0YWxsZWQgbm93Lg0KU2FtZSBzaWxl
bmNlIG9uIFVidW50dSBlYXJsaWVyLiBTcGVha2VycyB3b3JrZWQgb24gV2luZG93cyBvbiB0aGlz
IG1hY2hpbmUNCmJlZm9yZSBJIHJlcGxhY2VkIGl0LiBQcm9ibGVtIEludGVybmFsIHNwZWFrZXJz
IHByb2R1Y2Ugbm8gc291bmQuDQpzcGVha2VyLXRlc3QgLUQgaHc6MCwwIC1jIDIgLXQgc2luZSAo
ZGlyZWN0IEFMU0EsIFBpcGVXaXJlIGJ5cGFzc2VkKSBpcw0Kc2lsZW50LiBJbnRlcm5hbCBtaWMg
YW5kIFVTQiBoZWFkcGhvbmVzIHdvcmsuIENvZGVjIHN0YXRlIChhbHNhLWluZm8NCmF0dGFjaGVk
KSAtIFN0b2NrIFNTSUQgcXVpcmsgaXMgYXBwbGllZDogInBpY2tlZCBmaXh1cCBmb3IgUENJIFNT
SUQNCjEwNDM6MTAzMiIgLSBQaW4gMHgxNCAoU3BlYWtlciwgRml4ZWQpOiBhbXAgdW5tdXRlZCwg
T1VUIGVuYWJsZWQsIEVBUEQgMHgyLA0KY29ubmVjdGlvbiAtPiBEQUMgMHgwMiAtIERBQyAweDAy
OiBzdHJlYW09MSB3aGlsZSBwbGF5aW5nLCBhbXAgMHgzOC8weDU3LA0KdW5tdXRlZCAtIE1peGVy
OiBNYXN0ZXIgNjQlIG9uLCBTcGVha2VyIDEwMCUgb24sIEF1dG8tTXV0ZSBNb2RlIGRpc2FibGVk
IC0NCkdQSU8wLTIgYWxsIGRpc2FibGVkIGF0IHN0b2NrIFRoZSBjb2RlYyBhcHBlYXJzIHRvIGJl
IHNlbmRpbmcgYXVkaW87IHRoZQ0KZmFpbHVyZSBzZWVtcyB0byBiZSBhZnRlciBpdC4gVHJpZWQg
KG5vIHNvdW5kKSAtIEZvcmNpbmcgR1BJTyBtYXNrL2RpciAweDA3DQphbmQgc3dlZXBpbmcgU0VU
X0dQSU9fREFUQSAwLTcgdmlhIGhkYS12ZXJiIC0gbW9kZWw9IGFsYzI1Ni1hc3VzLWFpbywNCmFz
dXMtemVuYm9vaywgYXN1cy16ZW5ib29rLXV4MzFhLCBhbGMyNTYtYXN1cy1taWMsIGFsYzI1Ni1t
ZWRpb24taGVhZHNldA0KKHZpYSBod0MwRDAgbW9kZWxuYW1lL3JlY29uZmlnKSAtIFBpcGVXaXJl
IHN0b3BwZWQgZHVyaW5nIGFsbCB0ZXN0cw0KUG9zc2libHkgcmVsZXZhbnQgLSAvZXRjL21vZHBy
b2JlLmQgaGFzICJvcHRpb25zIHNuZF9pbnRlbF9kc3BjZmcNCmRzcF9kcml2ZXI9MSIgKGZvcmNl
cyBsZWdhY3kgSERBKS4gUmVzdWx0IHdpdGggaXQgcmVtb3ZlZCAoYXV0byk6IDxmaWxsIGluPg0K
LSBBQ1BJIGxpc3RzIFJlYWx0ZWsgU291bmRXaXJlIGRldmljZXMgKGUuZy4gMHgwMDAwMTAwMjVk
MDcwMTAwKSBhbmQNCnNuZF9zb2ZfcGNpX2ludGVsX3RnbCAvIHNvdW5kd2lyZV9pbnRlbCBhcmUg
bG9hZGVkLCBhbHRob3VnaCB0aGUgY2FyZCBpcw0KYm91bmQgdG8gc25kX2hkYV9pbnRlbC4gVW5z
dXJlIGlmIHJlbGV2YW50LiAtIFBsYWluIEFyY2ggImxpbnV4IiBrZXJuZWwNCmluc3RlYWQgb2Yg
Q2FjaHlPUzogPGZpbGwgaW4+IC0gMy41bW0gaGVhZHBob25lIG9uIHRoZSBjb21ibyBqYWNrOiA8
ZmlsbA0KaW4sIGlmIHRlc3RlZD4gU2luY2UgaXQgd29ya2VkIG9uIFdpbmRvd3MsIEkgc3VzcGVj
dCBhbiBpbml0IHN0ZXAgTGludXgNCmRvZXNuJ3QgZG8gKENPRUYgd3JpdGUgb3IgZXh0ZXJuYWwg
YW1wIGVuYWJsZSkuIEhhcHB5IHRvIHRlc3QgcGF0Y2hlcyBvcg0KY29sbGVjdCBtb3JlIGR1bXBz
LiBBdHRhY2htZW50czogYWxzYS1pbmZvIG91dHB1dCwgZG1lc2csIENPRUYgZHVtcCBvZiBub2Rl
DQoweDIwDQo=
