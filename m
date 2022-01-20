Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA59C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Jan 2022 04:55:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D07A2F75;
	Thu, 20 Jan 2022 05:54:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D07A2F75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642654535;
	bh=stu64OVfUP3jY26w+CFkrCA/YO10n8y8Y5JedhZ2UA4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JX8PCJvKeYM3XLfCU/KwfG4CWeLMg3nAOKlKO1691TA/+mdk1l1jKNC6Y2hbAphH6
	 4+bUTTp2lnuLRpt8zCw5uBWynWL9WUbeBx5k5EHbUAscZ0Qw18UwZyA3PAi5c6BDoX
	 0GLps28t2iXfQzUCQtEFAc3YOqRRVZ+oMqWiYSdI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79A9EF80128;
	Thu, 20 Jan 2022 05:54:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C84C4F8012E; Thu, 20 Jan 2022 05:54:41 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 0F9B7F8007E
 for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2022 05:54:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F9B7F8007E
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1642654474050827980-webhooks-bot@alsa-project.org>
References: <1642654474050827980-webhooks-bot@alsa-project.org>
Subject: alsamixer: `color` settings are not respected anymore
Message-Id: <20220120045441.C84C4F8012E@alsa1.perex.cz>
Date: Thu, 20 Jan 2022 05:54:41 +0100 (CET)
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

alsa-project/alsa-utils issue #137 was opened from int-e:

`alsamixer` supports customizing colors for the various controls using the `color` directive in the configuration file. Commit

   https://github.com/alsa-project/alsa-utils/commit/5d4442b2cfe967c44b5cd74fccb62d1fb4095b19

broke this feature, because it initializes curses colors *after* reading the configuration file, which overrides any colors that the configuration file may have set.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/137
Repository URL: https://github.com/alsa-project/alsa-utils
