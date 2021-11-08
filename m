Return-Path: <SRS0=zqBf=P3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410DCC433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Nov 2021 08:22:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4AB4610FF
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Nov 2021 08:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A4AB4610FF
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FC151673;
	Mon,  8 Nov 2021 09:21:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FC151673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636359739;
	bh=wR+2JWM8PPmOu4gc1LARW6Dngm2Nn2OFqhE2RSYopO8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CJnApgFDInoIGpPRmL4JGIvneSm9BobOvN6WGmap5tzN7JlrZSvihSruP9WIkIfC/
	 7CgRT6iDEr26q5llHpko0ZXl6o6o2TQtZz6uztfEUuK3pH9JksxV2vo1OM84FUhMOI
	 C/Iya6ZKPp9ClGSJd3G4dzqHQhA00vUPRCMKDjc4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9016BF80227;
	Mon,  8 Nov 2021 09:21:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1FE51F80107; Mon,  8 Nov 2021 09:21:27 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id BAEB4F80107
 for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2021 09:21:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BAEB4F80107
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1636359679557734966-webhooks-bot@alsa-project.org>
References: <1636359679557734966-webhooks-bot@alsa-project.org>
Subject: ucm2: Add support for RT5650 on MediaTek SoCs
Message-Id: <20211108082127.1FE51F80107@alsa1.perex.cz>
Date: Mon,  8 Nov 2021 09:21:27 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #117 was opened from kholk:

At least one MT8173 machine uses a RT5650 codec and that's Google Elm:
add a UCM2 configuration for this codec.

This was tested on Acer Chromebook R13 (MT8173 Elm).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/117
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/117.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
