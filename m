Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE9FC4332F
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Nov 2023 09:39:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0A75846;
	Sat, 11 Nov 2023 10:38:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0A75846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1699695538;
	bh=nAMJ5cw/MrQktIAnm6qhVoNIb9L26KTTRprP9oGHTZ8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=BPRvlV23oDUqurdEUXUMD/JVItHgR+cwbNUt28YeyykYHwTlvbmcIuEgkmvV/IZEt
	 uwAXMq1QDF34HfYvzyVjC0T15sMaRBrazPV+TCagp9oeDFYKkzGwiZ9UihHRcvvUwK
	 AoALZEzYfYIEF/t3DIDxhEl8Mxxo3wSej9TBSQOo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AFE77F804DA; Sat, 11 Nov 2023 10:37:40 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 43E52F80169;
	Sat, 11 Nov 2023 10:37:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B8EA7F80169; Sat, 11 Nov 2023 10:37:34 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 198D2F80125
	for <alsa-devel@alsa-project.org>; Sat, 11 Nov 2023 10:37:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 198D2F80125
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1699695449237920523-webhooks-bot@alsa-project.org>
References: <1699695449237920523-webhooks-bot@alsa-project.org>
Subject: hdajackretask /sys/class/sound/hwC1D0/reconfig Device or resource
 busy
Message-Id: <20231111093734.B8EA7F80169@alsa1.perex.cz>
Date: Sat, 11 Nov 2023 10:37:34 +0100 (CET)
Message-ID-Hash: I7A6KMT6IBQBTQ5WHGZOUYYU3X7HVN7K
X-Message-ID-Hash: I7A6KMT6IBQBTQ5WHGZOUYYU3X7HVN7K
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I7A6KMT6IBQBTQ5WHGZOUYYU3X7HVN7K/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-tools issue #21 was opened from ShalokShalom:

I try to apply the settings within _hdajackretask_ and then get this: 

![Screenshot_20231111_103300](https://github.com/alsa-project/alsa-tools/assets/6344099/51f8254a-c9a8-4ce7-9048-e537843d4653)

 - system: `"x86_64-linux"`
 - host os: `Linux 6.6.0, NixOS, 23.05 (Stoat), 23.05.4662.34bdaaf1f0b7`
 - multi-user?: `yes`
 - sandbox: `yes`
 - version: `nix-env (Nix) 2.13.6`
 - channels(root): `"nixos-23.05"`
 - nixpkgs: `/nix/var/nix/profiles/per-user/root/channels/nixos`

Issue URL     : https://github.com/alsa-project/alsa-tools/issues/21
Repository URL: https://github.com/alsa-project/alsa-tools
