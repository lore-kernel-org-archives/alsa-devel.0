Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B70EE020D
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Sep 2023 20:55:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC499A4D;
	Wed, 13 Sep 2023 22:55:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC499A4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694638557;
	bh=6xOkHNVdY0S5bLxrwP2LBKo+uA1WkDFNX31okXsuivc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=TQcEexBhlP5+dV7ChBOBEXBDxmeB5V5EDVjYlduKgJnH4Q0cqbwSom1oiqssuT+DK
	 n+4O6YZCIzgjoNcoHL0IjMtXGvdF/emmqg20s74AgCff5b+C38Qzgf1xh3nlYaPBqC
	 lW5bjSARAwAMDhPLXHyJGEvoic7nWqGb7Dygv9QE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 02410F80551; Wed, 13 Sep 2023 22:54:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 893B8F80425;
	Wed, 13 Sep 2023 22:54:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8BC4CF80425; Wed, 13 Sep 2023 22:54:40 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B344F80212
	for <alsa-devel@alsa-project.org>; Wed, 13 Sep 2023 22:54:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B344F80212
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1694638477700409412-webhooks-bot@alsa-project.org>
References: <1694638477700409412-webhooks-bot@alsa-project.org>
Subject: No sound output from ALC4080 on MSI X670-P
Message-Id: <20230913205440.8BC4CF80425@alsa1.perex.cz>
Date: Wed, 13 Sep 2023 22:54:40 +0200 (CEST)
Message-ID-Hash: CGTATZ4VFEMIPXDA7LE5RX7NRPQLDLPL
X-Message-ID-Hash: CGTATZ4VFEMIPXDA7LE5RX7NRPQLDLPL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CGTATZ4VFEMIPXDA7LE5RX7NRPQLDLPL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #352 was opened from gopokyo-colinn:

Hello.  I have the MSI x670-P motherboard which has ALC4080 which is USB audio.  I am provided with two USB audio devices, SPDIF and Speakers.  There are 2.1, 5.1, and 7.1 profiles.

I updated alsa to what was in debian.  My USB-Audio.conf file has an entry for my motherboard, but the ALC4080 conf file does not have a special case for my motherboard.

I do not know if my audio is supposed to be working or not.  I am running Ubuntu which replaced pulseaudio with pipewire.  I am not sure of where to start looking or how to troubleshoot this issue.  Any help would be appreciated.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/352
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
