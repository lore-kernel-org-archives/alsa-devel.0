Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCF4606A336
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Pm+UD2Gx
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9101A60218;
	Thu, 26 Nov 2026 07:29:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9101A60218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795674567;
	bh=rdYrNduQuGDcRGZYvtNaMMAEGj97EnO0ZiFunYTms4Y=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Pm+UD2Gxz5wWmJK6WRB8nSTmL+r9DNpln7pghLTkr5s9/i0ePcDiu95JDs4AO3qfT
	 ViYrvy51iYsbgwOsGV0XjP5QOHkRrn21Kj8R112FzPAo947OG6wB2hInDsjrWtxgph
	 ErNv53rfD7jeuIpKs7mnDUDGHTxtB4mxmnpcuRlI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F2853F805F7; Thu, 26 Nov 2026 07:28:52 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 186C3F805FF;
	Thu, 26 Nov 2026 07:28:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E059DF8051E; Thu, 26 Nov 2026 07:28:43 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795674522;
	b=HQ/CCRAhIVX2RmMmVkgvzq0XabJ8YJXVT2c5kps9OqIrK3JZfNUfZ+tFKo0EH3r3rU62
	 zlfog+LZVyjzRYOeQZlXxEvmR8zqrDgiAq2JDGyS6NnXiDm0WDO9wVIWWtRiZ0MY1IEzk
	 o/FJWDp1mlIaneU7yws7WUR1QgI94ykfRFToaNEq0gh3JfY7hQ74zpyxIMVjZAcltO+6/
	 d3cdiJk5Qa8XrzlazTtDmONS6Cv46yzj4QamS+4s1fhFvmfmw1+BLE0oXbhEEezbB+KAn
	 wKfACrQ6cR7ZUz8/4BwnZPgKIFPFIfPN6n78JBJuyy+WIfH7F66i7x3QI6qXc8T4+hA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795674522;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=rdYrNduQuGDcRGZYvtNaMMAEGj97EnO0ZiFunYTms4Y=;
	b=do1V774XFbB/vAbJ+JYoAZthBG5JahMoTOXF6ef4mCciYBXW8BWeUSSroqtjvG3DCkx6
	 p++XPN7r/kbxOLD0a0C/xfjTgBUB6Bya8hYpiLAJeFcJNfPgVvTJhplMG96QeFlbWQQ1T
	 gzA9PAWBD0IQgl1tfxjmeQyP00RidaFAEb4dQ4B29bTrw1CBCrBrzJd5jgflO9XvEmeLz
	 mKbj+rVQmfPQTkDOyFdS9I3P9Og596d4nt9jTbOrmzvGAmfrRz+wLPYzRdXTggMgUBHBu
	 7z7z6gIFmdwNCGnAbHWh1NhRzmE75Zv+tMlBGxmIu1EgujZn6kiNcQgH3qZYwms/ChQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 47558F80100
	for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2026 07:28:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47558F80100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18eb84765baa6b00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/841@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/841@alsa-project.org>
Subject: ucm2: Qualcomm: sc8280xp: add DisplayPort devices on X13s
Date: Thu, 26 Nov 2026 07:28:43 +0100 (CET)
Message-ID-Hash: LBHARC6CAKFSU5OK64GEFFR6HQILON7M
X-Message-ID-Hash: LBHARC6CAKFSU5OK64GEFFR6HQILON7M
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LBHARC6CAKFSU5OK64GEFFR6HQILON7M/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #841 was edited from jglathe:

Add HDMI0/HDMI1 DisplayPort playback on the Lenovo X13s HiFi config.

Muxing DISPLAY_PORT_RX_0/1 onto MultiMedia1 together with the headphone backend forces a single PCM and a ConflictingDevice dance. Dedicated frontends let each DP sink run its own playback at the same time as headphones and speakers.

- Headphones: MultiMedia1, `hw:${CardId},0`
- Speakers: MultiMedia2, `hw:${CardId},1` (unchanged)
- HDMI0 ("DP0 Jack"): DISPLAY_PORT_RX_0 / MultiMedia5, `hw:${CardId},4`
- HDMI1 ("DP1 Jack"): DISPLAY_PORT_RX_1 / MultiMedia6, `hw:${CardId},5`

Arm the DP mixers from the verb EnableSequence (same pattern as the IdeaCentre Mini). Device sequences only flip their own mixer; no ConflictingDevice between Headphones and the DP sinks.

No JackHWMute on playback. Headset vs internal mic is priority-only (200 vs 100).

Needs the matching SC8280XP-LENOVO-X13S topology change, merged in https://github.com/linux-msm/audioreach-topology/pull/77 and released in audioreach-topology v1.0.5.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/841
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/841.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
