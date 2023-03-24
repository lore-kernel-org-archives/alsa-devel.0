Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797ADC6FD1C
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Mar 2023 20:00:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E72FDE8C;
	Fri, 24 Mar 2023 20:59:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E72FDE8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679688022;
	bh=ZP5SgelNhp9dwlfmLib2ZZrHODTm7Gzam95wN/CasKU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=NbNG+tj3Lu0xILywlLYQIxLUmCMnOiSgQGih7z8S8ChxOzNG9cGPFu5/PBpmYOL2V
	 h9ucAJ7mBQtcmlD8NIQ7TdZSJGrct5BxtfRcGEMP4Z0Luof2+Hdhd14wwL8DL8pvg0
	 aWKG7R3IcK5KVl93iYpxn13Q0RQDaRJhCADVrHDo=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A372F802E8;
	Fri, 24 Mar 2023 20:59:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD600F802E8; Fri, 24 Mar 2023 20:59:05 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id A5A51F8024E
	for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2023 20:58:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5A51F8024E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1679687936852561712-webhooks-bot@alsa-project.org>
References: <1679687936852561712-webhooks-bot@alsa-project.org>
Subject: alsactl: add fallback for loading driver state
Message-Id: <20230324195905.DD600F802E8@alsa1.perex.cz>
Date: Fri, 24 Mar 2023 20:59:05 +0100 (CET)
Message-ID-Hash: N22KJK57FTGP4GH6KOV3ELQHTXFBVDYY
X-Message-ID-Hash: N22KJK57FTGP4GH6KOV3ELQHTXFBVDYY
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N22KJK57FTGP4GH6KOV3ELQHTXFBVDYY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #197 was opened from MrCry0:

Support loading driver state from the vendor-specific pre-installed sound configuration file /usr/lib/alsa/asound.state.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/197
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/197.patch
Repository URL: https://github.com/alsa-project/alsa-utils
