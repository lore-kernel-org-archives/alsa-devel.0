Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDC6C433EF
	for <alsa-devel@archiver.kernel.org>; Sat, 28 May 2022 21:29:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A2D2F184D;
	Sat, 28 May 2022 23:28:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A2D2F184D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653773360;
	bh=B0QHZ2pRn/Ik13Z5VPXtf91nPlXjdeLfu/D/0UY3+3o=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AL6pk1KCOJ4cqdcCIKBVricOMogA+v8L31Q709MvfKx8qObQKUKmUFviPpKu1YvQL
	 IUKp28B//ZeqshJBS/AeqbQDu0e18iLEp1daDCK1JiXgApbD8CQa9+j7Wa6DrKRsP0
	 slD4J7U1vkjAv1Ou65z8Ue4KxVfhwFa+j83A7zlc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2ED48F80124;
	Sat, 28 May 2022 23:28:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0F79F80279; Sat, 28 May 2022 23:28:25 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E8F11F80124
 for <alsa-devel@alsa-project.org>; Sat, 28 May 2022 23:28:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8F11F80124
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1653773298359621048-webhooks-bot@alsa-project.org>
References: <1653773298359621048-webhooks-bot@alsa-project.org>
Subject: ucm2 profile for Behringer Flow8
Message-Id: <20220528212825.E0F79F80279@alsa1.perex.cz>
Date: Sat, 28 May 2022 23:28:25 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #160 was opened from smangels:

- kudos to Pekka Oinas for supporting me finding the right settings
- provides an UCM2 profile for Behringer's digital mixer Flow
  configured into "streaming" mode
- 2 stereo outputs, 1 stereo input
- prepare filenames for Flow8's recording mode (10 chan input, 4 chan output)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/160
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/160.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
