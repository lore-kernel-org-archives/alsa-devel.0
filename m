Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FF8ECAAD1
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Sep 2022 10:09:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D72271630;
	Thu,  1 Sep 2022 12:08:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D72271630
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662026960;
	bh=K9I+lwQiWOo8jJzXILXPh+zSHqUYLP4tiDGnSF7487w=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XutLlBK417ZywtZpTalvFzB561hlEyBi1bfCw90cmasSN42SxK4BKQRq0Cp98xHNn
	 M78WoF7lVokBh8qTKW+eX4S7NECsxcGZAtSIao1M0a6xG6vmV3A47AnqRCJqmrDoDX
	 iVjwJCRypJyKHfG/DZ0OQUS3i329A3/IgQjfEr80=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86E60F8026A;
	Thu,  1 Sep 2022 12:08:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A4331F80236; Thu,  1 Sep 2022 12:08:29 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 7C6DFF80236
 for <alsa-devel@alsa-project.org>; Thu,  1 Sep 2022 12:08:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C6DFF80236
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1662026902959422112-webhooks-bot@alsa-project.org>
References: <1662026902959422112-webhooks-bot@alsa-project.org>
Subject: mt8195-demo: redefine soundcard initialization
Message-Id: <20220901100829.A4331F80236@alsa1.perex.cz>
Date: Thu,  1 Sep 2022 12:08:29 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #211 was opened from fchiby:

The previous initialization in Bootsequence set all Switch to off after boot. Whithout alsactl, alsa-ucm-conf does't work.
So remove the setting off of the Switch in the BootSequence and define Enable/DisableSequence in each device section for a proper setting.

Signed-off-by: Fadwa Chiby <fchiby@baylibre.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/211
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/211.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
