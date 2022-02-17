Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40BBC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Feb 2022 17:47:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25BEB17E6;
	Thu, 17 Feb 2022 18:46:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25BEB17E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645120052;
	bh=qAcGiZjBORAIOtTijIvo3FTIHRjKNaNmTwvrltghIjQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cRf216RClwEhJqgW0SnbWJw+mO8ic3/nmSiM5Sg6Z37YqcvAredDyUyqEtpv7rjC4
	 c+7hkzp5XQDkP8g92qej8SgBaFC45KSQjH2CQsMkRGaJvLoLvTdKp2Cw4zAoH54EAV
	 ZUs1s/TfcPPY5RSFfKMiYAfvvbUJ3TD3frYUXNik=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A84EAF8023B;
	Thu, 17 Feb 2022 18:46:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1E05F80240; Thu, 17 Feb 2022 18:46:38 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id CC2D6F80118
 for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2022 18:46:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC2D6F80118
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1645119988663079023-webhooks-bot@alsa-project.org>
References: <1645119988663079023-webhooks-bot@alsa-project.org>
Subject: ucm2: sof-essx8336: initial support
Message-Id: <20220217174638.F1E05F80240@alsa1.perex.cz>
Date: Thu, 17 Feb 2022 18:46:38 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #139 was opened from plbossart:

Loosely based on the sof-hda-dsp model for DMIC conditional handling.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/139
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/139.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
