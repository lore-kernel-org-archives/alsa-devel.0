Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A192AEB3622
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Mar 2026 17:36:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7528C60230;
	Mon,  2 Mar 2026 18:36:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7528C60230
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1772473004;
	bh=X7wXIqkWWJF18OoN1cM85kCS0lH6X/7oi++pZ3qigT8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fZhGlOJWFo4kiBayB0gohaRVOM4eIqS4QT+QkgFnJkoEjqMFJ4byuUdInAm9SnDWB
	 Vrz99t0wZB7T4+xJKfsn4pzp5BIMpWniheSk2TbuoO49vKqu7HPo7JjzBQKi2/86NP
	 ReHO1y84b2YQLiIxVfWtsN89Irw/rhoR9kQxtxlU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A1013F805E5; Mon,  2 Mar 2026 18:36:15 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A487F805E8;
	Mon,  2 Mar 2026 18:36:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 87E04F8026D; Mon,  2 Mar 2026 18:33:03 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 89936F800E2
	for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2026 18:32:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89936F800E2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18991697d8723100-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/712@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/712@alsa-project.org>
Subject: ucm2: rt1320: Add Use case Configuration for rt1320 with DMIC
Date: Mon,  2 Mar 2026 18:33:03 +0100 (CET)
Message-ID-Hash: IILMABSBIESE3IREB573INR32ZBULBQX
X-Message-ID-Hash: IILMABSBIESE3IREB573INR32ZBULBQX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IILMABSBIESE3IREB573INR32ZBULBQX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #712 was opened from AndreGilerson:

My surface pro 11 for business uses the rt1320 with a microphone. I have patches for the kernel to enable the configuration in: https://github.com/AndreGilerson/linux-surface

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/712
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/712.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
