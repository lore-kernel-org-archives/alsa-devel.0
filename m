Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BCCFA3741
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Oct 2022 17:07:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 050791687;
	Mon, 31 Oct 2022 18:06:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 050791687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667236065;
	bh=US/HYKumOFAtAMMcUMv5hpuKFTeXDrOmo2C/5S9vV6Y=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FJS3uTPpGAtUdxXyMHOFNm5+FcGKLSN+XLFDG6HzYOdjW3YK9c87y3XuUuUz+WMK1
	 eza2mBd4/knH/PrWFXjoFgxT761/LO3FjbZGWR+b7cxj+tGnFLtxj80EFP388tZT56
	 BcUzwVRVXYWaCNKX4DL3n139wmjHEb83qdClz1MA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E5FFF8015B;
	Mon, 31 Oct 2022 18:06:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 824F3F80163; Mon, 31 Oct 2022 18:06:52 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 46C34F800E1
 for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2022 18:06:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46C34F800E1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1667236009458420992-webhooks-bot@alsa-project.org>
References: <1667236009458420992-webhooks-bot@alsa-project.org>
Subject: feat: add support for ASUS ROG Strix Z790-E Gaming Wifi
Message-Id: <20221031170652.824F3F80163@alsa1.perex.cz>
Date: Mon, 31 Oct 2022 18:06:52 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #235 was opened from DASPRiD:

I've verified this profile on my motherboard, and both back- and front jacks seem to work fine, including SPDIF.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/235
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/235.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
