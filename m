Return-Path: <SRS0=v4AK=LB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6BFC47082
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 21:05:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFBA9611BD
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 21:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBA9611BD
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 628C51674;
	Mon,  7 Jun 2021 23:04:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 628C51674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623099945;
	bh=z+6NzayOksWsCGM9QMU1lOxtWgcUz/kWakCj1df/XIY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eUrShG/3US1ySD4PENwjzt9UH6wkd3I4Xx39beLNmZq5NpaQaxYlt3FMPHDPpmZBl
	 /ap3wOrzZwM5OZ09shfxfV1Y0thisYOw9gfrmnVVMsDli3n20t26N0UAwBHYZr/ipW
	 ZTz4VH1O5LQ6/pQOBMOMRCbIawkpkF6YhD2W7QiM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE313F8020D;
	Mon,  7 Jun 2021 23:04:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CA19FF80212; Mon,  7 Jun 2021 23:04:53 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E57E0F800AF
 for <alsa-devel@alsa-project.org>; Mon,  7 Jun 2021 23:04:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E57E0F800AF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1623099884613096952-webhooks-bot@alsa-project.org>
References: <1623099884613096952-webhooks-bot@alsa-project.org>
Subject: added an option to aseqnet to optionally set the midi process name
Message-Id: <20210607210453.CA19FF80212@alsa1.perex.cz>
Date: Mon,  7 Jun 2021 23:04:53 +0200 (CEST)
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

alsa-project/alsa-utils pull request #95 was opened from BrainDamage:

This option allows to run multiple instances of aseqnet without having
to double check the assigned port number, since each one can get spawned
with a unique name.

The patch is pretty minimal and clean, thopefully here shouldn't be troubles 
merging it.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/95
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/95.patch
Repository URL: https://github.com/alsa-project/alsa-utils
