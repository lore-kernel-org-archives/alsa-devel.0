Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FB6C28B20
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Mar 2025 04:41:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A5CE2601A8;
	Fri, 28 Mar 2025 05:41:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A5CE2601A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1743136892;
	bh=tZySojFQvR2nk0SW830dG4dD+UnUgd7eCNLWBN8zEW8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=byiZLJqMt1DpVM+ExPklzMHuLVUF06KBZ2H7Fq4sp+X3g/KnZPTh11/JfkFcUbQyg
	 D/Uj+HZHh5O2UzUPQzOxUP/z9KmZAkAm1/Aj1Sh2ytCX8YFZF4L9UDNujuwatiaxXg
	 C9nWkzmyALbS5s0pdh/Nz9i6DcaZB2Daod0l/OqE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B87CAF805B4; Fri, 28 Mar 2025 05:40:57 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A48DDF805C2;
	Fri, 28 Mar 2025 05:40:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B1A3FF80548; Fri, 28 Mar 2025 05:40:49 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 56B30F80212
	for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2025 05:40:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56B30F80212
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <1830ddb9fe09c700-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/537@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/537@alsa-project.org>
Subject: Add UCM2 support for ASUS ROG Strix B850-I Gaming WiFi
Date: Fri, 28 Mar 2025 05:40:49 +0100 (CET)
Message-ID-Hash: 7LX22MUJUW7XEN6ZUA276QDGKJUKDVZ6
X-Message-ID-Hash: 7LX22MUJUW7XEN6ZUA276QDGKJUKDVZ6
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7LX22MUJUW7XEN6ZUA276QDGKJUKDVZ6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #537 was opened from austinthiel:

Referenced [this guide](https://askubuntu.com/a/1469066) to get SPDIF out working on my ASUS B850-I Gaming WiFi

[alsa-info.txt](https://github.com/user-attachments/files/19498803/alsa-info.txt)

In case it's relevant, using a sample rate of 48kHz is required. I found that other sample rate produces very low quality, garbled audio.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/537
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/537.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
