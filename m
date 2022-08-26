Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFDBECAAD4
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Aug 2022 12:22:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 29DA4161E;
	Fri, 26 Aug 2022 14:21:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 29DA4161E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661516535;
	bh=fwj0m20EWj+8MpW6W0JsDKSiyDF17qq8/YP2OWdgUD4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iBeu1IVt3jyWfN3Ci/a/Pfcuw0qj0/y2LILVovfrcJdXYtc2rHkLAu5tTOqw0m+B4
	 YnmVj33Uznge24uotV5Sm3dUD2moWz230Ux0rZVTAzZcx3Uq3lvDncbaubT2IqSU+9
	 6ePXIpgOyjPY1BlW2U7vcE2CDh32tvD7ACNEaVqg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BCD16F8014B;
	Fri, 26 Aug 2022 14:21:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81311F80238; Fri, 26 Aug 2022 14:21:22 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id E85B1F80105
 for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2022 14:21:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E85B1F80105
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1661516479081584930-webhooks-bot@alsa-project.org>
References: <1661516479081584930-webhooks-bot@alsa-project.org>
Subject: Add interactive pause/resume functionality
Message-Id: <20220826122122.81311F80238@alsa1.perex.cz>
Date: Fri, 26 Aug 2022 14:21:22 +0200 (CEST)
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

alsa-project/tinycompress pull request #14 was edited from LaurentiuM1234:

We want to be able to interactively pause and resume the stream.

Initially, when trying to play an MP3 song, cplay would hang during the polling on compress_write. The cause for this was the fact that, after calling `get_codec_mp3`, the file pointer would point to the first MP3 data, leaving out the first MP3 header. I'm assuming that this would cause the codec to be unable to process the received frames since it wouldn't be able to find the first MP3 header.

In order to be able to use the pause/resume functionality on MP3 streams, this problem had to be addressed before adding the actual functionality.

Request URL   : https://github.com/alsa-project/tinycompress/pull/14
Patch URL     : https://github.com/alsa-project/tinycompress/pull/14.patch
Repository URL: https://github.com/alsa-project/tinycompress
