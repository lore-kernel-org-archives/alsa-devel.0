Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B64C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 17 May 2022 14:29:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFAA284C;
	Tue, 17 May 2022 16:28:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFAA284C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652797788;
	bh=g4q/1qca0h5pnsOodcR/g58gQUO6cZYv/JspfVd85js=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AzAp7IA5bkiYAhx7zrVKZkxoq8vJItdzbf2BlL9Bx+04MEIYuU/GQx3p61MezCwt8
	 dEhveG5xciTUboqWX5cqV6pIctipi64J4ysEZWM+SGZCs6TiBDgiYkj0Ui1iqotoMA
	 E+Hw4jK0xWwpNQ+vEryjIZO4Xn0eWFQU0kaycOuY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7BAE5F801D8;
	Tue, 17 May 2022 16:28:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 60D8DF802DB; Tue, 17 May 2022 16:28:53 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B5AB9F800D8
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2022 16:28:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5AB9F800D8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1652797725783672094-webhooks-bot@alsa-project.org>
References: <1652797725783672094-webhooks-bot@alsa-project.org>
Subject: vc4-hdmi.conf: use a proper hdmi pcm, fix broken default pcm
Message-Id: <20220517142853.60D8DF802DB@alsa1.perex.cz>
Date: Tue, 17 May 2022 16:28:53 +0200 (CEST)
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

alsa-project/alsa-lib issue #229 was opened from macmpi:

referring https://github.com/raspberrypi/linux/issues/4662#issuecomment-1114000673 and assorted [patch](https://mailman.alsa-project.org/pipermail/alsa-devel/2022-April/200025.html) from @HiassofT
Thanks for consideration.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/229
Repository URL: https://github.com/alsa-project/alsa-lib
