Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C0AC4321E
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Dec 2022 10:05:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 732DE17BC;
	Mon,  5 Dec 2022 11:04:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 732DE17BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670234729;
	bh=FOV45z4oKxE+0DwTuyjNo0Qr2okH1UPBfU08ZHVkN8M=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oljPmnHfHR8JfMxPDZnhfJsXzMEGAAWp8Fea7gJgMzkOX91MLJL38HGYINtSuwV7I
	 w7KxpY4SBqz15g89QvK7/KSXRGUiV2e7ItaXtnIa1RoFBaf/bhdRHAqnLMm5x4ZDy/
	 u7z1jEdG0zTYvCAxlV320SSoG+XjvxAG7CaFL85s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D0337F80171;
	Mon,  5 Dec 2022 11:04:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34DABF80236; Mon,  5 Dec 2022 11:04:36 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 27332F800BD
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2022 11:04:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27332F800BD
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1670234669404473066-webhooks-bot@alsa-project.org>
References: <1670234669404473066-webhooks-bot@alsa-project.org>
Subject: clangd friendly headers
Message-Id: <20221205100436.34DABF80236@alsa1.perex.cz>
Date: Mon,  5 Dec 2022 11:04:36 +0100 (CET)
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

alsa-project/alsa-lib pull request #286 was opened from timblechmann:

quality of life improvements when working with clangd enabled IDEs. these two patches fix issues when clangd parses the headers in isolation in a c++ compile context

---

* make headers self-contained
* avoid c++ keyword

Request URL   : https://github.com/alsa-project/alsa-lib/pull/286
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/286.patch
Repository URL: https://github.com/alsa-project/alsa-lib
