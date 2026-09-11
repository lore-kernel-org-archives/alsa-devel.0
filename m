Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650B4C88E4D
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Sep 2026 19:22:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C3F5602C8;
	Fri, 11 Sep 2026 21:22:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C3F5602C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789154568;
	bh=/SMUysLzFvmsrqEKV743BmNII2Qj6UiFbxn3Fwzc3mw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=l3usQNeXH+zmPbZ0DDn217Y8FMeDx8Ns+uz4dyD4LDb53vPMPN+3YL3Oa51INycwI
	 kPGHAdx6VGfZ8n5TVGxzBcghTfWy1+JCcVwVEoxS75RbjHhXsGuf79pcKD8RYZEL1f
	 +ogAO1X6Wy1tn68nyDHJaqUgkc5Bl1kZu7GHYHq0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5EA34F80622; Fri, 11 Sep 2026 21:22:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D2911F80622;
	Fri, 11 Sep 2026 21:22:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A9E15F805B2; Fri, 11 Sep 2026 21:22:04 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789154520;
	b=WmZN8Zqemve/x+S+zIm0Zr+KOPR5LBXQKdXIMloDTBzNVbGbkqPeedEmj8tfwhc8IHmV
	 I96cKE62/mzTgHEu0874nQjSadE42rqlG96lfJPh1kG4I39+dxszydt9+RYMguVcUAYfn
	 BYx+QIIZaADyu3Sn2y5SRRehtbWyQUJW/leRFZqzixPmzqf0shtdLH2x3rbWbGphRgYCU
	 0StrGQJXrAviLfWVmzimLdzrpQ2vvxEt2SgBzmNrd66AI40kWBHjST+vGaUpvrjVjgKcG
	 5iJn27AQEQvcEHrVBt3nSPo+FYyIU6CtAFvxSy0E5J9/9sGVaIeGagNLB0H2UzlWirg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789154520;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=/SMUysLzFvmsrqEKV743BmNII2Qj6UiFbxn3Fwzc3mw=;
	b=PIVBUQ3/r/0ibsGrgUwHPXz8bDY5soYsNFYGnJ9nhfmXFDbdvQSI6E0t/uG5zVu0OB4a
	 TuI/APm7yYG5zPdjDwAeqx5MVgllwTjwOcoFEFROdOKKWaQfrqb+pvVG4DCTF59pnAqna
	 TozSfrpih4IGE2PSL10MBxtQHuD9AOwo6X6AeZaxK0gmquSyd61OFOA2DS+1AnXbGSxbr
	 Z/KclMGTYYbM5x6Fbf6OJdJVKZIs+K7CP7obXZd/Xuw7mos2TGKbNQc3B3enNAyQBNGGR
	 JJSPSIAb6Tx/if3cv1xhluvHHq5j1c6Qi2oRKwNTkCmGXAaU4VdXAjknOb1fuMe2atg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A5ECF8060B
	for <alsa-devel@alsa-project.org>; Fri, 11 Sep 2026 21:21:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A5ECF8060B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d45a8e502b9200-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-lib/pr/524@alsa-project.org>
References: <alsa-project/alsa-lib/pr/524@alsa-project.org>
Subject: pcm: reject invalid multi bindings without assertions
Date: Fri, 11 Sep 2026 21:22:04 +0200 (CEST)
Message-ID-Hash: Q6J557HBYD3Y54O2GOLGQ5TS7ULE3D6S
X-Message-ID-Hash: Q6J557HBYD3Y54O2GOLGQ5TS7ULE3D6S
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q6J557HBYD3Y54O2GOLGQ5TS7ULE3D6S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib pull request #524 was opened from HarshRajSinghania:

Fixes #523

The `multi` PCM parser initializes unused binding slots with `slave_idx == -1`. `snd_pcm_multi_open()` previously evaluated `schannels[i] < schannels_count[sidxs[i]]` before checking for an unbound slot, causing a negative array index and an assertion abort for sparse binding configurations.

This patch:

* skips unbound binding slots before dereferencing the slave index;
* validates the slave index and channel explicitly;
* returns `-EINVAL` instead of relying on assertions for malformed configuration.

Reproducer from #523:

```
pcm.null { type null }
pcm.poc {
    type multi
    slaves.a.pcm "null"
    slaves.a.channels 2
    bindings.0.slave a
    bindings.0.channel 0
    bindings.5000.slave a
    bindings.5000.channel 1
}
```

Before the patch, alsa-lib aborts with:

```
pcm_multi.c:1125: snd_pcm_multi_open: Assertion `schannels[i] < schannels_count[sidxs[i]]' failed.
```

The fix makes the malformed configuration fail cleanly with `-EINVAL`.

Reported and fixed by Harsh Raj Singhania.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/524
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/524.patch
Repository URL: https://github.com/alsa-project/alsa-lib
