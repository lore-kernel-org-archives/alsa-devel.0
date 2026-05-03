Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD7AFF885A
	for <alsa-devel@archiver.kernel.org>; Sun,  3 May 2026 07:53:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 031A96018A;
	Sun,  3 May 2026 09:53:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 031A96018A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777794819;
	bh=E3sn1KxsJ3FFUIGpGRoQvqNthwp935bSSo9TVTTnjG4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=la7UUPbwKYBCPoPAXJ1PuooRMeJzYkkq5ywrizFIasUVM3u/4P6churfcEQq1HwLV
	 w3JeHjUG6R0Y3TnuMhdvMhMDJnrv9Ohb9SUNOVQsaY6V9Kgs1mYTl8lOD/gH26/rb8
	 hp2rzJo1usZiQ8fdIFLL4jJoExw6YtQRJ220wynY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1B22FF805EE; Sun,  3 May 2026 09:53:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CFA24F805EC;
	Sun,  3 May 2026 09:53:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1E892F804F2; Sun,  3 May 2026 09:53:00 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 56E24F8021D
	for <alsa-devel@alsa-project.org>; Sun,  3 May 2026 09:52:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56E24F8021D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18abfeee59809400-webhooks-bot@alsa-project.org>
In-Reply-To: <18abfeee595a7100-webhooks-bot@alsa-project.org>
References: <18abfeee595a7100-webhooks-bot@alsa-project.org>
Subject: SSL2 Debian13, Kernel 6.18.21, lates alsa-ucm sound issues
Date: Sun,  3 May 2026 09:53:00 +0200 (CEST)
Message-ID-Hash: Y7KH3YCA2FZOX6CZBVYPGRRKJBWBEQ3F
X-Message-ID-Hash: Y7KH3YCA2FZOX6CZBVYPGRRKJBWBEQ3F
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Y7KH3YCA2FZOX6CZBVYPGRRKJBWBEQ3F/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #749 was edited from brandtan:

Hi Team,

everytime I start discord my other peep can hear themselves.
The issue is: Since firmware version 1.2 of SSL2 Audio interface, they addded loopback channels ( RL & RR )
THose channels are automaticall being routed to respectice inputs obviously and in addition to that, these channels are being routed to any kind of audio software: Discord, Mumble, OBS etc...

What can be done against it.

Latest kernel, latest alsa-ucm, latestes everything. I tried nothing since I do not know what to do.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/749
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
