Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD428ECAAD4
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Aug 2022 22:58:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF9AB1632;
	Sat, 27 Aug 2022 00:57:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF9AB1632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661554722;
	bh=gmZq1m2o64jxSUdmAvKmtAfD8wZ+9OlyufLxrEVrdnA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=idpHShfltwl5X7tq/pLzij8wYvrMymgBVcqnCjRjZ3p/gdbAyjoYJpCTPiFqTZB6i
	 1fYSlV0s+dAk4s45OiPZcMFaKu/1q7+KpWcCDSaY4xhgIqKs1KtvVZ/q88YBmVJyj6
	 OiTAsJDP600jaR7md6sRBiY7wIi9CBfZQYGAfHwc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 71CABF80105;
	Sat, 27 Aug 2022 00:57:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D3CBBF80238; Sat, 27 Aug 2022 00:57:50 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 502DEF8014B
 for <alsa-devel@alsa-project.org>; Sat, 27 Aug 2022 00:57:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 502DEF8014B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1661554668131293058-webhooks-bot@alsa-project.org>
References: <1661554668131293058-webhooks-bot@alsa-project.org>
Subject: Fix for ALC4080 (ASUS ROG Strix B660-F Gaming WiFi)
Message-Id: <20220826225750.D3CBBF80238@alsa1.perex.cz>
Date: Sat, 27 Aug 2022 00:57:50 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #206 was edited from RomanAverin:

Fix for ALC4080 (ASUS ROG Strix B660-F Gaming WiFi)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/206
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/206.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
