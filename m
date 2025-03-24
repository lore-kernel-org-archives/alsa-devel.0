Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E21C36002
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Mar 2025 12:15:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4C6F16017A;
	Mon, 24 Mar 2025 13:15:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4C6F16017A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1742818538;
	bh=3I4TXYVEbamAq4dKpnbIDcVy9CdlXXJinCJHbeanKb0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=bvKgnziJOw1c68HVdEv16L0vRmnCW7eO0qGsB0HqAL6hJoWtsjxcwdaVO6Ngx3F0S
	 fnyB9y9yW6KNeDlt2B2PbEBrFJTjDyGCSIw8X4i69hJndByxNYOi+ipwCM/JOd2zI9
	 Cu9JIQPXVME9AkCA4YYfOsqEO3BHt9fY9pt7HH0U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AEE7FF805C0; Mon, 24 Mar 2025 13:15:04 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 37537F805B5;
	Mon, 24 Mar 2025 13:15:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15004F80424; Mon, 24 Mar 2025 13:12:44 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 40F86F80075
	for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2025 13:12:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40F86F80075
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <182fbc0f0d9f7e00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/532@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/532@alsa-project.org>
Subject: ucm2: Qualcomm: fix typo in Lenovo T14s matching
Date: Mon, 24 Mar 2025 13:12:44 +0100 (CET)
Message-ID-Hash: 3IG3CXS3DYTXZMWNPYC7TJ3RYQNZYXZY
X-Message-ID-Hash: 3IG3CXS3DYTXZMWNPYC7TJ3RYQNZYXZY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3IG3CXS3DYTXZMWNPYC7TJ3RYQNZYXZY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #532 was opened from obbardc:

The original commit referenced an incorrect laptop model in the matching code. Use the correct model. This introduces no functional changes.

Fixes: e17dde6fd1c3 ("ucm2: Qualcomm: add Lenovo T14s support")

cc @Srinivas-Kandagatla

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/532
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/532.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
