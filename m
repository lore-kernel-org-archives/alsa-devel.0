Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F1FEDF04C
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Feb 2026 07:18:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33C0260215;
	Thu, 12 Feb 2026 08:18:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33C0260215
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1770880718;
	bh=dXdmibLGSJVvCR4vfqzsetvVq6UDsqJ1kwWNO/QOlMs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=cwAPHSp7wYeb15DQ7pOqC/WxcgligWafOPNS94TEe517HBd0lCj9zwzmB2KxmadVL
	 OajeYgBuyP+fKwnKuEoM7l0jCu16TQ2o+MA6UNCHn/vTD6iJNZWPXW0jOkoDY14JLh
	 Oqdb7CvKSsAktdNw+ShGhnoSrrEZzEbxJVLHr2ag=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C7CCF805EF; Thu, 12 Feb 2026 08:18:11 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 340A5F805F5;
	Thu, 12 Feb 2026 08:18:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 33E15F8055A; Thu, 12 Feb 2026 08:17:58 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id DE813F800BD
	for <alsa-devel@alsa-project.org>; Thu, 12 Feb 2026 08:17:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE813F800BD
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18936e9771ef7b00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/704@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/704@alsa-project.org>
Subject: Qualcomm: qcs615: Remove JackControl from TALOS EVK HiFi config
Date: Thu, 12 Feb 2026 08:17:58 +0100 (CET)
Message-ID-Hash: SECDZGFD3I3SS3ATMRASGD6MGMZ5YEVB
X-Message-ID-Hash: SECDZGFD3I3SS3ATMRASGD6MGMZ5YEVB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SECDZGFD3I3SS3ATMRASGD6MGMZ5YEVB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #704 was opened from QTI-Quill:

The EVK board does not support headset or jack detection. Keeping JackControl entries prevents PipeWire (wpctl) from exposing sinks and sources correctly.

Remove JackControl from Headphones and Headset devices so PipeWire can enumerate playback and capture nodes normally.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/704
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/704.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
