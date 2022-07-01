Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1B2C433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  1 Jul 2022 20:57:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A82A168C;
	Fri,  1 Jul 2022 22:57:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A82A168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656709074;
	bh=zKa1fEYkcpwqIGz6UH90THLkRLaMARWdw7G0SofLYPs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZCCjAlVS+il2VhrHlqKLYnfxRXg9ge3orR1uhRQ9fthvJxIsHa1SbWyM9Y4WcJeVK
	 VAqujIuk4lCMXjmTLAq1pwY7Qfg9SAgZZBUFX/DcQUS/EK/H8jCgMaWvuzyFIvxftW
	 ckX9xI8S2VSh8P9qxdjvDu6UwIii/uksLSqeHAtE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D067FF8014E;
	Fri,  1 Jul 2022 22:57:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D5140F80155; Fri,  1 Jul 2022 22:57:02 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id CE88BF800E8
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2022 22:56:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE88BF800E8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1656709016231002092-webhooks-bot@alsa-project.org>
References: <1656709016231002092-webhooks-bot@alsa-project.org>
Subject: include/sound/type_compat.h: fix include guard
Message-Id: <20220701205702.D5140F80155@alsa1.perex.cz>
Date: Fri,  1 Jul 2022 22:57:02 +0200 (CEST)
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

alsa-project/alsa-lib pull request #247 was opened from jg1uaa:

include/sound/type_compat.h uses `#define __TYPE_COMPAT_H` but it conflicts
same include guard of include/type_compat.h

now, include/sound/type_compat.h uses `#define __SOUND_TYPE_COMPAT_H`

this is already done in NetBSD's pkgsrc patch.

(thanks to tsutsui@netbsd.org)

Request URL   : https://github.com/alsa-project/alsa-lib/pull/247
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/247.patch
Repository URL: https://github.com/alsa-project/alsa-lib
