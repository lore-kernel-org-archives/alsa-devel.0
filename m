Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8405EC4332F
	for <alsa-devel@archiver.kernel.org>; Sun, 11 Dec 2022 05:31:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7AB892A47;
	Sun, 11 Dec 2022 06:30:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7AB892A47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670736708;
	bh=oiCvaQfciCoTj+V0MMFpfxle3cOSphGU4eFne6bmEpE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xygf8Jw9XCAKa3iqY9KaDiW2lyW7jjdPT4WtoTwAEDCmOm5cT/AImo1SH6jdTiB7y
	 l8rjhvgrwyKZ1ztsnbRbuTfMgHYhPzdBt06U3FPU0RFT+CooMlgfk4NrVLhAYXMWtW
	 4M1IpYbkYRp/GBQedURRvIgB3vdWRK8yE59ngoeY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A65BF80165;
	Sun, 11 Dec 2022 06:30:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57A01F801EB; Sun, 11 Dec 2022 06:30:56 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id DEA75F800F8
 for <alsa-devel@alsa-project.org>; Sun, 11 Dec 2022 06:30:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DEA75F800F8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1670736653064030886-webhooks-bot@alsa-project.org>
References: <1670736653064030886-webhooks-bot@alsa-project.org>
Subject: Add support for ASUS ROG Crosshair X670 Extreme
Message-Id: <20221211053056.57A01F801EB@alsa1.perex.cz>
Date: Sun, 11 Dec 2022 06:30:56 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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

alsa-project/alsa-ucm-conf pull request #249 was opened from ioquatix:

- Confirmed working.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/249
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/249.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
