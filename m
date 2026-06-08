Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E4ACD8C9F
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:50:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EECE3601CA;
	Mon,  8 Jun 2026 14:50:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EECE3601CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780923056;
	bh=8TZzMTalXs0Au5ejuG5plVY2bXnumwr+AkOXEsMg+FQ=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Ey5qReefblD+ima+IHuvIJ94O731klvxkZUNckRAkjprnuUR8U8EK4hSZr7IYYbvN
	 E04Du5zCcBKS/xEEvu3waU1iPptyvPhnOL0vXjbs58kaMaV8N0JPTULU2xFi2046mW
	 lyAiABSSiVCrFepAmaPGif5hk4Q3hkg+cCCCm+pk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 00895F805FF; Mon,  8 Jun 2026 14:50:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B074AF80600;
	Mon,  8 Jun 2026 14:50:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A9085F80423; Mon,  8 Jun 2026 14:50:12 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=77.48.224.245
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780923008;
	b=aOrBVJYC2U5aAV9efjUWVK8DwzIWGs3sAtCL28N0p1DuiGF2loEl/emXiO5QB0BIdXCl
	 8sPd27fJirLfGpgDepYxKyGXhibUe/6eYEcdcbedxMScNuGKXV7yxddyjIEmA217dTIV/
	 vVL0pu02HREDS98XGMJ4X2a9ffp4idrPr/KIpx/lWEsJfsQaKPzaH0DFJgRrsJv3iTcj9
	 ZZh5H5WHSumCy1dFpKntO6acldspTpVzuu6mO9tuZaTPmRaz3gw+v4oAruIBD6ynxjXRE
	 aFM1N1pxCG+2PbDmjteLp8ckefloBPpZOcwvuNrB5Kgex1ydaPuqXg8xZ2NhfJJ2byA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780923008;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=8TZzMTalXs0Au5ejuG5plVY2bXnumwr+AkOXEsMg+FQ=;
	b=mgu27J2vKlYni1mvNH/89xoNlEddlbFGi7wGFFokYPlQLp4ethzAwSmgKJsOfpnND4LX
	 bnxgDDBof690AFyKS/QzRcaOFDNwSG+6VSs670xkIdi+x/QCN1ky5moHGveUtbArNbRzp
	 ipTMuMcWxkyAsabS2WeI9YXRN31wdze+vMCjahsbRT37ESdTMlZLuX7cXRGv6uYi2+/1O
	 fwD6TG/ijcAuyqSnVWkwQFjMaXuBrWxKcMrwznP8spnAQJXOO0BAOyIz+O67s85Msd0y6
	 ctU0HnNHtMLtOfulb31Oxtgm+xSMaLkivhfob1YbtMYO+9DdFKcX9CAtQKXfbqLyAtQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=77.48.224.245
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6AD1FF80124
	for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2026 14:50:07 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 50DF7BB0;
	Mon,  8 Jun 2026 14:50:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 50DF7BB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1780923005; bh=ef7XffzNQehz4EhUfOkkPLWTkPPRZ8pOU+AT6YmpkoE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ga0+eDrhctO5crlMiapbs8pX6dJnOe+VE/dWlB4zWMSh9NExHcecjhBX7ETapngVp
	 AXKZNXUH7rzLEQQLYGBh5Rx9jqVuY/PGk9zrsEVmt2HPdGayIMdBE1shtIu/Q6pItM
	 kVxB2Gol5mnZkIxlDMaus8FMa0ekl1iSZVgbJ784=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Mon,  8 Jun 2026 14:50:03 +0200 (CEST)
Message-ID: <3bc19b9c-77f1-443f-88d9-d78508cbfa28@perex.cz>
Date: Mon, 8 Jun 2026 14:50:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Security: double-free / invalid pointer dereference in alsa-lib
 config parser (`parse_def`) via crafted configuration text
To: Luigino Camastra <luigino.camastra@aisle.com>, alsa-devel@alsa-project.org
References: 
 <CAGt8pqBU0p2voB+qHxWGcNJrKHAcBhAyHUUBPLBN-Yj_SiV6MQ@mail.gmail.com>
Content-Language: en-US
From: Jaroslav Kysela <perex@perex.cz>
Autocrypt: addr=perex@perex.cz; keydata=
 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
In-Reply-To: 
 <CAGt8pqBU0p2voB+qHxWGcNJrKHAcBhAyHUUBPLBN-Yj_SiV6MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ISKZ3EXJK23OMAOMWJIXNZDFMUIBAJEX
X-Message-ID-Hash: ISKZ3EXJK23OMAOMWJIXNZDFMUIBAJEX
X-MailFrom: perex@perex.cz
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ISKZ3EXJK23OMAOMWJIXNZDFMUIBAJEX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 6/8/26 12:05, Luigino Camastra wrote:
> Dear ALSA maintainers,
> 
> I am writing to report a memory-safety issue in **alsa-lib**'s
> configuration parser (`src/conf.c`). The bug was found by fuzzing the
> public API `snd_config_load_string()`, and is reachable from any
> application that loads attacker-influenced ALSA configuration text or files
> (`snd_config_load`, `snd_config_load_string`, `snd_config_update`,
> `~/.asoundrc`, etc.).
> 
> ## Summary
> 
> When parsing a nested compound (`{ … }`) or array (`[ … ]`), `parse_def()`
> calls `parse_defs()` / `parse_array_defs()` but **does not check their
> return value before continuing**. On a parse error from the nested call,
> the inner level has already deleted (and unlinked) its node via
> `snd_config_delete(n)`; `parse_def()` then falls through and calls
> `snd_config_delete(n)` again on an already-freed / unlinked node during
> error cleanup. This corrupts the configuration node list and leads to a
> **double free / invalid pointer dereference**.

Thank you for this report. I've fixed this issue in commit 536dd6f8 ("conf: 
add missing return value check in parse_def()") .

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
