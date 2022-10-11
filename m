Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1B3C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Oct 2022 13:33:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 300823CAE;
	Tue, 11 Oct 2022 15:32:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 300823CAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1665495199;
	bh=yTA0Skul5ItbFmaiJVEVKFWCDi5tEj7H8RqUopybjIA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LXBxB3/BBdo8guR0aAXWkMBNaHQmqpzN1geOClE3oNmcjKtd5RyxEfDVhgvhb5MwA
	 jLtYTofeXPnuBi+sxI3uDq3oKkCEwKHQS3wYGjx5wIc1Ogi+S/jZ2js44UZkB3DevI
	 S6zR5bExSR/iGV7EloI55OGhHqWTgRNfRHUOMfyA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D2F81F80134;
	Tue, 11 Oct 2022 15:32:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 43317F801D5; Tue, 11 Oct 2022 15:32:27 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9C1DEF80132
 for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2022 15:32:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C1DEF80132
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1665495139140371084-webhooks-bot@alsa-project.org>
References: <1665495139140371084-webhooks-bot@alsa-project.org>
Subject: Add support for listing compress devices
Message-Id: <20221011133227.43317F801D5@alsa1.perex.cz>
Date: Tue, 11 Oct 2022 15:32:27 +0200 (CEST)
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

alsa-project/tinycompress issue #17 was opened from dbaluta:

Similar with `aplay -l` we need an option to list compress devices. `cplay -l`.

Issue URL     : https://github.com/alsa-project/tinycompress/issues/17
Repository URL: https://github.com/alsa-project/tinycompress
