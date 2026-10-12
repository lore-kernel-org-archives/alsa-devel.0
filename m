Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC50CA9ED0
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:35:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6BBA60204;
	Mon, 12 Oct 2026 23:35:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6BBA60204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791840944;
	bh=8KEw6k+ul2Kc3QzzAeWVAqtsm9LkknVrTzMjYAqpDDM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=TVRZR+ZruwclZHWUas6VTD8VoWgwsXT+1CJdiNvVMjFSV9Aui521U1Ht68rjYD41U
	 qBwnD2mCC2QhVtwcL0QFz8wkdASSAmnmi1XWQG1jyYb25j78VRM2u+YvIreLsVVkM5
	 Qy7EKXHRli0O4+FpQj33GBsJt52VhjjQ+q4K98LU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A8F06F80601; Mon, 12 Oct 2026 23:35:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F0F8F805FA;
	Mon, 12 Oct 2026 23:35:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C1432F80526; Mon, 12 Oct 2026 23:35:05 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791840904;
	b=AfswahB8u0V6i+AI79bXFA4jcqE4irzU2qmu2g9R0TkQKyaeebyKT9q+MA8jzjy1T2fT
	 wFUFT6fgr+x8jk64nNq3GotNJsxZKcjIwo7ok5C0PtsmCJA1irXUadA+et2a1OTtM9KEi
	 JKJWp1AGiymXHha9pxHex4VMRb2J0mzimlzXdGqwC8pOQ7AVbdcWcUjmqLC5Ss9UriSvX
	 12R5IeApWTgFj8aOf9AXm3XTTcQmZyP8rjwVvewR9n/necZC9sXNOj76b6u4aBYAve/kU
	 ONmhBctnjoiLcpMGrv80gxA4iqVkAQRcxuVLDmmw/byv6hL+A/yAxy58W42ontDevow==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791840904;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=8KEw6k+ul2Kc3QzzAeWVAqtsm9LkknVrTzMjYAqpDDM=;
	b=T8ZrpEdRvnts5+jzw/TI3mMNNAT6TpsMoImV0uI3dT/d9wulzQ7gSwih7DbyIniS1kvR
	 /sl+hB2iZ5vXe85GD95VO+ZA5Ss/Y+Hjqy7Zv9qBZGw+T2cOC01PS0+TlHtYEUD7mI/+D
	 8mcFFTCPy55d+/DDPcFOvh+Q+j4y69w/lwHymCm5L6BSsEMPBcfreHYpP08VYMzabnoVt
	 HCjOeBihVURYghFd0+w8nqAtmAxVWKZVXBe4/+Jeshlv3tlqteWpRGhl88LWkk4+EkGHa
	 bYZzgWRo4gfGUQxANka3d2CcYuFEM5kCAd67zFg+8hi7Qkl3j94z+3JHFCSL0GQCEbA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 76D13F80100
	for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2026 23:35:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76D13F80100
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18dde5ce9e53ba00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/878@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/878@alsa-project.org>
Subject: HDA: Handle better Bass speaker including 4 channel mode
Date: Mon, 12 Oct 2026 23:35:05 +0200 (CEST)
Message-ID-Hash: YJIXQAV5LHU4WGQX3BYK7N7N5VBZM2OZ
X-Message-ID-Hash: YJIXQAV5LHU4WGQX3BYK7N7N5VBZM2OZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YJIXQAV5LHU4WGQX3BYK7N7N5VBZM2OZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #878 was opened from CSVincentS:

Follow up of #533.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/878
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/878.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
