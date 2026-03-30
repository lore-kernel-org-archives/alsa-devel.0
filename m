Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4C1D35163
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:48:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4AFA9601DD;
	Wed,  1 Apr 2026 11:48:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4AFA9601DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775036913;
	bh=rkqf9Jx971aiNbPT7v8V+qqa8qLtnSefs3NuNyOK92Q=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=AeCyGv4K3TG9n0+LxdRF5qH6tYlDT/4wNYvY6ia28qnCI5upWxxPXrWKyIeh+2l74
	 I2SE02bTaexmQlRgPMXlPMbVL71bB941lLreHgLjG5SxvtRDkD6v27+4g+56yHrtZ+
	 AETjb2tLogJRsLg1fo2MRg6e+VB35HdpHgHddNAk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7507BF805EF; Wed,  1 Apr 2026 11:47:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F81AF805F3;
	Wed,  1 Apr 2026 11:47:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 46BEEF805E2; Mon, 30 Mar 2026 10:11:43 +0200 (CEST)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 47277F8027B
	for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2026 10:11:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47277F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=glUfpfRx
Received: by mail-ot1-f46.google.com with SMTP id
 46e09a7af769-7d1872504cbso4111864a34.0
        for <alsa-devel@alsa-project.org>;
 Mon, 30 Mar 2026 01:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774858291; cv=none;
        d=google.com; s=arc-20240605;
        b=fzTutu3ttPjf6u88dP9nZJixlpUYDyE2eATU7/TeLWkxYSDtgmj+DULVI7vpGblILU
         ouXkcjikGG7zDbAlhFOMHHD3rJs/wJRWqRC+wG+K/cjJS1m0l/OMW4/YKvDPah00LmOv
         +7edpY/TR5XLck4uiaZ0/x+CetmEINg5UCepUP+WO8Jd/ScYV5c9EOP7SDr+OhlvjPQS
         3qg0wUUQAdNpOwtH2qjqjCJ/M6GuFxwcpdxuptQlqOJA9A51nHTxvlfm/G+gDuBCvKB5
         bmEcIiBvfeteNlc4JaLw1KKoHPQetJDgg75cHGf2F0Jao7DAM3S4ttZ38IXPxHhF1M4c
         Phww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=9TA0lcQ33vTFG266puXfbv5fD2JexnmS2+exiklJvSc=;
        fh=oRoccz0oVvJhemgmWN+IP2Bi1QJUdh52KSJ0uqPpbZw=;
        b=loMgH7iIWOVLf78kM/9pC0Ak2HIMaTw77niEJ4lRvUv+LI1vo3M/E/Rh8GJpHwr+pN
         7MZtk4vmghTQBMOPZoVj2f2NTEYGvRN3GwtULd0vcMTOe+sL0E3/bt9r5NEioSmDsj6O
         khb5AXLqw2EIh+OArx4rh4AyL12MXesCIVk7Lr9Bv3+5FTQPTRx4BoPKMVNRrlOWVxRX
         JNGEYbAtsNHpCKha7pBR+xwLsYL1r8xjWrWj0XqynHTHNUX23O9flxBBkA40/LbTWFVp
         8uI1/194JVV/c6e8aaovC2/wA/C3la9X13M9m5T3TSM8/YdHsFBzm5QngyDNMNvDo8yw
         kPvg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774858291; x=1775463091;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9TA0lcQ33vTFG266puXfbv5fD2JexnmS2+exiklJvSc=;
        b=glUfpfRxd/Z5tImXOX72NPQP5mnLZNG947FvXoodMhql5ICZ6GW72ZGEOR1F9NQPXF
         E9WcWwLKQxg5q5JWgteDJX8m8GBM+YUYKrt+bp6LAPFyvNZB0yt+EFKIhbV3ORfXeDkX
         Hw4WfWdXqu0UHtzTZ10pSvyiFIoaC1WCQDk4n/HTR4AnrQUndXfWBiMB05LS32zRl/fc
         CEXroZp2ymdXCl2eMV/K+9hM33Xu1C3J2QqNI4U/cea2W/rxzLhvDgT121mfdlZwuAYZ
         BL7v1Kr7nTZwUk6BgA3SoAhf5evMXfejaUbv1v6aIy1RCinECxPJE0AutgbaNUkJ8Oxl
         fi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774858291; x=1775463091;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9TA0lcQ33vTFG266puXfbv5fD2JexnmS2+exiklJvSc=;
        b=aS0cvmETxqSSMiu7oXU/FtDU8I754TxT3qtkrkJcSLTuzHu9jnCiJTVPCAuZLzbm8Q
         GDeZbNzkxNq69OeJdGTnLKHOx5Cm0CAlxwtOOFNs4oM6/v8QNw/JOZ7y3Y0+AljKMMS0
         5Ft9g1ppfuh1MqeNjDrFs4go5Asauu9T8tnpcsTulpl7PNfQmlsSp2fgAlhMw7kPFOMv
         W3ZlLAAp0tpJVgL/A2Hc2oFXbAVOklRCtvwh6qqftD3u1MdT5U0K2IHQS8CgLI5PPnPJ
         JkVu9UWQTCnFAxL2KRrmOv7fZsYnMrLdjpIgPYSyds1ERiGjtEBRqEUgMaxN4Ik47Ui6
         Khrg==
