Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F27C4332F
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Nov 2022 22:40:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B8B81F7;
	Sat,  5 Nov 2022 23:39:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B8B81F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667688036;
	bh=3QZQqcPqubu16OB7KllWXlNDgbzyz7a4TKDzbFrmGew=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BfQn6+CpZbmO3GaXrfEVzqUBCFpCj4D4Xqeff51KHB20QX7ePCHg7ciTrot7EOYKX
	 WXO68qKC5+SzUZd/VPB6q964xiOzdvbNQE5yj/YQyOe/YZoNCOV06Spf5XIvOAIZYf
	 DmisX+09aH/5NVdMteb4kBT4/j7W06WxnG5fzcGQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1C7ABF8027C;
	Sat,  5 Nov 2022 23:39:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 731FBF803DC; Sat,  5 Nov 2022 23:39:43 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 6A948F8012F
 for <alsa-devel@alsa-project.org>; Sat,  5 Nov 2022 23:39:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A948F8012F
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1667687979899627924-webhooks-bot@alsa-project.org>
References: <1667687979899627924-webhooks-bot@alsa-project.org>
Subject: ucm2: add support for "Digidesign Mbox 3"
Message-Id: <20221105223943.731FBF803DC@alsa1.perex.cz>
Date: Sat,  5 Nov 2022 23:39:43 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #237 was opened from ManuLinares:

Add ucm2 support for "Digidesign Mbox 3", 
without it, alsa detects as analog-surround4.0, instead of 2 line and 2 spdif in/out.

[alsa-info.txt](https://github.com/alsa-project/alsa-ucm-conf/files/9944813/alsa-info.txt)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/237
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/237.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
