Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8E9C53219
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:56:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9CBEB601FA;
	Tue, 28 Jul 2026 11:56:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9CBEB601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785232590;
	bh=ZNVevsptdPNBI4t/aoEtOHUDexVbKPjzW/npHSmRgYs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fc6U7urApHK28foW3t554ppodu6p5xNMa0VlbPDfM/1vu6EDR+zzqLxepiaeZ1QOj
	 uZWP/InFu4hOaMaNtl1zaCNR1a8O8kjC3d0h1KtGPOUCDogRv8eQuacV4YQdptyOZk
	 klzzhejD8Nmfw2Dtxn7zb7ywTv+VLy/NUFE352HM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BB225F805FF; Tue, 28 Jul 2026 11:55:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4604DF80600;
	Tue, 28 Jul 2026 11:55:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E7DFF80526; Tue, 28 Jul 2026 11:55:44 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785232543;
	b=OI7F1Ox6m3x/09AZJES1Zk0b1lUyJ73Y7wthStNBooXa2BFsRYP4Bgek8zKRK/rJdAKS
	 7Yhbvz3bejR9AS2+U7SV9KnjxNMKcBZGZY9PrZO4xbGBB+Z6ye8mNDNrWDr/sWS3ovYKA
	 NKPvP42XUJgZQu+1Y9LPbP5HZmb42myXVsncl+IHINyLNP2hasGFrF1cClghPOJQOZjdV
	 tnh3Sy379De0VfpeDh1nsiU5Qj70fr/2LFyRsJVCFnsZDxSdqOuM2bVPG7TaM4vAty8ZY
	 jYmSrTvRxdW4oPDy0wIf71rghAD6SPOwPbFEi5oAhNIQNFllOlnpdJHXUbwn3bYQPgg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785232543;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=ZNVevsptdPNBI4t/aoEtOHUDexVbKPjzW/npHSmRgYs=;
	b=HXOgg3bbfymu2jiiwPzhQyFz8uOut1B3PZBsxLKLZrr2efaVBKBvQ3cLAOprbawpR1rB
	 qQmfE09K/IS/Gj7Ef8uc0KOH/o9Krhgn9DLa10rXN7qeqQhnsA7LruDnuUxRusjdVLJ9T
	 F1e47fLm8l/PHa2Z4AO1QjfMRISAYPBUejzJ5+0ql3RXRAcUpntwxYLTaUTiaXauuzruG
	 9uqNYoh6+PEshZYPkzJgzhF4tV2XvuRFLK4HkTg6+zWXObT9ZPBD9OAE77TJdkNV9Ictb
	 WzllK5T693EMQ3nHUcXbW0ObcGJSQFSwdeMsOIw4SFlJT5H3v78+hinU8+ciPQ5L31Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 88A5EF801F7
	for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2026 11:55:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 88A5EF801F7
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c66b89d5ca6300-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/791@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/791@alsa-project.org>
Subject: Qualcomm: qcs615/sa8775p/qcs8300: Add uboot TALOS EVK / Lemans EVK &
 Monaco HiFi config
Date: Tue, 28 Jul 2026 11:55:44 +0200 (CEST)
Message-ID-Hash: WLWE7MPZWB2SWX6YTUIRN3MXCGGR6D7T
X-Message-ID-Hash: WLWE7MPZWB2SWX6YTUIRN3MXCGGR6D7T
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WLWE7MPZWB2SWX6YTUIRN3MXCGGR6D7T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #791 was edited from kumarsingh-art:

Add UCM2 configs for uboot variant of the Qualcomm variant Talos/ Lemans & QCS6490.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/791
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/791.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
