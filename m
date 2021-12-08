Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD002C433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Dec 2021 22:39:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF16518F7;
	Wed,  8 Dec 2021 23:38:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF16518F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639003163;
	bh=uSrQVFwblyG8YwVmeMn/r9NvjzpQaUT64j8BgvzDMHA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qpZi7ClhJRsjaMqXnqtNyr3pyZ9I2xu9uyb0Zhmp1copYfbQKYFrCESiD5H55+0oi
	 BTDUKj1Vcjq/vP14uuSWJwlukrJfGDckdnFVTtYZ5a9t3wRRvF4LYSlKMJGWLXDusc
	 yoq4slU166/ue/MgaskFRJNsbTTyoE+5CRtZzZ0g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CC4CF804CC;
	Wed,  8 Dec 2021 23:38:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 172DDF804E5; Wed,  8 Dec 2021 23:38:32 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 1B396F80217
 for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2021 23:38:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B396F80217
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1639003106017263889-webhooks-bot@alsa-project.org>
References: <1639003106017263889-webhooks-bot@alsa-project.org>
Subject: Pacman cannot find alsa-lib=1.2.6
Message-Id: <20211208223832.172DDF804E5@alsa1.perex.cz>
Date: Wed,  8 Dec 2021 23:38:32 +0100 (CET)
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

alsa-project/alsa-lib issue #198 was opened from TonyDaraguon:

Using Arco
When I try to update lib32-alsa-lib, my package manager tells me that it couldn't find the dependencies (alsa-lib=1.2.6).
What should I do?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/198
Repository URL: https://github.com/alsa-project/alsa-lib
