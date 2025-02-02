Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C6CC0218F
	for <alsa-devel@archiver.kernel.org>; Sun,  2 Feb 2025 10:16:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13E3B601B0;
	Sun,  2 Feb 2025 11:16:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13E3B601B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1738491403;
	bh=C5KiXRE1foEPmoFgDEHqfJSC9/XFFFWY/940oQTQwX4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=UC6TfEPzM9xwx5n3yLHfC4VHKAHoWA8+du8lyVvz5i223XwNcC9FBFOWcAai/fzVq
	 Mn5alFKf/hfkbHySe9XCa2jJBsc/am5/ylmgXArsQiXYtFubpvj9Y/Ke/tv8wIcJIK
	 7RyEDd7WUFtPBnmnmiq3S8q8Tes5lY8mlHN6N4TQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 62945F805C3; Sun,  2 Feb 2025 11:16:16 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A169DF805C3;
	Sun,  2 Feb 2025 11:16:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 04771F8049C; Sun,  2 Feb 2025 11:15:45 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 44470F8014B
	for <alsa-devel@alsa-project.org>; Sun,  2 Feb 2025 11:15:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44470F8014B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1738491340635127783-webhooks-bot@alsa-project.org>
References: <1738491340635127783-webhooks-bot@alsa-project.org>
Subject: alsaucm fails with unknown If.Condition.Type
Message-Id: <20250202101545.04771F8049C@alsa1.perex.cz>
Date: Sun,  2 Feb 2025 11:15:45 +0100 (CET)
Message-ID-Hash: JAT5PLRUTMYGCI5HTOOVHHBDREFISWLS
X-Message-ID-Hash: JAT5PLRUTMYGCI5HTOOVHHBDREFISWLS
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JAT5PLRUTMYGCI5HTOOVHHBDREFISWLS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils issue #290 was opened from abewieland:

I get the following when running `listcards`:
```
$ alsaucm listcards
ALSA lib ucm_cond.c:367:(if_eval) unknown If.Condition.Type
ALSA lib main.c:1554:(snd_use_case_mgr_open) error: failed to import hw:0 use case configuration -22
ALSA lib parser.c:2978:(uc_mgr_scan_master_configs) Unable to open '-hw:0': Invalid argument
alsaucm: error failed to get card list: Invalid argument
```

Let me know if I can provide any better debugging data. My system is a Dell laptop with Intel Tiger Lake and Realtek ALC3204, if that's helpful.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/290
Repository URL: https://github.com/alsa-project/alsa-utils
