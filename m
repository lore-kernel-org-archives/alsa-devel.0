Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BE4C624C6
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:09:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52975601D0;
	Mon, 31 Aug 2026 22:08:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52975601D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788206948;
	bh=kBF3/hWO4MxbctQkYHMWvKbTnHAmxsjblALSfgTWXYY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=dKLvnTp9e6h5E6XsIL7UddjPcDcRB3OBvONGS+dMNmlXz8vG8uPQFPbFCNo0SCTEk
	 Da6Sv06GBWU0tOaTF+nIVE/h2q+ATP8L9pF8km5IHwsbHt8QJyK8wT19DyEmAOEzlc
	 b+Qolr11yvspUB58PRM/WPhFfh83CtV30iJtOO8g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9A84EF805F7; Mon, 31 Aug 2026 22:08:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E3D14F805FB;
	Mon, 31 Aug 2026 22:08:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 370D2F8051F; Mon, 31 Aug 2026 22:08:27 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788206906;
	b=L8pv0TVyxXno7wmLICmawzeW/bDzMIo1WYwAs6zvNyqa1FAqOmXPipJExl9axduSRcgo
	 Lh/1x1UtC21bwRJAHlAULG6eQ3vXzB3+1PpeyuJVz7KFiW4CFWdn7+VkrLVIg0lj30HTZ
	 53RwvNMXSc/oY1b7LN/q4V9qyrok2v6d+xRL7R6C4HxhTnu5flqhsi5L4EjcRAhq0QWjH
	 CRrPhAKnQMztSgkI+H0Z8ewSS3PgwWPaKpaUw1gbb1kmjIkOoUm3QMD5/2wwcxu8tI0YT
	 LmN/TJEOEdOjNUnblNrXyx6UmXMwpo1zflZyeCNxlfjJD5HTQfAXxj2dsFKiwbxuktg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788206906;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=kBF3/hWO4MxbctQkYHMWvKbTnHAmxsjblALSfgTWXYY=;
	b=QAqBcI1BoTNOQwk0mTvM5MC3WdKUhz9x8/k/4oHChTIEGqaYhfrdNs3qiAY8Qhk2Ylv1
	 iS7gHLsFK9tfvCew/Ub2hpjjtiME9dZHgRL+OgEvCeFRi8yUVagq34US1a4+njWhwbyaU
	 aBf4Z9XjBm522by7mlQEr/NN2WPiy/YkjUEtnduBxtA7hV7tc1Zyb/Q181TIn/3/4FlHf
	 LSh1+qWe0WgE4WSOeVNfAm22tvydj4DZUixXeQnd2gkIebcqpRhVDulvJdOWiQcsv3NmI
	 FlHTjAkw8YQREWeVZ1QlqWd9emE17IwqBumXh/4Y+/n7hH++7MwWNF0hwaukG5zim3g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B75CF80071
	for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2026 22:08:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B75CF80071
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d0fcb4693e4300-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/846@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/846@alsa-project.org>
Subject: HDA-Intel: Add ALC233 profile for Lenovo SSID 17aa:33c2
Date: Mon, 31 Aug 2026 22:08:27 +0200 (CEST)
Message-ID-Hash: YPBG3XSKMEPPFY6M4M77YGASSXHXQF4B
X-Message-ID-Hash: YPBG3XSKMEPPFY6M4M77YGASSXHXQF4B
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YPBG3XSKMEPPFY6M4M77YGASSXHXQF4B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #846 was opened from RenjithPananchikkal:

Realtek ALC233 with Lenovo subsystem ID 17aa:33c2 has no UCM2 profile. Without it, PipeWire/WirePlumber uses the generic ACP path which marks the Speaker as unavailable when a 3.5mm headset is plugged in, causing GNOME to hide the Speaker output entirely.

Add a CardComponents check for 17aa33c2 in HDA-Intel.conf and a dedicated HiFi.conf with Speaker always visible (no JackControl) and Headphones using jack detection via Front Headphone Jack.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/846
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/846.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
