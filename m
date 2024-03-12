Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7831C54E5D
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:01:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F04A5E0F;
	Tue, 12 Mar 2024 15:00:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F04A5E0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710252063;
	bh=tq8NoXBkQdTZ6Rcra4ICm8lAeeH4K2bfKPvM7HgN598=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=AHU3hAPQD2sQITuwdWQ6R5+rAf6JLnIB4lclGtDbJ2nAYWMeVKI0hKifuGp9pDiyz
	 IiA+Z10RDApm9PtHKcp2t1jALqJg+9LjUEYU3SGbDK9qxbGe5+3zs/Ye6hNcJTZIMb
	 RPrDFF2cGz9Q56oHmflm9NpfFdH4G691r4IBJxmA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 82F03F805A1; Tue, 12 Mar 2024 15:00:32 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EE67FF804B0;
	Tue, 12 Mar 2024 15:00:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E1AD8F8028D; Tue, 12 Mar 2024 14:58:29 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 36078F80088
	for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2024 14:58:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36078F80088
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1710251905489773512-webhooks-bot@alsa-project.org>
References: <1710251905489773512-webhooks-bot@alsa-project.org>
Subject: Added new utility aseqsend
Message-Id: <20240312135829.E1AD8F8028D@alsa1.perex.cz>
Date: Tue, 12 Mar 2024 14:58:29 +0100 (CET)
Message-ID-Hash: WBKKZ2ZTXODRGWGDBPV6FFVVD4R36K3L
X-Message-ID-Hash: WBKKZ2ZTXODRGWGDBPV6FFVVD4R36K3L
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WBKKZ2ZTXODRGWGDBPV6FFVVD4R36K3L/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #257 was opened from mj15003:

New utility **aseqsend** enables to send MIDI messages encoded as a string of hexadecimal characters to specified ALSA seqencer port. Similar functionality is already available with amidi tool, however only for raw midi ports. **Aseqsend** command has been developed mainly to conveniently test and debug another MIDI software. I think it might be useful for others to be included with general alsa-utils package.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/257
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/257.patch
Repository URL: https://github.com/alsa-project/alsa-utils
