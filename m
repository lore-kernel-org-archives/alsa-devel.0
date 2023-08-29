Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D3DC6FA8F
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Aug 2023 17:09:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA0CD7F1;
	Tue, 29 Aug 2023 19:08:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA0CD7F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693328944;
	bh=H/SBJJL3bftT6r2w486GfdFXrwsljuG92yitKJRkVKU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=E2hyOwBx5G+tApHM/NupYzkEsB759cemuBtGFTSw1IRFn37/dcfPJMAIj3MV57pt7
	 5KO6bAPhzTYwQUjf0Od1Pe5jc93TCn++AjE2AqEA2KShPyoMZ1o+5m33eaflfe15e9
	 SxG7J8YnUiTsLRlHYyNmAm1NKHukacjjAgJrbdbM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 584AFF80236; Tue, 29 Aug 2023 19:07:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F0B92F80158;
	Tue, 29 Aug 2023 19:07:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B3A74F80158; Tue, 29 Aug 2023 19:07:34 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id B911CF800D1
	for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2023 19:07:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B911CF800D1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1693328847275744200-webhooks-bot@alsa-project.org>
References: <1693328847275744200-webhooks-bot@alsa-project.org>
Subject: Front 3.5mm panel not recognized (MSI X370 Gaming Pro & MSI B450-A
 Pro)
Message-Id: <20230829170734.B3A74F80158@alsa1.perex.cz>
Date: Tue, 29 Aug 2023 19:07:34 +0200 (CEST)
Message-ID-Hash: MCVBF3WBTAPK6EELH5WUICMADV4QHJ2J
X-Message-ID-Hash: MCVBF3WBTAPK6EELH5WUICMADV4QHJ2J
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MCVBF3WBTAPK6EELH5WUICMADV4QHJ2J/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #344 was opened from fiftydinar:

Realtek ALC892 soundcard on both.

alsa-info.sh (MSI X370 Gaming Pro)
http://alsa-project.org/db/?f=26d6d5ef7701fabf260fd75e0d2bd135976019dd

alsa.info.sh (MSI B450-A Pro)
http://alsa-project.org/db/?f=621f405abe6c94f4a3069caba7ab7cb802d03563

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/344
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
