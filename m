Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE164EDB7D4
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:10:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A24B601F1;
	Tue,  7 Apr 2026 11:10:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A24B601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775553056;
	bh=aYLoEp3I2F9OSK0V6oliL9zeUrE5mMOqRJABj/uMPS0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=rQreCtQMNnX7Wi8MDzC0eY3lrDXFX/4a+vZfVCyoLQ7X0R5wNUrGaGOIUIigyGERH
	 TP8/ZAH0uO0EnYKqi448Rc2ngqIioc33a5jH/qYez8QzqAe1RUHX/FMFMIgL6mRj0y
	 xe55MsE7oEc7JGRqy5Y0S0c1T62uSAhd/b0KFxwE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8A541F8057F; Tue,  7 Apr 2026 11:10:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B04DF8057F;
	Tue,  7 Apr 2026 11:10:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 75F3CF8049C; Mon,  6 Apr 2026 11:44:46 +0200 (CEST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E2F68F8001F
	for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2026 11:44:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2F68F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Xxafreqn
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-50bbc41677dso57222341cf.0
        for <alsa-devel@alsa-project.org>;
 Mon, 06 Apr 2026 02:44:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775468682; cv=none;
        d=google.com; s=arc-20240605;
        b=FXVRSDidTkmBdeppaM2K64u6xYGePVWvPR+dA6ynXmHO0S4yZcpI5nxKu+ajtodE28
         zteotWzOD3Stk+YatgCnghZ4T7b6lPjeRAjVgTqvdazpP7fauMtyh7If4mgDcm3Y0gOd
         TxrVZFg1GBjI2IOJ2gqAOIIh2yyLdhFYF6r04aSRpHRNrjiQmicxtBIfaw0lFRpWalIN
         kY/Y2Q9CHSENw+NGC/V9ZxKsfUWC5WKpr7TGVaS557bLT7e3uXsYg9tLUeYWr8Wb4XTm
         WhDej+DRmZjH1OP1elcUzIafzsE/j/WYUR78JOlabFymyhsfRk4HdWIOg/F8tTqd0vZG
         Fa0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=dcNAPaw+n6T4AiydShoCdLPgf9+PXa+0QHB97QAjOEE=;
        fh=zK3GOoXS76erKJ6fDIHBFuvk60OuZ/PGAsBaY5iP8KM=;
        b=jWStBCFRD6CmvVC40lWC4pQTmKZRSRSoOTmahe2idQ45ol5RZ9igub5W87uccpzGzU
         l5perDf5wq0tXfbZ7D9PnDTxzwhTjhKHAlSx6hTmX437dXHVow9GtH/srFHOTdCRvsUE
         b5yHO0xFhs3ssGzgitp8QfTsMll677cDIJm4fbxYcAxjH5SFzYLKJDqVIqnvJ3iNXHGG
         GOGPCV8Z/HiuVEUsRJntkpXZpG1IUcilnqa2+QoAM2RprLeOHJvrs29Rnmnd0/hZWXL7
         F5RYTNXXTSZLccG946DKVNRicke9KVIj3eJRRP2ot2MqMrDRvFHfWXAGaUoNLyv4LUlp
         0YDg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775468682; x=1776073482;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dcNAPaw+n6T4AiydShoCdLPgf9+PXa+0QHB97QAjOEE=;
        b=XxafreqncklIHRZ+mzz1Tha4HheCOhCFv5elmWEB2rL4pjXPutFEil4d0vLSwUHmGX
         tXs1Di+MTKfKnhsFOodY4N+Exi7ZjrxvyFUA/+Xg3OdqiL+yofxq0is3R2N/drI/5GYu
         GvH2zf0FVQ336Oh5NWaCiIIhsz3M/Bl93E2/oIMODTacFg+eH+OU1G3XjNI2o3FP4OMa
         rlVIHeMfuXAIXVsW0rF7PhtIKwxG8+ZG+3uFsFgVggNzU5f2F/9HEPRskOqkBQN5up0Q
         q+2aQob2wF5u09XI3ZcJ5RBf3SbADdnsgEZDJeRj5pYQUCBmRR1ykWrQd6zbd12bo1ez
         BTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775468682; x=1776073482;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcNAPaw+n6T4AiydShoCdLPgf9+PXa+0QHB97QAjOEE=;
        b=oSBZWkAqCMulqCSh9iq3ucjc3GXoIPAYGHN2/7QONU9VLahqWxajjzTzHg8RggN5RG
         bWBZr+fqIhjg/vvxI1/vwzG1iJChDdXvJOOVIcQdN5loGskOz2gZiqtDQnAGp9VSWvsQ
         5OQ2eheWfUUKh1RYf5LH8rI+lRkeTUSqxq9mENTuqEHl3XCfIZeXJFgKuYBdyJJwlyOD
         B8ZUfGuw2KfuGvxAnUckRpF6VbYhfdNJz19yPyPr6V+YwpPyfBcQQKGNm/OJELNND/M1
         nad5ZbO1zKDztDR5hvhMFUw5oLfVXDIoFOqRMtTK3PIbQcyZ8TCjymcmCiB+GjdIqbvs
         nlnA==
X-Gm-Message-State: AOJu0Yy88ChgjP0q29jN3QN2yJrFLjQLlito+yGN0hTfu0Fu64s1IoX1
	OBpy4Q0VbhLI0AtxOX+OpYabmzYftl6zgiyrTSTRXj11sxlnZFHVnTyt76PVgWUiCrriz6/P/qR
	M1/hCJ8dUgqt/lvFgmfF32dSNu24v2DIo4q+BMCY=
X-Gm-Gg: AeBDiev4tib4zZhh5thSIU0pKIpVSp9iHcdC7/ewJyM+uHtMC8XfDZao9ghbF9kEjSy
	Ds/BHsaNlUD7yTr7op6LQ7V8nGjhswRkBskSxva7D4VmF/R3IsYHbLbBh4P6AMgQOI3jv5l8ew1
	jPkRJJtVB6b1J5Pl8UPpXOUlfY851vVicorQdX7VPjbv+35WmU28p13ZjUzbiilZqbsNHCSycoH
	FBRN9DPeQCp4IZYX4QSOcw7y7hBR8p3IeOXDj5hql9rWX/T+kjEdnWal56fLcvtx+e0oJTrF/DJ
	eZKL
X-Received: by 2002:ac8:5f47:0:b0:50d:81c4:4c83 with SMTP id
 d75a77b69052e-50d81c453a9mr101547551cf.41.1775468681918; Mon, 06 Apr 2026
 02:44:41 -0700 (PDT)
MIME-Version: 1.0
From: Marcin Krycki <m.krycki@gmail.com>
Date: Mon, 6 Apr 2026 10:44:30 +0100
X-Gm-Features: AQROBzDgw1unaDbLh8N2pZrC4uN1olI_lb7EkfSOEvKI5iTlse0-B2CwDqBbA9Y
Message-ID: 
 <CAEfRphPU_ABuVFzaHhspxgp2WAqi7kKNGo4yOOt0zeVFPSj8+Q@mail.gmail.com>
Subject: [BUG] ALSA: hda/realtek: SSID 1458:a194 is shared by different
 Gigabyte ALC897 front-panel layouts
To: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Cc: tiwai@suse.de
X-MailFrom: m.krycki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: N2RAPHMA2KNX7QXNZCEK7L5PUUMVPQ4J
X-Message-ID-Hash: N2RAPHMA2KNX7QXNZCEK7L5PUUMVPQ4J
X-Mailman-Approved-At: Tue, 07 Apr 2026 09:10:13 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N2RAPHMA2KNX7QXNZCEK7L5PUUMVPQ4J/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGksDQoNCkkgZm91bmQgYW4gaXNzdWUgd2l0aCB0aGUgcmVjZW50IEFMQzg5NyBxdWlyayBmb3Ig
c3Vic3lzdGVtIElEIDE0NTg6YTE5NDoNCg0KICBTTkRfUENJX1FVSVJLKDB4MTQ1OCwgMHhhMTk0
LCAiSDYxME0gSCBWMiBERFI0IiwNCiAgICAgICAgICAgICAgICBBTEM4OTdfRklYVVBfSDYxME1f
SFBfUElOKQ0KDQpNeSBzeXN0ZW06DQotIEJvYXJkOiBHaWdhYnl0ZSBCNTUwIEdBTUlORyBYIFYy
DQotIENvZGVjOiBSZWFsdGVrIEFMQzg5Nw0KLSBTdWJzeXN0ZW0gSUQ6IDE0NTg6YTE5NA0KDQpT
byBteSBib2FyZCB1c2VzIHRoZSBzYW1lIHN1YnN5c3RlbSBJRCBhcyB0aGUgb25lIG1hdGNoZWQg
YnkgdGhlIHF1aXJrDQphYm92ZS4NCg0KT24gbXkgYm9hcmQgdGhpcyBxdWlyayBpcyBpbmNvcnJl
Y3Q6DQppdCBmb3JjZXMgcGluIDB4MTkgdG8gSFAgb3V0LCBidXQgb24gdGhpcyBib2FyZCAweDE5
IGlzIHRoZSBmcm9udCBtaWNyb3Bob25lDQpwaW4gYW5kIGhlYWRwaG9uZXMgYXJlIGNvbm5lY3Rl
ZCB0byAweDFiLg0KDQpXaXRoIHRoZSBxdWlyayBhcHBsaWVkOg0KLSBmcm9udCBtaWNyb3Bob25l
IGlzIGRldGVjdGVkIGFzIGhlYWRwaG9uZQ0KLSBmcm9udCBtaWNyb3Bob25lIGRvZXMgbm90IHdv
cmsNCi0gcGx1Z2dpbmcgb25seSB0aGUgbWljcm9waG9uZSBtdXRlcyBzcGVha2VycyBhcyBpZiBo
ZWFkcGhvbmVzIHdlcmUgcHJlc2VudA0KDQpBZnRlciByZW1vdmluZyB0aGUgcXVpcmsgbWF0Y2gg
Zm9yIDE0NTg6YTE5NCwgZnJvbnQgcGFuZWwgYmVoYXZpb3IgaXMNCmNvcnJlY3Q6DQotIG1pYyBv
bmx5OiB3b3Jrcw0KLSBocCBvbmx5OiB3b3Jrcw0KLSBtaWMgKyBocDogd29ya3MNCi0gbWljIG9u
bHkgd2l0aCBocCB1bnBsdWdnZWQ6IHNwZWFrZXJzIHJlbWFpbiBhY3RpdmUNCg0KVGhpcyBzdWdn
ZXN0cyB0aGF0IHN1YnN5c3RlbSBJRCAxNDU4OmExOTQgaXMgc2hhcmVkIGJ5IGF0IGxlYXN0IHR3
bw0KZGlmZmVyZW50DQpHaWdhYnl0ZSBib2FyZHMgd2l0aCBkaWZmZXJlbnQgZnJvbnQtcGFuZWwg
QUxDODk3IGxheW91dHMsIHNvIG1hdGNoaW5nIHRoaXMNCnF1aXJrIG9ubHkgYnkgU1NJRCBpcyB0
b28gYnJvYWQuDQoNCkkgYW0gbm90IHNlbmRpbmcgYSBwYXRjaCBiZWNhdXNlIHRoZSBxdWlyayBt
YXkgc3RpbGwgYmUgY29ycmVjdCBmb3IgdGhlDQpINjEwTQ0KYm9hcmQgaXQgd2FzIGFkZGVkIGZv
ci4gQnV0IHRoZSBjdXJyZW50IFNTSUQtYmFzZWQgbWF0Y2ggY2F1c2VzIHJlZ3Jlc3Npb24NCm9u
DQpHaWdhYnl0ZSBCNTUwIEdBTUlORyBYIFYyLg0KDQpSZWxldmFudCBjb2RlYyBkdW1wOg0KDQo9
PT0gTm9kZSAweDE5ID09PQ0KTm9kZSAweDE5IFtQaW4gQ29tcGxleF0gd2NhcHMgMHg0MDA1OGY6
IFN0ZXJlbyBBbXAtSW4gQW1wLU91dA0KICBDb250cm9sOiBuYW1lPSJGcm9udCBNaWMgQm9vc3Qg
Vm9sdW1lIiwgaW5kZXg9MCwgZGV2aWNlPTANCiAgICBDb250cm9sQW1wOiBjaHM9MywgZGlyPUlu
LCBpZHg9MCwgb2ZzPTANCiAgQW1wLUluIGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMywgc3Rl
cHNpemU9MHgyNywgbXV0ZT0wDQogIEFtcC1JbiB2YWxzOiAgWzB4MDEgMHgwMV0NCiAgQW1wLU91
dCBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4MDAsIHN0ZXBzaXplPTB4MDAsIG11dGU9MQ0KICBB
bXAtT3V0IHZhbHM6ICBbMHg4MCAweDgwXQ0KICBQaW5jYXAgMHgwMDAwMzczZTogSU4gT1VUIEhQ
IERldGVjdCBUcmlnZ2VyDQogICAgVnJlZiBjYXBzOiBISVogNTAgR1JEIDgwIDEwMA0KICBQaW4g
RGVmYXVsdCAweDAyYTE5MDQwOiBbSmFja10gTWljIGF0IEV4dCBGcm9udA0KICAgIENvbm4gPSAx
LzgsIENvbG9yID0gUGluaw0KICAgIERlZkFzc29jaWF0aW9uID0gMHg0LCBTZXF1ZW5jZSA9IDB4
MA0KICBQaW4tY3RsczogMHgyNDogSU4gVlJFRl84MA0KICBVbnNvbGljaXRlZDogdGFnPTAzLCBl
bmFibGVkPTENCiAgUG93ZXIgc3RhdGVzOiAgRDAgRDEgRDIgRDMgRVBTUw0KICBQb3dlcjogc2V0
dGluZz1EMCwgYWN0dWFsPUQwDQogIENvbm5lY3Rpb246IDUNCiAgICAgMHgwYyogMHgwZCAweDBl
IDB4MGYgMHgyNg0KDQo9PT0gTm9kZSAweDFiID09PQ0KTm9kZSAweDFiIFtQaW4gQ29tcGxleF0g
d2NhcHMgMHg0MDA1OGY6IFN0ZXJlbyBBbXAtSW4gQW1wLU91dA0KICBDb250cm9sOiBuYW1lPSJI
ZWFkcGhvbmUgUGxheWJhY2sgU3dpdGNoIiwgaW5kZXg9MCwgZGV2aWNlPTANCiAgICBDb250cm9s
QW1wOiBjaHM9MywgZGlyPU91dCwgaWR4PTAsIG9mcz0wDQogIEFtcC1JbiBjYXBzOiBvZnM9MHgw
MCwgbnN0ZXBzPTB4MDMsIHN0ZXBzaXplPTB4MjcsIG11dGU9MA0KICBBbXAtSW4gdmFsczogIFsw
eDAwIDB4MDBdDQogIEFtcC1PdXQgY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6
ZT0weDAwLCBtdXRlPTENCiAgQW1wLU91dCB2YWxzOiAgWzB4MDAgMHgwMF0NCiAgUGluY2FwIDB4
MDAwMTM3M2U6IElOIE9VVCBIUCBFQVBEIERldGVjdCBUcmlnZ2VyDQogICAgVnJlZiBjYXBzOiBI
SVogNTAgR1JEIDgwIDEwMA0KICBFQVBEIDB4MjogRUFQRA0KICBQaW4gRGVmYXVsdCAweDAyMjE0
MDIwOiBbSmFja10gSFAgT3V0IGF0IEV4dCBGcm9udA0KICAgIENvbm4gPSAxLzgsIENvbG9yID0g
R3JlZW4NCiAgICBEZWZBc3NvY2lhdGlvbiA9IDB4MiwgU2VxdWVuY2UgPSAweDANCiAgUGluLWN0
bHM6IDB4YzA6IE9VVCBIUCBWUkVGX0hJWg0KICBVbnNvbGljaXRlZDogdGFnPTAxLCBlbmFibGVk
PTENCiAgUG93ZXIgc3RhdGVzOiAgRDAgRDEgRDIgRDMgRVBTUw0KICBQb3dlcjogc2V0dGluZz1E
MCwgYWN0dWFsPUQwDQogIENvbm5lY3Rpb246IDUNCiAgICAgMHgwYyAweDBkIDB4MGUgMHgwZiog
MHgyNg0KDQpSZWdhcmRzLA0KTWFyY2luIEtyeWNraQ0KbS5rcnlja2lAZ21haWwuY29tDQo=
