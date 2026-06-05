Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A480CD6E6B
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Jun 2026 09:13:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6413960266;
	Fri,  5 Jun 2026 11:12:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6413960266
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780650779;
	bh=Ea6Su996IBNJyJy/iKdTVesOgYfLDAIti0WEr5Uz+D8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=e6jJPZ265gOFzl9FusmubWHNuwFN08JYu+gNRuY4PzG3jsZ9dImedhmGU0bECPA7D
	 D/FCQzjeHRVdwD9Uu25t9nQwkleQ9Za7biC1zBYHw7qnASagoWAgKt8sElq14nVb3B
	 OQbvsrpYP5AEiytgaciFloqJs4iLUK76OumHAXZg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B686FF805FE; Fri,  5 Jun 2026 11:12:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F124FF800D0;
	Fri,  5 Jun 2026 11:12:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 55F4FF8047D; Fri,  5 Jun 2026 11:12:11 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780650730;
	b=CuQO7aV2habKbHpfqB8gI3ZQY2X76vSgubx1ZM5fIx9B/ohsu7D1xdPyMUMFuaZ0W11s
	 2gKfJHmMv0MTJOQdfNCsBkKr90MlfJ6OcORmADdZyuWvER4Oq2RwCl5bV+noIX7hURrRQ
	 +cEdEPlfHYK+GpqKHMRIPpyys7f6BE8aNu8aGjlihteaDT5z9wNH3RFXwwdPQ9nO99fX3
	 bupJmOCaOXqidT8cw4afIk3SaXMYM9Jf7QsBgo3IVJvvn2zDOJ+6SalM8ret7Sg7EZHZN
	 J+wyc+xlRQvb7+96sv95ZE3d4+Qfwl9euqy0zvImMyWXU2MjcYmQBAcr3Skprfz/BRw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780650730;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=Ea6Su996IBNJyJy/iKdTVesOgYfLDAIti0WEr5Uz+D8=;
	b=RgivhPZbbaX7PpbJEou1NIt6vonPhgwRoSOIRYPDA62aq5oPjrGMvz9PHUrhAgt2uHl6
	 9IDVbhxvu9jQ9rKLvU4SX+PFTxY+4pWRU0Cgha8YUjO46RwKjMWB4WEQcd/z7UFRzbD+d
	 mG0w4Nc+WZoe/YEPt/4bTtwpCiK9cSvLVKFtFPXRWZFYdmJ5vcMwjDA7bXeMwAyqYEwCJ
	 AGPhnN2feuT/5UrZz8ktq2c2HMY1BA44djSFtQQAVxbhv6l5+lGK0tq+6fTknPyBlyPX9
	 BcSEYSJcU2Pe/eo3y0wfnUY01bhurLbGyDjolFdq5oWlMBY4qFTR3EXyRitoJbs6Y2A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id B7503F800D0
	for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2026 11:12:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7503F800D0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b624676dca9d00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/778@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/778@alsa-project.org>
Subject: Fixes for cs42l43/cs35l56 bridge speaker amp configs
Date: Fri,  5 Jun 2026 11:12:11 +0200 (CEST)
Message-ID-Hash: VLN47O4NJA3BTKE4VXJRU2WAWOALDOFZ
X-Message-ID-Hash: VLN47O4NJA3BTKE4VXJRU2WAWOALDOFZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VLN47O4NJA3BTKE4VXJRU2WAWOALDOFZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #778 was opened from charleskeepax:

Update a couple of issues with systems where the speaker amps are connected through the codec and the headphone output is not being used on the codec.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/778
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/778.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
