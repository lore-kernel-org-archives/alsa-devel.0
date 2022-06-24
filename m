Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF230C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jun 2022 20:07:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F2C717F7;
	Fri, 24 Jun 2022 22:06:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F2C717F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656101258;
	bh=TAZd7oM1NtfCWCTVMrZc5jkxU0ChSJ7lS6B+Mki79B0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IALMKW3L8vE/C0CF8zLV/1ifqGrxdBkyvKBcWutX18I+RcEmFvf+ud60OKbMiniLO
	 8wVJT5i1Hn08fhgUKaL+ei6YC1L7vjOSuEUtSAO2PbLUF7WF0Az8Un5narc7oVEsP4
	 DloAUvRVKKFzbkTXCk6YimRrPWGgGd1bxM7+g6fw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0E8C7F80107;
	Fri, 24 Jun 2022 22:06:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 42A42F80139; Fri, 24 Jun 2022 22:06:46 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id AFC91F80107
 for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2022 22:06:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AFC91F80107
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1656101200391197920-webhooks-bot@alsa-project.org>
References: <1656101200391197920-webhooks-bot@alsa-project.org>
Subject: sof-soundwire: broken settings for RT711 and RT711-SDCA
Message-Id: <20220624200646.42A42F80139@alsa1.perex.cz>
Date: Fri, 24 Jun 2022 22:06:46 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #179 was opened from plbossart:

[plb@fedora ~]$ alsaucm -c sof-soundwire set _verb HiFi
ALSA lib main.c:826:(execute_sequence) unable to execute cset 'name='PGA2.0 2 Master Capture Switch' 0'
ALSA lib main.c:2573:(set_verb_user) error: failed to initialize new use case: HiFi

There's not such thing as a switch here:

amixer -Dhw:0 sget 'PGA2.0 2 Master',0 
Simple mixer control 'PGA2.0 2 Master',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 80
  Front Left: Capture 80 [100%] [30.00dB]
  Front Right: Capture 80 [100%] [30.00dB]

In addition, it makes no sense to use an SOF control to set the volume/switch on the headset codec side. The volume control should be done in the codec, not in the SOF firmware.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/179
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
