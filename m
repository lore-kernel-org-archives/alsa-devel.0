Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF322C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Jul 2022 23:06:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9552839;
	Wed, 20 Jul 2022 01:05:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9552839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658272006;
	bh=40GTc3YAuUrx+jnzJlo+TJ88k8tUWatebbR1ZKcDj+k=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OhR+mEE1LKCJ5AYRVF005ltypxAS43zH/OLJUyZiHc3Ltc5vEXsHDzyZ2Utt7jKQK
	 +31qU+2U2aE/k0FQPoDmcazN3IqYJnp21gsyYNUasVQihoNaCGLUb50Lt0D7DSbHHP
	 jJrwSyJ82WkDCkKiuQUSnq//o81ix6FnC22Xrft4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 61484F8016D;
	Wed, 20 Jul 2022 01:05:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83303F801EC; Wed, 20 Jul 2022 01:05:54 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 44616F80169
 for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2022 01:05:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44616F80169
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1658271947181247950-webhooks-bot@alsa-project.org>
References: <1658271947181247950-webhooks-bot@alsa-project.org>
Subject: Behringer UMC204HD HiFi "Default" profile crackling audio
Message-Id: <20220719230554.83303F801EC@alsa1.perex.cz>
Date: Wed, 20 Jul 2022 01:05:54 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #192 was opened from acepukas:

Since the recent update to 1.2.7.2, the Behringer UMC204HD "Default" profile has crackling audio through "Line A" and "Line B" ports. Switching to the "Direct" profile allows for clean audio but it's output over 4 speakers (front left and right, rear left and right). Not really sure how to trouble shoot this.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/192
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
