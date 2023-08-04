Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C52C001DF
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Aug 2023 09:45:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8FFE83B;
	Fri,  4 Aug 2023 11:44:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8FFE83B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691142328;
	bh=a2Uu8UI8V0vvRA3hscoyzszAisM9xQQnRCyxHTEGNwM=;
	h=Subject:From:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:Date:From;
	b=SmBwG8jjgi5fI53z6OTVCop9EdI/RmXqqeDT2nODlQOp2eLOU8d5lBhaqAKiWT8we
	 Um+eKkXe+AlEEla2eAS0kxATx2PuUhyxlThHhITmZaZLHSqHMoJLXtARNmT+m6OmUP
	 TT87v65frvErG4UVBsJbza6isUYJG/I3UI7rckCo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CB2B0F80578; Fri,  4 Aug 2023 11:43:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E9B9FF805A1;
	Fri,  4 Aug 2023 11:43:07 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [PATCH 0/2] ALSA: hda/realtek: Add headphone quirks for Aya devices
From: ruinairas1992@gmail.com
To: alsa-devel@alsa-project.org
Message-ID: <20230802153730.39273-1-ruinairas1992@gmail.com>
X-Mailman-Approved-At: Fri, 04 Aug 2023 09:42:54 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S3TMELZFIOCAFDZGIGRX5AOECKPQ7COA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>
Date: Fri,  4 Aug 2023 11:43:08 +0200 (CEST)

The content of this message was lost. It was probably cross-posted to
multiple lists and previously handled on another list.
