Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7327C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 16 May 2022 16:25:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 50C66164D;
	Mon, 16 May 2022 18:24:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 50C66164D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652718302;
	bh=l9lGChT2Audl1bzg8dG+0fqxAUhLyJ3KMgxT25HLskg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UHISZfThZC+kpKbd/eAwaI3Tms4AdbgeSAB55Q79YFmWoVNZbABfnTWCRPiEy9s3I
	 Qdv0XIYcxIuucWeNAC1qjUrAKjeHjG39G9m3QjpvduGMdFKWCJTFas+GUFO55esSna
	 aM9VxtDFiMHQshMLuwOEoUHPkE0XAoCWcRJjrPwA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DF6BCF8012F;
	Mon, 16 May 2022 18:24:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 38D82F8014B; Mon, 16 May 2022 18:24:10 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 2FE27F800D8
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2022 18:24:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2FE27F800D8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1652718246566613913-webhooks-bot@alsa-project.org>
References: <1652718246566613913-webhooks-bot@alsa-project.org>
Subject: Complete support for "Pro" USB multichannel cards
Message-Id: <20220516162410.38D82F8014B@alsa1.perex.cz>
Date: Mon, 16 May 2022 18:24:10 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #154 was opened from perexg:

- [x] channel split using alsa-lib
- [ ] channel split inside app
- [ ] channel split hide the specific configs (alsa-lib, app side support)
- [x] mixer control remap using alsa-lib
- [ ] simplify the mixer control remap

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/154
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
