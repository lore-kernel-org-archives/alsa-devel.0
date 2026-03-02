Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA15EB7ECF
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2026 12:11:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8E2660243;
	Wed,  4 Mar 2026 13:11:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8E2660243
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1772626279;
	bh=o+niAFp6BkH/Xf0x+QpvouhnhlmGPgr6mL08QCBhQ0w=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Wq0K7/PEM6CV2H2xcokgUF+HbuG2w+2YQi4qfejmIEOUo6fo/BXIgEajvnreqd6sF
	 f+2BWdxo5v5hzjrUOb3LiWFUKr0Op3ebdR705er3AxyQnd8HLCxUd1VufgvZ+J5gQX
	 mzAWPH5RPKLl7Ft0dJyGet7GiSR96WR335DXBGf8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D981BF805ED; Wed,  4 Mar 2026 13:10:43 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 29CDDF805B5;
	Wed,  4 Mar 2026 13:10:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7ABF1F8026D; Mon,  2 Mar 2026 06:55:28 +0100 (CET)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BD1ABF8016E
	for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2026 06:55:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD1ABF8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=SIHw28nr
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-389ebb0e885so72058801fa.1
        for <alsa-devel@alsa-project.org>;
 Sun, 01 Mar 2026 21:55:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772430914; cv=none;
        d=google.com; s=arc-20240605;
        b=Ncb2nKK6Hyu6N5NexeTAL80Oekfdqnd7DqQ1RrumyqNbzgQuCzlmEdb/xFVgoYGPjt
         1lUdZMcYABO5BrGYurKnFSIvhnkrC6NdYmEC+MdHIUDEsi3LOiEnusiGMf9sCbErzojC
         W7BsX1i7Xi39fVqMXHwXZZ4G02bZ3IUuD6ASgYB0oRSo5NbO15ZbgtbI3nzGcPJDI2Ed
         5fwxJ/XMq7fUaL5rPZkiJ5iOr4ioQIxu4qilUvYnmQ/4JYunWaNoO3gaoLL+p2Vc/ids
         d1ctb9ZoCdsHCGeE2yv6Ltczczpx22ym/q1qjblC0RdzjB2NcH+BCSyK/TkThVlADqSN
         0ypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=LMxII9RvT5ZVT9zJuQFQ+Uugzy7i+B/BF2FUz3bFjKM=;
        fh=JZ/S8OcThY4VVJJNHjkqjt/aK7LdpVSL9pTh5LF++Z4=;
        b=XkUYRqefukH5KKSO8vJWG4cvwYIOhnLMgjBB5EppFhTnjroqISobAp0SIhAtG4dcMt
         1FAa6KeNk3lPL7l/vkM1mmj5enT7t96ej/LTsru3P+ZahGahh+NEWWwRs5nakRYE85Uz
         clJFKVS9BHI0NF8WhZ7d2VK/c374RYAMe27YLhd3mo5oj0roSpHHg1sq2uVHvOERorDT
         2VYUW6HeEoS8sPxXBTbRrzt0jOEy83dGpUXIGRRNCBvxcu6tvJU5pKZp9aLVxtQxkQYS
         tRLrxC8LM6G24d4SbUayROVb8kWDfri3F7F+4gbBw7rU8KZsnhPd65hfg2uCwikP6SCg
         PYLg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772430914; x=1773035714;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LMxII9RvT5ZVT9zJuQFQ+Uugzy7i+B/BF2FUz3bFjKM=;
        b=SIHw28nrR0x+0URCklysQijr9tSItyHwZYGv8B+EHeLZ8oEZq/Fvugyf4hHBgLtbpi
         DznwXJ4MOQIfKRGur9mZ0NkzoWd9gTYfQv7XukCNclOwZZYayq8q7s26rkCcFDOCInlA
         uIL0U7p1wrBUW//E3WO3GUH5OCMECl1jnTNBWByoSbv3qS0o+QTvE+wHNk7VE10Tb3cJ
         lNnN/W6uzBpsuHaiGPp4gKvDTz/H8XlOBwLYlyHp2wcbquCIyEGexIf9ea6SmnA0yBJy
         zweJe8GC7bXAPfLgWCVvnwDL4rdN+5whHeNNUxpxihKzd+VvRazH9zUjo4jySnpesvA4
         28ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772430914; x=1773035714;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LMxII9RvT5ZVT9zJuQFQ+Uugzy7i+B/BF2FUz3bFjKM=;
        b=mwSy/BLW2tnuFVmCr3SrXruF2kcrcIcMH4XjCGzVe4TpL5JNNsBmDgpUk9w7d/gh+I
         /sJlj7jHbmb64qHJfAsAh5dhquYzziaYqOS9PGDH3nqkKU3NxvPTLhhBZRB0gRFEZgLA
         9WXBqHA9oeyjW8wI2kU4Q5OwRwHhavlIK2UZSPOPigyICoUuy3ts9rUpm2asspUJMpAm
         UKSUUYQePoMqHOoiz4PSkzMNHXvbXDg5Cu1tsyKRFcqfwqVnoYyLh427639h+Fr6DuUl
         J8Geqa6MnvB5ew8/vLLC/TcyVyhYbv7lzw1wLJ2neqfGHQo09ivALquJCitGDqtpJHUA
         mzEA==
