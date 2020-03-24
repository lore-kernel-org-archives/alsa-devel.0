Return-Path: <SRS0=1tVn=5J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F375AC10DCE
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 06:59:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593EA20663
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2020 06:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rwVOCbnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593EA20663
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E4E4846;
	Tue, 24 Mar 2020 07:58:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E4E4846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585033162;
	bh=MmeP/Liqq9QxncDpAFT3ifqliNWQgcWK89WA8BRiS88=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rwVOCbnjGyltM2r48NB16IDoD86vYNl9UClmPWBvGnVOa4WPVXvaoV8Ae1Wfll7ug
	 pty8gTrNrogP+SqZ+vC6o2hcj/yb4JeVdjeyMiKclkPbp9m2/ZgFV2wlH/sD2MTzMh
	 /yvDdhe6fp03/jHRa42v+d8p4yx3FiKKpHRIo0MY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26D55F801F8;
	Tue, 24 Mar 2020 07:58:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7274CF801F9; Tue, 24 Mar 2020 07:58:30 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 8AA6FF80095
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2020 07:58:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8AA6FF80095
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1585033106797276020-webhooks-bot@alsa-project.org>
References: <1585033106797276020-webhooks-bot@alsa-project.org>
Subject: sound: update header to v0.2.0
Message-Id: <20200324065830.7274CF801F9@alsa1.perex.cz>
Date: Tue, 24 Mar 2020 07:58:30 +0100 (CET)
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

alsa-project/tinycompress pull request #4 was opened from vinodkoul:

Kernel has upgraded compress headers with support for WMA, ALAC and APE
and bumped version to 0.2.0, so update this header as well

Signed-off-by: Vinod Koul <vkoul@kernel.org>

Request URL   : https://github.com/alsa-project/tinycompress/pull/4
Patch URL     : https://github.com/alsa-project/tinycompress/pull/4.patch
Repository URL: https://github.com/alsa-project/tinycompress
