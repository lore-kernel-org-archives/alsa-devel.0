Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0858FCCF9EB
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Sep 2024 02:15:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 131B8852;
	Thu, 26 Sep 2024 04:15:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 131B8852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1727316918;
	bh=HTp+jdOdyubEnx8qiG0C1/H7OJxc67Iz8dm7MYshmFo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=oNL7BcCnkyYdpcEpxEFlrRzm9S5etrpVQTP0OTZW8+dqR67oSim0rUJMyl3HzkwG9
	 038MektfJwd2/X/Y6vmUXsXnsWTRcqzcrxWTngGI2MQWPHo4qY3gB8aN5aqnJcbLdH
	 sXDI39ORnri6Pq+H+4loBHBtkSKqyyZZ/Ftm1W4A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 45287F805AA; Thu, 26 Sep 2024 04:14:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B5C7F805B6;
	Thu, 26 Sep 2024 04:14:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 168E5F802DB; Thu, 26 Sep 2024 04:14:40 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 4FC6AF80074
	for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2024 04:14:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FC6AF80074
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1727316877687193394-webhooks-bot@alsa-project.org>
References: <1727316877687193394-webhooks-bot@alsa-project.org>
Subject: GoXLR - Dynamic Output Channel Count
Message-Id: <20240926021440.168E5F802DB@alsa1.perex.cz>
Date: Thu, 26 Sep 2024 04:14:40 +0200 (CEST)
Message-ID-Hash: QPNRUADEYMIX7CEWWQJDA2NTYO3BQ4Y7
X-Message-ID-Hash: QPNRUADEYMIX7CEWWQJDA2NTYO3BQ4Y7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QPNRUADEYMIX7CEWWQJDA2NTYO3BQ4Y7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #444 was opened from FrostyCoolSlug:

The next GoXLR firmware release is going to add two new output channels for the full sized device, labeled a 'Stream Mix 2'. Outside of general usage, there's no way to determine whether these channels exist or not outside of the UCM2 definitions as the device is booting up.

Is there currently the facility to configure the devices virtual channels based on the number of channels reported by the hardware (so if there are 23 hardware channels, use the current configuration, if there are 25 hardware channels use an adjusted configuration), and if not, could you suggest the best way to handle this implementation?

Regards,
Craig McLure

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/444
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
