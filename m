Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A3BF53D92
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2026 20:30:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 58CE0601F2;
	Mon, 16 Mar 2026 21:30:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 58CE0601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773693023;
	bh=vG3vgr0p+0oRP0ql0jJd0PSKp8qrqUOEB4/X6rBWQU8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Gq1dFARFnPRbICPc2t5fec7D1hmZS3UwB8Tab7l4+An1pHdklY+rfxRyh3jklbrxF
	 KFAzV6z3qQ0yMjZomRKF5d9wPHS555DOCR3iwbVZUtvV6PjlJ6i6hyXq3D1iJQ8CVa
	 0fNY1DjcLQVPl9MMPLsI0zKDGo0y6mTNWPQYfi0s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D1F73F805EE; Mon, 16 Mar 2026 21:29:47 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B203F805E1;
	Mon, 16 Mar 2026 21:29:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BF3D6F80535; Mon, 16 Mar 2026 21:29:39 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id EFAA8F80495
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2026 21:29:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFAA8F80495
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <189d6c5d95278100-webhooks-bot@alsa-project.org>
In-Reply-To: <189d6c5d951dea00-webhooks-bot@alsa-project.org>
References: <189d6c5d951dea00-webhooks-bot@alsa-project.org>
Subject: Accident
Date: Mon, 16 Mar 2026 21:29:39 +0100 (CET)
Message-ID-Hash: LDMRSVGOMSQMRBL7N4BO3JRK5QMPVMF4
X-Message-ID-Hash: LDMRSVGOMSQMRBL7N4BO3JRK5QMPVMF4
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LDMRSVGOMSQMRBL7N4BO3JRK5QMPVMF4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #723 was edited from P-v-D:

`cat /proc/asound/card0/stream0
Roland BRIDGE CAST X-I V2 at usb-0000:09:00.1-2, high speed : USB Audio

Playback:
  Status: Running
    Interface = 1
    Altset = 1
    Packet Size = 392
    Momentary freq = 48000 Hz (0x6.0000)
  Interface 1
    Altset 1
    Format: S32_LE
    Channels: 14
    Endpoint: 0x0d (13 OUT) (ASYNC)
    Rates: 48000
    Data packet interval: 125 us
    Bits: 24
    Channel map: FL FR FC LFE RL RR FLC FRC RC SL SR TC -- --
    Sync Endpoint: 0x8e (14 IN)
    Sync EP Interface: 2
    Sync EP Altset: 1
    Implicit Feedback Mode: Yes

Capture:
  Status: Stop
  Interface 2
    Altset 1
`

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/723
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