X-Gm-Message-State: AOJu0YzgyzfPeCb9d2N/jp7f6mz3TPDmTOyf6yw4VSMOJQQ5ammya76O
	tJ5v3PsWH8Uu+boyQ3zCPrZ93/S8yfDFqb9P1Iuj/lHA6ZQFUVo80MB4VAESHDS5DrhFbeEnyKr
	yAicV5xE/VYBXTXFa2AFyUBmDjvg6Kxc=
X-Gm-Gg: ATEYQzyuwOcwCBY6bONLglOnP2hqPb0QmZU9ZqK570KVEFByIclKsVjRQ9DCtzDOxTk
	KSga439ocguFsWu8MQL0ax60N79VFnVp51GBf3vqJXX6iZvmji2elKTA9VhSAuZRiq4n46hsuBW
	25Ag0xk9RVitBunLsWlMLOsL/7GgXN5FKLSSVhAT169N4ZlLlZur3ZSkDHhVaw7nGc6Bv+dwbEI
	4U4unC44IOlUEp92rEsRdkXCWngsvXH1zSYNqTgIR7AZbp+yetTC9bxE3ZVlqeKpsPirq7VxPuy
	SBO4BOs58wo9/G9cj7lKe1zKJDSnDb7Rzlfi7Osd
X-Received: by 2002:a4a:e9e7:0:b0:67e:1739:a32e with SMTP id
 006d021491bc7-67e1739a666mr5264226eaf.2.1774858291245; Mon, 30 Mar 2026
 01:11:31 -0700 (PDT)
MIME-Version: 1.0
From: BALAVENKATESH S <vashbala@gmail.com>
Date: Mon, 30 Mar 2026 13:41:20 +0530
X-Gm-Features: AQROBzBrE7F4HEDb6JgmjMkwRssFh6zRDRtbqaOQ5cZ3w5_yv-Xq7x3AgymQbss
Message-ID: 
 <CAFgaNEPuZYe1+QXMAvQPjS5zboiO_LX5RrtOj2Cc_UK0OOPfbQ@mail.gmail.com>
