Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D01C982C4
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 672E0601FC;
	Wed, 16 Sep 2026 15:12:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 672E0601FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789564354;
	bh=2nE/Bl8UY8rwgCFU28BOXjFJCB+P2y98AIGWHgaV3mg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=L3JY1CZPsMDI9faSDQAN50XkzAK70sgDiCOV7mpVTB8n8f26BD5io+6Ne73/vN6T6
	 mHeGoZD6S9LK0xz5/c5IFJNk3dsVh3eb4OxQnsWTOt4wpAGPRfx5/TCMa5RSY3elsS
	 Ljg5ro0ql4l6RuL2W9qmzKNdN2iy76shqXou2YL0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D2F16F805FE; Wed, 16 Sep 2026 15:12:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 84DFCF80600;
	Wed, 16 Sep 2026 15:12:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AF600F802DB; Wed, 16 Sep 2026 15:11:55 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789564315;
	b=pIW4SFsIhM96X1qTbt0brz8oAuxHE8eIzn9z1jKrb3qLiterwgPUdC/mIjOHwfRq0V32
	 cQKrEFyDTNDvdAmSTMw7i+rtVQZ6yN0jvITgTR6LqyL0VVQ3NIOa3UHY1pUzJR4XkQkHy
	 q5AEcVzQy+KDKDNOeG9kZ1P6C4F8RTUeyoyQGxmxL+FNswbzpKXQtboOdCp4GudbtO5zO
	 p2DNcN5pt+iCWYu/59n1Wc0VtpkZM3w9fiGOTOzKWLPRaullzI/oI2FGtM9riJ+C2orad
	 JMHEjqRrKQk6lmuMAfQ85h4rE+wUfSZVXkx7F5Msx7Iy0aGIMF52wls+TBeLj1eyCNw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789564315;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=2nE/Bl8UY8rwgCFU28BOXjFJCB+P2y98AIGWHgaV3mg=;
	b=HRmP93hRUqIUkkcdGbq8/Z3BRoxGtc36C8d62SbvAWK+mHjWxtrjyJTlN5obb7JZdJnu
	 LoNiJZxADaG9HVxkMBitmTQFTEdk9g5b94GuKE7GD/JloJz9QwIjlhzgU7rv7zlK+9nvL
	 lROcZQlcErYbh/qUU1OXg0YrTaS53/nDxuaLzpRBEucGDzouWgZqXokPsZavsSHWVEOtM
	 G+ZuLAm0EKjvApVzLZkf3AWr+IEsYWtY0lWTUPDtTvnUaflf3g9b8rRzF3zl72P8OBJXr
	 heU8mVUPi7d69n8OlF0AE+T4VEvMqSEf/DyubfJIIa2YsxifIficRXwqakoVMv1LmLg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 12703F8007E
	for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2026 15:11:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12703F8007E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d5cf42df004f00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-utils/pr/336@alsa-project.org>
References: <alsa-project/alsa-utils/pr/336@alsa-project.org>
Subject: Fixes for alsa-info.sh errors at parsing system environment
Date: Wed, 16 Sep 2026 15:11:55 +0200 (CEST)
Message-ID-Hash: 7G6EDMOKTSNTAQHHIN4FB2QYEKLAEVPX
X-Message-ID-Hash: 7G6EDMOKTSNTAQHHIN4FB2QYEKLAEVPX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7G6EDMOKTSNTAQHHIN4FB2QYEKLAEVPX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #336 was opened from tiwai:

There have been a few errors from alsa-info.sh at gathering and processing the system environment, as found in openSUSE bugzilla (https://bugzilla.suse.com/show_bug.cgi?id=1279431).

Here are trivial fixes.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/336
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/336.patch
Repository URL: https://github.com/alsa-project/alsa-utils
