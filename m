Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA9CEE49BF
	for <alsa-devel@archiver.kernel.org>; Sat,  9 Sep 2023 18:53:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0918D83A;
	Sat,  9 Sep 2023 20:53:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0918D83A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694285635;
	bh=vELJBwvwc1Jc/uqYXY0cIZzAykhl+Vmz9jdf6L10quc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=OM8Lr7jr1DTWXyVVFHnQl24xdx5BTXpzrRKj+577HEd6kWIu4OXclmL+ugl4u7sMJ
	 /14knB9Qzl2FkEAkYch5BEuGFDJhtSsIg2XmL/Cpq+8O+TKgR6eJ8uhc/3IEw3yL9u
	 irEzDNn4mYYp4Wm3xJGsau64jI6WyiChzzh2egfI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7D8FBF80551; Sat,  9 Sep 2023 20:53:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4AD1DF80494;
	Sat,  9 Sep 2023 20:53:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D2D03F80494; Sat,  9 Sep 2023 20:50:04 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id A1F90F800F5
	for <alsa-devel@alsa-project.org>; Sat,  9 Sep 2023 20:50:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1F90F800F5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1694285400406148672-webhooks-bot@alsa-project.org>
References: <1694285400406148672-webhooks-bot@alsa-project.org>
Subject: Remove mic permissions.
Message-Id: <20230909185004.D2D03F80494@alsa1.perex.cz>
Date: Sat,  9 Sep 2023 20:50:04 +0200 (CEST)
Message-ID-Hash: PO6RL4X72XKYXU4PAE77HWYDAHDINND5
X-Message-ID-Hash: PO6RL4X72XKYXU4PAE77HWYDAHDINND5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PO6RL4X72XKYXU4PAE77HWYDAHDINND5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #353 was opened from stefan11111:

I first asked this on the gentoo forums: https://forums.gentoo.org/viewtopic-t-1164837.html
I would like to tweak my /dev/snd permissions in such a way that members of the audio group can listen to sounds, but only root and maybe root group can use the microphone to record sounds.
Is such a thing possible? Note that I have a static /dev, so no need to worry about changes not being permanent.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/353
Repository URL: https://github.com/alsa-project/alsa-lib
