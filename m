Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D20BC4332F
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Nov 2023 10:23:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D8B084D;
	Thu,  2 Nov 2023 11:22:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D8B084D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698920598;
	bh=nxFHoUjcS49j/4AN+t8WD+FvoekXQHL5vf16Hez2M9k=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=XfjV8QB6uODCURKukKu4zMkkpocdGsBJ8Tnq6U4u7TVAvteDyoewzIRhpltGLE8EQ
	 56mB8Gwjq6RXiHpjWcisMVmVIrRi8yQwtxSV7JJcO4KuXPVH/0452G4nXbTJdfhjga
	 igYKvw9GNNFhg1A9bDO+Bft56Kt6bIRZOZWhiCdM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6AA4AF80290; Thu,  2 Nov 2023 11:21:52 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 09528F80290;
	Thu,  2 Nov 2023 11:21:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 20AB4F80290; Thu,  2 Nov 2023 11:18:29 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id C4FB7F8003C
	for <alsa-devel@alsa-project.org>; Thu,  2 Nov 2023 11:18:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C4FB7F8003C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1698920307777283907-webhooks-bot@alsa-project.org>
References: <1698920307777283907-webhooks-bot@alsa-project.org>
Subject: hdajackretask info window takes up all screens
Message-Id: <20231102101829.20AB4F80290@alsa1.perex.cz>
Date: Thu,  2 Nov 2023 11:18:29 +0100 (CET)
Message-ID-Hash: 6M2H67HKT2ZZ6GP6QJPAJXWNHVIPJGRQ
X-Message-ID-Hash: 6M2H67HKT2ZZ6GP6QJPAJXWNHVIPJGRQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6M2H67HKT2ZZ6GP6QJPAJXWNHVIPJGRQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-tools issue #20 was edited from francisdb:

For a multi-monitor setup you get a very large window.

The code below should probably be removed

https://github.com/alsa-project/alsa-tools/blob/8c8d6941f21ea68894ce7fd13e92b3ac9f16dc8a/hdajackretask/main-gtk.c#L517-L523

Issue URL     : https://github.com/alsa-project/alsa-tools/issues/20
Repository URL: https://github.com/alsa-project/alsa-tools
