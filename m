Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9FFC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Dec 2021 19:55:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 32FF81848;
	Tue, 21 Dec 2021 20:55:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 32FF81848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640116551;
	bh=yhn6WQmUA81wyAMAKB6mbRPDx/jK9o1Yl12H3z/zEUo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZIHOHJx3j0yZ/Ud2jlZ9laTBLLhWHrnRJcYXjjE5A5KagMRIYuSUUQ3McCCHeu/st
	 hw9U5o9kJPIRbDp4/yR/TS4Fq1XOVnGazrdVlnaMrPqrGJ5tzqW8ALT1W8ehYiGCPu
	 0Fm9sBrd+dVpb2OeNwolM0FFydb2iViCbR//e2N4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CBEECF80118;
	Tue, 21 Dec 2021 20:55:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ACA3DF8012E; Tue, 21 Dec 2021 20:54:58 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 4E8DCF80084
 for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2021 20:54:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E8DCF80084
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1640116487287379980-webhooks-bot@alsa-project.org>
References: <1640116487287379980-webhooks-bot@alsa-project.org>
Subject: [WIP][RFC] Nhlt plugin and simple plugin interface
Message-Id: <20211221195458.ACA3DF8012E@alsa1.perex.cz>
Date: Tue, 21 Dec 2021 20:54:58 +0100 (CET)
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

alsa-project/alsa-utils pull request #129 was opened from juimonen:

Initial something... I need to figure out:

- where to specify which plugins to load/run (nhlt now hard coded)
- where to install the plugins
- how to get the to-be-loaded plugin names and where
- is the "hidden-visibility" gcc flag ok to hide other than .so entrypoint

Request URL   : https://github.com/alsa-project/alsa-utils/pull/129
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/129.patch
Repository URL: https://github.com/alsa-project/alsa-utils
