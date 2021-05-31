Return-Path: <SRS0=0Rat=K2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B732BC47082
	for <alsa-devel@archiver.kernel.org>; Mon, 31 May 2021 08:39:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA10E611EE
	for <alsa-devel@archiver.kernel.org>; Mon, 31 May 2021 08:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA10E611EE
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7AE27846;
	Mon, 31 May 2021 10:38:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7AE27846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622450360;
	bh=6cEddZKtF9ZXp9447WuEfxpS3zny3ut7O/8gsIlElXA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t1SfrP86GJG89MFMy9YPVdzhUyVm5ETktabnOnFqqisyG2fCTuY9XdFc6B94KEQrR
	 x0IIcgNB7jxA4SV6QvcBuDl/t2JFmWrp8WhtUjrG70SZqT6xXXyytjhQ0hnWcxMB5/
	 mvbrdnqZvw1SA9mUmNlAnIwhX3BRj1UyoiN63vIg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 085A5F80273;
	Mon, 31 May 2021 10:38:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B6838F802E2; Mon, 31 May 2021 10:38:27 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 2CDA6F80161
 for <alsa-devel@alsa-project.org>; Mon, 31 May 2021 10:38:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2CDA6F80161
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1622450299411672115-webhooks-bot@alsa-project.org>
References: <1622450299411672115-webhooks-bot@alsa-project.org>
Subject: Add UCM for Nvidia Tegra HDMI Audio
Message-Id: <20210531083827.B6838F802E2@alsa1.perex.cz>
Date: Mon, 31 May 2021 10:38:27 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #94 was opened from clamor-s:

This were used to have audio over HDMI on Asus Transformers. You may find original configs [in pmOS](https://gitlab.com/postmarketOS/pmaports/-/tree/master/device/testing/device-asus-tf201/ucm) and paths used [here](https://gitlab.com/postmarketOS/pmaports/-/blob/master/device/testing/device-asus-tf201/APKBUILD#L30-38). I have adjusted them to use syntax 4 and re-use common codecs.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/94
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/94.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
