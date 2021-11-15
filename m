Return-Path: <SRS0=FucB=QC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA818C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 11:42:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A958E61ACE
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Nov 2021 11:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A958E61ACE
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E00B1678;
	Mon, 15 Nov 2021 12:41:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E00B1678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636976547;
	bh=UYSaL+ZEldfPk5tT/f1PVOlIMti1TDbqxcctaUa2ynA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tLx9aEakR6YbAH7S388m5HdPOhc4HPFjS2H3hwTvljlbZAenHUBVD6zbZzO3D1pXA
	 sUU1QWAhHT6g3BAGQeey7IY+ije7VoMeHvM2hxjqWoEDonv0fCUqymmSp5vf8/hSzO
	 VTsmyezP98PI2vTOD3s585cYBKSwhRvqy7qjY1Qk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F392F801D5;
	Mon, 15 Nov 2021 12:41:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4D8FF8027D; Mon, 15 Nov 2021 12:41:34 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 8FF70F80134
 for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2021 12:41:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8FF70F80134
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1636976487997591019-webhooks-bot@alsa-project.org>
References: <1636976487997591019-webhooks-bot@alsa-project.org>
Subject: hw: add option to specify dynamic DAPM routing to apply when the
 plugin is opened
Message-Id: <20211115114134.D4D8FF8027D@alsa1.perex.cz>
Date: Mon, 15 Nov 2021 12:41:34 +0100 (CET)
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

alsa-project/alsa-lib pull request #192 was opened from bku-sue:

The kernel's sound soc subsystem has a DAPM functionality, which makes complex audio routing easy, and most of it is done inside the kernel. However, in the case of dynamic routing (when there is a multiplexer in the signal path), the multiplexer is exposed as an enum MIXER control which must be set from userspace. As the selection of these controls directly influences what audio path is captured/played, the sensible thing to do is to create multiple HW plugins in the ALSA conf, each referring to the same HW device number, but with different routing parameters.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/192
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/192.patch
Repository URL: https://github.com/alsa-project/alsa-lib
