Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569E9C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Jan 2022 08:13:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 24C3C17CF;
	Thu,  6 Jan 2022 09:12:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 24C3C17CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641456798;
	bh=gAg+/MsLsCtqwG6Uq5Pm/dMsOChriRnv1ekSLaO1/vI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tgRc0ftmdwqrB5pY+jXDw/AfQ5d6DqApcsxtHqA+cNOH7boY5eRHJ0iiqzY/GaCNE
	 dHvX9LdtF0Nrdbk8DDeYUaHGOxvOoaGPEwZeH9r5RdCMlgQEHn54gnapP3kHfUBhHi
	 G0+WLw9iTJLFbj+2JEMmsrTy9fEbFUUOGNj4+CTU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4207F800AE;
	Thu,  6 Jan 2022 09:12:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28FC4F80155; Thu,  6 Jan 2022 09:12:27 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id D12F7F800AE
 for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2022 09:12:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D12F7F800AE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1641456742193588018-webhooks-bot@alsa-project.org>
References: <1641456742193588018-webhooks-bot@alsa-project.org>
Subject: hda-analyzer porting to GTK3
Message-Id: <20220106081227.28FC4F80155@alsa1.perex.cz>
Date: Thu,  6 Jan 2022 09:12:27 +0100 (CET)
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

alsa-project/alsa-utils issue #134 was opened from kosiu:

I know that hda-analyzer is not a part of alsa-utils.
I'm trying to port it into GTK3 at first but I encounter
problems with scrolling of the graph.
Source is here:
https://github.com/kosiu/alsa/tree/gtk3

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/134
Repository URL: https://github.com/alsa-project/alsa-utils
