Return-Path: <SRS0=ggqu=GJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09673C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Jan 2021 17:32:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9969023125
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Jan 2021 17:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9969023125
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D9A6D168E;
	Wed,  6 Jan 2021 18:31:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D9A6D168E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609954337;
	bh=pN1xJPqtf5kg/AcOhH3OarNRrC9XbbvhtfzYDHrqyyU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PbtgSC3pTtzf9ikoAeZP5EuW8as5jZCvkdRwjjQnsuV2bqlCW10nzcJUYGcej7dNw
	 jAcivHuSCRtrhyiDQ4H+HxZGOwH7NEyn/cQjfML9JNJ6YO9xE4jfwpOn5D9/uFPvQm
	 1hfz38EST9Y0Pt3KM8pyWtgSxKocnZzDhgAlQje4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64176F80165;
	Wed,  6 Jan 2021 18:31:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DC2FF80166; Wed,  6 Jan 2021 18:31:26 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 1542FF800FD
 for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2021 18:31:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1542FF800FD
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1609954281179683924-webhooks-bot@alsa-project.org>
References: <1609954281179683924-webhooks-bot@alsa-project.org>
Subject: dmix + dshare and changes of period_size buffer_size
Message-Id: <20210106173126.8DC2FF80166@alsa1.perex.cz>
Date: Wed,  6 Jan 2021 18:31:26 +0100 (CET)
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

alsa-project/alsa-lib issue #109 was opened from pietercardoen:

Dear

I'm trying to create my audio configuration using dmix or dshare plugins but i'm facing some issues.

Currently, if I don't use dmix or dshare, I'm able to specify the period_size using aplay and changes are populated to the hardware. However if I include a dmix/dshare plugin, I'm  not able to configure the period_time anymore.

To configure dmix, one needs to specify this:
slave {			# Slave definition
  pcm STR		# slave PCM name
  # or
  pcm { }		# slave PCM definition
  format STR	# format definition
  rate INT	# rate definition
  channels INT
  period_time INT	# in usec
  # or
  period_size INT	# in frames
  buffer_time INT	# in usec
  # or
  buffer_size INT # in frames
  periods INT	# when buffer_size or buffer_time is not specified
}

Is it possible in any way to avoid the need to specify buffer_size/periods/... and to avoid the system to fall back on defaults?

Kind regards
Pieter Cardoen

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/109
Repository URL: https://github.com/alsa-project/alsa-lib
