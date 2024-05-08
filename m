Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49749C04FFE
	for <alsa-devel@archiver.kernel.org>; Wed,  8 May 2024 18:48:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3009E0D;
	Wed,  8 May 2024 20:47:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3009E0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1715194080;
	bh=SzTZCfjBuw/1ITIzvCZJM9K5Z86ngtWwAOwkZXtM0YY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=cuF0vicV6JxsPMTa2sx9A3gCeVqoAF0ZEkNf7m1PZBW+PN9CwddsIBWp0kmnkV9HY
	 GsVhNYe6Zp4mkt72cKrtn8eHC/9UGRO9TiRlpZtdaMbQFJ4TzmN8A/pgnqX5ZsBy9s
	 /LZDbkdr1jeRfG2aT9VIT5sFkAP6AEy75/OJYUvM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC749F805A9; Wed,  8 May 2024 20:47:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A894F805A9;
	Wed,  8 May 2024 20:47:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B34B2F8049C; Wed,  8 May 2024 20:47:22 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 12335F8003A
	for <alsa-devel@alsa-project.org>; Wed,  8 May 2024 20:47:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12335F8003A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1715194037191637516-webhooks-bot@alsa-project.org>
References: <1715194037191637516-webhooks-bot@alsa-project.org>
Subject: Motu 828 (28 x 32) support
Message-Id: <20240508184722.B34B2F8049C@alsa1.perex.cz>
Date: Wed,  8 May 2024 20:47:22 +0200 (CEST)
Message-ID-Hash: QJS7E5B2ITDMASJRUCGXE3W6NIWPFVJE
X-Message-ID-Hash: QJS7E5B2ITDMASJRUCGXE3W6NIWPFVJE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QJS7E5B2ITDMASJRUCGXE3W6NIWPFVJE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #415 was opened from beatboxa:

The newest [Motu 828 (28x32)](https://motu.com/en-us/products/828/) does not appear to have a UCM yet.  It is a class compliant USB device; so as a result, it generally "works" at a very basic level; but default channel mappings and profiles do not. 

The system appears to default to only 2 channels in and 2 channels out.  So, for example, surround playback seems to mix into either the left or right channel.

In qpwgraph, it shows 30 inputs (I believe this includes an additional 2-channel loopback at the end) and 32 outputs, all marked as "AUX#," where # starts with 0.  I was able to identify which AUX# corresponds to which input or output on the device, through the use of qpwgraph and the device's built-in digital VU meter.

I have tried to create a UCM or even an asoundrc; but I have no idea what I'm doing.  The documentation and examples are not intuitive for me.

Could I collaborate with someone in order to get this audio interface supported?  I'd be happy to run any commands and tests you advise on.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/415
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
