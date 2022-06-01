Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AC3C43334
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jun 2022 21:19:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 44791172B;
	Wed,  1 Jun 2022 23:18:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 44791172B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654118370;
	bh=BtmVRi8LAeL+tBRjaePo8oEACwLMQwC8/UuhArgKrME=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gr8OH6HhkteErsk7oLn8u+dxalbHyDLIxEBVWFcfvueAbW4wtssIKy/eJbZYXsIHn
	 eXvvA795t/kT3M/4PCOa0cz3seTnIBQ8DsML2+q9SelyJpUWkz5rxyxvB0q6FJOqZ2
	 5TAOwLKaSIej6P56qWNLqreSI1D5BJ1f/YblGSZw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2700F8019B;
	Wed,  1 Jun 2022 23:18:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85F90F80149; Wed,  1 Jun 2022 23:18:37 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id D18FCF80089
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2022 23:18:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D18FCF80089
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1654118308754235983-webhooks-bot@alsa-project.org>
References: <1654118308754235983-webhooks-bot@alsa-project.org>
Subject: 1.2.7: missing git tag
Message-Id: <20220601211838.85F90F80149@alsa1.perex.cz>
Date: Wed,  1 Jun 2022 23:18:37 +0200 (CEST)
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

alsa-project/alsa-lib issue #232 was opened from kloczek:

https://www.alsa-project.org/wiki/Main_Page says that last release is 1.2.7 but there is no git tag for that version here.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/232
Repository URL: https://github.com/alsa-project/alsa-lib
