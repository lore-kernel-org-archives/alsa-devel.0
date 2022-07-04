Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAD5C433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Jul 2022 10:08:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42A3A16EA;
	Mon,  4 Jul 2022 12:08:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42A3A16EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656929335;
	bh=3nqcADvzo+MUZV06PAsABnDtetuu4hS1AP3pMIPMILc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L0/4MCjU8Q1VHmEWkd2bH0XkvglAcisoWLu0rghX0PiqgEdQjZPZuRfGgF0cXyLM+
	 qiwz9aZBk9OM1asn0cqsrtXz206y6Y5MjGxuDZVrmUq3xNgNgBjodHlY9t+5coIVav
	 N3WURFtWU8//EqYN1kYOyA9mt9DeArFpW38Yjm6o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C7B09F80141;
	Mon,  4 Jul 2022 12:08:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7C91F8012A; Mon,  4 Jul 2022 12:08:02 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 7020FF8012A
 for <alsa-devel@alsa-project.org>; Mon,  4 Jul 2022 12:08:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7020FF8012A
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1656929279956115007-webhooks-bot@alsa-project.org>
References: <1656929279956115007-webhooks-bot@alsa-project.org>
Subject: failed to import acp5x use case configuration -2
Message-Id: <20220704100802.D7C91F8012A@alsa1.perex.cz>
Date: Mon,  4 Jul 2022 12:08:02 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #184 was opened from DocMAX:

docmax@steamdeck: ~ $ ALSA_CONFIG_UCM=/usr/share/alsa/ucm2/ alsaucm -c acp5x set _verb HiFi
ALSA lib main.c:1541:(snd_use_case_mgr_open) error: failed to import acp5x use case configuration -2
alsaucm: error failed to open sound card acp5x: No such file or directory

Why does it fail? I have the following directory set up:

/usr/share/alsa/ucm2/conf.d/acp5x/HiFi.conf
/usr/share/alsa/ucm2/conf.d/acp5x/acp5x.conf

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/184
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
