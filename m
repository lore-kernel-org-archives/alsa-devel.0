Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D8CC352A1
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Dec 2022 09:29:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5BF3C18AE;
	Wed,  7 Dec 2022 10:28:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5BF3C18AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670405349;
	bh=6RaKWIafme74CLQOtmcU7B1D+n+6f5PoMSOOZNzUYaE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YKPmq7dVLzI8tWVAr0hXg+k/OHdbKttbF4AmF1YFxcL4pYR0fBbvLyIBLJ7xPO4Ao
	 WV+ou5oPKEk3WkdsRCBxxH/NDdOUAfZZAZwK3OaNG+LOvFPWNjNyHu7TzjXSuQ5cRE
	 43k6Nhet3RQlLWsasdZM8JMHCGxljqD7y6MH40hY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13617F8021D;
	Wed,  7 Dec 2022 10:28:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A3FFF802BE; Wed,  7 Dec 2022 10:28:18 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 36214F80121
 for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2022 10:28:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36214F80121
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1670405294652120113-webhooks-bot@alsa-project.org>
References: <1670405294652120113-webhooks-bot@alsa-project.org>
Subject: sof-essx8336: update HiFi.conf
Message-Id: <20221207092818.2A3FFF802BE@alsa1.perex.cz>
Date: Wed,  7 Dec 2022 10:28:18 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #246 was edited from junocomp:

This enables the speakers from startup, detects the HDMI audio and enables the internal microphone. I have tested this on 3 devices with Debian now and it seems to work. Can other people test it too please. If it works, it will be worth pushing it upstream.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/246
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/246.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
