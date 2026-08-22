Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E9EC5DF81
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:46:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 000686026D;
	Mon, 24 Aug 2026 13:46:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 000686026D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787571997;
	bh=ia1eb/UMhytcVg4GSwu7samRBGdhHJZ6/xoFZNm0eEk=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=G2yj7DfyAt14NAuasYTXPzDog+StguSMhBlDNnyHLmx1TIFGXtJfqEwGl8/tZGC01
	 x4QGH3EKmdbI3HXaHEnXri78/0Kt4G2A37yQD7O/3YYz5OVYpZUCbWkoKgNdbpSTnx
	 S27qOhpdmHDYMNKAIeyH7eoJPOhIYDv1LXk08HWI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D5C1CF80659; Mon, 24 Aug 2026 13:45:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 70981F8065E;
	Mon, 24 Aug 2026 13:45:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B4167F804F3; Sat, 22 Aug 2026 18:48:53 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1787417332;
	b=UqWvzaJrGYH2RUfiNiZrD5S/GmGDrtkjGuMhzStwfHYTr+cQl5ch6xNXv1CNtmPcfVdq
	 6BtzLXCG3BspzK3WWTLdc4w56Fv22KSIBIBmKzFxMiJSbDmzXTEF/rkyHGooKNDZI+ewy
	 0FEl++RhFLkIMYllfFeOv1+NQepO8GbPzUNbQx4HxoYApeBxM9uJFjeQ64MgntckS4lyv
	 +MAv1Q9OBD/Jtb+MtFbBFi+QeCte8k1MYu16so/8VHEceLQg9211/ELb6bIpWnUcHBFEO
	 X9bDn6Oe/YvlNkR9uKH8jKZ5JiKUmbA/JVFLRnpJ78gsyYflIHTCcKhl9XPajCthOtw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787417332;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=if1WOlXGlIFerfr/C5pOf+hHx6PnuQJyYOIpea9F7g0=;
	b=hT050VLXHIVCxQChOD57RAF/PFdXlGYX+LK6iJWPGAk8hqqi9l7C10uypUiR8FfPKhB/
	 Rk+G5Czq12RXrEbomWjpB6AfFXrH25HTWreUME78hJ9gFxiZZJ92a+oIQfzrE0Z6kGFB5
	 3/bK0EGBgf2rZF1TMVR4w3U4wQXNwNtnm0ywWKwqb9rllukszO0wJKqaSb9keo1ORNmyS
	 gfmQmG67BQtfwjK8uhZd+e05Pze2pkHU/crb3IUO15Yn32EvI5ANuCOJ5SuGD1rTJdSZ8
	 vvbJJE7tvVxxV0E2gpqk9JYSyvwvbRcKdYojkgCzxpVOqjnoNgFUvRmk3MtqQS+HlHQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ahg4PCls;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 20363F8014C
	for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2026 18:48:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20363F8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ahg4PCls
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2d560775ca2so17322315ad.1
        for <alsa-devel@alsa-project.org>;
 Sat, 22 Aug 2026 09:48:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787417329; cv=none;
        d=google.com; s=arc-20260327;
        b=Z0d7VAf+ysmvg0ByAq3RgLAlSKgTu5TYw8eAkm9Kcrb7S5dX+HSt0z3cSqyer/sHDn
         TZzsLk31iQeR/I4oOCsaHk6xNahz1BMFfAUaZNh/3BIRs2JKg0Tf102iMfeSTr1q9tWv
         cMzfnhUkZznTy11ifRFQoov8306QecFW8e0gmO1tNnSyfd2+tDHVuViQPMxfkB462P/8
         mA1qvQm5GHm/Yy005oNW072LAbCtBdB0cWtzQs3aXvDv6uUND6TKn6aRhgFTnvu5AocL
         q/B/UcfUyXPUmp6iiFkTi6rANr0F6l1zu3VXTjS/TxmCyq/BgLcaqP+NnLvflKB9/ll4
         W4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=if1WOlXGlIFerfr/C5pOf+hHx6PnuQJyYOIpea9F7g0=;
        fh=2isATh+npgJkfIm+whpkHEuuCp0nQTKGbhK9whTadLU=;
        b=FDzdjLc3t0uI9svzlycFuUx+4wHP4Ou7S4LA5vGK25UrKk8mekgBShdw1y9uMR1s9d
         JRbBuLhursJKqtP033fYL0N7St7xIat0qzw3W21sLSj00k0GsfR3pV5R/SSj3ZulGJE1
         U8gmLcdeGT9Ntro1h3cS5TC+7UocLbqfhVK7UYx+bo9Cn7XeIRMOteKoU0+M4n7pQfVP
         5+vZ86Y2SGHv625r085eDcapfxswejTXg1wFolHm4YcIHn1S1wPBmdvf2G+9mGGDRY5T
         DVN4rkSteLsEzHEJ2Py4rK1lfpL+4ERZRUmrvfgfEFwEkTCnwLPrt/ifJOjwWeO05MXL
         T5Sg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787417329; x=1788022129;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=if1WOlXGlIFerfr/C5pOf+hHx6PnuQJyYOIpea9F7g0=;
        b=ahg4PClsd90hwvx+ep+Mk4zK5croI1kwZ17lx6ljZ6T7sH27a/uYMwhbFl5imwoP23
         5l2GmIBHS4BlcL/y1ZVBpAiWyqiikL6hT/kkfcSvYI32HSbgoh5jMngFyK1VLtOgPiBz
         0QCfHwr5PDSQV089vuwhIV67W/67pnOp2GqbHCgIbghoaDm0Sxf3lYfQnM6MuF6UqWv5
         jUdSVTr9A2Y2L+vUicNY7mp+jrqGtCm/ImTB8MmHa1vQIB1PBHpWMbFjSCEBNNe24UO2
         uLC6xnmBtmLBg1IqcOZW9OlZX5mNqyN8IFPRWiZocDNmMn8okaG7/0e0+0HPGz6nl569
         aPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787417329; x=1788022129;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=if1WOlXGlIFerfr/C5pOf+hHx6PnuQJyYOIpea9F7g0=;
        b=CKMrPkhzbHVgJXTtQrrCuIzq9Oha3rZBicUK/Si4ZBMLlzMVgn6wlZ1QuEEwxYs3h5
         ZUN6eJuUpJtRvw2lH5AdLFmozPWNvJkdlfTNTdB65pVckd8TtgcCuZTo9Jqiga/B0+BJ
         RTF82go2CbuJVsiFAU1M+yPyAWar85d+9YkGNBHHh3J4T41xYJvRl11HT/8SZQacL8yF
         h/MmvMtInVA0RdrSmRPlpZE8tbJBD2Abn6sC3jsqDuUhrD3MOEouv5z7n7yNJ7wY9p+w
         ceLRL2w6UTSy89StRznsbLMwwXRFMGz+ioPjO8bkiJKv5kbw0ndUyJvu4hoHxtOjrTTL
         9qbw==
