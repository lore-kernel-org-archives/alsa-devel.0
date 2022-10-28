Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70FEECAAA1
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Oct 2022 10:28:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2208122DC;
	Fri, 28 Oct 2022 12:27:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2208122DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666952905;
	bh=HUCHtGo5OqBeDHVIkKbMbdpxmHfV5BXqjHLAWCLswaM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AAe4IKTVXV65gSYmsmn4bmaJb/mrs9lDqdbAPWETtVr1SfXM3k6IXY5lFDcfX7tl8
	 e16XUweb3ZqG/GAegiY+6XtQHUdbsFH1nqWA0vQ7BFI86PhVlz45J+TXob3nXePZW2
	 uztIQX84QWLKBHCHOwZZd9ZTxYZU848/2EvYksTs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C754EF8024C;
	Fri, 28 Oct 2022 12:27:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4973F8025A; Fri, 28 Oct 2022 12:27:33 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id A90ABF80095
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2022 12:27:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A90ABF80095
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1666952847013259888-webhooks-bot@alsa-project.org>
References: <1666952847013259888-webhooks-bot@alsa-project.org>
Subject: alsamixer not readable in xterm
Message-Id: <20221028102733.B4973F8025A@alsa1.perex.cz>
Date: Fri, 28 Oct 2022 12:27:33 +0200 (CEST)
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

alsa-project/alsa-utils issue #176 was opened from Frank-Steiner:

Hi,
after upgrading from opensuse 15.3 to 15.4 we realized alsamixer is not useable in standard xterm with white background (which is our default) because the black background vanished. Found https://mailman.alsa-project.org/pipermail/alsa-devel/2021-June/185925.html which explains it. 
But that patch was a bad idea for everyone just using standard xterms and not themed ones.

Adding sth. like a "--black-background" switch could be helpful for those people not working with themed X11...
cu,
Frank

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/176
Repository URL: https://github.com/alsa-project/alsa-utils
