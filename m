Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B8FC4167B
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Dec 2022 02:30:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6598257D0;
	Mon, 26 Dec 2022 03:30:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6598257D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672021854;
	bh=smyNeioRH+6xG9Mj+q3v/unHdsbrW4UvKb1ptBK2R/o=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sm+j9hr6m7qMmKzrUHD8sbCrlpIAe4ZLGEfCBtMQFv2lbwwCIUeTZDwH0jtfdXlE3
	 9u6LwBuN7FMEJSCEpn65R15BiOPumjI2ua5nr/UY9BN7QB8UzohibIVH6GkvjK+2k4
	 DFBe9KOSnpo0noIGTskQwgaQhbeZepW0c1/oKGqk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13CEEF802A0;
	Mon, 26 Dec 2022 03:30:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E9D2F80310; Mon, 26 Dec 2022 03:30:03 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 1F334F80134
 for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2022 03:29:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F334F80134
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1672021799100692034-webhooks-bot@alsa-project.org>
References: <1672021799100692034-webhooks-bot@alsa-project.org>
Subject: sof-hda-dsp: Set Dmic0 Capture Switch on
Message-Id: <20221226023003.1E9D2F80310@alsa1.perex.cz>
Date: Mon, 26 Dec 2022 03:30:03 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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

alsa-project/alsa-ucm-conf pull request #259 was opened from KaiChuan-Hsieh:

Internal microphone default is off after fresh installation. Add operation to set the control on to align with other sound architecture.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/259
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/259.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
