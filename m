Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C47ECAAA1
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Sep 2022 22:41:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DA991616;
	Tue,  6 Sep 2022 00:40:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DA991616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662417703;
	bh=iTfE7FpHj7dt4cVilGz2B/xcQmBqndKAf8SibO8giS0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nrXzTymMK/pBgflRGC2jBSQifRGwzfNQPpp18PBBsVaNp3BV4KOhgWLMq0UDai7z3
	 nNvnCQq2fe2ugcklY0lxOqzWejsOWPoizJyQWSW/jZfC5JDHZbo0DuSDLvt4SZuTK8
	 jpKXgZbBPR1Uaein4U97+CKXHbU3EVOpMs5X4npg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24951F80165;
	Tue,  6 Sep 2022 00:40:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 88A55F80238; Tue,  6 Sep 2022 00:40:51 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E2ED2F800CC
 for <alsa-devel@alsa-project.org>; Tue,  6 Sep 2022 00:40:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2ED2F800CC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1662417648270813942-webhooks-bot@alsa-project.org>
References: <1662417648270813942-webhooks-bot@alsa-project.org>
Subject: amidi: --send shouldn't require a seekable file
Message-Id: <20220905224051.88A55F80238@alsa1.perex.cz>
Date: Tue,  6 Sep 2022 00:40:51 +0200 (CEST)
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

alsa-project/alsa-utils issue #167 was opened from BasedUser:

Just like `--receive`, `--send` should instead send events to a given port until the sent file returns EOF, or `amidi` is terminated. Pipes and FIFOs cannot currently be used to create a persistent MIDI source.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/167
Repository URL: https://github.com/alsa-project/alsa-utils
