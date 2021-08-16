Return-Path: <SRS0=rgkk=NH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7260C4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 16:44:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C43860F55
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 16:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C43860F55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8FC4166F;
	Mon, 16 Aug 2021 18:43:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8FC4166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629132253;
	bh=pRlN4ntaxNxZ3FhJD/Tt/CJCwv/1JoButnAjITMh61k=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=j4+ZtVWLrslyPiLqH8ofZXffYoG+cS9DmtB2PJXDAxqZVu07564VkqGh9iqwO4hMF
	 0r7VUwFtpJONUMxMD5dC3BpVwQiDucqIrboTXMzNhHhy84l/v/GrxEseERkMgzbxLd
	 RmN+sBw3W04NrMvphDobFfGf7aIjhJRIpuEZ07hQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E870F80246;
	Mon, 16 Aug 2021 18:43:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 779C2F80249; Mon, 16 Aug 2021 18:43:21 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C805DF80154
 for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2021 18:43:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C805DF80154
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="s7Q8jp6i"
Received: from [10.172.193.212] (1.general.cking.uk.vpn [10.172.193.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id F07123F04D; 
 Mon, 16 Aug 2021 16:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1629132186;
 bh=0Aci3PtlGfoMUvbObF/5DAnE61QA6srUCQf5qmnkZSs=;
 h=From:To:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type;
 b=s7Q8jp6iDjOscuUyTOeoDhes/D3AdsCB/AsTwmX+AiT+Am3c7PgzvmRtKDZQHJ0mD
 iwO7JU1lmV92Nxg56z1VRrYR2GnNOiQG8YTIHWiDdf2QRaUlbdeU+Gqq7VKMDV9x/+
 ZnV0Ur40kAJoVRdepgSAUhPUVDpK/SLjo+1Q+hZIaysFVRLsY1uW0chwbcxb7CbFqo
 GIUO8OAgJQmHyT7WPB8esfy/+O1e17gToO83xUO1AS0yUMlmqQkV5J5nfussflOOST
 0jQaM+weVM1dFtM6pzAnbSQ9uOjZ9T2LADtzHKVXqCjLThDknxGWXtL8D2M0RKgBDZ
 pSh4JxbV4kX4Q==
From: Colin Ian King <colin.king@canonical.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Subject: re: ASoC: sh: Add RZ/G2L SSIF-2 driver
Message-ID: <962029d0-d001-f85c-1676-262372faeb34@canonical.com>
Date: Mon, 16 Aug 2021 17:43:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi,

Static analysis on linux-next with Coverity has detected an issue in
rz_ssi_stop, sound/soc/sh/rz-ssi.c with the following commit:

commit 03e786bd43410fa93e5d2459f7a43e90ff0ae801
Author: Biju Das <biju.das.jz@bp.renesas.com>
Date:   Fri Aug 13 10:11:54 2021 +0100

    ASoC: sh: Add RZ/G2L SSIF-2 driver


The analysis is as follows:

367
368        /* Wait for idle */
369        timeout = 100;
370        while (--timeout) {

Wrong operator used (CONSTANT_EXPRESSION_RESULT)

operator_confusion: rz_ssi_reg_readl(ssi, 4) | (33554432UL /* 1UL << 25
*/) is always 1/true regardless of the values of its operand. This
occurs as the logical operand of if.

371                if (rz_ssi_reg_readl(ssi, SSISR) | SSISR_IIRQ)
372                        break;
373                udelay(1);
374        }

I suspect the & operator was intended to mask the specific bit. However
I'm not sure if the intent is to detect if the SSISR_IIRQ bit should be
zero or one at the point where the break should occur, hence I'm
reporting this issue.

Colin
