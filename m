Return-Path: <SRS0=q21C=4W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9BEC3F2D1
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:10:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 419EF2072A
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uVbmIkit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419EF2072A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D29F1671;
	Thu,  5 Mar 2020 14:09:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D29F1671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583413810;
	bh=/UPiOxsuucMb8padFBubdEP01nT2C3ZljTPONylfi6Q=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uVbmIkitP9LQM6MLlkEwue8PWSU7ywdaMTA+9O8b3bKt2zAoVZDEUrWpNZKdi+2r8
	 e8HQNrMuk7aUOoN/cn6rPid9n2gchIMMFhzG6AQ5BszxrSE7UNhde8XLla9qdZNfpD
	 en3E2iznlHJk32qEhwBsHopp1bl2zJzNkrpSHiKc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4BE89F8028E;
	Thu,  5 Mar 2020 14:07:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF256F80271; Thu,  5 Mar 2020 14:06:40 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 01720F80279
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2020 14:06:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01720F80279
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1583413597191935062-webhooks-bot@alsa-project.org>
References: <1583413597191935062-webhooks-bot@alsa-project.org>
Subject: sof-hda-dsp: Support systems without integrated graphics audio
Message-Id: <20200305130640.DF256F80271@alsa1.perex.cz>
Date: Thu,  5 Mar 2020 14:06:40 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #15 was opened from kv2019i:

On systems where integrated graphics audio is not present
or is disabled, the HDMI PCM nodes are disabled. Add rules to
detect these systems by checking presence of HDMI jack controls
with UCM2 rules.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/15
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/15.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
