Return-Path: <SRS0=TxyJ=FA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21A1C56202
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Nov 2020 13:15:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C40F422201
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Nov 2020 13:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kO2rID9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40F422201
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0CDD517BB;
	Thu, 26 Nov 2020 14:14:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0CDD517BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606396524;
	bh=McU6QmCKksaUdzfOjxUE3e9W6kuSdgOq6PWdcgadwUc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kO2rID9RJTrT4J/TKqeTtDPugx4w26iKgA6nnCSZNyHv1el6E/QojwQimLVWUdjCE
	 AxftMm8t/7DKVEJlsa/A3/WlSHDxmy1LvVjj6cW5vLkZMU/+4hY+CoCDGwwD1R5jMm
	 yQF5zBhFPS+A4rg+BtG45BJaKoMoyRSqX+WXtnVY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A91CF80164;
	Thu, 26 Nov 2020 14:14:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 872B5F80165; Thu, 26 Nov 2020 14:14:31 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 80642F80159
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2020 14:14:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80642F80159
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1606396457981029034-webhooks-bot@alsa-project.org>
References: <1606396457981029034-webhooks-bot@alsa-project.org>
Subject: pcm: snd_pcm_readi - plugin type multi, the overun appears when read
Message-Id: <20201126131431.872B5F80165@alsa1.perex.cz>
Date: Thu, 26 Nov 2020 14:14:31 +0100 (CET)
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

alsa-project/alsa-lib pull request #102 was opened from ouwenchen:

After type route use type multi, merge the two input streams.There was
PCM error due to insufficient readable data.Cause the underlying read
pointer cannot be updated, and then it will be overrun.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/102
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/102.patch
Repository URL: https://github.com/alsa-project/alsa-lib
