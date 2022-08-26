Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD9EECAAA3
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Aug 2022 10:57:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B52C6167E;
	Fri, 26 Aug 2022 12:56:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B52C6167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661511425;
	bh=J2lrFo60kGgO6FH+DLvyV3H2fJXllOcuw86C/9wybs0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DsfvGOGdy2K7hNN/VTDwrXZjMnc17EjbhgAUxmaIRd0ULnm9WQWnEexA4X07Cm14u
	 p8zcUMLsI4HxNkdcmMneWZYo5bfrnh2tiq+A0qoyPDEb8c/fBu6w0uL8DmlSrI7lyU
	 wnLqUaSrY/MjvvW2ehwbO2q4dacU8kjACP+nT7Vo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 527FDF8014B;
	Fri, 26 Aug 2022 12:56:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8F64FF80238; Fri, 26 Aug 2022 12:56:13 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 117ADF80105
 for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2022 12:56:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 117ADF80105
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1661511370267873049-webhooks-bot@alsa-project.org>
References: <1661511370267873049-webhooks-bot@alsa-project.org>
Subject: Add interactive pause/resume functionality
Message-Id: <20220826105613.8F64FF80238@alsa1.perex.cz>
Date: Fri, 26 Aug 2022 12:56:13 +0200 (CEST)
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

alsa-project/tinycompress pull request #14 was edited from LaurentiuM1234:

We want to be able to interactively pause and resume the stream

Request URL   : https://github.com/alsa-project/tinycompress/pull/14
Patch URL     : https://github.com/alsa-project/tinycompress/pull/14.patch
Repository URL: https://github.com/alsa-project/tinycompress