X-Gm-Message-State: AFuF++k80dm1t/0SpgE/u3Y99zMM+ChRovaGYposMAIAlKJ5pSVpVNdM
	wcPyEWnyE9mZdX1Wn0WrxDE9J+CSv1RBcgiQb/dc0ihC96Nsfjjk/zW9tUn7ko2LRgYAwcrRz96
	4KXvY7+qVYEiPT+yDkFVScY0CF0qu7mNeMP0tT+k=
X-Gm-Gg: AR+sD10rOqmB6BOEBd0NWiWkUA+PM5nSQFh/d6H+ZncOZMxXz7AvqVI03VcWOwYkL9O
	QbSzwmt4XtzH4UoJuV67BGBy1KRINoEC35UJTfUprQ5UyzddABUyA+ozJU9AxHPFB4opvSuk01W
	bVTn9mUmc6BmKFuerZBhJ0e855CO8AZESY5eDWTcGvIyhKcY1oolXgxNF0xH+Fvm/x9f2Mou/X+
	nmZuEc57UBS32Qck9qcLP9Sh2ShcvpwfUAJmUrcSTOwtiW7zhzjCdkhaVtreqSJZnQxY6/u3sP9
	f9bKVpfBnkOgcN/tEbKT85kdRUj4sCXAdGvctRmWr8bIEeKXM0p0r/ls6oXsrLRo01puUApVSin
	yg/+LY0sGb6Igc53tC5TNBIR6rhOtyBxmP369Lq7tCSm3VBOWnP08ECk6oYMnB0jaSGTQ04/ZiB
	mWBnoXMXEwGVHm2X1ST22m8gguYyEUCUe6ZhshGao8fCCLYk8SVNBF