X-Gm-Message-State: AOJu0Yx3GFSojmTxox/eKU5Zo/NccT0HWdNcREUa4hoJ9Geft1QEXAOY
	JQ3AV+eFygxGaCWrxkkPWuKtlQR4GQUPMjsoo42W3jIIKE2D02w9TrBrvk7oIpcDZbfs0csEHRj
	vmMJSFF7nIPa1jzXZ6dqXL0tzNVVVUMlyHFQw
X-Gm-Gg: ATEYQzwvmRvjqX/wdH+mvk2Exo8P6/sDEAsVnwTpmtgYB8qn+SAlAEHu3n/ERepgDkV
	5WHvTDXLFVeCx/CBo+7T1HSelnHkiLnMQNnu/v0oMePv0MfU9svh0k/kbsbYic7AUbng8VUVtug
	0l8mqi/Hcz8uS248f2KCPqRNdEnXfjy2AEwIHSC6X3ZYwCaGXFAQ+sxGKn117ktimJqaOx+mFQr
	CLBa10IG2k5Fo16/4QScL7vb9Stfb2p/mDPYb3Ti3wpqxMWHZA17MpNCcCdl8sst3s+GSGvF0/0
	u1FXQZI=
X-Received: by 2002:a2e:a555:0:b0:383:16e7:9c3 with SMTP id
 38308e7fff4ca-389ff109cb2mr65016861fa.3.1772430914047; Sun, 01 Mar 2026
 21:55:14 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?Q?Fabian_Rito_Wahlstr=C3=B6m?= <fabian.rito.wahlstrom@gmail.com>
Date: Mon, 2 Mar 2026 06:55:03 +0100
X-Gm-Features: AaiRm50gW75_za6dveXfh-jdQ3g8IXDoV1XMqLd6uFVrIYDdEWwAnndYbYRuB3U
Message-ID: 
 <CALRXgPOw03E2TrsQAeYCz-ncMQNkBCv7Zaj+Wu29MTYT93kBiA@mail.gmail.com>
Subject: ALSA: hda/realtek: Missing quirk for Dell XPS 15 9500 (ALC289,
 1028:097d)
