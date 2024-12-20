Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CB3E77188
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Dec 2024 08:28:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E5F060247;
	Fri, 20 Dec 2024 09:27:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E5F060247
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1734683282;
	bh=DVBgrxWoxUdhvSOjFkj3p1kX3AFiXPV+99aYlcTrsyU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=KepTFGmJvbGhfmyWruqnFGGOJse/jQ8awBHcADQ9lVdQINSHvboUUjiliQJ80qJZ0
	 c1LAKlYnF6Gmms8BG9safxr5CiCWcUytCMKtIE/eZ7X7A2Ehjo8fKqADjzxmETnJuw
	 xBrIHJMXq8TIKVExJ+Uw7t3DCl77E/34ibXHbYuQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3D3DCF805C1; Fri, 20 Dec 2024 09:27:28 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 258DEF805C3;
	Fri, 20 Dec 2024 09:27:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EB6B9F80171; Fri, 20 Dec 2024 09:27:20 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 12A08F80104
	for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2024 09:27:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12A08F80104
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1734683238197997570-webhooks-bot@alsa-project.org>
References: <1734683238197997570-webhooks-bot@alsa-project.org>
Subject: USB-Audio: Add support for TASCAM Model 12
Message-Id: <20241220082720.EB6B9F80171@alsa1.perex.cz>
Date: Fri, 20 Dec 2024 09:27:20 +0100 (CET)
Message-ID-Hash: O2TNVHAC5LTTNU4OJZTWLWO654HEHFBW
X-Message-ID-Hash: O2TNVHAC5LTTNU4OJZTWLWO654HEHFBW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O2TNVHAC5LTTNU4OJZTWLWO654HEHFBW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #490 was opened from Unveiled53:

Adds support for the TASCAM Model 12 USB multi-track mixer. Couple of things to note:
- This profile assumes the "USB AUDIO" setting on the mixer itself is set to "MULTI INPUT".
- Under the "MULTI INPUT" mode, this mixer has 12 logical input channels (Last two are a stereo mix) and 10 logical output channels.
- Most of the accessible I/O is combo XLR/TRS jacks, so I opted to have the mono capture devices (With the exception of physical inputs 8 and 10 which are TRS only) named as "Mic" with the rest as "Line".

Otherwise, the profile is tested and working with the latest USB-Audio profiles.

[alsa-info.txt](https://github.com/user-attachments/files/18207924/alsa-info.txt)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/490
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/490.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
