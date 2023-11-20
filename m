Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A79C2BB3F
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Nov 2023 16:20:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C92582C;
	Mon, 20 Nov 2023 17:19:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C92582C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1700497230;
	bh=a2Uu8UI8V0vvRA3hscoyzszAisM9xQQnRCyxHTEGNwM=;
	h=Subject:From:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:Date:From;
	b=V0HYsdI+iyA8r7Xmj2ygObIoqvKL0EIuOYy2P5i41JKUfwBhPQnzuCXLXdXDsgW0q
	 mweAu1wj+76PqhhlMdG2BsiaNdh8+YCq4iHf87g2RcDxtf+pT1VxAzG+6F4xYv5g1Y
	 7a/PFI96lSSui43L7KuF9RQGaH7a6tnMnmAEZFWg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D4DD1F805FC; Mon, 20 Nov 2023 17:17:19 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4DF67F805F9;
	Mon, 20 Nov 2023 17:17:19 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 6/7] ASoC: cs43130: Allow driver to work without IRQ
 thread
From: ckeepax@opensource.cirrus.com
To: alsa-devel@alsa-project.org
Message-ID: <20231120095522.GH32655@ediswmail.ad.cirrus.com>
X-Mailman-Approved-At: Mon, 20 Nov 2023 16:17:16 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/62JHNZ64BZ32JRIATS2Y45AXMCZAELI4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>
Date: Mon, 20 Nov 2023 17:17:19 +0100 (CET)

The content of this message was lost. It was probably cross-posted to
multiple lists and previously handled on another list.
