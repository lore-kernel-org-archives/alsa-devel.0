Return-Path: <SRS0=U/T/=46=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6543C10DCE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 07:48:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F8120409
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Mar 2020 07:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="u7mhAdVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F8120409
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0DDB179E;
	Fri, 13 Mar 2020 08:47:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0DDB179E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584085682;
	bh=vuYDkC8rzmfREN5KuSojnMxn0yIi+rgOraghGSGvs/A=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u7mhAdVjGyBuOIAomQAqNPSkJbBHo94DLRaT+xNICrx+yttjedXk33OTjhnc3WWeu
	 F0nz28ggtXiAxoPkdUBrPqZPGqu1x8sBp/piSPihqkbxSyMwRHI1Oh1G+TO+E6OUnF
	 focYeS6rAjCJ6ZHjWC3cHesvRiVYIfdsFP/xzaac=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48271F801A3;
	Fri, 13 Mar 2020 08:47:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C9311F801EB; Fri, 13 Mar 2020 08:46:18 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 6C540F80090
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2020 08:43:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C540F80090
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1584085382060765028-webhooks-bot@alsa-project.org>
References: <1584085382060765028-webhooks-bot@alsa-project.org>
Subject: conf: USB-Audio: Add C-Media USB Headphone Set to the IEC958 blacklist
Message-Id: <20200313074618.C9311F801EB@alsa1.perex.cz>
Date: Fri, 13 Mar 2020 08:46:18 +0100 (CET)
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

alsa-project/alsa-lib pull request #36 was opened from tanuk:

Fixes: https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/317

Signed-off-by: Tanu Kaskinen <tanuk@iki.fi>

Request URL   : https://github.com/alsa-project/alsa-lib/pull/36
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/36.patch
Repository URL: https://github.com/alsa-project/alsa-lib
