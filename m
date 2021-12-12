Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D210AC433F5
	for <alsa-devel@archiver.kernel.org>; Sun, 12 Dec 2021 15:48:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1CA81AA0;
	Sun, 12 Dec 2021 16:47:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1CA81AA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639324090;
	bh=4rxcZLHbk3XVy6y4CffFQwgwws46s6/xcd/iZkcND8Y=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vd7YKmrLlaZQgngsn8OCgEK685FpW45j+VE40hypCkzsjJEGpS494yFWZgNCgV2pU
	 kaImsJ7i8jEMVPEW0Klu+eJv7rAEKMaPpnXB+IlqOJXrv9M9QcaRWn30KgVuvEbxB5
	 jfxvCsZlm6p3goCVjNdlbNC6KoKuKb1+Fz2ODDOg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7DFC6F80165;
	Sun, 12 Dec 2021 16:47:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3CC26F80246; Sun, 12 Dec 2021 16:47:18 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id A5AB4F80059
 for <alsa-devel@alsa-project.org>; Sun, 12 Dec 2021 16:47:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5AB4F80059
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1639324030376167059-webhooks-bot@alsa-project.org>
References: <1639324030376167059-webhooks-bot@alsa-project.org>
Subject: Move the call to expand variables and expressions
Message-Id: <20211212154718.3CC26F80246@alsa1.perex.cz>
Date: Sun, 12 Dec 2021 16:47:18 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-utils pull request #127 was edited from ranj063:

With the addition of the math expression evaluator in alsa-lib, we can use it to evaluate simple math expresionns for objects attribute values based on other attributes.

For ex: we can set the expression for buffer size as follows:

buffer_size "$[($in_channels * 48) * 4]"

The buffer_size attribute value will be computed with the attribute value "in_channels" based on the expression above. So if $in_channels = 2, buffer_size will be evaluated to 384.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/127
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/127.patch
Repository URL: https://github.com/alsa-project/alsa-utils
