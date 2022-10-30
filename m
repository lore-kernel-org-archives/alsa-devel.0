Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A604ECAAA1
	for <alsa-devel@archiver.kernel.org>; Sun, 30 Oct 2022 18:08:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A4B9A15E0;
	Sun, 30 Oct 2022 19:07:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A4B9A15E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667153313;
	bh=5HYKLQyY44fxcmSvxn5qrHNSejd1EBXXf5e0VVn3Fsc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l9EzbvcZDTFxIt0AvKTCxNi8Vj+SoWPp78D5GrAabWKw3RuTulM9MxOXthwHs762H
	 m8KglY1JQ+IaNZepmhL1Ss2D8sQRyLGHtqbfO2qhK2Xl35mGqjPw1wkz8LlW6oBREN
	 gvJ8Rbqs9gw8WLVVQWOLkcP8SxDEPOMHFdWHXpQE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3679CF80166;
	Sun, 30 Oct 2022 19:07:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7283FF800CC; Sun, 30 Oct 2022 19:07:42 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 183D5F800CC
 for <alsa-devel@alsa-project.org>; Sun, 30 Oct 2022 19:07:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 183D5F800CC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1667153259322611094-webhooks-bot@alsa-project.org>
References: <1667153259322611094-webhooks-bot@alsa-project.org>
Subject: utils/alsa.m4: include <stdlib.h> for exit()
Message-Id: <20221030180742.7283FF800CC@alsa1.perex.cz>
Date: Sun, 30 Oct 2022 19:07:42 +0100 (CET)
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

alsa-project/alsa-lib pull request #278 was opened from thesamesam:

Clang 16 makes -Wimplicit-function-declaration an error by default and it's easier to just explicitly include <stdlib.h> rather than hope the ALSA headers always have it.

Signed-off-by: Sam James <sam@gentoo.org>

Request URL   : https://github.com/alsa-project/alsa-lib/pull/278
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/278.patch
Repository URL: https://github.com/alsa-project/alsa-lib
