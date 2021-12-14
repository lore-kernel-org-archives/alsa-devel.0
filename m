Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32304C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Dec 2021 04:28:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B224317CD;
	Tue, 14 Dec 2021 05:27:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B224317CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639456100;
	bh=UQ853Oxrkc9KugF7kQkaxjeP+OlZ7/ywLOtOIjFdRuA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HaY9nkbRLNYmexhfgJja70HoG3/vfYGOPf8YdJwDHlwWMYlDKRpsdmRPrxOxxAnDn
	 PmHWtnLH0v2MxafO7UV8joWsamyZZcTl6ii4CNSGXD+cLM7WRbmJaaPtq5mVaI+8O8
	 J4X1eA2aCyCUUr9l1NbWgF1Zp1A7aF3RziKw3pYE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C2AAF801EC;
	Tue, 14 Dec 2021 05:27:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1DDBFF80246; Tue, 14 Dec 2021 05:27:28 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 143FBF8016A
 for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2021 05:27:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 143FBF8016A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1639456034319045067-webhooks-bot@alsa-project.org>
References: <1639456034319045067-webhooks-bot@alsa-project.org>
Subject: Does alsa-lib call this kernel api?
Message-Id: <20211214042728.1DDBFF80246@alsa1.perex.cz>
Date: Tue, 14 Dec 2021 05:27:28 +0100 (CET)
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

alsa-project/alsa-lib issue #204 was opened from Nick0412:

Where in the alsa library does it reference the alsa kernel api: https://www.kernel.org/doc/html/latest/sound/kernel-api/alsa-driver-api.html?

Do these two apis interact at all?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/204
Repository URL: https://github.com/alsa-project/alsa-lib
