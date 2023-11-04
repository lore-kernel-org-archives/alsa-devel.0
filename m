Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002CAC4332F
	for <alsa-devel@archiver.kernel.org>; Sat,  4 Nov 2023 12:25:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D9E8823;
	Sat,  4 Nov 2023 13:25:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D9E8823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1699100755;
	bh=hTBWud1WiUKp6Avuu9voneiNNJXiv6jNooi+NDU8PLM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=JkWeGAZ9YwEzb7IZuv97iDiYf/DigUJbUo3P07sbc3ZRV8MY9LHYEKgVPHkVsfjWG
	 xWPXT5IfZekM1TzhvJvApYWiUyl6qY/k7Cbck5XP7BnEBVejNcO0kM2WXCpK96+ElN
	 fz/RyXbgXdZMEYbpHsGV96FXejG+qmXrVZKqOvXc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 60126F80558; Sat,  4 Nov 2023 13:24:29 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B7CCF8014B;
	Sat,  4 Nov 2023 13:24:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B64EF8020D; Sat,  4 Nov 2023 13:22:20 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C02FF8014B
	for <alsa-devel@alsa-project.org>; Sat,  4 Nov 2023 13:22:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C02FF8014B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1699100536390785456-webhooks-bot@alsa-project.org>
References: <1699100536390785456-webhooks-bot@alsa-project.org>
Subject: [dmix] time for a default up to 8 channels?
Message-Id: <20231104122220.2B64EF8020D@alsa1.perex.cz>
Date: Sat,  4 Nov 2023 13:22:20 +0100 (CET)
Message-ID-Hash: ODUED4HKCXFWXWKATJSLNXL4JEXPE5VN
X-Message-ID-Hash: ODUED4HKCXFWXWKATJSLNXL4JEXPE5VN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ODUED4HKCXFWXWKATJSLNXL4JEXPE5VN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #362 was opened from sylware:

Isn't the time for dmix to try to configure by default the audio hardware with as many channels as possible up to 8 (at min 48/44.1 kHz, 16bits/float32)?

The channel map should be fine nowadays, shouldn't it?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/362
Repository URL: https://github.com/alsa-project/alsa-lib
