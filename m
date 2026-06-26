Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59B6CDE008
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:32:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A2B2A601E0;
	Fri, 26 Jun 2026 11:32:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A2B2A601E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782466347;
	bh=PuwBcMisE1G5lEY60KiMMfQsROVwbe95dAJDgDVZuw0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=etkoMw7pOaYnwCq29pVI/WK3YLuROblpCDLHRAzTjYKv2ltKKIP/zmca4OiXDCgBz
	 WP0cGSRaIAamhPIcnMl5yFhanp/Y+E0UvA+cAto5LD8fjva3gjg5ZRl3g59DElujL9
	 OOqEP/q1kQsYwk53PC+rd57/xwprQXHr8fyP50gQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 73FD4F805F7; Fri, 26 Jun 2026 11:31:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1806CF80602;
	Fri, 26 Jun 2026 11:31:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8F309F8010B; Fri, 26 Jun 2026 11:31:45 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782466304;
	b=q8P1aMxVe5gJC5uF0ETigJmfY3pkdtD0F+M8epg8+RUXhX5aGEDJfzeniQZGeR/aVujH
	 2JvGGsRvCAlnjWbIha7qTHdBykKP7e2UCKxzKrJHnJzkI2xK3njfZKWTJxgEXuXwZlBE1
	 +9X5WCy3jz0HRRtRWpVDyTtjLJcS1UJnB3h6HVreu9Tslydt85y/OZB+0snA60lKAxpgV
	 7Neg3cdvkw2E/I9YfS+i9ELu0tbK2gujJTdLE3au8NfrKuHw/f/4HKUDvK1R5Pa33gsWI
	 Jd21RrUJZeXI8C0ynEGyvjSgQIV7Nzvnfjf0jGE/u+QyQ5wnu2xjIc3Bf9SvJGieEPw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782466304;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=PuwBcMisE1G5lEY60KiMMfQsROVwbe95dAJDgDVZuw0=;
	b=DpSb/N+a2QMxlEOX4DvExADTEyfNBQjJhY1WKOZyIlnAPeCwoNNPoH58oC7zlGmxI2w1
	 USW8sNJIsYtgKfXWZ4IsJJVjGS4zmMtEtBLRwAI9W8S1AXY+i6N3g77SQOq01Qp+ayPjP
	 ylPD0SKgElgyVCaGiiQ9eQuAxfAGgKjYGjoFGeZ83OHvQqK2a7Bu1edhGj7eiTwIeehUP
	 jdHxxS8YI0IGo6hstaHHFDqS0F5eLEI+dk0HoKO6ot7XQOXGMh3xz7xClcapL3UXff4EA
	 Tc03iM2WhQ7SHRZaA+NwTWCRIxzM02PSjco0wJqmDtgHHLfHx0x3NkiEh9oAq2rqnAA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 249C6F8025A
	for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2026 11:31:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 249C6F8025A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18bc97a8852f2000-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/797@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/797@alsa-project.org>
Subject: ucm2: MediaTek: mt8391-evk: Fix channels and add volume controls
Date: Fri, 26 Jun 2026 11:31:45 +0200 (CEST)
Message-ID-Hash: FNEDXC4PKFBUZDNSNZMML4L5L2VTVH24
X-Message-ID-Hash: FNEDXC4PKFBUZDNSNZMML4L5L2VTVH24
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FNEDXC4PKFBUZDNSNZMML4L5L2VTVH24/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #797 was opened from zoran055:

Set Speaker to stereo and add PlaybackVolume/CaptureVolume controls for Speaker, Headphones, Headset and Mic1.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/797
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/797.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
