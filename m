Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA031C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Feb 2022 16:08:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 608EA171B;
	Mon, 21 Feb 2022 17:08:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 608EA171B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645459735;
	bh=ftNJbufy22JBWdwV7j4SDRkRZ7SHDU/Qcg7mNW/OQFQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uwJI07KorH5FLBo3DYwlaAiqkLsn/6T00oVI/q2tmpPBbmw+03qI7hr9dXkhLkt8d
	 oJymxNtlT1MRSnbxY5b8pQpPhMR0AiDPxyf5TSxMU5lM2pVJbeoTVHCUo6CEy0OELx
	 6kxzNSXpXqMPJEokVmXao9AvlgkdVkAOvAIP1Q6Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB262F800D1;
	Mon, 21 Feb 2022 17:08:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 88DC5F8013D; Mon, 21 Feb 2022 17:08:03 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 78033F800D1
 for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2022 17:07:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78033F800D1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1645459677030811071-webhooks-bot@alsa-project.org>
References: <1645459677030811071-webhooks-bot@alsa-project.org>
Subject: jack: implement pcm operation sw_params
Message-Id: <20220221160803.88DC5F8013D@alsa1.perex.cz>
Date: Mon, 21 Feb 2022 17:08:03 +0100 (CET)
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

alsa-project/alsa-plugins pull request #43 was opened from aditpape:

to reflect an updated avail_min value during runtime

Signed-off-by: Andreas Pape <apape@de.adit-jv.com>

Request URL   : https://github.com/alsa-project/alsa-plugins/pull/43
Patch URL     : https://github.com/alsa-project/alsa-plugins/pull/43.patch
Repository URL: https://github.com/alsa-project/alsa-plugins
