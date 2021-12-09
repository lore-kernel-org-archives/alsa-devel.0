Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E47C433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Dec 2021 09:50:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8469C225E;
	Thu,  9 Dec 2021 10:49:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8469C225E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639043433;
	bh=8gfaoFxzmBHhW4+NrVpcMPGYgocSpWbUa2HvdpKzBZc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TITd0NexdAM1zBlzG6nOnuntDXC7DFdCjBDDtSRCjaI9tHnOmwjpV8mhU25mBKxSt
	 ymGDZ5eJuoLJEvAothsX9KUj8O0JpQLAZFyOZxLKRAvW8dgVlhcufSBf/2lPXSuhnI
	 0tICdyC/xK0Lg6QiW/Ye52vBSeu6rnFjvpwY9fY4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4EEEF80259;
	Thu,  9 Dec 2021 10:49:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21CCFF8028D; Thu,  9 Dec 2021 10:49:39 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 63799F800AB
 for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2021 10:49:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63799F800AB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1639043364590735912-webhooks-bot@alsa-project.org>
References: <1639043364590735912-webhooks-bot@alsa-project.org>
Subject: PinePhone support
Message-Id: <20211209094939.21CCFF8028D@alsa1.perex.cz>
Date: Thu,  9 Dec 2021 10:49:39 +0100 (CET)
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

alsa-project/alsa-ucm-conf issue #124 was opened from tomfitzhenry:

It'd be great to have PinePhone support in alsa-ucm-conf. https://gitlab.com/pine64-org/pine64-alsa-ucm/-/issues/3 is the canonical source of PinePhone UCM.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/124
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
