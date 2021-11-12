Return-Path: <SRS0=QusE=P7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C8CC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Nov 2021 13:19:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C314A61054
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Nov 2021 13:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C314A61054
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BC881661;
	Fri, 12 Nov 2021 14:18:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BC881661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636723138;
	bh=OzlGD+vDkBbCis992q/5fajGtF2xNHv2t4QELKjfLxE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RFh/Cbt0R0B8sdm5cXOe5EPWsCmJHGoMnhHAHp60bz+O4aCUTrw74zCjaTUdEFB0t
	 EOqYlwmxBMfHcUQ1ehvBIlmtmQexN7j50+LTWnEJqxZ5qitHj5GyFoIFbaVSyZ4du2
	 l/fy4aHckWfDhirPV4jZ/18zK/MhNZceF+9DmNQs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1814EF80227;
	Fri, 12 Nov 2021 14:18:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 951A1F8049E; Fri, 12 Nov 2021 14:18:06 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 77F49F80086
 for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2021 14:18:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77F49F80086
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1636723079727916002-webhooks-bot@alsa-project.org>
References: <1636723079727916002-webhooks-bot@alsa-project.org>
Subject: Unable to connect KEF X300A USB speakers
Message-Id: <20211112131806.951A1F8049E@alsa1.perex.cz>
Date: Fri, 12 Nov 2021 14:18:06 +0100 (CET)
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

alsa-project/alsa-lib issue #189 was opened from simbatl:

I'm trying to USE a pair of KEF X300A speakers. They work with aplay on Ubuntu 20.04 server, but fail on Ubuntu 18.04, 20.04 and 21.10 desktop.

Here is output from pulseaudio -vvv:
[pulse.log](https://github.com/alsa-project/alsa-lib/files/7527770/pulse.log)

And here is output from alsa-info.sh:
[alsa-info.txt](https://github.com/alsa-project/alsa-lib/files/7527773/alsa-info.txt)

Anyone who know how to solve this issue? :)

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/189
Repository URL: https://github.com/alsa-project/alsa-lib