X-Received: by 2002:a17:902:ceca:b0:2d3:6fac:d67c with SMTP id
 d9443c01a7336-2d670c980e1mr95468975ad.10.1787417328374; Sat, 22 Aug 2026
 09:48:48 -0700 (PDT)
MIME-Version: 1.0
From: David Sandquist <sandquist@gmail.com>
Date: Sat, 22 Aug 2026 18:48:37 +0200
X-Gm-Features: AcwNN1WMlHZ1mH7BuFudQFHaYC7rcddzvDLsNI0tYZ5s2CZgA5cjVpt3XvWMsoY
Message-ID: 
 <CAH-vmYL9hSTHzuKBGizQ3SH2+NsW+7ioaaxvBd0wb_5N+gMEZA@mail.gmail.com>
Subject: ALC295 internal DMIC: works only after a warm reboot from Windows,
 and no readable state differs
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
X-MailFrom: sandquist@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: BDT63IMTFADPOCAGTWFZITCEQFGCPX2X
X-Message-ID-Hash: BDT63IMTFADPOCAGTWFZITCEQFGCPX2X
X-Mailman-Approved-At: Mon, 24 Aug 2026 11:45:32 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BDT63IMTFADPOCAGTWFZITCEQFGCPX2X/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGkhDQoNCkkgaGF2ZSBzcGVudCBzZXZlcmFsIGRheXMgb24gdGhlIGludGVybmFsIGRpZ2l0YWwg
bWljcm9waG9uZSBvZiBhDQpMZW5vdm8gVGhpbmtQYWQNClgxIFRhYmxldCAzcmQgZ2VuICgyMEtK
LzIwS0ssIEFMQzI5NSwgUENJIFNTSUQgMTdhYToyMjQ0KSBhbmQgaGF2ZSByZWFjaGVkDQphIHJl
c3VsdCBJIGNhbm5vdCBleHBsYWluLiBJIGFtIHdyaXRpbmcgcGFydGx5IHRvIGFzaywgYW5kIHBh
cnRseSBiZWNhdXNlDQp0aGUgZWxpbWluYXRpb25zIG1heSBzYXZlIHNvbWVvbmUgZWxzZSB0aGUg
dGltZS4NCg0KVGhlIHN5bXB0b20sIGFuZCB0aGUgc3dpdGNoOg0KDQotIENvbGQgYm9vdCBMaW51
eDogdGhlIGludGVybmFsIG1pYyBjYXB0dXJlcyBhIGZsb2F0aW5nIGFuYWxvZyBpbnB1dC4gTm90
DQphdWRpby4NCi0gQm9vdCBXaW5kb3dzLCBsZXQgaXQgcmVhY2ggdGhlIGRlc2t0b3AsIHRoZW4g
d2FybS1yZWJvb3QgaW50byBMaW51eDogdGhlIHNhbWUNCnN0b2NrIGtlcm5lbCwgdGhlIHNhbWUg
ZHJpdmVyLCB0aGUgc2FtZSByZWdpc3RlcnMsIGFuZCB0aGUgbWljIHJlY29yZHMgcmVhbA0KYXVk
aW8uIFZlcmlmaWVkIGJ5IGEgY29tbWVyY2lhbCBhY291c3RpYy1maW5nZXJwcmludGluZyBzZXJ2
aWNlIHJldHVybmluZw0KdGhlIGNvcnJlY3QgdHJhY2sgZnJvbSByb29tIGF1ZGlvLCBub3QgYnkg
bGV2ZWwgYWxvbmUuDQotIFBvd2VyLWN5Y2xlOiBkZWFkIGFnYWluLiBPbmUgV2luZG93cyBib290
IHBlciBwb3dlciBjeWNsZSwgbm90IHBlciByZWJvb3QuDQoNClRoZSBzdGF0ZSBpcyByZW1hcmth
Ymx5IGR1cmFibGUuIEl0IHN1cnZpdmVzIFMzIHN1c3BlbmQsIHRoZSBjb2RlYydzDQpvd24gRDMg
cG93ZXItZG93biwNCkZVTkNUSU9OX1JFU0VULCBhIGZ1bGwgUENJIHJlbW92ZS1hbmQtcmVzY2Fu
LCBhIGNvbXBsZXRlIERTUCBjb3JlIHJlc2V0LA0KYW5kIGFueSBudW1iZXIgb2YgTGludXgtdG8t
TGludXggd2FybSByZWJvb3RzLiBIaWJlcm5hdGlvbiBraWxscyBpdCwgYW5kIHNvDQpkb2VzIGFi
b3V0IDMwIHNlY29uZHMgdW5wbHVnZ2VkLCBzbyBpdCBpcyBub3Qgc3RvcmVkIGNoYXJnZS4NCg0K
V2hhdCBJIGNhbm5vdCBmaW5kIGlzIGFueSBkaWZmZXJlbmNlIGJldHdlZW4gdGhlIHR3byBzdGF0
ZXM6DQoNCi0gfjI0MDAgY29kZWMgcmVnaXN0ZXJzIGFjcm9zcyBhbGwgZWlnaHQgdmVuZG9yIENP
RUYgYmFua3M6IG5vdGhpbmcNCnNlcGFyYXRlcyB3b3JraW5nIGZyb20gZGVhZC4gVGhlIHR3byAq
d29ya2luZyogc2FtcGxlcyBJIGhhdmUgZGlmZmVyIGZyb20NCmVhY2ggb3RoZXIgbW9yZSB0aGFu
IGVpdGhlciBkaWZmZXJzIGZyb20gYSBkZWFkIG9uZS4NCi0gVGhlIGNvZGVjIHZlcmIgaW50ZXJm
YWNlIHJlcGxheWVkIGFzIHN0YXRpYyBzdGF0ZSwgYW5kIHNlcGFyYXRlbHkgYXMNCnRoZSBleGFj
dA0KV2luZG93cyBDT1JCIGJ1cnN0IGluIHRydWUgcmluZyBvcmRlciB3aXRoIHJlYWQtYmFja3Mg
aW4gcGxhY2UsIHRoZSByZXN1bHRpbmcNCnN0YXRlIHZlcmlmaWVkIHN0aWxsIGxpdmUgYWZ0ZXJ3
YXJkczogc3RpbGwgZGVhZC4NCi0gVGhlIGZ1bGwgMTYgS2lCIEhELWF1ZGlvIGNvbnRyb2xsZXIg
QkFSMDogYnl0ZS1pZGVudGljYWwsIGFmdGVyIG1hc2tpbmcgc2V2ZW4NCmtub3duIGZyZWUtcnVu
bmluZyByZWdpc3RlcnMuIExDVEwvU0NGIGlzIDIgaW4gZXZlcnkgc3RhdGUgdW5kZXIgYm90aCBv
cGVyYXRpbmcNCnN5c3RlbXMuDQotIDE1MiBwaW5jdHJsIHBhZHMsIFBDSSBjb25maWcgc3BhY2Us
IEFDUEksIHRoZSBjbG9jayB0cmVlOiBpZGVudGljYWwuDQotIEFsbCBmb3VyIFBDSCBHUElPIGNv
bW11bml0aWVzLCByZWFkIHJhdyB0aHJvdWdoIC9kZXYvbWVtLCBpbmNsdWRpbmcNCnRoZSBkZWVw
LXdlbGwNCkdQRCBjb21tdW5pdHkgYXQgZmRhZDAwMDAsIHdoaWNoIFBOUDBDMDIgY2xhaW1zIGFu
ZCBwaW5jdHJsIG5ldmVyIGJpbmRzLCBzbw0Kbm8gcGluY3RybC1iYXNlZCBjYXB0dXJlIGhhZCBl
dmVyIGNvdmVyZWQgdGhvc2UgMTIgcGFkczogbWQ1LWlkZW50aWNhbC4NCi0gVGhlIFBNQyBhbmQg
dGhlIEVDOiBpZGVudGljYWwsIG9yIGV4cGxhaW5lZCAodGhlIEVDIGRlbHRhIGRlY29kZXMNCnZp
YSB0aGUgRFNEVA0KdG8gY2hhcmdlciBhbmQgcG93ZXItYnVkZ2V0IGZpZWxkcykuDQoNClR3byB0
aGluZ3MgSSBkaWQgZXN0YWJsaXNoIHRoYXQgbWF5IGJlIHRoZSB1c2VmdWwgcGFydDoNCg0KMS4g
V2luZG93cyBkb2VzIG5vdCB1c2UgdGhlIFBETS9ETUlDIGludGVyZmFjZSBhdCBhbGwuIEkgZGVj
b2RlZCBpdHMgRFNQDQpJUEMgZm9yIG9uZSBjYXB0dXJlLW9wZW4sIGFuZCB0aGUgZ2F0ZXdheSBp
cyBIREFfTElOS19JTlBVVCAoZG1hX3R5cGUgOSksDQpub3QgRE1JQ19MSU5LX0lOUFVULiBUaGUg
bWljIGF1ZGlvIGNvbWVzIG92ZXIgdGhlIEhELWF1ZGlvIGxpbmsgZnJvbSB0aGUNCmNvZGVjIC0g
dGhlIHNhbWUgc291cmNlIHRoZSBsZWdhY3kgcGF0aCBhbHJlYWR5IHVzZXMuIExpbnV4LCBvbiBh
IHdvcmtpbmcNCmJvb3QsIGNhcHR1cmVzIGl0IHdpdGggUFBDVEwgPSAwLCBpLmUuIHdpdGggdGhl
IERTUCBwcm9jZXNzaW5nIHBpcGUNCmdsb2JhbGx5IGRpc2FibGVkLCB3aGlsZSBXaW5kb3dzIGlk
bGVzIGF0IDB4YzAwMDAzYzEuDQoNCjIuIFJUS1ZIRDY0LnN5cyBpcyBuZWNlc3NhcnkgYnV0IGl0
cyBjb2RlYyB2ZXJicyBhcmUgbm90IHRoZQ0KbWVjaGFuaXNtLiBEaXNhYmxpbmcNCm9ubHkgdGhl
IFJlYWx0ZWsgY29kZWMgZnVuY3Rpb24gZHJpdmVyIGluIFdpbmRvd3MsIGxlYXZpbmcgdGhlIGNv
bnRyb2xsZXINCmFuZCBEU1AgcnVubmluZywgYW5kIHRoZW4gd2FybS1yZWJvb3RpbmcsIGxlYXZl
cyB0aGUgbWljIGRlYWQuIERpc2FibGluZw0KdGhlIHdob2xlIGNvbnRyb2xsZXI6IGFsc28gZGVh
ZC4gU28gdGhlIFdpbmRvd3MgYXVkaW8gc3RhY2sgaXMgYSBnZW51aW5lDQpwcmVyZXF1aXNpdGUg
YW5kIGZpcm13YXJlL0JJT1MgYWN0aW5nIGFsb25lIGlzIGV4Y2x1ZGVkLCBidXQgdGhlIHZlcmJz
IHRoYXQNCmRyaXZlciBpc3N1ZXMsIHJlcGxheWVkIGV4YWN0bHksIGRvIG5vdGhpbmcuDQoNClNv
OiBzb21ldGhpbmcgc3Vydml2ZXMgYSBmdWxsIGNvZGVjIHJlLWluaXRpYWxpc2F0aW9uIGFuZCBh
IGZ1bGwgRFNQIHJlc2V0LA0KcGVyc2lzdHMgYWNyb3NzIGFyYml0cmFyeSB3YXJtIHJlYm9vdHMs
IGRpZXMgd2l0aGluIHNlY29uZHMgb2YgcG93ZXINCnJlbW92YWwsDQphbmQgaXMgaW52aXNpYmxl
IGluIGV2ZXJ5IHJlZ2lzdGVyIG9uIHRoaXMgcGxhdGZvcm0gSSBoYXZlIGZvdW5kIGEgd2F5IHRv
DQpyZWFkLg0KDQpNeSBxdWVzdGlvbnMsIGluIHRoZSBvcmRlciBJIHdvdWxkIG1vc3QgdmFsdWUg
YW4gYW5zd2VyOg0KDQotIElzIHRoZXJlIHN0YXRlIG9uIGFuIEFMQzI5NSB0aGF0IGlzIG5vdCBy
ZWFjaGFibGUgdGhyb3VnaCB0aGUgdmVyYiBvcg0KQ09FRiBpbnRlcmZhY2VzIGFuZCB0aGF0IGNs
ZWFycyBvbmx5IG9uIFZERCBsb3NzPyBFdmVyeXRoaW5nIEkgc2VlIGZpdHMgYQ0KbGF0Y2ggaW5z
aWRlIHRoZSBjb2RlYyB0aGF0IHRoZSBkb2N1bWVudGVkIGludGVyZmFjZSBjYW5ub3QgcmVhZCBi
YWNrLg0KLSBXaGF0IGNhbiB0aGUgdmVuZG9yIGRyaXZlciBkbyB0byB0aGlzIGNvZGVjIHRoYXQg
aXMgbmVpdGhlciBhIGNvZGVjIHZlcmIgbm9yDQpEU1AtcmVzaWRlbnQgc3RhdGU/IE9uIHRoaXMg
cGxhdGZvcm0gdGhlIGNvZGVjIGVudW1lcmF0ZXMgb24gdGhlIFNTVCBidXMNCihJTlRFTEFVRElP
XEZVTkNfMDEpLCBzbyBpdCBhbHNvIHNwZWFrcyBEU1AgSVBDIOKAlCBidXQgSSByZXNldCB0aGUg
RFNQIGNvcmUNCm91dCBmcm9tIHVuZGVyIGEgd29ya2luZyBzdGF0ZSBhbmQgdGhlIG1pYyBrZXB0
IHdvcmtpbmcsIHNvIHRoZSBsaWJyYXJpZXMNCml0IGxvYWRzIGFyZSBub3QgaXQgZWl0aGVyLg0K
LSBIYXMgYW55b25lIHNlZW4gdGhpcyBzaGFwZSBiZWZvcmUsIG9uIGFueSBkZXZpY2U/IEEgV2lu
ZG93cyBib290DQphcm1pbmcgc29tZXRoaW5nDQpmb3IgdGhlIHJlc3Qgb2YgdGhlIHBvd2VyIGN5
Y2xlLCB3aXRoIG5vIHJlYWRhYmxlIHN0YXRlIGRlbHRhLg0KDQpFdmVyeXRoaW5nLCBpbmNsdWRp
bmcgdGhlIHRvb2xzIGFuZCB0aGUgbmVnYXRpdmUgcmVzdWx0cywgaXMgd3JpdHRlbiB1cA0KaGVy
ZToNCg0KaHR0cHM6Ly9naXRodWIuY29tL3NhbmRicmFuY2gveDEtdGFibGV0LWdlbjMtbWljcm9w
aG9uZQ0KDQpJIHNob3VsZCBzYXkgcGxhaW5seSB0aGF0IEkgYW0gbm90IGFza2luZyBhbnlvbmUg
dG8gZml4IHRoaXMuIEkgaGF2ZSBhDQpzd2l0Y2hhYmxlDQpBL0Igb24gdGhpcyBtYWNoaW5lIC0g
V2luZG93cyB3YXJtIGJvb3Qgb24sIHBvd2VyIGN5Y2xlIG9mZiAtIHNvIGlmIGFueW9uZQ0Kd2Fu
dHMgYSBzcGVjaWZpYyByZWdpc3RlciByZWFkLCBhIHNwZWNpZmljIHdyaXRlIHRyaWVkLCBvciBh
IHRyYWNlIGNhcHR1cmVkDQppbiBlaXRoZXIgc3RhdGUsIGl0IGlzIGNoZWFwIGFuZCBJIGNhbiB1
c3VhbGx5IHR1cm4gaXQgYXJvdW5kIHRoZSBzYW1lDQpkYXkuIFRoYXQgb2ZmZXIgaXMgdGhlIG1h
aW4gcmVhc29uIEkgYW0gd3JpdGluZy4NCg0KVGhlcmUgaXMgbm8gcXVpcmsgZm9yIDE3YWE6MjI0
NCBhbnl3aGVyZSBpbiB0aGUgUmVhbHRlayBjb2RlYyB0cmVlOyBJDQpjaGVja2VkIHRoZSBzb3Vy
Y2UgcmF0aGVyIHRoYW4gYXNzdW1pbmcuIFRoZSBzYW1lIHN5bXB0b20gaXMgcmVwb3J0ZWQgYW5k
DQp1bnJlc29sdmVkIGZvciB0aGlzIG1vZGVsIG9uIEZlZG9yYSAoRGlzY3Vzc2lvbiAjMTU5MTg1
KSBhbmQgTGludXggTWludA0KKHQ9NDUwNzgzLCBpbmNsdWRpbmcgYSBzZWNvbmQgbWFjaGluZSBp
biB0aGF0IHRocmVhZCksIHNvIGl0IGlzIG5vdCBhIGZhdWx0DQppbiBteSB1bml0Lg0KDQpUaGFu
a3MgZm9yIHJlYWRpbmcgdGhpcyBmYXIsIGFuZCBmb3IgQUxTQSAoISksDQpEYXZpZCBTYW5kcXVp
c3QNCg==
