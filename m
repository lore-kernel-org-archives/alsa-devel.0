Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29ADAC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Apr 2022 03:49:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9254318FE;
	Wed, 20 Apr 2022 05:48:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9254318FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650426569;
	bh=UmEZNwACFUKxevHes8M0nIsWY9pnDeFV/oo3PZjJRRw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ndZ3GLsKWCKCBqOOIV8xE+ggHT8Yrey4wnH/pLIrUzqnJhNaKuM77r+aRo7ySPBdF
	 FiBRX5VictBX7mW18JvfrL/2/5qbXSVKzM6eUvDisSjLXAEoHyWnGpgDs3sg9C2IEC
	 3AGhf6eq4u+y4mBXFBYYGhMMZpPEZqpG4ZUzVGMs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1ABC9F80116;
	Wed, 20 Apr 2022 05:48:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D8C4CF800C1; Wed, 20 Apr 2022 05:48:36 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 43436F800C1
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2022 05:48:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43436F800C1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1650426510718120098-webhooks-bot@alsa-project.org>
References: <1650426510718120098-webhooks-bot@alsa-project.org>
Subject: HDA-DualCodecs: Fix wrong jack control on Lenovo P520
Message-Id: <20220420034836.D8C4CF800C1@alsa1.perex.cz>
Date: Wed, 20 Apr 2022 05:48:36 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #149 was opened from khfeng:

Lenovo P520 uses the same line out switch like other dual codecs
systems, however it uses another jack control. So consolidate the switch and
separate the jacks to make its jack control work again.

Fixes: 7dda1e21 ("HDA: improve support for HDAudio-Gigabyte-ALC1220DualCodecs")

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/149
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/149.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
