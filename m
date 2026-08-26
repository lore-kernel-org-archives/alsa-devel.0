Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64948C5DF97
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2026 23:04:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F87D60273;
	Thu, 27 Aug 2026 01:04:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F87D60273
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787785454;
	bh=xP5CZC+ZPBti/ZEp+kqodV6QovXMV5csqegE4xzF5As=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=vJikBICEqMc1QTDWXer2zPvIIt09wblOW7fPyAOwLdo5S+33HYQREFxza4nHmpQWO
	 A1UXAh8Cgm3t3s/AbS6DfLY/pQQDQ9UtH31VTu9VHsbNg2SQc5gqNWTxnu57jpvhwG
	 gORrYcXwL8SNaxrodKL8dLhpkgH6Mula/N6uKAIQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B823F805EE; Thu, 27 Aug 2026 01:03:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D6B1F805EE;
	Thu, 27 Aug 2026 01:03:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC6D4F8047D; Thu, 27 Aug 2026 01:03:32 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787785412;
	b=DUlcP5t9tiQCaoE6MeSfJAO26C9+c4k6gEPmdxJzzfmBfLm4aiz/lQD1H3LQzzByF/Kx
	 /2w+wXYD7exAOXLYTyV15Dk2i6UXFORDLpdYD2ry3khn2x5ryLb5qHIA7KH48yJU9g4y2
	 oNy+0vyhXFrPh5RmVtVCWVGqnFKU6xHA76n49SmXr5t4PI6h5LdiIIvGHrGp+jmymKjiQ
	 1KieJUisOY1hshcYTEU5NifN2Htk/38jbmMPvB+9+0ysC07Qxd9/QzDwQ4qxhzAB9oBcP
	 erLKuKhPEUuLYj5z5yiLpYztiF2L1flumXwiGMQ+B5oHQwssUhOK0VM9Peumunz7CwA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787785412;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=xP5CZC+ZPBti/ZEp+kqodV6QovXMV5csqegE4xzF5As=;
	b=P0ghQF7KjC5oaEmtbTMQDOgsKANXBA0F+GK47KIOEzhCzGiARrM6mHR+vtQbZT1NVu90
	 m2fI7AoBfZp85Ggj9982f9qoT+8drcrohXaPGorYXiQmt46PwZR6mt5dKlTzRSbuLVpT1
	 3vPmQlH6eaJgxDXOrBhYKSzhUnfnzCX86HYPe+eyDhrt6lw0Ulv4gyN38ZflIS359F8fv
	 Y3cIAL3cH/caM6w62JjjfkGKu2EeWGlcWSD/BssCXLiKZG4DoKPJ3ppRd1KxqIOE2/VRm
	 J8v7CFKnjYKo76aWC3s167F+9Lu6/uhXtNLdA/09H0TbWkPNnuQZLy+k6EcAJLZV7ow==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 57A5EF8011B
	for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2026 01:03:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57A5EF8011B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18cf7d5be2274700-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/842@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/842@alsa-project.org>
Subject: ucm2: Intel: chtmax98090: also initialize volumes for Google Kip
Date: Thu, 27 Aug 2026 01:03:32 +0200 (CEST)
Message-ID-Hash: TA5JL56OJUIWJLHJGMBNWXCLIWVPZ5RU
X-Message-ID-Hash: TA5JL56OJUIWJLHJGMBNWXCLIWVPZ5RU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TA5JL56OJUIWJLHJGMBNWXCLIWVPZ5RU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #842 was opened from Smu1zel:

## What does this modify?

The HiFi.conf configuration in ucm2/Intel/chtmax98090.

## Why?

Google Quawks (ASUS Chromebook C300) is the only platform properly accounted for in terms of volume initialization, resulting in unacceptably low volume on Kip (HP Chromebook 11 G4).

## How is this resolved?

Convert the conditional for Quawks into a RegexMatch, and include Kip in the regex pattern.

## Note

Kip is the only Bay Trail Chrome* device I own, so I am unfortunately unable to test other devices. If they have the same issue, those devices can easily be added, however.

Signed-off-by: Lynden Lewis <lyndenl25@yahoo.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/842
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/842.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
