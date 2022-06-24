Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED44C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jun 2022 14:58:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 918E416AF;
	Fri, 24 Jun 2022 16:57:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 918E416AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656082686;
	bh=UIFEeYLpr9guYKYqDkgfYUoxkCGfqIRK9mVSei4iAtI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UKfHs9hu4tvnrjK+ihye5eblVarOsga0JdpLVGn7UxVoGF7sJ6sEkZU/4jjM5foxa
	 N4TbbbsaFV6qtrS3NqzLSqBBNLtrO5AlVgocIZAsrtQddmkvLNZbOfTz1MWgNLcd5q
	 YTJWHUF9AqZRbfnbZgc6m4e/ZBXiPry66p7f6ylE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04E50F80137;
	Fri, 24 Jun 2022 16:57:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 283E6F80139; Fri, 24 Jun 2022 16:57:14 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id F04CEF80107
 for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2022 16:57:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F04CEF80107
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1656082627462064981-webhooks-bot@alsa-project.org>
References: <1656082627462064981-webhooks-bot@alsa-project.org>
Subject: UCM for Behringer UMC204HD not working
Message-Id: <20220624145714.283E6F80139@alsa1.perex.cz>
Date: Fri, 24 Jun 2022 16:57:14 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #178 was opened from maru-sama:

Similar to #177 I have problem with the ucm setting for the UMC204HD. The problem is that apparently no mixer is being created for the device, when trying to open the card with alsamixer it just fails with cannot load mixer controls. the mixer has been created though if I do not missread the output from alsa-info.sh (attached)
[alsa-info.txt](https://github.com/alsa-project/alsa-ucm-conf/files/8977069/alsa-info.txt)

I am using alsa-libs 2.0.7 and the latest ucm from master on ubuntu 22.04 to make sure that I have all the minimum requirements.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/178
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
