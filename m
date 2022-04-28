Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC216C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Apr 2022 16:39:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A44D315F2;
	Thu, 28 Apr 2022 18:38:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A44D315F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651163977;
	bh=w1xy+/3dsDxYjy2TQcb3M1DB/+mOq2z6DsuSaHmmwPw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZiqAIM+88ENt4SwhknVCamvA+dgON2qickLVx0ULM+PXnIWO85TkaMjXvwHveksNC
	 kXuD3BM8O+6O6mucWtmbHfjNJdto3wNS8ht15W3NVizNEnAtb9Vqs6D3F3M5OzrJ6U
	 X1CmoTl7pDEg1dvNAIj9GvVWmw2nuVYrN6w9flrA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2ABCEF8016E;
	Thu, 28 Apr 2022 18:38:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7A5FF8020D; Thu, 28 Apr 2022 18:38:45 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 09E50F800F2
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2022 18:38:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09E50F800F2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1651163922796066999-webhooks-bot@alsa-project.org>
References: <1651163922796066999-webhooks-bot@alsa-project.org>
Subject: pcm: dmix: fix wrong scaling in 32bits pcm mixing
Message-Id: <20220428163845.A7A5FF8020D@alsa1.perex.cz>
Date: Thu, 28 Apr 2022 18:38:45 +0200 (CEST)
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

alsa-project/alsa-lib pull request #222 was edited from katsuster:

Generic mixing function for 32bits pcm has used 8bits right shift for
pre-scaling. But this is generating wrong result if pcm data is
negative value because return value type of bswap_32() is unsigned int.

This patch adds type cast bswap_32() result to signed int.

Request URL   : https://github.com/alsa-project/alsa-lib/pull/222
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/222.patch
Repository URL: https://github.com/alsa-project/alsa-lib
