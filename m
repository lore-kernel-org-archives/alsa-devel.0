Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4617BC79F99
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:37:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA05F602C9;
	Tue,  8 Sep 2026 20:37:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA05F602C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788892654;
	bh=r5ahpvAzEgELjG3c+r0gLKI5c3mwrCX62hFRh65IeHM=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=dhD2Noic+OJQcN07VAov5bb3lRQ6AOJiIXL5N8bwzXbK7QAFJFPiUtM+/g5oOOidg
	 N3Qk/Jp/usv2M7EpFc+aGLEsf8Dg55bIQ1iGbpgAuMqAQQ/nQ48kxOxev7gDVmAxAS
	 gbq3HDMlGS6boObdkKgMJRdpC7qKmncSrlk2i2N8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BE7D5F806CA; Tue,  8 Sep 2026 20:35:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 43C51F806CF;
	Tue,  8 Sep 2026 20:35:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 07E41F804CC; Tue,  1 Sep 2026 14:27:25 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.175
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1788265644;
	b=rJAb54fWtPEmDOkUyV2vKlPN5UIbCxTqx35pwuXRmbTk1MLnN1VchvEKNnPYwYq5Pt6W
	 7fpaqueUxHHX0QwATgCLfzzYpGQyNSLH7G18dfjnuDOKTTXIijQhiSzGSHhxsCjfez8jb
	 0m7t39kPd70vo3QbldB4Nuwj5qRuxd2uzvG12Jj3jnCWVx6qg4nowi9aBkfl0G2ESc1hS
	 50xywlVPRZQ+RD+36k4JcAW7H4pGFu7IQWESKQVZPBzutP3+lQQ+CEOkIk06rQG3WkzMP
	 Ks4jGwDIZHU6zOxlcaWyCWgpkYkF/edQxA/9lYnlEgVVgJNqIovKY/PHT/Pdb1xchCw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788265644;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=JIrh6piAK+xRTqBOCCKUc68PKY0t1VuWtj6xyZuKAs4=;
	b=Qj79p3yRmcKR3cOfRzc2w7iRrsU4PAtTw9dhosJpBHBFq6zRuZXYXwhpUJpCG5t8DC+D
	 nQnhYpvlqzbdsu+FSISrKgr3qpA63B3uULDY9HL021S9uE+EG1ZxmL5Tn39l5t3ukGWBK
	 AJB/YluXjhF7uqbzowURaR2qECCBx89G5EVH0ikFgSnEN4jO5Af1tKapkI2NWSIZoikFF
	 2u+tG2ns+LHl2P1KO2ibJcjNrSDFl26IvKDgx1EMoHriLF7O8lYcU/79Kit575zvk7MS9
	 K2rgQirFPMKMUymLr0Gsg2L9l5RC+29/gSrWcPWN1TIXgCNvmWg/Cu2sLblPkCPJfzQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="C05f+AM/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 471B4F80071
	for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2026 14:27:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 471B4F80071
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=C05f+AM/
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-cc1ceadbd16so5189073a12.2
        for <alsa-devel@alsa-project.org>;
 Tue, 01 Sep 2026 05:27:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788265641; cv=none;
        d=google.com; s=arc-20260327;
        b=FNSDxIzCE/PDMMFJAq8ZZFXXzJZIHoeNoQ6t5LJ39IfwNpzDFO5KM9ovOvSrsFugz6
         q3hom5HLwef35NhpMJ4GhhacuS1C4kVU1P58t4W+ydBEv9akHq6ds+NmtR8kVHXi8sWV
         G7DiwdoXJ7VBK1p28xr0YCP02wGgz79ry5g38xVNIL0eDw8zqtX1WEasQo88nmoBRIYu
         g1w6Um238oU+oCCJrx/FAxi2HxrRbE4X8tDriFyxsMjfz5PFKbUzy/mKgEkAE7kZAtH3
         r9nFXp2HFtytHy3pyGvF2q2ATBD1bO8E2tyyBIK/M/64KTHWrxS5hb03Us018Bfp+lXn
         15Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=U8CKVv7KJVJ2cWRo1kZ8L5Npa0Ktlc3vHr2kjZ80qwA=;
        fh=yCDIHx1U61JIv6KiViJSyz/QAFYVbnik2O0jXSdY5Fw=;
        b=HtNfnrD3gzJp6bP3sNh5jq42Oi//CCPRpW0NmcQa5VpsgzT6D5OtbCnu+yPeo2sHlt
         +/2zSe5Dbhs716KbwXtgQ4kP3y0gK9cXMiKOHO2CbSzx2rjAgIQR+2EAW/65j/XMTi6g
         6f/OAEDojfeSASKx0bjZ5EbogF2nsnpDiVB8+ZwbKG7nmpi2vGYcW78d9sFLuF7CRjQ1
         YP7jBadBV2uZKuuMdr47jlwuwvcs6LD1I8S07fQH+t6pX2ql173moEtIUvQ7pjD+Y/ap
         Eoq7oCFwCFwEkRICcCha8/+/kUX/HpuI13HGWRAKoLdg8ttWxTyEaqWqKIG0r41nBCK+
         pK5w==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788265641; x=1788870441;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U8CKVv7KJVJ2cWRo1kZ8L5Npa0Ktlc3vHr2kjZ80qwA=;
        b=C05f+AM/DzItk+5+fnfgvJI9/U5ovU8iEt58fpd74fcthAssiyBiq7UEhEPNijh2qp
         q61f7vX031pW4WZVdDFiO/YiAKCk0BhVPLFjFCRiCUsZ0uBzgD3FY6FjQV3YgO32/rYm
         qNaJ0s0CaZlj6OxpuG0N91kF7dCaEnwnuTM/DtvTwVNPypgjQLNMo7wGJBSGvW19zRp2
         hBZGA6rpfy0J0xq/zRzsxGAoEEqjlVtkaFDjL93czvzhtgsxvk3IWoZYCdFNgau0ter5
         jDhfXac2+A6Gzo4j2SAnhq/p9XbZX8Fz9saFy9a4+o71by0XWDE/hqOFzRn3LSAoM02X
         768g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788265641; x=1788870441;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U8CKVv7KJVJ2cWRo1kZ8L5Npa0Ktlc3vHr2kjZ80qwA=;
        b=TUfBfeTNgMZGd/Vz1DYaLwcnxUTYq177bKb5chlQNaZKavJBqXGC4Ej1hu7U568Y6a
         GCCoTJ09e446X9icbir4OHnU/dhc91pgG3bg1D/MLZQQxbGs3HUIx2/pHEIm4pbADutj
         +nLI0IJ4fPPqUzsSIjRESP46121oLfunw0ZU1vJfyjouTf0jwfZ4lLETpXUFKPBuH55O
         VQanWPswM3KpeynNHwU64l5CxIct5HP9zmDdjhbt7toJ43Qq7H1jd9xtYSYhs8xtaM3N
         LcCuJjwrb/pV3GLBoGXAi7x1gY382JWn5fdHvN77vdoqOr5VhTjdM7uRSha4RTdoj90H
         Kqtw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2HVNhR/+h/CsSj3VQ4Kw7iST8qBh2qGLzRpdY/4iOOlc8+s36MoQzfLH153NCfrsDqvg4wmMvbv7I@alsa-project.org
