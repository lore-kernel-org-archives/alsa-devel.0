Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F86C433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Oct 2022 19:27:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C052165E;
	Thu,  6 Oct 2022 21:26:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C052165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1665084422;
	bh=EO2doqcnT7igtDEVNP1rkjg3aKE72xMucbpv+H6Ohao=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dUDHo1xgRpB6nXkP0M+9Nw1oFkhgZXnf9+MpttS47BmUm5hdI/y1RDEh9Se3hD4Tm
	 0v4/EuuwqwU7hbkYiJTsU4impslAcw1sTGRr3+QC2MFTKEYeXiYqYPymq0mJf43Y3V
	 JNw3O4T9i/nRxrSps79JJs/cou7ikjNYhfg+fHRU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C43C3F80254;
	Thu,  6 Oct 2022 21:26:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A27FF800BF; Thu,  6 Oct 2022 21:26:10 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C0125F800BF
 for <alsa-devel@alsa-project.org>; Thu,  6 Oct 2022 21:26:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0125F800BF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1665084367332529068-webhooks-bot@alsa-project.org>
References: <1665084367332529068-webhooks-bot@alsa-project.org>
Subject: Add Arturia Minifuse 1 Support
Message-Id: <20221006192610.1A27FF800BF@alsa1.perex.cz>
Date: Thu,  6 Oct 2022 21:26:10 +0200 (CEST)
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

alsa-project/alsa-ucm-conf pull request #226 was opened from nodens:

Arturia Minifuse 1 is a stripped-down version of Minifuse 2:
- 1 Input
- 2 Outputs
- Loopback interface to ease recording of the computer output

(attempt at fixing #220)

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/226
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/226.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
