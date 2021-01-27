Return-Path: <SRS0=72a4=G6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E3AC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 16:57:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4583364D9E
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Jan 2021 16:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4583364D9E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1DD51703;
	Wed, 27 Jan 2021 17:56:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1DD51703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611766612;
	bh=7y3leCP9tuZa8gpf6D90UngXgLOd5Jn9ZvZN4MYzC2Q=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DC4VzO60FHdWNeDd8KSLBhmSS2w/1duH0SAY1fzx2Sg8hXbAkMGaDSODIWVhVucx4
	 V/+ZHNwdutYMqwpqKDbNiLgCVCLA2XoLUaTn0Ui8CTkA1ouYkk+jIvN02bIhOhyBfu
	 BahjIYekc5jI2lvX4cYkohtKNEE6NpE8YSf0eyuE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A6717F80218;
	Wed, 27 Jan 2021 17:56:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 839C9F80259; Wed, 27 Jan 2021 17:56:00 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 2CCF9F800F0
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2021 17:55:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2CCF9F800F0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1611766546521182060-webhooks-bot@alsa-project.org>
References: <1611766546521182060-webhooks-bot@alsa-project.org>
Subject: Likely ALSA driver bug in snd_hda_intel per syslog
Message-Id: <20210127165600.839C9F80259@alsa1.perex.cz>
Date: Wed, 27 Jan 2021 17:56:00 +0100 (CET)
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

alsa-project/alsa-utils issue #76 was opened from dhdurgee:

[alsa-bug.log](https://github.com/alsa-project/alsa-utils/files/5881756/alsa-bug.log)

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/76
Repository URL: https://github.com/alsa-project/alsa-utils
