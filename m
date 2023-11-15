Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F661C46CD3
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Nov 2023 13:22:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8336828;
	Wed, 15 Nov 2023 14:22:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8336828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1700054575;
	bh=a2Uu8UI8V0vvRA3hscoyzszAisM9xQQnRCyxHTEGNwM=;
	h=Subject:From:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:Date:From;
	b=RY7HwqqpF/Ccw43Hf1nrMM6pbjJzDXxARTcLSMCR7kbxZr09IfJcloPxiRgSD7u9S
	 pss8s7O99c9NYAofLHELTjMia4Ms2uOaM5waVtVIYQSd2uwjvkhpaZnlVExcYUE4mS
	 IcQjjY8QcJkWgtU9ki0h6YIBf5OjFTInKXcHcshw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A127F80551; Wed, 15 Nov 2023 14:21:38 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A55EBF801D5;
	Wed, 15 Nov 2023 14:21:37 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [PATCH] ALSA: hda: i915: Alays handle -EPROBE_DEFER
From: maarten.lankhorst@linux.intel.com
To: alsa-devel@alsa-project.org
Message-ID: <20231115123625.74286-1-maarten.lankhorst@linux.intel.com>
X-Mailman-Approved-At: Wed, 15 Nov 2023 13:21:33 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SL5F25YFLEQSDFUY3WUSOV7KC5ZPTL7R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>
Date: Wed, 15 Nov 2023 14:21:38 +0100 (CET)

The content of this message was lost. It was probably cross-posted to
multiple lists and previously handled on another list.
