Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278E4C982DD
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2026 19:47:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3ED9E60200;
	Fri, 18 Sep 2026 21:47:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3ED9E60200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789760833;
	bh=0hQTrENtNJ0P7sH605gLX+Oz0I5J+rlVcGrlGfw6ea0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=UkWbUWEf0DI5KUh9XnLWQRxO4n78TfiICuhc5eoZTVaWqt5FpBIgmYg4vmfL69G1l
	 MGsvnfeYJWcPXQ0+Z8wzOKoQjO3hruwd3HVQQE956YBwjwmKKNaEkxq/J7InBkhJhw
	 CfuomdyP6m71N4NkAr+zCfh0TYVn03MHDBqybAYw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 505F8F80603; Fri, 18 Sep 2026 21:46:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8ABEEF80601;
	Fri, 18 Sep 2026 21:46:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E208CF80571; Fri, 18 Sep 2026 21:46:31 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789760791;
	b=ilnyXuG7QRcMWNwRNx8DXvH+TbY4vaBJUzKdg4SyTLBQQZHVH2R/wzE7aEP5ipSBeu7H
	 2PCCbuocvdPTZcKiUB9POkhnYXH+eZB75CVBFERbk3NCm5ppBCmmv4AWBpH/H+YzaRLyc
	 6cOqz6E+6/afZcFgWrzAD64ICtTMSZhD+6DDjHafLKj8Yt8vT5tJgEBFbYDH1CIUGsTpe
	 izmHGvK/kjl2S2X1Csr1yQn3lKcv8wnqTd2jHC+UX0hgMLrzGDhoV77tSoA7Om5rAqJtq
	 Gd6T0b+M/pwDHDlfh6069ThK+ZNO6zOy6DXXtRWVlU+9OgLxpJUnn8GXDxyJxoo8eRg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789760791;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=0hQTrENtNJ0P7sH605gLX+Oz0I5J+rlVcGrlGfw6ea0=;
	b=OpNwQ674nMvCUEJFPx55JAhknkUXg/UzC5dKOCN+2uz5lRz8tsJhvjxbWLUt0dJnjeKF
	 JstnxeidRuAUO5UH9fU2ZJ8SNlqGqq6p0aMZqRgJxx3K83Dh4PNgMzymR7bi6OMvV+kMe
	 kMmXGB3cX7daVHu306K23ugh4gR3cZeYKGO3DMFILMuPd7HO7o06kBdfP36NNp1d0jmeb
	 3F24Ieqd2STTzQbwejirsguaxJqVrDx+AiL+RmDwaiisWQZJiowFl9/2bxOhcErNmIK/1
	 y+UlA5PAAaEBu8RqZZlN96YhxPQ5xNZo6SRvCgKYQwBxqZ5LoLFY0trYttzeLd7hPaw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E8B6F8026A
	for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2026 21:46:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E8B6F8026A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d681f48ae4dc00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/526@alsa-project.org>
References: <alsa-project/alsa-lib/pr/526@alsa-project.org>
Subject: topology: harden binary topology decoder against malformed input
Date: Fri, 18 Sep 2026 21:46:31 +0200 (CEST)
Message-ID-Hash: UPZ66UVKNOWQQMIY6HOM662KXJ2OYD2C
X-Message-ID-Hash: UPZ66UVKNOWQQMIY6HOM662KXJ2OYD2C
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UPZ66UVKNOWQQMIY6HOM662KXJ2OYD2C/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #526 was opened from HarshRajSinghania:

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
