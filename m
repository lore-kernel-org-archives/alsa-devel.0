Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CE5C43458
	for <alsa-devel@archiver.kernel.org>; Sat,  4 Jul 2026 12:08:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC7A2601F3;
	Sat,  4 Jul 2026 14:08:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC7A2601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783166903;
	bh=kUsm1xVdbNZ7fUWAe+6/CgNnv3KVHiGR3sb4eMIh2MA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=G/ipUlFid/bbmqKjqEvBTT2vt5wyBhli7U6YaJfLGvhdV+JvZQIv05Bd/hMW5gZNi
	 ul4/NGWRsvzRDHur5ZdE+lwN2EUl8sB2mUJW0aeVfXIub/CeAyf7wNbso4Utm40mxV
	 pwJeyi9mGTIoIQI//qSJZrEOHpMbmBYzCcpktthA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5C411F805FC; Sat,  4 Jul 2026 14:07:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D20C5F805FC;
	Sat,  4 Jul 2026 14:07:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A9F0CF8057F; Sat,  4 Jul 2026 14:07:38 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783166858;
	b=U2diKQF5n56k3q/YMmNojfXI1xvaGveZgeZQxdZNx3miwKBcCqJIwXptyInTVITFm3RI
	 I5WpFZSsfkeHh2ETdPvQto8aizPZqrplZaftT7sdbpUZZv3/zHhvVBzIBRhT4t5q5MalF
	 k4bWk3Q73chQnm78rNiqKOpKKaszkWCHtMI4SnxfDoD1mrJHuZLexOu/BdLNZ8ffFURtl
	 UnZgP9+H+v+yDUwlFkzIbjAq9A1GwpibGGLut+R6RBu034PYvDCN7Cf/zu6KjpcK6PwkI
	 YkG0vmAI5sy83xoq1NWC47IHxeI4I2dNN6JGpWHJQeFnLMy32aXja089bHiLmPgDoWg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783166858;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=kUsm1xVdbNZ7fUWAe+6/CgNnv3KVHiGR3sb4eMIh2MA=;
	b=ZcWnjXgM4PFbOhm1WKx9zBzC6+QtKvA9orYuXS5uuftXePOLL9+18BO0jGm7lblkYP4E
	 JSKv+tf711wnTcpWeEisdViXfmNVrZ1Sts3TTXElA5rHrBSyRG8VcFecf8xhBA15XuUq2
	 kjfeykqJNzoRkgstQoO+eMp148A9Zpj8eKqqE0E01M3a/JyqQ8d/lUSPNxRpTt08gtEAv
	 nogTNyFQdfBnJ1ythyP+TMFNXyKGya5CARaQj63vtfqIo1l/kvvVc0ciAsvCY0KEUILc+
	 k75qkf3iz2NW62UiZfxFA6OKNw2lFcymjUSMASKtq4zzbAhmTO5Z2KLIENJ4T1p5nbw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A0B9F8011B
	for <alsa-devel@alsa-project.org>; Sat,  4 Jul 2026 14:07:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2A0B9F8011B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bf14cee52c5a00-webhooks-bot@alsa-project.org>
In-Reply-To: <18bf14cee505bb00-webhooks-bot@alsa-project.org>
References: <18bf14cee505bb00-webhooks-bot@alsa-project.org>
Subject: [Security] Segmentation Fault DoS in snd_config_load_string via
 corrupted linked list pointer
Date: Sat,  4 Jul 2026 14:07:38 +0200 (CEST)
Message-ID-Hash: GV273LXPW4UVTPW2KDZN2SZ52OG7LB4B
X-Message-ID-Hash: GV273LXPW4UVTPW2KDZN2SZ52OG7LB4B
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GV273LXPW4UVTPW2KDZN2SZ52OG7LB4B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #514 was opened from eglonnnn:

### Description

A segmentation fault vulnerability in alsa-lib v1.2.15.3. When `snd_config_load_string()` parses a crafted ALSA configuration text, the parser produces an inconsistent linked-list state during array/composite node handling, causing `list_del()` to access an uninitialized pointer and trigger a SEGV.

### Impact

- Denial-of-service via process crash
- Any application processing untrusted ALSA configuration text is affected

### Reproduction

All materials are available in my research repository:

https://github.com/eglonnnn/opensource-fuzz-vulnerability-research/tree/main/SEGV%20in%20alsa-lib%20snd_config_load_string

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/514
Repository URL: https://github.com/alsa-project/alsa-lib
