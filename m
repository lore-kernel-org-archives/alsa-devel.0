Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8440BC3F6B0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Aug 2022 06:10:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A7BF1829;
	Fri, 12 Aug 2022 08:10:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A7BF1829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660284650;
	bh=uzMJFzBLfTNgKjWDIl0zZSYZaa/INcnNEkr5UeJsyT0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u7XziUD9vTTyrN8dU4jQ+hbHsSfbMbAY1HUW0bAwlI8pFORi+HtnXkIVwpWuiPKey
	 3zeff23Ws7bVHbp9sRDO/I8Fyq9EEO+4BCT4mSs9jw81mX3x4CStH+3vSaP+vg/Nd1
	 HtV0QWd8rKz6CLkxNph9QHkKuT48GSCAzAezKfXc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3EFEBF80152;
	Fri, 12 Aug 2022 08:10:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26229F8026A; Fri, 12 Aug 2022 08:09:58 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 3E950F80054
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2022 08:09:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E950F80054
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1660284592628407001-webhooks-bot@alsa-project.org>
References: <1660284592628407001-webhooks-bot@alsa-project.org>
Subject: Include <sys/soundcard.h> instead of <linux/soundcard.h>
Message-Id: <20220812060958.26229F8026A@alsa1.perex.cz>
Date: Fri, 12 Aug 2022 08:09:58 +0200 (CEST)
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

alsa-project/alsa-oss pull request #3 was opened from davidebeatrici:

The `linux` folder strictly contains kernel headers, including OSSv3's.

A distribution may package the OSS development header(s) separately.

Request URL   : https://github.com/alsa-project/alsa-oss/pull/3
Patch URL     : https://github.com/alsa-project/alsa-oss/pull/3.patch
Repository URL: https://github.com/alsa-project/alsa-oss
