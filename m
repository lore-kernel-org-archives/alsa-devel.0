Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0309ECD6E4A
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jun 2026 13:31:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A89C6022C;
	Tue,  2 Jun 2026 15:31:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A89C6022C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780407106;
	bh=PaEacdS+UZE7hTgTP1+AhRTrVoakllBxlrZ1rYcpANI=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=dWgCO4gAHN/HmtXIeNTdSTsp8WjxxRux4hNcqY9GkWdJT8ILH+F2HnDA8tveKvR5b
	 x70J8F3sHI8tKzg8rfTe+69kKVvbzltlHt1dr7Z/0PlqzEEZrSAtqRDezl98Epqugg
	 m0cFqDc30IL141dzXrs/P+Mg82+fbElJcNkUbYR4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 056F3F805F3; Tue,  2 Jun 2026 15:31:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DF84DF805FE;
	Tue,  2 Jun 2026 15:31:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0868FF804F2; Tue,  2 Jun 2026 13:32:57 +0200 (CEST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 35436F800B0
	for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2026 13:32:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35436F800B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=X0E7Flyg
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-bed4cc46252so323445766b.3
        for <alsa-devel@alsa-project.org>;
 Tue, 02 Jun 2026 04:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780399974; cv=none;
        d=google.com; s=arc-20240605;
        b=SJdDVuarTHvQt32x33toLftt8rfdW68mHM+9X4/jea/48sEV4dFPcckOikMSQ6vTeS
         KuLi5iTLyQyVlDq49XXhLqyqmjWOBja3rswFya7huCj2ZgoixYd+EOySnG1/iEkvNHoS
         yE9BuFASgdlqBrwWBltI6IVlD5WXz8hnV2TGxc11NjZ9I0obiIOMNb95i/9BL+QwNoyO
         cqgRY/zILGa+h5YVy0QzSziUvgo5kg85hlDxKiJDbcobw7zq4r5b9y8oFNmL3Hm24H6P
         xYSTO/DLf/GM770xOVcwgofL91mN6ybSac1Xttcjxb/20od3Tb0J67xuuFgn79wOsLhm
         dQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=u6FAaY7m9xjzcaqn44Yg0ZxI1+GTZFaXI74TfHPgyM8=;
        fh=6Jb5EblTJCQp0KCxZUQreraaePn84/xcH2tj1h2SfR8=;
        b=MwxW4Ss8sygRBgbMYL4mnydirfVmQsJ2eOBurXXxDNGw54ewrNYijUel6Y5+5mITcg
         A/j5Ql0QaFdk75PDFRD8zS+tojxOom8wulxFg7dOQxTrnQ2EhWYn8yZ/nm1ri0pmhq+O
         XRGZQEq3EpWlQgXwDmsXrWV8H2SL0priVoYfBNvGL8mnp9EqR+TDoRZkFpdS9h3r14sQ
         0WUHyDBKeL7oplAWkXmTCZJ4EpFm0Ckv5R1ivlAvdsUF/espqHS6EV33wXqJSmR4xTrH
         y3SQq14JE6OD/vQ1NwvCQs9UvGn+HhD44/y2xS6QREa+H6YvugDaYDvTVpzm2bXHS4cg
         +hQg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780399974; x=1781004774;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u6FAaY7m9xjzcaqn44Yg0ZxI1+GTZFaXI74TfHPgyM8=;
        b=X0E7Flygztsp1mclube2wbEedYBKhCjOqZ4jQTFpDHs8P3TEyA9myLuN2Rsu226bX8
         jQNzmPkpMp+B/56pklLtO+CCNeA0N7c0t1dRDhbAQJHta8TPl+IhOkKLqMASPuxaWnZt
         zdKrRqOGVfa2CTY65H0KhsIijD6VsZcbVPAaq6a6fRslgQR0GVCrcs/QjaplJGdWO+b8
         dwzMYbGPfINwidJ1P/16iI2WSFQiQgNgz8xeRHZAkLrnmZnXlS9burCoFNtxKXLw6S1h
         /0ckw2Svycnguz3WY1HUHiiXGMZAR7of9OBt5sYU79cM8BbqTo+P1IpcRNmPJvdFmKxM
         Kiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780399974; x=1781004774;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6FAaY7m9xjzcaqn44Yg0ZxI1+GTZFaXI74TfHPgyM8=;
        b=fWE5Hecp+fzEPHJ+E2+KEqoP2h3AN+BxerDL86azgXYjQFFpk2X0A4oRx7K4GeTtSh
         POIUR35ugJJk7ITlIb/25zD3yJNxREn+tO6RvjPLyAFMUP2yMu0+26vkirfuWrK4pm1k
         D3y5I6uPIHebK39JSabMcnrghBCX+6sjtkJgOFaAKyLu7oXiTagM9SOWdmqDErZ4JKUT
         6Nf3MoAYzp5GzRdOJDTXnXPvcraXV60N8REVnTNPzgUC6gruQyDcgcsqVqwzxdMaYEYR
         7am073CmWwC9ExEiMicBTm2s9EZrWdsliD9rce7VqNlTvDcEybByWlLhMlQ2qxMUw4Pp
         kgPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gx7OPk4WsO2H+7/oKa+e1kkZyWDDpEAT2xrgNSDwdFBp5gY1HNxd6i9MS5HXqrIytlAqJWDK+vzvh@alsa-project.org
X-Gm-Message-State: AOJu0YyK0IOnKgG4xP0agKlMlvki7zSe/cpDV8/WMbVbyCiHRMv15X4c
	jZa46FrY2LBP+uUGVuP3ijgsnpw2fEyPmcwKNgHXGq/XReWB3528YqW1wY36mjDNl8qdSS/2c1g
	3epqa0qxL8GUhisrET205KXXbb5jNE7w=
X-Gm-Gg: Acq92OE4dCnNWUIzjMRJbxYtmZ1i4WgVhZQk3gzI2OOBodWQR0UY/BC0AqJ1MshF8WE
	X6ZFQObzPOQheB0LKqmIGRr8AXTkvxi/NxflLpWZMOv+KkElIzD1ZiDITuAZJWKuIxtS2rub6Dg
	cCh1WkRtL/5zOswYMvC4BVWGUVjraf6wN4l+w+ym2aYMAPUWPwgxHkjp7b1Fl0aBi8VAw0RDfnD
	+91l1QMNN6ArRz5Pb1QXhIZPvX7v+z0tul3+IwhOd7WYyCHLqnGqPSElLcyXWpj0xElRZQn6u9N
	GJx3P+aFLy8IX7EV8q9KdMGyBDhcbyVJ0oZ2sgFQ+uMYCg/Uc3kf
X-Received: by 2002:a17:907:9484:b0:bee:215e:546e with SMTP id
 a640c23a62f3a-bee215eac1amr453973166b.1.1780399973937; Tue, 02 Jun 2026
 04:32:53 -0700 (PDT)
MIME-Version: 1.0
From: Cliff Brady <brady725@gmail.com>
Date: Tue, 2 Jun 2026 06:32:42 -0500
X-Gm-Features: AVHnY4IzJUvFhOxY-g_8cvGa0a-x4J85M1YS1_kYc0SgTWu0UoRdX4EFuPyn80M
Message-ID: 
 <CAFGAnONFP+=y3p2VQ_ciZzX_d=wjKP0jZf-JfVK1p1_EAz2ZXA@mail.gmail.com>
Subject: Creative X-Fi hw20k2 (SB0880) that appeared in kernel 6.12.85
To: tiwai@suse.de, linux@hohmatik.de, alsa-devel@alsa-project.org
X-MailFrom: brady725@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 7DH4GUVEHDEQPYEI2B6VJABXTPQ5DBRZ
X-Message-ID-Hash: 7DH4GUVEHDEQPYEI2B6VJABXTPQ5DBRZ
X-Mailman-Approved-At: Tue, 02 Jun 2026 13:31:03 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7DH4GUVEHDEQPYEI2B6VJABXTPQ5DBRZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGkgVGFrYXNoaSwNCg0KSSdtIHdyaXRpbmcgdG8gcmVwb3J0IGEgcmVncmVzc2lvbiBvbiB0aGUg
Q3JlYXRpdmUgWC1GaSBodzIwazIgKFNCMDg4MCkNCnRoYXQgYXBwZWFyZWQgaW4ga2VybmVsIDYu
MTIuODUsIGFuZCB3aGljaCBJIGJlbGlldmUgaXMgcmVsYXRlZCB0byBjb21taXQNCmIwNDVhYjNk
ZmY5NyAoIkFMU0E6IGN0eGZpOiBGaXggbWlzc2luZyBTUERJRkkxIGluZGV4IGhhbmRsaW5nIiku
DQoNCkhhcmR3YXJlOg0KICBDYXJkOiBDcmVhdGl2ZSBYLUZpIDIwSzIsIG1vZGVsIFNCMDg4MCAo
UENJIElEIDExMDI6MDAwYikNCiAgRHJpdmVyOiBzbmRfY3R4ZmkNCiAgS2VybmVsOiA2LjEyLjg1
IChIb21lIEFzc2lzdGFudCBPUyAxNy4zLCBnZW5lcmljIHg4Ni02NCkNCg0KU3ltcHRvbToNCkFm
dGVyIHVwZ3JhZGluZyBmcm9tIEhBT1MgMTcuMiAoa2VybmVsIDYuMTIuNzcpIHRvIEhBT1MgMTcu
MyAoa2VybmVsDQo2LjEyLjg1KSwgdGhlIFgtRmkgYW5hbG9nIG91dHB1dHMgcHJvZHVjZSBubyBh
dWRpbyB3aGVuIGFjY2Vzc2VkIHZpYQ0KUHVsc2VBdWRpby4gIEhBT1MgMTcuMSAoa2VybmVsIDYu
MTIuNjcpIFgtRmkgYW5hbG9nIG91dHB1dHMNCmFsc28gIHN1Y2Nlc3NmdWxseSBwcm9kdWNlZCBh
dWRpbyB3aGVuIGFjY2Vzc2VkIHZpYSBQdWxzZUF1ZGlvICBUaGUgUEEgc2luaw0KcmVwb3J0cyBS
VU5OSU5HIGFuZCBhbGwgQUxTQSBtaXhlciBjb250cm9scyBhcmUgYXQgZnVsbCB2b2x1bWUgYW5k
IHVubXV0ZWQsDQpidXQgbm8gYXVkaW8gaXMgaGVhcmQgZnJvbSBhbnkgYW5hbG9nIG91dHB1dCBj
aGFubmVsIChmcm9udCwgcmVhciwgc2lkZSwNCmNlbnRlci9MRkUpLg0KDQpEaWFnbm9zaXM6DQpQ
QSBvcGVucyB0aGUgZGV2aWNlIHdpdGggZGV2aWNlLmFjY2Vzc19tb2RlID0gIm1tYXArdGltZXIi
LiBEaXJlY3QgQUxTQQ0KYWNjZXNzIHZpYSBzcGVha2VyLXRlc3QgYnlwYXNzaW5nIFBBIHByb2R1
Y2VzIGF1ZGlvIGNvcnJlY3RseSBvbiBhbGwNCmNoYW5uZWxzLiBGb3JjaW5nIFBBIHRvIGNsb3Nl
IGFuZCByZW9wZW4gdGhlIFBDTSBkZXZpY2UgdmlhIHBhY3RsDQpzdXNwZW5kLXNpbmsgLyByZXN1
bWUtc2luayByZXN0b3JlcyBhdWRpbywgc3VnZ2VzdGluZyB0aGUgbW1hcCBidWZmZXINCmhhbmRz
aGFrZSBiZXR3ZWVuIFBBIGFuZCB0aGUgY3R4ZmkgZHJpdmVyIGlzIGZhaWxpbmcgc2lsZW50bHkg
b24gZGV2aWNlDQpvcGVuLg0KDQpUaGUgaXNzdWUgaXMgcmVwcm9kdWNpYmxlIGV2ZXJ5IHRpbWUg
UEEgb3BlbnMgdGhlIGRldmljZSBmcmVzaCAoZS5nLiBhZnRlcg0KcGEgcmVzdGFydCBvciBzaW5r
IHJlc3VtZSBmcm9tIHN1c3BlbmRlZCBzdGF0ZSBmb2xsb3dpbmcgaWRsZSB0aW1lb3V0KS4gVGhl
DQpzdXNwZW5kL3Jlc3VtZSB3b3JrYXJvdW5kIHJlbGlhYmx5IHJlc3RvcmVzIGF1ZGlvIGVhY2gg
dGltZS4NCg0KSHlwb3RoZXNpczoNClRoZSBvdXQtb2YtYm91bmRzIGFycmF5IGFjY2VzcyBmaXhl
ZCBieSBjb21taXQgYjA0NWFiM2RmZjk3IGluDQpkYWlvX2RldmljZV9pbmRleCgpIGZvciBodzIw
azIgbWF5IGhhdmUgYmVlbiBpbmFkdmVydGVudGx5IG1hc2tpbmcgYQ0KcHJlLWV4aXN0aW5nIGRl
ZmljaWVuY3kgaW4gdGhlIGN0eGZpIG1tYXAgaW1wbGVtZW50YXRpb24uIFdpdGggdGhlIGZpeCBp
bg0KcGxhY2UsIG1tYXArdGltZXIgbW9kZSBpcyBuZWdvdGlhdGVkIHN1Y2Nlc3NmdWxseSBhdCB0
aGUgUEEva2VybmVsDQppbnRlcmZhY2UgYnV0IGF1ZGlvIHRyYW5zZmVycyBzaWxlbnRseSBmYWls
LiBBIHBvc3NpYmxlIGZpeCB3b3VsZCBiZSB0byBzZXQNClNORFJWX1BDTV9JTkZPX05PX01NQVAg
aW4gdGhlIGh3MjBrMiBQQ00gY2FwYWJpbGl0aWVzLCBmb3JjaW5nIFBBIHRvIGZhbGwNCmJhY2sg
dG8gcmVhZC93cml0ZSBtb2RlIHdoaWNoIHdvcmtzIGNvcnJlY3RseS4NCg0KS2VybmVsIHdhcyB3
b3JraW5nOiA2LjEyLjc3DQpLZXJuZWwgcmVncmVzc2lvbiBpbnRyb2R1Y2VkOiA2LjEyLjg1DQoN
CkkgYW0gaGFwcHkgdG8gdGVzdCBhbnkgcGF0Y2ggb3IgcHJvdmlkZSBmdXJ0aGVyIGRpYWdub3N0
aWNzLg0KDQpCZXN0IHJlZ2FyZHMNCg0KQ2xpZmYgQnJhZHkNCg==
