Return-Path: <SRS0=+eNr=5T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99420C43331
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:35:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49081207FF
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R3pq2isk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49081207FF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 711B51658;
	Fri,  3 Apr 2020 16:34:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 711B51658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585924527;
	bh=sLXJGYGqlPEFuSv9bArH9Tv/PEQayCMMtzTlwsHqygs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R3pq2isk1gXxOR+soc+smxn9TcnWgpkTVTUGyHArmEtu6xNWG1IUJ3a/FZFVn/8t0
	 i0l7G21OAW/GReJ/QgHK0ek4fAJfNLX2v/2jihTF64EtIMokHrM9fTp59IZaUxbbxv
	 qV2OCKlSfolwlTk8xGZDJ+DrRPkSvFXwgM1Fldv4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB77AF80141;
	Fri,  3 Apr 2020 16:34:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6706FF8014C; Fri,  3 Apr 2020 16:34:34 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id F11F9F800E4
 for <alsa-devel@alsa-project.org>; Fri,  3 Apr 2020 16:34:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F11F9F800E4
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1585924469088310003-webhooks-bot@alsa-project.org>
References: <1585924469088310003-webhooks-bot@alsa-project.org>
Subject: conf: USB-Audio: Fix S/PDIF output of ASUS Xonar AE
Message-Id: <20200403143434.6706FF8014C@alsa1.perex.cz>
Date: Fri,  3 Apr 2020 16:34:34 +0200 (CEST)
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

alsa-project/alsa-lib pull request #40 was opened from im-0:

ASUS Xonar AE is a PCI-Express card containing USB controller:

	USB controller [0c03]: ASMedia Technology Inc. ASM1042A USB 3.0 Host Controller [1b21:1142]

and the actual USB sound card:

	ID 0b05:180f ASUSTek Computer, Inc. XONAR SOUND CARD

As other Xonar USB sound cards, it uses second device for digital
output.

Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>

Request URL   : https://github.com/alsa-project/alsa-lib/pull/40
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/40.patch
Repository URL: https://github.com/alsa-project/alsa-lib
