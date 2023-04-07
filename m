Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C5FC6FD1D
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Apr 2023 03:36:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6888E7B;
	Fri,  7 Apr 2023 05:36:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6888E7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680838612;
	bh=cnTmYXvHs4eV25S7ywymaSS8Y32ISsPiXEDwb9Nxlr4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=IqoxEoaNn0nb78FYwylr1fGWyD1qEmSABP12hRuXnzlCq0iJEbgm9Xwt2ipTq5DVz
	 YmPnYVO+wcggA7iWRaMNgFJyljdZ7+yEWbmOeNfCiWPzP9Tdwt6b61ojaq7uAP/G8d
	 P8pVebnEKvi/KvIFQjRVS0eZifxCscyUtKb5X0z4=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 181BEF8026A;
	Fri,  7 Apr 2023 05:35:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E65F1F8026A; Fri,  7 Apr 2023 05:35:35 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E5B9F80149
	for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2023 05:35:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E5B9F80149
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1680838534346010447-webhooks-bot@alsa-project.org>
References: <1680838534346010447-webhooks-bot@alsa-project.org>
Subject: [question] [ucm] how to manage the ucm and ucm2 for different kernels
Message-Id: <20230407033535.E65F1F8026A@alsa1.perex.cz>
Date: Fri,  7 Apr 2023 05:35:35 +0200 (CEST)
Message-ID-Hash: RVTXWAYI74H2JFJRX2AUCQQWROQFHXRP
X-Message-ID-Hash: RVTXWAYI74H2JFJRX2AUCQQWROQFHXRP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RVTXWAYI74H2JFJRX2AUCQQWROQFHXRP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #301 was opened from leif1992:

I got a problem which confused me for a long time. Wish I can get a good answer from here.

I write the ucm and ucm2 files for my sound card which can work well with my driver. And I need to support both 4.19 kernel (which use the ucm) and the 5.4 kernel (which use the ucm2). They are all deployed in the /usr/share/alsa. However, I need to install to audio driver for both 4.19 and 5.4 (DKMS). The ucm and ucm2 were both deployed at the same time. When I switch the kernel to 5.4, my ubuntu can't load my UCM files normally, and if I removed the files in the usr/share/alsa/ucm and then reboot the OS. My ucm files in the usr/share/alsa/ucm2 can be loaded normally.

Would you please help me figure out this incompatibility problem?

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/301
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
