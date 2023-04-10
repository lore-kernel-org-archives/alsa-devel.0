Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE50C77B61
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Apr 2023 14:42:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8491AF87;
	Mon, 10 Apr 2023 16:41:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8491AF87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681137759;
	bh=tRrxNbFSHoW5hhB7qa4pa7onqoK8iPC5XRKgBHuW4DU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=DVU/VmMXalDLHWWv1++FhGcbcDCQ6GTQVauFEbrtV6WYgP/kXF9UaGnLnxrWvyAN9
	 0PT2p9hDpVOBpqfH2FI7clKhxbQJ/j1XotH3XR7asl+3RKufmky1j/2JU2HpXgak2X
	 eKbtwW2FrcAq/YvY6nwle8TnZoIlSkzA1+bg1ovk=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C573F800E5;
	Mon, 10 Apr 2023 16:41:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9A88DF8032B; Mon, 10 Apr 2023 16:41:21 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 52FE0F800E5
	for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2023 16:41:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52FE0F800E5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1681137674405156851-webhooks-bot@alsa-project.org>
References: <1681137674405156851-webhooks-bot@alsa-project.org>
Subject: [V2] sof-hda-dsp: Add speaker led support
Message-Id: <20230410144121.9A88DF8032B@alsa1.perex.cz>
Date: Mon, 10 Apr 2023 16:41:21 +0200 (CEST)
Message-ID-Hash: 4QLEQT6BCUA4SLMLMIWOPWC37TDD3GF2
X-Message-ID-Hash: 4QLEQT6BCUA4SLMLMIWOPWC37TDD3GF2
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4QLEQT6BCUA4SLMLMIWOPWC37TDD3GF2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #302 was opened from Kobatw:

Replace hard code with variable.
before: sysw "-/class/sound/ctl-led/speaker/card1/attach:Master Playback Switch"
after:    sysw "-/class/sound/ctl-led/speaker/card${CardNumber}/attach:Master Playback Switch"

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/302
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/302.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
