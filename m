Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99EBC433FE
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Apr 2022 15:08:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8521616FD;
	Thu,  7 Apr 2022 17:07:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8521616FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649344123;
	bh=VIqBtihNVEhTQ521N6isPwqtqp9UpqcTvFwMZBbkst8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tnROARPiIydN5QJFoY9zLXDH8yLZRZ1wqzuZw12QdI4xlKPjfaeAwth77189PT+gV
	 pPCmFBttMbKTLLgIZMM7cUU+pqjZlDGNdz86TmN7/vR2t0BZzK2DJn3PVRqKmFl7YN
	 2fG1NiL0i1ihrfQhx3fBJfJ2qIFSSsW3816aRMiE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1966BF80054;
	Thu,  7 Apr 2022 17:07:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 240F4F8024C; Thu,  7 Apr 2022 17:07:52 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id AD1A0F80054
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2022 17:07:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD1A0F80054
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1649344065101376057-webhooks-bot@alsa-project.org>
References: <1649344065101376057-webhooks-bot@alsa-project.org>
Subject: HDSPMixerOutput.cxx:96: possible typo ?
Message-Id: <20220407150752.240F4F8024C@alsa1.perex.cz>
Date: Thu,  7 Apr 2022 17:07:52 +0200 (CEST)
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

alsa-project/alsa-tools issue #10 was opened from dcb314:

clang says:

HDSPMixerOutput.cxx:96:30: warning: suspicious concatenation of string literals in an array initialization; did you mean to separate the elements with a comma? [-Wstring-concatenation]

Source code is

  "AEB 1", "AEB 2", "AEB 3," "AEB 4"

Maybe better code

  "AEB 1", "AEB 2", "AEB 3", "AEB 4"

Issue URL     : https://github.com/alsa-project/alsa-tools/issues/10
Repository URL: https://github.com/alsa-project/alsa-tools
