Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EC8D58CA3
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Mar 2026 21:31:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D75C16020D;
	Sun, 22 Mar 2026 22:30:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D75C16020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774215069;
	bh=d9NJ213fPFuxMZMTLKxkV9so2vdlOLQyg+MUxibrMLE=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=uOcg8hFt8keqLIY5gD7G4Ex7bzqA1PCJwHKMOTFdj6B5HBvCb3k7LhQcEslSH2OX3
	 q7ufXhVluQu61jTfmOwdsFBqz6KU3zgDdQ/B7RersY9tMs1XPq9iDVp4AsO1lrQZZX
	 nos40QhrVUdsbqwrwXZMCHWXqw4Ymig2yXJFdcaA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 06335F8060D; Sun, 22 Mar 2026 22:30:40 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A32DCF8060E;
	Sun, 22 Mar 2026 22:30:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 828E6F8053B; Fri, 20 Mar 2026 01:02:06 +0100 (CET)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
 [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7DE85F80087
	for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2026 01:02:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7DE85F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=R3EhVqcn
Received: by mail-vs1-f45.google.com with SMTP id
 ada2fe7eead31-5ffdd9a6155so1928430137.1
        for <alsa-devel@alsa-project.org>;
 Thu, 19 Mar 2026 17:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773964922; cv=none;
        d=google.com; s=arc-20240605;
        b=PClyXekNJez0CRtYrYk1KFBedjjK3g7xx14wMyTbCJixNCxhvguPMd/4iGR43pJq55
         7baLKum5I60VsuoXPKMmpAz9M+LSMba3CdZr9zYiyB3GD+JmpMH8fZzt2s81B7eWdB2+
         R2rV58EsOlf4m45G0M3DJz2tKBNJ/7Q6Fif3uasjbpdAcQTu5vU+uqXxQK12ilYgaIgk
         xKIOEoX0XCSsSgYRE6yZq5qLQaGuyvX18CQRpZSSkdloqNYo5RO6b4aEQLqUJMdE7NrJ
         EvmeAnAbnTGdaKRMJd7OsQP4O6fcayT6hNtkmMtrpMGoVZS+wuzPlAxIVhVV/9H0tmLG
         Kk5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=E/WXPhXF9gAOL/NhricIK6H14Ixbm5F4Tst/cAlUBiE=;
        fh=Ew/FczzB7o7aRfej3b0OqrTSMw6fQi9VXUH7aRGOf/4=;
        b=TmZModTzmLUHnz53BrPrqCe4cti6K7zWQk5G/fizWw7IvfLCdmimflMhzdRRoaRfXR
         rwa4B3VH1++VANsYOhi/yUn/oL4LsfA00HfV/SKiLvuucbHh3dPKho/jrIHGASkPHBA3
         iHZ0oy9V1rW1zLZRRfeSdTZlEu+AnVhJoJuG//BqfmyQs5zo8cEJFLR59WMJEIrJAVAP
         VkpUJMsb+2GowmOJHd3hPNrJRGuSsszN3XfgGzoNQ5HlR1jNuUiJDtWinRNhv9CoR4HQ
         f6I/usipe625tLO87ggVQQQ0aSpTCCuLdGuJZsV2TpacoRFcN63Cy+LZMbyx+XHnng5q
         WI+A==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773964922; x=1774569722;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E/WXPhXF9gAOL/NhricIK6H14Ixbm5F4Tst/cAlUBiE=;
        b=R3EhVqcne+MQ943GO1K9la/S6se4yaqUmvl5ZpAQtfKw2gaRqt7I66CHvdPspWhuuh
         V4EzbLABYd3IFwYPlmMVWhSRXw4NNnnKUAOqfefGYPi+ud3LRhs16bmtFz1Ju+8mVDJH
         ryUtAHovmnyPC6s+pj9rHazZxVyVwRA/gBUsS96T7vZ4WPNpU3lO3r5fpcqsXnKiPFMv
         U6sjNseEiD9sBrh5j73QuCg700JMqwrPUCkM71tRN6/5QHAHs6eTEGp6PqVFXeSVzlaT
         rR6j7mK3ynK4qWXaqFAUA8rsEEtymXaRg3w2hmZijsFqvmZNq9pWNW6sz53kQ6hmURoC
         Z5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773964922; x=1774569722;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/WXPhXF9gAOL/NhricIK6H14Ixbm5F4Tst/cAlUBiE=;
        b=pResYTbXbrfKJKsWzmcA27IYsyxfiUROYkjBQzLCqS7Vi0V+v7o9MXbK+v3TaZ0odw
         4XSBzG7qgsx0lUCpSgT/Y7ZurzYA4tEpArOUSLVygRTDJjOsMPUyUrCnKgXozoiA0/h3
         OaGRtAdfIBI7f/5AeB+i0Wi/dhbDvO2ofrTNSFrO72wPML2Yy4USUs6+blNgyxrMoazf
         D0HDrNZTrJnUEa+ztGK31hGdVLc1V9qP+mB9jLjdbuLawhughEc2HG7FyhX2Gbf36nmZ
         W9G5Fgwjahs25sJBLWXhXechRob7nh1IyOuIYj4jTGz9kWhO+ehH2fH6E4lNEAW/wYeE
         Npow==
X-Gm-Message-State: AOJu0YyVvKuxEhl4ZBgNfo5qHi37v/Y8Sqhy+Usjd3sEbDH8XrXyh6J3
	p8EtJVkxnyjdAmdEwDdKlxFa69zq99xKa3iQ7TWo/VHnkRJFMarNQ7LoW0zebkRAV6c0DuX/x/g
	hFsHDWc0bacoo8tvJgBYifVF4mJdjPqaHBCIdT3Z7yw==
X-Gm-Gg: ATEYQzxS1j8L8gqtGqH4epumUA2FO35/0P9aJMSHAgF4a0vvw3iXRSt04+l6WK3ZcVg
	gyZDPBlKD6dU2szYXuJFxUVF2ChQILHP+cPwc2DzCyU+PnecSdNV3M+gfSTHlsZx8sbjphJhmcC
	drp5CTxJlhJOktLgWSQdSxI07kbfM4FnrLrBZcAmGnj8I6NWJI/Akp1PDILS8iOnNsh9gqSEOWz
	RHb6baY1QHZKYncG2KpT+L9gVswR6av/dYV5M4LKaFJMH8SZij4MCnWCuU0BgiVfsXIWM7lwEq8
	918bwoBZf80qEURvWuoK4WHtM0niur1VNpIqZuaNbBCzCZ/y+JRvDlHWVc/69WTDtgaNOg==
X-Received: by 2002:a05:6102:5791:b0:5f8:e41e:e5cc with SMTP id
 ada2fe7eead31-602af6cc7ecmr624687137.9.1773964920903; Thu, 19 Mar 2026
 17:02:00 -0700 (PDT)
MIME-Version: 1.0
From: Elie Muluke <eliemuluke@gmail.com>
Date: Fri, 20 Mar 2026 00:01:24 +0000
X-Gm-Features: AaiRm52LnrbP4dZS4i8q5H6kFEKZLjyZWWB7FxuNrvQWr8FXk27VQUhVn81COoE
Message-ID: 
 <CALh3mGgtDgBkvdXwinZze3GqcockKMnbKu7W2ZccHPCn8FaVrA@mail.gmail.com>
Subject: ALC287: Missing quirk for Lenovo Yoga 7 2-in-1 14IML9 (subsystem
 0x17aa38db) - no bass speakers
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, perex@perex.cz
X-MailFrom: eliemuluke@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: VVOKCBTZRWTWFGSCPHDPBSF5V7PZWR2U
X-Message-ID-Hash: VVOKCBTZRWTWFGSCPHDPBSF5V7PZWR2U
X-Mailman-Approved-At: Sun, 22 Mar 2026 21:30:34 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VVOKCBTZRWTWFGSCPHDPBSF5V7PZWR2U/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

SGksDQoNCkknbSBydW5uaW5nIEZlZG9yYSA0MyB3aXRoIGtlcm5lbCA2LjE5Ljggb24gYSBMZW5v
dm8gWW9nYSA3IDItaW4tMSAxNElNTDkNCihwcm9kdWN0IElEIDgzREopLiBUaGUgaW50ZXJuYWwg
YmFzcyBzcGVha2VycyBwcm9kdWNlIG5vIG91dHB1dCDigJQgb25seSB0aGUNCnR3ZWV0ZXJzIHdv
cmssIHJlc3VsdGluZyBpbiB2ZXJ5IHRoaW4gYW5kIHF1aWV0IHNvdW5kLg0KDQpGcm9tIGRtZXNn
Og0KICBzbmRfaGRhX2NvZGVjX2FsYzI2OSBlaGRhdWRpbzBEMDogQUxDMjg3OiBwaWNrZWQgZml4
dXAgKHBpbiBtYXRjaCkNCg0KVGhlIHN1YnN5c3RlbSBJRCAweDE3YWEzOGRiIGlzIG5vdCBwcmVz
ZW50IGluIHRoZSBhbGMyNjkuYyBxdWlyayB0YWJsZS4NCk90aGVyIHNpbWlsYXIgWW9nYSA3Lzkg
bW9kZWxzIHVzZSBBTEMyODdfRklYVVBfWU9HQTlfMTRJQVA3X0JBU1NfU1BLX1BJTg0KYW5kIHdv
cmsgY29ycmVjdGx5Lg0KDQpTeXN0ZW0gaW5mbzoNCiAgTWFjaGluZTogICAgTGVub3ZvIFlvZ2Eg
NyAyLWluLTEgMTRJTUw5ICg4M0RKKQ0KICBDb2RlYzogICAgICBSZWFsdGVrIEFMQzI4Nw0KICBT
dWJzeXN0ZW06ICAweDE3YWEzOGRiDQogIEtlcm5lbDogICAgIDYuMTkuOC0yMDAuZmM0My54ODZf
NjQNCiAgQ1BVOiAgICAgICAgSW50ZWwgQ29yZSBVbHRyYSA1IDEyNVUgKE1ldGVvciBMYWtlKQ0K
DQpDb3VsZCB5b3UgcGxlYXNlIGFkZCBhIHF1aXJrIGVudHJ5IGZvciB0aGlzIGRldmljZT8NCg0K
VGhhbmtzDQpFbGllDQo=