X-Gm-Message-State: AFuF++nLGjJAH3/zKAYO/XcRVDjbHDbwN78OuK9vybfLWu1wrK4Ocu3T
	g3ChiYab/gig1NdIDF1iv7f+u1P/VchfMJPi3WMlWTt3dEfyzkBZaD69MngYqHatFnpTkxdYwTT
	mSaj0izmjrw6MXb0tHGk1WK5VZwTXAiQ=
X-Gm-Gg: AYBFou0rAe/VA2hx6vBctUBy4i4zBRhV65sKTRoVJvBHTcldNX0VjYPCj5LOHUVYqz+
	XfZxgWMmRodXmtiyveFVVv1iJzTC2Nkxtia/FiljrUjyQRcvY5NhlHqr/XYBuozzXKDx3C37ANv
	LijDRr6gQwdfm2Yoehp+oxbU7JsV2ZNtKXxUgxtuH476Rx13bmPE5TEZTrQeos8slcno/0E8WAg
	duox68vYOiQtr3Ba/eCpl6gIKzrMw9a4KzXHEjq+B/GfX+FLQD6GdcGZ17U5vWWBjlWEo9MAa4f
	MOx7R1e57gP0XRGmyKSyPC+DMYqJPnfRJVeN34gygjgZqhTaqZ6VLQJXQlla
X-Received: by 2002:a17:90b:2249:b0:398:cb56:e92 with SMTP id
 98e67ed59e1d1-398cb561618mr21594702a91.11.1788265640778; Tue, 01 Sep 2026
 05:27:20 -0700 (PDT)
