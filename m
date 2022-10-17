Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF41C433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Oct 2022 07:48:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 566C03969;
	Mon, 17 Oct 2022 09:47:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 566C03969
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1665992896;
	bh=YskWV0rSXaufcXl0OZ6q2/ltiFVjXco4G5kbq4B83HI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SUNUi/SGlJeIwdmiJrPO1JG5adNrbV/5I2ND9vMZ1OLWesBqXxhghWjsduZgIEuBU
	 2r34yDSqtDS8XswFA5TtFsh3v5xxGjbuHklVP3CN3DtGNLPFNWqGeltJCwgDY22yR+
	 zMhVWmXdGEOfMSP9DUF0s1I1iGHIw99TV0hkDS6c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE4FEF8025E;
	Mon, 17 Oct 2022 09:47:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29389F80496; Mon, 17 Oct 2022 09:47:24 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B65D5F800AA
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2022 09:47:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B65D5F800AA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1665992841244613886-webhooks-bot@alsa-project.org>
References: <1665992841244613886-webhooks-bot@alsa-project.org>
Subject: Draft: Add Arturia Minifuse 1 Support
Message-Id: <20221017074724.29389F80496@alsa1.perex.cz>
Date: Mon, 17 Oct 2022 09:47:24 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #226 was edited from nodens:

Arturia Minifuse 1 is a stripped-down version of Minifuse 2:
- 1 Input
- 2 Outputs
- Loopback interface to ease recording of the computer output

(attempt at fixing #220)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/226
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/226.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
