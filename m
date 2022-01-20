Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F30C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Jan 2022 07:35:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 904A93137;
	Thu, 20 Jan 2022 08:34:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 904A93137
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642664133;
	bh=lOxmWzO92apB+W5Wz5jN7IYDTWv1iNaq0yoZYHH9VUc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GWeJzOkC0oNlQwdRyCsXzozpWPPcXquC+MNZWzJZq6AT2gJC85+mc5Xf3yiihDjlP
	 YojRU87VyEY2gJyZFoGzXC2JUcv49Q8puUqhdQePKErVpm87g3Syq6daT/OMdE5PhQ
	 BCI8xFXoVDlBcZCfzs7Ocoi5L3qsTT3f83A5jI4c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B911F80128;
	Thu, 20 Jan 2022 08:34:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5DA1CF8012E; Thu, 20 Jan 2022 08:34:41 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 55730F800F2
 for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2022 08:34:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55730F800F2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1642664074883182049-webhooks-bot@alsa-project.org>
References: <1642664074883182049-webhooks-bot@alsa-project.org>
Subject: Make code compatible with Python 3.10
Message-Id: <20220120073441.5DA1CF8012E@alsa1.perex.cz>
Date: Thu, 20 Jan 2022 08:34:41 +0100 (CET)
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

alsa-project/alsa-lib pull request #210 was opened from ginggs:

As noted in bpo-30459, PyTuple_SET_ITEM() does not return a value.

https://bugs.python.org/issue30459

Request URL   : https://github.com/alsa-project/alsa-lib/pull/210
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/210.patch
Repository URL: https://github.com/alsa-project/alsa-lib
