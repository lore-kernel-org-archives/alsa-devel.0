Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCB6C44507
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2026 04:59:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F279601F6;
	Fri, 17 Jul 2026 06:59:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F279601F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784264386;
	bh=35ewuQ5Zed9Y0UN68PlYH3d5vdlpXenY3mF06lzcStQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=eyJ8yZyKj4Kvw0xd6YeKRuP0kklgT2Dgx3SnWtXUxslqal0DwUW7ve1HQqud3Zsp9
	 kUueoY7UCpOv4BsJJZ0Yrq/a8dcQHxgdqLmlCwl8OBzIctvJXibryI4vbLKq5mFDtn
	 yOJ1jPHanAaw7mVEEHaR6vTYhpgmhpmAT2qATNlQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0C830F805F9; Fri, 17 Jul 2026 06:59:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 29D19F80600;
	Fri, 17 Jul 2026 06:59:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A6668F80526; Fri, 17 Jul 2026 06:59:05 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784264345;
	b=V8liqYOtHrU5Slt3K3DcmnclOYgXK1ZLdwdZLa27lfw5rVfBfw1OVx3msh9fbh8jJVOK
	 keK3cb7lCkhI0IVhs6JyVzxrKvu2UoY4VxYJyIg3cJKTfZuUOXVe/Qjtyp6TQwhlMsh/s
	 UAGNeou9MtEMQYMuvfqfRx8lVBSXCIAqnsQ+W/eKh6eNXhRfJ6KRcdLi0BWZIL+wVi+9T
	 acXHsNgiyBV2wGHfutpGuD8j/f2mnf7bvUTfs7tX9yqLCNWsPjEzsScM8/KwS4Pm55jSN
	 dV9BJcJ4A0iTbbev9SZHofiHPgKx+ts5HDQOS7k2SPJqEvKu/pvXWuSshTmjTUX9mSQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784264345;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=35ewuQ5Zed9Y0UN68PlYH3d5vdlpXenY3mF06lzcStQ=;
	b=Ihkd5DB6tlF1d+rfFgnJAvisILPPz7Ux2kwrs034AFsCOLt4Q8rlPSiofkd9aXvg2iHn
	 K8Di5pZYzhIbLhcl40HBI4i0Uk0Rjutcb4RMbJFKZbl41pMag2nzmu6a2D6grURq+qEoe
	 umxfDpc52T93VhoTOMa6o6SOasJwxHHa12TDKjYvbJWsv90jXfOj4xS3ZDyJjSYQ7tJ8B
	 PnpqlGU09Tz2qBqj9RLLWk5PMYY6dtBfbrl+SUxbZt71IXJBw8RvyP7N1NVorRrwbkcpv
	 tJKveylJVnRGFHR/HeupxLP2YF0grm4oI3kgUUcFes+gEblTUUhRKju0ghClkspnALQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id E7A70F8047D
	for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2026 06:59:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7A70F8047D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c2faf76a2c8400-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/811@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/811@alsa-project.org>
Subject: USB-Audio: ALC4080: Add MSI MEG Z890 ACE
Date: Fri, 17 Jul 2026 06:59:05 +0200 (CEST)
Message-ID-Hash: GW3RM5CMQCW3HFCSMZAORBDNDFG6M465
X-Message-ID-Hash: GW3RM5CMQCW3HFCSMZAORBDNDFG6M465
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GW3RM5CMQCW3HFCSMZAORBDNDFG6M465/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #811 was opened from tosoyn:

Add USB ID `0db0:f70b` (MSI MEG Z890 ACE, board MS-7E22) to the ALC4080 match list.

Tested on the actual board with Ubuntu 25.10 / kernel 6.17 / PipeWire 1.4.7: with this change the card is split into Front Headphones / Speakers / S/PDIF sinks and Microphone / Line Input sources, and front panel headphones + microphone work correctly (stock profile routed playback to PCM 0 only, leaving the front headphone jack on PCM 1 silent).

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/811
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/811.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
