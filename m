Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D017C3DA4B
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jul 2024 09:35:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 80D20E0F;
	Wed, 17 Jul 2024 11:35:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 80D20E0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1721208952;
	bh=a2Uu8UI8V0vvRA3hscoyzszAisM9xQQnRCyxHTEGNwM=;
	h=Subject:From:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:Date:From;
	b=EDpgKHEGswyC9JYKuTZqm1BWewYY927Du0c6Q97apiv7IUeywJuUOs97X8lPeG5lq
	 DT2FIDNnDJmRYKfEfFysiWRBazDJ9gDuY5f0OlHma1RL6I4Bu30yxiTIMTc9iCkOkC
	 EOEwkiWDPZzqDL6ZJ8ezVBk27RTWtSLFMKsxEN1E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6A594F80680; Wed, 17 Jul 2024 11:34:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AE2A1F8068D;
	Wed, 17 Jul 2024 11:34:24 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [PATCH v9] ALSA: hda/tas2781: Add tas2781 hda SPI driver
From: baojun.xu@ti.com
To: alsa-devel@alsa-project.org
Message-ID: <20240711132001.2792-1-baojun.xu@ti.com>
X-Mailman-Approved-At: Wed, 17 Jul 2024 09:34:17 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2YEAWETOCIURVQP2AP6SXQN3ZHUAWIXR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>
Date: Wed, 17 Jul 2024 11:34:25 +0200 (CEST)

The content of this message was lost. It was probably cross-posted to
multiple lists and previously handled on another list.
