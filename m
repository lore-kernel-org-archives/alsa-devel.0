Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F942C36008
	for <alsa-devel@archiver.kernel.org>; Sat, 29 Mar 2025 07:31:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2E3B601ED;
	Sat, 29 Mar 2025 08:31:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2E3B601ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1743233494;
	bh=ZFVENcirFe39d0gcp5cIUNt4x7C5wQSF6gsjEgaE3t4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=eY5snDtRtuBpD8SfdA9XghOTLAj3Cr+7Bg117dNEO8x93MMByeTNANhzfWPNdlen2
	 NjWL/NX9tBVhw5ki+uYGoycNKxdnCn+caJqy5paFJk92YaLK2IHTl3eyHqpNWSKN8w
	 /AGyQJiIr9iol32a0HEEMt3VP7K8rikx5xJiROaA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E6E1EF805BE; Sat, 29 Mar 2025 08:31:01 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CCCF6F805C2;
	Sat, 29 Mar 2025 08:31:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E3AF9F8055B; Sat, 29 Mar 2025 08:30:56 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 212A0F80093
	for <alsa-devel@alsa-project.org>; Sat, 29 Mar 2025 08:30:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 212A0F80093
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <183135973046b800-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-tools/pr/32@alsa-project.org>
References: <alsa-project/alsa-tools/pr/32@alsa-project.org>
Subject: envy24control: fix crash when using system profiles file
Date: Sat, 29 Mar 2025 08:30:56 +0100 (CET)
Message-ID-Hash: AMGD5JRAYRVPGRYK2VJ3HUYTYR2LXT5K
X-Message-ID-Hash: AMGD5JRAYRVPGRYK2VJ3HUYTYR2LXT5K
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AMGD5JRAYRVPGRYK2VJ3HUYTYR2LXT5K/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-tools pull request #32 was opened from andreas56:

envy24control crashed if you tried to start it with -f /etc/envy24control/profiles.conf.

Request URL   : https://github.com/alsa-project/alsa-tools/pull/32
Patch URL     : https://github.com/alsa-project/alsa-tools/pull/32.patch
Repository URL: https://github.com/alsa-project/alsa-tools
