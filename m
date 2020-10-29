Return-Path: <SRS0=XEtc=EE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13E5C4363A
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 06:59:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6508B21775
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 06:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vnaSZ9Pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6508B21775
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 639B715E0;
	Thu, 29 Oct 2020 07:58:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 639B715E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603954752;
	bh=eNqhsd4/KszbC9N7KkEJK5gwnRec7EFD+lUYBln5IwQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vnaSZ9PauX7KuBPRg7ju5jnaxe6GcJMO1O+XySSrM0YZ/keIHOstu+o4Azi2SR6Aa
	 dE2B9/4IzktfJUoQ2ZvkqkeuUCHy1rPzjM4fGMnRCpl1wjmLoPHJ82zTKaFVRIgryg
	 drHn2xeaa00kcl7AP2zX3ArZTNPwf7OC3P6e28F0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D51C9F80095;
	Thu, 29 Oct 2020 07:58:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0E4CF8020D; Thu, 29 Oct 2020 07:58:20 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id A25C7F80095
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 07:58:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A25C7F80095
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1603954693201121092-webhooks-bot@alsa-project.org>
References: <1603954693201121092-webhooks-bot@alsa-project.org>
Subject: ucm: return error if boot_list is empty
Message-Id: <20201029065820.B0E4CF8020D@alsa1.perex.cz>
Date: Thu, 29 Oct 2020 07:58:20 +0100 (CET)
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

alsa-project/alsa-lib pull request #94 was opened from jason77-wang:

If bootlist is empty, that means there is no BootSequence defined
in the ucm for this sound card, let set_boot_user() return error,
then alsactl could have chance to use non-ucm ways to initialize the
sound card.

Signed-off-by: Hui Wang <hui.wang@canonical.com>

Request URL   : https://github.com/alsa-project/alsa-lib/pull/94
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/94.patch
Repository URL: https://github.com/alsa-project/alsa-lib
