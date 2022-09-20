Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120E6ECAAD8
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Sep 2022 08:43:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3914C204;
	Fri, 23 Sep 2022 10:42:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3914C204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663922596;
	bh=B9T5ifR8l5F54DQp+KrPOLUQw8g9WRv6jY9a1u+hqgI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BiVFiwTNLx3TyNBjTZ6REHRcf+kcb2xlR0kJp3tWp7vBIISefP0C01Ss7FdjG44+X
	 TkL0WcJamEizKVG1/f7+s7VEyr5HgPnypeHDVP1DxYuoZQQiN9iPz0OHb/oI3I7X9t
	 WA8jRqn9cfrBnQRg/z3nPslclrEu7CZehH5rv3cA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB3E8F80224;
	Fri, 23 Sep 2022 10:42:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A92D8F800F2; Tue, 20 Sep 2022 05:46:02 +0200 (CEST)
Received: from mail-m11883.qiye.163.com (mail-m11883.qiye.163.com
 [115.236.118.83])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA4F4F800F2
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2022 05:45:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA4F4F800F2
Received: from rockchip.. (unknown [58.22.7.114])
 by mail-m11883.qiye.163.com (Hmail) with ESMTPA id 075F184078F;
 Tue, 20 Sep 2022 11:45:47 +0800 (CST)
From: Jason Zhu <jason.zhu@rock-chips.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Subject: [PATCH 0/1]
Date: Tue, 20 Sep 2022 11:45:44 +0800
Message-Id: <20220920034545.2820888-1-jason.zhu@rock-chips.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSx8eVkxISkoZQh9NQh1DGlUTARMWGhIXJB
 QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktITkhVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OSI6Nzo6Tz0YGB1NURgfN1E6
 C00aCj5VSlVKTU1ITU9OTk9MTUhJVTMWGhIXVREaCBQVVQETDjsJFBgQVhgTEgsIVRgUFkVZV1kS
 C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUJJTTcG
X-HM-Tid: 0a8359007ac32eb8kusn075f184078f
X-Mailman-Approved-At: Fri, 23 Sep 2022 10:42:24 +0200
Cc: sugar.zhang@rock-chips.com, Jason Zhu <jason.zhu@rock-chips.com>,
 alsa-devel@alsa-project.org
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

ASoC soc dai

Jason Zhu (1):
  ASoC: soc-dai: export some symbols

 sound/soc/soc-dai.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.34.1

