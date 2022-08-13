Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13104C19F2D
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Aug 2022 13:27:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 365BC844;
	Sat, 13 Aug 2022 15:26:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 365BC844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660397237;
	bh=YxWzOM/mDo1IRsnS3/cRjIGIyK3/9sZKc3fsFCZNMWs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OVYUkIHOrLq3OgMI0A4hvwqWil0UX8CAnr3SeW3yS07ErrtogVvGKAt/XSwrhpewB
	 8pS+a49wDATqhuEnj6dMEsmgENKbkk4qZvQtly6C5XyasbvRm2hJBoYphGdPRSVMzQ
	 U03ATAdV9yFj0kqml1MhWWFRYhMW7Tw02XKnYAVI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1CB3F8014C;
	Sat, 13 Aug 2022 15:26:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22DFBF80166; Sat, 13 Aug 2022 15:26:24 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 72977F800CB
 for <alsa-devel@alsa-project.org>; Sat, 13 Aug 2022 15:26:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72977F800CB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1660397178484344959-webhooks-bot@alsa-project.org>
References: <1660397178484344959-webhooks-bot@alsa-project.org>
Subject: snd_pcm_readi(),return -11,Resource temporarily unavailable
Message-Id: <20220813132624.22DFBF80166@alsa1.perex.cz>
Date: Sat, 13 Aug 2022 15:26:24 +0200 (CEST)
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

alsa-project/alsa-lib issue #259 was opened from xukawendi:

i called the function snd_pcm_readi() to capture pcm data, but the function returns -11,and the snd_strerror(-11) shows "Resource temporarily unavailable",How can I resolve this problem?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/259
Repository URL: https://github.com/alsa-project/alsa-lib