MIME-Version: 1.0
From: Allen Abraham <allenabraham713@gmail.com>
Date: Tue, 1 Sep 2026 08:26:44 -0400
X-Gm-Features: AcwNN1WiHwXiDwCP6UyxUwUpFdRVsn1DTon447XPpEW_Doqq7sP-FKdO9oYtoSE
Message-ID: 
 <CACw2+N5x_DCXKj_k-iV8sQ=hcS7KxVyfRZsaR8PPx6qpRAFMug@mail.gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add mute LED quirk for HP Pavilion
 14-dv0xxx
To: "tiwai@suse.com" <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
X-MailFrom: allenabraham713@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: B3RYVZ5MYZIFKEL7MUJLP2KZI2UOQMH3
X-Message-ID-Hash: B3RYVZ5MYZIFKEL7MUJLP2KZI2UOQMH3
X-Mailman-Approved-At: Tue, 08 Sep 2026 18:35:12 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B3RYVZ5MYZIFKEL7MUJLP2KZI2UOQMH3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SFAgUGF2aWxpb24gMTQtZHYwMDU0dHUgKFBDSSBTU0lEIDEwM2M6ODdjOSkgd2l0aCBSZWFsdGVr
IEFMQzI4NyBjb2RlYw0KY29udHJvbHMgdGhlIG11dGUgTEVEIG9uIHRoZSBGNSBrZXkgdmlhIEdQ
SU8gNCAobWFzayAweDEwKS4NCkFkZCBhIHF1aXJrIGVudHJ5IHdpdGggQUxDMjg3X0ZJWFVQX0hQ
X0dQSU9fTEVEIHRvIGVuYWJsZSB0aGUgbXV0ZSBMRUQuDQoNClNpZ25lZC1vZmYtYnk6IEFsbGVu
IDxhbGxlbmFicmFoYW03MTNAZ21haWwuY29tPg0KLS0tDQogc291bmQvaGRhL2NvZGVjcy9yZWFs
dGVrL2FsYzI2OS5jIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRp
ZmYgLS1naXQgYS9zb3VuZC9oZGEvY29kZWNzL3JlYWx0ZWsvYWxjMjY5LmMNCmIvc291bmQvaGRh
L2NvZGVjcy9yZWFsdGVrL2FsYzI2OS5jDQppbmRleCBlNDM0OTc0Li40NmZlMTU2IDEwMDY0NA0K
LS0tIGEvc291bmQvaGRhL2NvZGVjcy9yZWFsdGVrL2FsYzI2OS5jDQorKysgYi9zb3VuZC9oZGEv
Y29kZWNzL3JlYWx0ZWsvYWxjMjY5LmMNCkBAIC03MzgyLDYgKzczODIsNyBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGhkYV9xdWlyayBhbGMyNjlfZml4dXBfdGJsW10gPSB7DQogIFNORF9QQ0lfUVVJ
UksoMHgxMDNjLCAweDg3ODgsICJIUCBPTUVOIDE1IiwgQUxDMjg1X0ZJWFVQX0hQX01VVEVfTEVE
KSwNCiAgU05EX1BDSV9RVUlSSygweDEwM2MsIDB4ODdiNywgIkhQIExhcHRvcCAxNC1mcTB4eHgi
LA0KQUxDMjM2X0ZJWFVQX0hQX01VVEVfTEVEX0NPRUZCSVQyKSwNCiAgU05EX1BDSV9RVUlSSygw
eDEwM2MsIDB4ODdjOCwgIkhQIiwgQUxDMjg3X0ZJWFVQX0hQX0dQSU9fTEVEKSwNCisgU05EX1BD
SV9RVUlSSygweDEwM2MsIDB4ODdjOSwgIkhQIFBhdmlsaW9uIDE0LWR2MHh4eCIsDQpBTEMyODdf
RklYVVBfSFBfR1BJT19MRUQpLA0KICBTTkRfUENJX1FVSVJLKDB4MTAzYywgMHg4N2NiLCAiSFAg
UGF2aWxpb24gMTUtZWcweHh4IiwNCkFMQzI4N19GSVhVUF9IUF9HUElPX0xFRCksDQogIFNORF9Q
Q0lfUVVJUksoMHgxMDNjLCAweDg3Y2MsICJIUCBQYXZpbGlvbiAxNS1lZzB4eHgiLA0KQUxDMjg3
X0ZJWFVQX0hQX0dQSU9fTEVEKSwNCiAgU05EX1BDSV9RVUlSSygweDEwM2MsIDB4ODdkMywgIkhQ
IExhcHRvcCAxNS1ndzB4eHgiLA0KQUxDMjM2X0ZJWFVQX0hQX01VVEVfTEVEX0NPRUZCSVQyKSwN
Ci0tIA0KMi41NS4wDQo=
