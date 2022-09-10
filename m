Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4AAECAAD5
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Sep 2022 07:24:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB5C916A0;
	Sat, 10 Sep 2022 09:23:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB5C916A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662794669;
	bh=6TdfJR7rY5jw8Xml2Wu5vzXdqO9cZVXwgjMlj8lAHxU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y3UIamajU0T3MQeyoWxucmqyLIW/nBnuuwNUlc9Cbjt8gFvMoTfYuiA6UhElIUIMT
	 Q63ihGYTB1YCtYXFbVmsN5pMdS9cjY4OVhu4dutUz0d9XVXBmCtlNJ9R/GWbvrfIVP
	 LKkiYJhQ1ZfHxlNUEOdBLlzd+/hP+ZeldmyntL/I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DD478F800B8;
	Sat, 10 Sep 2022 09:23:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34653F8011C; Sat, 10 Sep 2022 09:23:29 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id C50FAF800B8
 for <alsa-devel@alsa-project.org>; Sat, 10 Sep 2022 09:23:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C50FAF800B8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1662794606599087954-webhooks-bot@alsa-project.org>
References: <1662794606599087954-webhooks-bot@alsa-project.org>
Subject: aseqdump crashing after running for a bit
Message-Id: <20220910072329.34653F8011C@alsa1.perex.cz>
Date: Sat, 10 Sep 2022 09:23:29 +0200 (CEST)
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

alsa-project/alsa-utils issue #170 was edited from BlastBolt5:

I have been working on a script to control pipewire sources and sinks using faders on my midi keyboard but aseqdump keeps erroring out with

> Port unsubscribed 128:0 

I don't have any other midi device to test it out and see if it's specific to this conrtoller but I'm using the Korg nanoKontrol2. If i need to provide anything else just let me know.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/170
Repository URL: https://github.com/alsa-project/alsa-utils
