Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF43ACD6E6B
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:55:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 94B926025E;
	Thu,  4 Jun 2026 15:55:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 94B926025E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780581330;
	bh=ykR57S+dq5VdzWTG1k96O1xu4uuH+r+y7CTxVe1/6DQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Lk4fBhlJK7dMmw4eFVDYHUWVHaPXt74O4VJnB8xjAbi+qhzSiwyo+7mOxDpFc7tPT
	 Gqm+tEAen7lfuKw8Zu10pFSAfR54K+6760bW3g1vvWAQvPvCnF49KbNs/okrG1y5IY
	 H/YtxjZoNKP5qczcdBAZNK/TasgFw6OfshMUHdLw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EDF23F805F5; Thu,  4 Jun 2026 15:54:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A35CDF805F7;
	Thu,  4 Jun 2026 15:54:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7E63BF804CC; Thu,  4 Jun 2026 15:54:47 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780581286;
	b=ba7SuTd9vyUig/wg5zErhP65s3jkG6jJDG48OHQaRFi4UkhuXjuEmd1GzXLM3cXcB5N3
	 1Ohw2ULOlzL4IdUhMbWWhnwYCvQXtPwpjgCx5uFbMVKDnQIdS6Ycridb34xdzPYcxWnED
	 2+HAGo3jflfhK6mpDixbWHjL66afEwzhbyTmZcLhu9+VYoOZUnjJYJuFvq6b5cSwPPklj
	 idIe6d3buj2Tt9i94EVMfM8x+MqlzGVZtlSktGtIua6fsFVOUjQULfv+L8XttJww6XgSW
	 0QZR7EqFKOuihJD+lXMthuPjEPetIYuZ5hVGhaDGIlLAqxxR9+2k39dbOUKZVnbkA6g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780581286;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=ykR57S+dq5VdzWTG1k96O1xu4uuH+r+y7CTxVe1/6DQ=;
	b=p7wi0i/p9n7cIQvQONjax6RbtyQ/DSigINrP5yKo92fC6wS/jQvgwitX/rH+IM2oegrA
	 yDiMw9Gle8ke7IBjcHA5SdxqVKn0QgvWUzlS0Q3fgri1wtdaC7g/6ErMr8JyY/KRLHqiT
	 dmkzP4PxJ9+B7NYQYDWopi5g+EpPI3/TO7/Rpf7NI5/CK/RxIuMbWs0+ca0SLOTQ1QMcv
	 vGWaRJu6LycLRL4PbaIzLjgJjSz15I7zukPERL2dRdM3ACCmkPFGrpgiNhEo2ZP5YIppb
	 6+Xbrh/a3LdkXBgSsLY0s0Z2Z+J7Gv/ZQTiZ4t5IHX2t8z/UHHpF90rFZHQxyTwODNQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id D080AF8047D
	for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2026 15:54:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D080AF8047D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b5e53ec7692b00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/775@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/775@alsa-project.org>
Subject: sof-soundwire: cleanups for rt712, rt713 and rt722 multi codec
Date: Thu,  4 Jun 2026 15:54:47 +0200 (CEST)
Message-ID-Hash: E5EOYCLFPIXM4HVA236BTAJJ7SRWPYFX
X-Message-ID-Hash: E5EOYCLFPIXM4HVA236BTAJJ7SRWPYFX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/E5EOYCLFPIXM4HVA236BTAJJ7SRWPYFX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #775 was opened from perexg:

RT712 - move rt712-dmic to rt712 config (included in If.multi_init and from HiFi.conf)

RT713 - move rt713-dmic to rt713 config (included in If.multi_init and from HiFi.conf)

RT713,RT712,RT722 - do not include files for individual devices when multi codec is detected.

Declare 'MultiHeadsetShadow' variable to be consistent with other shadow variables (Speaker, Mic). Use it for RT712 and RT713 (Headphones/Headset devices).

Link: https://github.com/alsa-project/alsa-ucm-conf/issues/774

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/775
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/775.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