To: alsa-devel@alsa-project.org, tiwai@suse.de
X-MailFrom: fabian.rito.wahlstrom@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: XA62XQDLIOMRRSA4HZG3ZLFE2VWMNOH5
X-Message-ID-Hash: XA62XQDLIOMRRSA4HZG3ZLFE2VWMNOH5
X-Mailman-Approved-At: Wed, 04 Mar 2026 12:10:37 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XA62XQDLIOMRRSA4HZG3ZLFE2VWMNOH5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGksDQpJIGhhdmUgYSBEZWxsIFhQUyAxNSA5NTAwIChzdWJzeXN0ZW0gSUQgMTAyODowOTdkLCBj
b2RlYyBBTEMyODkpIHdoZXJlIHRoZQ0Kd29vZmVycyAobm9kZSAweDE3KSBhcmUgY29tcGxldGVs
eSBzaWxlbnQgb24gTGludXguIFRoZSBtYWNoaW5lIGFwcGVhcnMgdG8NCmJlIG1pc3NpbmcgZnJv
bSB0aGUgcXVpcmsgdGFibGUgdW5saWtlIHRoZSBYUFMgMTUgOTUxMC85NTIwLzk1MzAgd2hpY2gg
d2VyZQ0KYWxyZWFkeSBmaXhlZCBpbiBtYWlubGluZS4NClRoZSByb290IGNhdXNlIHNlZW1zIHRv
IGJlIHRoYXQgbm9kZSAweDE3IGhhcyB0aGUgd3JvbmcgcGluIGRlZmF1bHQgdmFsdWUNCigweDQx
MTExMWYwID0gTi9BKSBpbnN0ZWFkIG9mIDB4OTAxNzAxMzAgKGludGVybmFsIHNwZWFrZXIpLg0K
SSBoYXZlIGJlZW4gZXhwZXJpbWVudGluZyB3aXRoIGEgbG9jYWwgcGF0Y2ggdGhhdCBhZGRzIGEg
bmV3IGZpeHVwDQpBTEMyODlfRklYVVBfWFBTMTVfOTUwMCB1c2luZyBhbGMyODVfZml4dXBfc3Bl
YWtlcjJfdG9fZGFjMSwgY2hhaW5lZCB0bw0KQUxDMjg5X0ZJWFVQX0RFTExfU1BLMiwgY29tYmlu
ZWQgd2l0aCBhIGZpcm13YXJlIHBhdGNoIGNvcnJlY3RpbmcgdGhlIHBpbg0KY29uZmlnIGZvciBu
b2RlIDB4MTcuIFRoaXMgZ2V0cyBhbGwgNCBzcGVha2VycyB3b3JraW5nLg0KSG93ZXZlciBJIGFs
c28gbm90aWNlZCB0aGF0IHRoZSB2b2x1bWUgY29udHJvbCBmb3Igbm9kZSAweDE3ICh3b29mZXJz
KSBpcw0Kbm90IHN5bmNlZCB3aXRoIG5vZGUgMHgxNCAodHdlZXRlcnMpLCBjYXVzaW5nIHRoZSBi
YXNzIHRvIGRvbWluYXRlIGF0IGxvd2VyDQp2b2x1bWVzLiBJIGFtIGN1cnJlbnRseSB1c2luZyBh
IFBpcGVXaXJlIHJlbWFwIHNpbmsgYXMgYSB3b3JrYXJvdW5kIGJ1dCBJDQpzdXNwZWN0IHRoZXJl
IGlzIGEgcHJvcGVyIHdheSB0byBzeW5jIHRoZSB2b2x1bWUgY29udHJvbHMgb24gdGhlIEFMU0Eg
bGV2ZWwuDQpXb3VsZCBpdCBiZSBwb3NzaWJsZSB0byBnZXQgZ3VpZGFuY2Ugb24gdGhlIGNvcnJl
Y3QgYXBwcm9hY2ggZm9yIGJvdGggdGhlDQpxdWlyayBhbmQgdGhlIHZvbHVtZSBzeW5jIGlzc3Vl
PyBJIGFtIGhhcHB5IHRvIHRlc3QgcGF0Y2hlcyBhbmQgcHJvdmlkZQ0KbW9yZSBoYXJkd2FyZSBk
ZXRhaWxzIGlmIG5lZWRlZC4NClRlc3RlZCBvbjoga2VybmVsIDYuMTguMTMsIEZlZG9yYSA0My4N
ClRoYW5rcywNCkZhYmlhbuKAi+KAi+KAi+KAi+KAi+KAi+KAi+KAi+KAi+KAi+KAi+KAi+KAi+KA
i+KAi+KAiw0K
