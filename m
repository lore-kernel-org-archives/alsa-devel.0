Return-Path: <SRS0=eDLw=CB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85068C433E1
	for <alsa-devel@archiver.kernel.org>; Sun, 23 Aug 2020 01:16:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E84207C3
	for <alsa-devel@archiver.kernel.org>; Sun, 23 Aug 2020 01:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cjixYGiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E84207C3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7BC651669;
	Sun, 23 Aug 2020 03:15:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7BC651669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598145386;
	bh=sQjMgaH3XiR+A804/sTBZPqeaQu+k7h51/yFUlneyEE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cjixYGizbYwC0Smrr/m+IaTP4Pvfk6kskhLhScRUS/e05KK+OKCiIyLMoTijkpyuQ
	 /Xp9oAChTDcS+GOGq8SjxxHHJ7/nAeGocwAjIrQ2ueo9MsgumA4MxiyPVZUdXOWOpx
	 m8JpDLoZ350vdp/TekCnNRpN5/08dkkl7t37yTqU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 135E8F800B8;
	Sun, 23 Aug 2020 03:15:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6EBA8F8025A; Sun, 23 Aug 2020 03:15:33 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 22387F800B8
 for <alsa-devel@alsa-project.org>; Sun, 23 Aug 2020 03:15:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22387F800B8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1598145329750840902-webhooks-bot@alsa-project.org>
References: <1598145329750840902-webhooks-bot@alsa-project.org>
Subject: Is raw MIDI API  really raw ? (Running status)
Message-Id: <20200823011533.6EBA8F8025A@alsa1.perex.cz>
Date: Sun, 23 Aug 2020 03:15:33 +0200 (CEST)
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

alsa-project/alsa-lib issue #80 was opened from MusicMaker:

A device is sending always 3 bytes for note off/on event. The host application uses a virtual port to receive the data  The ALSA RAW MIDI API seems to remove the status byte if the channel of the status byte is the same. Once the channel changes, the RAW MIDI API provide the status byte to the higher level layer. Is this the bahaviour of the RAW MIDI API ? if yes then raw isn't actually raw. Can this  be disabled ? Could not find a parameter at port open to do this. (not using the sequencer)

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/80
Repository URL: https://github.com/alsa-project/alsa-lib
