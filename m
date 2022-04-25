Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15970C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Apr 2022 23:33:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 054AA1878;
	Tue, 26 Apr 2022 01:32:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 054AA1878
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650929591;
	bh=3d61BMQc+tySDJJALW5CTSwb/qQS/egy0QosVG2tyoc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CA1FBr1DJ+gJHkSheAP/CWx78BX3gQtr4RYbttbSOi9lO3vMgJQyOr0G+SDglLc7/
	 Has5MrzcVEpXzovCeiVhrk290d4KsEfMwHH92jdy84JbuAzX/btAcBCNidHhWsosN2
	 zKidDFGg5Sp4Pq8d1PPK7jzUtM40/OIK2A/7qu2Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D2BCF80152;
	Tue, 26 Apr 2022 01:32:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0C857F8016A; Tue, 26 Apr 2022 01:32:19 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 7FA33F800CB
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2022 01:32:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7FA33F800CB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1650929531132909060-webhooks-bot@alsa-project.org>
References: <1650929531132909060-webhooks-bot@alsa-project.org>
Subject: ucm2: sof-glkda7219max: add HDMI/DP support
Message-Id: <20220425233219.0C857F8016A@alsa1.perex.cz>
Date: Tue, 26 Apr 2022 01:32:19 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #150 was opened from plbossart:

First add HDMI/DP

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/150
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/150.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