Subject: [BUG] Crackling/distorted internal speakers on ASUS C-Media USB audio
 (0b05:6205) / snd_usb_audio
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org
X-MailFrom: vashbala@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: FSUTEIK2Q54I3WXRDM3CHHENQBBJT7P3
X-Message-ID-Hash: FSUTEIK2Q54I3WXRDM3CHHENQBBJT7P3
X-Mailman-Approved-At: Wed, 01 Apr 2026 09:47:51 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FSUTEIK2Q54I3WXRDM3CHHENQBBJT7P3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGkgQUxTQSBkZXZlbG9wZXJzLA0KDQpJIGFtIHJlcG9ydGluZyBhIHBlcnNpc3RlbnQgY3JhY2ts
aW5nL2Rpc3RvcnRpb24gaXNzdWUgb24gYW4gQVNVUyBsYXB0b3DigJlzDQppbnRlcm5hbCBzcGVh
a2VycyB1bmRlciBMaW51eC4NCg0KSGFyZHdhcmUgLyBkcml2ZXINCg0KTGFwdG9wIG1vZGVsOiBb
aW5zZXJ0IGV4YWN0IEFTVVMgbW9kZWxdDQpVU0IgYXVkaW8gZGV2aWNlOiBBU1VTVGVrIEMtTWVk
aWEoUikgQXVkaW8sIFVTQiBJRCAwYjA1OjYyMDUNCkRyaXZlcjogc25kX3VzYl9hdWRpbw0KS2Vy
bmVsIHRlc3RlZDogNi4xOS45LWFyY2gxLTEsIGFsc28gdGVzdGVkIGxpbnV4LWx0cyA2LjE4LjE5
LTENClVzdWFsIHVzZXJzcGFjZSBzdGFjazogUGlwZVdpcmUgLyBwaXBld2lyZS1wdWxzZSAvIFdp
cmVQbHVtYmVyDQoNClN5bXB0b21zDQoNCkludGVybmFsIHNwZWFrZXJzIGNyYWNrbGUvZGlzdG9y
dCBkdXJpbmcgcGxheWJhY2suDQpUaGUgcmlnaHQgY2hhbm5lbCBpcyB3b3JzZSB0aGFuIHRoZSBs
ZWZ0Lg0KQmx1ZXRvb3RoIGFuZCBleHRlcm5hbCBhdWRpbyBkZXZpY2VzIHNvdW5kIGZpbmUuDQpB
dWRpbyBvbiBXaW5kb3dzIG9uIHRoZSBzYW1lIGxhcHRvcCBzcGVha2VycyBpcyBmaW5lLg0KDQpX
aGF0IEkgdmVyaWZpZWQNCg0KT24gTGludXgsIHRoZSBhY3RpdmUgb3V0cHV0IGRldmljZSBpcyB0
aGUgQVNVUyBDLU1lZGlhIFVTQiBhdWRpbyBwYXRoLCBub3QNCnRoZSBJbnRlbCBIREEgYW5hbG9n
IHBhdGguDQpUaGUgaXNzdWUgcmVwcm9kdWNlcyBvdXRzaWRlIHRoZSBicm93c2VyIGFuZCBvdXRz
aWRlIFBpcGVXaXJlLg0KSSByZXByb2R1Y2VkIGl0IHdpdGggZGlyZWN0IEFMU0EgdXNpbmcgc3Bl
YWtlci10ZXN0IG9uIGh3OjAsMC4NCkkgdGVzdGVkIGJvdGggNDQuMSBrSHogYW5kIDQ4IGtIeiwg
YW5kIGJvdGggUzE2X0xFIGFuZCBTMjRfM0xFLg0KVGhlIGlzc3VlIHJlbWFpbmVkIHByZXNlbnQg
YWNyb3NzIHRob3NlIGNvbWJpbmF0aW9ucy4NCkxvd2VyaW5nIGdhaW4gbWFrZXMgaXQgbGVzcyBu
b3RpY2VhYmxlLCBidXQgaXQgZG9lcyBub3QgZnVsbHkgZWxpbWluYXRlIHRoZQ0KcmlnaHQtY2hh
bm5lbCBkaXN0b3J0aW9uLg0KDQpVc2VmdWwgcmVwcm9kdWN0aW9uIGRldGFpbHMNCg0KRGlyZWN0
IEFMU0EgZXhhbXBsZXMgdXNlZDoNCnNwZWFrZXItdGVzdCAtRCBodzowLDAgLWMgMiAtciA0ODAw
MCAtRiBTMTZfTEUgLXQgc2luZSAtcyAyDQpzcGVha2VyLXRlc3QgLUQgaHc6MCwwIC1jIDIgLXIg
NDQxMDAgLUYgUzE2X0xFIC10IHNpbmUgLXMgMg0Kc3BlYWtlci10ZXN0IC1EIGh3OjAsMCAtYyAy
IC1yIDQ4MDAwIC1GIFMyNF8zTEUgLXQgc2luZSAtcyAyDQpzcGVha2VyLXRlc3QgLUQgaHc6MCww
IC1jIDIgLXIgNDQxMDAgLUYgUzI0XzNMRSAtdCBzaW5lIC1zIDINCg0KQWRkaXRpb25hbCBub3Rl
cw0KDQpJIGFsc28gdGVzdGVkIHNuZF91c2JfYXVkaW8gbG93bGF0ZW5jeT0wLCBidXQgaXQgZGlk
IG5vdCBoZWxwLg0KU2luY2UgdGhlIHByb2JsZW0gcmVwcm9kdWNlcyB3aXRoIGRpcmVjdCBBTFNB
IG9uIGh3OjAsMCwgSSBzdXNwZWN0IHRoaXMgbWF5DQpiZSBhIGRldmljZS1zcGVjaWZpYyBxdWly
ay9yZWdyZXNzaW9uIGZvciBVU0IgSUQgMGIwNTo2MjA1IGluIHNuZF91c2JfYXVkaW8uDQoNCkxv
Z3MgLyBhdHRhY2htZW50cw0KDQphbHNhLWluZm8uc2ggb3V0cHV0OiBbaW5zZXJ0IGFsc2EtaW5m
by5zaCBVUkxdDQpBdHRhY2hlZDogYXN1c19hdWRpb191c2IudHh0IChvdXRwdXQgb2Y6IHN1ZG8g
bHN1c2IgLXYgLWQgMGIwNTo2MjA1KQ0KDQpJZiBuZWVkZWQsIEkgY2FuIHRlc3QgcGF0Y2hlcyBv
ciBhZGRpdGlvbmFsIGRlYnVnIGNvbW1hbmRzLg0KDQpUaGFuayB5b3UuDQpCYWxhdmVua2F0ZXNo
IFMNCg==
