Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A16CF2591
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Nov 2025 13:20:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2783601F2;
	Wed, 19 Nov 2025 14:20:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2783601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1763558433;
	bh=CWAF+urYqTcut0PANUoad6S2tLLPN+TlU5yJlJE7vjg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=T1XJjFeMvGvdJUCBQC0Js3N4tWLTT8hRua8GV53FIMLOd9MSSkzrHEHxJLde2O4w/
	 PofpLMYLFsovPVQ8h9qLR5nGvfEcpkMZYgWBPZzDQq6uf1f7+r8SHblpxOKUx9buio
	 aPsQkbtQzgB6iFn41+DvFTVPkK/Ri9+TaL3kvJaM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B694CF805D5; Wed, 19 Nov 2025 14:19:54 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 48AD5F805BF;
	Wed, 19 Nov 2025 14:19:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2C976F80171; Wed, 19 Nov 2025 14:19:47 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 59EA0F800B5
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2025 14:19:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59EA0F800B5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18796b01e5cdd800-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/643@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/643@alsa-project.org>
Subject: HDA: route speaker volume to Post Mixer Analog
Date: Wed, 19 Nov 2025 14:19:47 +0100 (CET)
Message-ID-Hash: IJH362MIHBO7OW7KTQGKFCKNBRRNHFVT
X-Message-ID-Hash: IJH362MIHBO7OW7KTQGKFCKNBRRNHFVT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IJH362MIHBO7OW7KTQGKFCKNBRRNHFVT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #643 was opened from Lyapsus:

On certain laptops (e.g., Lenovo Legion Pro 7 16IAX10H), the live speaker gain is exposed through the Post Mixer Analog controls. The default UCM entries point at Speaker/Master, so software volume never touches the woofer amps. Routing the Speaker device to the Post Mixer Analog mixer and volume elements restores proper volume control without affecting other paths

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/643
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/643.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
