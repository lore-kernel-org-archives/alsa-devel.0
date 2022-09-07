Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D66DC38145
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Sep 2022 10:21:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7ED6610E;
	Wed,  7 Sep 2022 12:21:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7ED6610E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662546115;
	bh=a5TinBsgQkutjSzv8aX0ExM6eVp3yphdPxD922pJKWM=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BBMikGzUv3cZzzNV3HWnDBDyL2Ed/84nnpxfHIdvlAk8tmf/0ctdqiXuZzBfPTK8h
	 Iwt1gLJ5Q5X715CLL7w6pDaWmYtSwp/K5xzBnXVbXzyDXRmGCb0ee0PKUe/HLXxOJh
	 LV7LswhxX3yyfuhaiIY2uWnNOYjQ8vQM0Fzr2wwA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EBE2F80528;
	Wed,  7 Sep 2022 12:20:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 307B8F80538; Wed,  7 Sep 2022 12:20:29 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 6B56CF80536
 for <alsa-devel@alsa-project.org>; Wed,  7 Sep 2022 12:20:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B56CF80536
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1662546017830454111-webhooks-bot@alsa-project.org>
References: <1662546017830454111-webhooks-bot@alsa-project.org>
Subject: utils: cplay: Add support for ID3v2 header skip
Message-Id: <20220907102029.307B8F80538@alsa1.perex.cz>
Date: Wed,  7 Sep 2022 12:20:29 +0200 (CEST)
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

alsa-project/tinycompress pull request #15 was opened from LaurentiuM1234:

This patch will allow playing MP3 files containing ID3v2 tag at the beginning of the file.

This is done simply by parsing the ID3v2 header, extracting the header size and seeking to that position (+10 bytes from the header size which is not included in the 'header size' field of the ID3v2 header)

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Request URL   : https://github.com/alsa-project/tinycompress/pull/15
Patch URL     : https://github.com/alsa-project/tinycompress/pull/15.patch
Repository URL: https://github.com/alsa-project/tinycompress
