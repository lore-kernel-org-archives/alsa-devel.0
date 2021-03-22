Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4839BC433C1
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 21:48:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3A8619A8
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 21:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3A8619A8
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 758E842;
	Mon, 22 Mar 2021 22:48:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 758E842
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616449731;
	bh=vpPod5X4Q6EuLa8mZLHO5mHBvhGXJydMWAYt3W1e32k=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ukwXDZKx2iC9IPCuE0hUKWeKAf5WpLzZq6YwzC+q2Mb/n49VjLKzuSMYGIkiVlLq3
	 3xDwUvCjx1eLoGvlQnIfPbvVfB/f2qbbivsBq3fCM02sdmVWTD5fws47FBCJwzYlGT
	 SHG/dfmYSWBU4amQdAgBTNPIpn5KeHIn0OzYD70c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D9FB5F80156;
	Mon, 22 Mar 2021 22:48:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EE48EF8016B; Mon, 22 Mar 2021 22:47:58 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 5E137F80107
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 22:47:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E137F80107
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1616449675592206955-webhooks-bot@alsa-project.org>
References: <1616449675592206955-webhooks-bot@alsa-project.org>
Subject: alsaloop man page error
Message-Id: <20210322214758.EE48EF8016B@alsa1.perex.cz>
Date: Mon, 22 Mar 2021 22:47:58 +0100 (CET)
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

alsa-project/alsa-utils issue #82 was opened from nootc:

There is a small typo in the alsaloop man page:
https://github.com/alsa-project/alsa-utils/blob/c9e9a79c6cfef3212bdb5f9be4f6ea1d2a5e8670/alsaloop/alsaloop.1#L76-L86
"-c" is used for both "channels" and "rate". Thankfully, the source thinks otherwise and "-r" is used for "rate".

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/82
Repository URL: https://github.com/alsa-project/alsa-utils
