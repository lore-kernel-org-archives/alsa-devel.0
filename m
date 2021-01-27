Return-Path: <SRS0=72a4=G6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494B0C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 15:38:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D533D207E8
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 15:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D533D207E8
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40CCB170F;
	Wed, 27 Jan 2021 16:37:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40CCB170F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611761876;
	bh=G3vVaXk8OWsCrJFjithMp3l1QyeJ54k9GRH25fs4qAE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nCBr6LE3Pm52D1nJL27CzLPZpK5IJeVQjHRbqWKUipOGHWD6oZ/gPXciD2A/NdTcn
	 Dm6l687VuPLOtmvvYkq8Sh4zWRllJopdNi9/8Bi71aI8K4df6DA2AZNXudD6hldK6N
	 gJCm9hvtuXbhjfeBLCPyS7TCSrvGHQBo/62toTOM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B90C7F800E9;
	Wed, 27 Jan 2021 16:37:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26BF5F80259; Wed, 27 Jan 2021 16:37:04 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id A0940F800E9
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2021 16:36:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0940F800E9
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1611761807933743000-webhooks-bot@alsa-project.org>
References: <1611761807933743000-webhooks-bot@alsa-project.org>
Subject: [Feature request][alsactl] Allow -g/--ignore to be used with init
 command
Message-Id: <20210127153704.26BF5F80259@alsa1.perex.cz>
Date: Wed, 27 Jan 2021 16:37:04 +0100 (CET)
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

alsa-project/alsa-utils issue #75 was opened from MichaIng:

It would be great if the `-g`/`--ignore` flag would have an effect on the `init` command as well, so that `alsactl -g init` does not print and exit with an error, if no sound cards have been found.

Since it can be checked for attached sound cards on Linux easily via /proc or sysfs, this is of minor importance, and probably there is a reason why it is as it is. In this case, probably the `--help` output could be extended by this info, which is currently only present in the man page. Reading the `--help` only, one (or at least me) would not guess that this flag is ignored by the `init` command.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/75
Repository URL: https://github.com/alsa-project/alsa-utils
