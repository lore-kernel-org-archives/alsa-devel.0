Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CECCA5FC4
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:00:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00ED56028D;
	Wed, 30 Sep 2026 21:00:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00ED56028D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790794833;
	bh=0lIn1SVyM2XmICaLdkIlhPmGsDjwsTj55YA0nhf/L1M=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ijq6V7U2ZU/uhiqYs/C0TXWs0f+ueYIfRe/y6oKurQ9E3qIOYZtofEqhCzP7C+BAQ
	 qd25qTNC2jXxjyXOli5y604uj66l7ULrs9+jHT9OJ8G8bR43SmWn3f+NrRq0isaI3I
	 ED2L/zGaDpVsoAvHPEgOPWECQ5VZUSsKLVLKUPT0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A84DAF80619; Wed, 30 Sep 2026 20:59:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 72B8FF80617;
	Wed, 30 Sep 2026 20:59:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ACDDEF80542; Wed, 30 Sep 2026 20:59:39 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790794779;
	b=qE/zqErGyhWqBMVtdoTPNdoE2ACvlZR0MLPvACq74t0kIPr9m9wgEuBlJ4uoB9lkbMJb
	 0omfVS7vKfTW5M0vKUdZUaeXvGAfYUCO9wCl/wNfy3CxCdw5dNRxfOsjn2sh2Bzl3XFZG
	 /3w05HuSLCKgGDrw1xEbfylFInSn9kf/ELjH8x7ozOuCacNXMe8KdXwmZMIaZHvndC5+X
	 3xXQV0ElY9SyZfFw8MXWLiClXQAcLAL2I6o+9YN1FlWnrVK010m/6whFbC7EQoKm+3Qp/
	 jDIOxb1aNCI9y1A7ZG77cXy9pKkpe0P5JdVi9Hwui7RAhRfYo3vtPvvZWz4FayJTpwQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790794779;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=0lIn1SVyM2XmICaLdkIlhPmGsDjwsTj55YA0nhf/L1M=;
	b=HsBQfMriMKoIF8KSQ+WZ71LXeVdlxu3yO+u4iJ+VVszF37lwU3Yh34im5Kj7OTuVd758
	 pJL6ijMli9ciNn11jEHQjJGpJUHp7qVYxEqVgf/cFLD9KrEpV55l3B0kc3ROGLF8bw9MO
	 mzhRC0/KCXEFMtrpbTACRqK0ILAvwYTjbzIoQPU/pNLfXshsR8U25ZmaIBfG45mTd7QKI
	 VaI9rUsrANMeRhZZYK2W39sjP0FHiHcLxhXHkYXpvZmwFk7sdD/v7y395m2hfZdoowBaj
	 JYG1vlQI4EP4SdOXv9fzqtrU3+hxTlwTU3uXvjrrnFmhyrKve4uHk1X4bQ0lVgDqr2Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 25188F800D0
	for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2026 20:59:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25188F800D0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - reopened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18da2e5cd71b3200-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/526@alsa-project.org>
References: <alsa-project/alsa-lib/pr/526@alsa-project.org>
Subject: topology: harden binary topology decoder against malformed input
Date: Wed, 30 Sep 2026 20:59:39 +0200 (CEST)
Message-ID-Hash: OVDYRQUVSRGQTDPCM2HC2JQC2HSVWB6S
X-Message-ID-Hash: OVDYRQUVSRGQTDPCM2HC2JQC2HSVWB6S
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OVDYRQUVSRGQTDPCM2HC2JQC2HSVWB6S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #526 was reopened from HarshRajSinghania:

As discussed over email with Jaroslav, this hardens the binary topology decoder
against malformed / untrusted `.tplg` input. Three related issues, each confirmed
with AddressSanitizer:

1. `snd_tplg_decode()` (src/topology/decoder.c): `hdr->size + hdr->payload_size`
   is evaluated in 32-bit and can wrap, bypassing the payload bounds check; the
   block decoder is then called with the raw (huge) `payload_size`, causing an
   out-of-bounds read. Fixed by doing the arithmetic in 64-bit (and the advance
   in `size_t`).

2. `tplg_decode_dapm_widget()` (src/topology/dapm.c): the kcontrol loop reads the
   control header (`chdr->type`, then `mc/ec/bc->size` and `->priv.size`) before
   the `size2 > size` check, giving an out-of-bounds read on a truncated payload.
   Fixed by adding `size < sizeof(*chdr)` / `sizeof(*mc|ec|bc)` guards and
   computing `size2` in `size_t`.

3. `tplg_decode_dapm_graph()` (src/topology/dapm.c): `alloca()` is called with a
   size derived from the input payload, allowing stack exhaustion on large input.
   Fixed by switching to `calloc()` / `free()`, which fails gracefully.

Scope is the debug-oriented decode path only, as you noted. Standalone ASan PoC
harnesses are available if useful.

Signed-off-by: Harsh Raj Singhania <raj.harshraut@gmail.com>

Request URL   : https://github.com/alsa-project/alsa-lib/pull/526
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/526.patch
Repository URL: https://github.com/alsa-project/alsa-lib
