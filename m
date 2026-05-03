Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12698CD13DA
	for <alsa-devel@archiver.kernel.org>; Sun,  3 May 2026 01:16:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72BEF60203;
	Sun,  3 May 2026 03:15:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72BEF60203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777770965;
	bh=7G00r0CFAFmuzf8gfrdNTEEN1ulTHSWzsVqHeeBI4zw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=vVIGFcAY21rfReFiFHu6hzyFPE0l/F/D4V/ugQ18abeRZoVV8P5X0+vX7036X+PAW
	 1F6FJcX/dgVZqMLLyKSPY3/TezDLGiFTPmpmqyydGQfEX06DX+rN6IYXP172ZGzoeX
	 0V+NwP+TC6qgj6AErqHPhLOvDHiX+BhjSKCOUPxI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8FC27F805F0; Sun,  3 May 2026 03:15:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 31F23F805F2;
	Sun,  3 May 2026 03:15:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E7E16F804F2; Sun,  3 May 2026 03:15:23 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id EFB99F8021D
	for <alsa-devel@alsa-project.org>; Sun,  3 May 2026 03:15:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFB99F8021D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18abe93be6e32500-webhooks-bot@alsa-project.org>
In-Reply-To: <18abe93be60cc200-webhooks-bot@alsa-project.org>
References: <18abe93be60cc200-webhooks-bot@alsa-project.org>
Subject: ubsan: `runtime error: variable length array bound evaluates to
 non-positive value 0`
Date: Sun,  3 May 2026 03:15:23 +0200 (CEST)
Message-ID-Hash: 52JOMLJXFDH7OLQUN3H62Q6MSDSXOSRZ
X-Message-ID-Hash: 52JOMLJXFDH7OLQUN3H62Q6MSDSXOSRZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/52JOMLJXFDH7OLQUN3H62Q6MSDSXOSRZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #505 was opened from pobrn:

While testing pipewire with a sanitized build of alsa-lib, the following is reported:

<details>

```
/pipewire/subprojects/alsa/src/pcm/pcm.c:7827:4: runtime error: variable length array bound evaluates to non-positive value 0
    #0 0x7b5f909a1e7d in snd_pcm_slave_conf (/pipewire/build/subprojects/alsa/dist/usr/lib/libasound.so.2+0x5a1e7d) (BuildId: 2137baa0902bc081fc7d45192f387a7550800d43)
    #1 0x7b5f90a9e29c in _snd_pcm_empty_open (/pipewire/build/subprojects/alsa/dist/usr/lib/libasound.so.2+0x69e29c) (BuildId: 2137baa0902bc081fc7d45192f387a7550800d43)
    #2 0x7b5f9098bd9a in snd_pcm_open_conf (/pipewire/build/subprojects/alsa/dist/usr/lib/libasound.so.2+0x58bd9a) (BuildId: 2137baa0902bc081fc7d45192f387a7550800d43)
    #3 0x7b5f9098c78e in snd_pcm_open_noupdate (/pipewire/build/subprojects/alsa/dist/usr/lib/libasound.so.2+0x58c78e) (BuildId: 2137baa0902bc081fc7d45192f387a7550800d43)
    #4 0x7b5f9098c9d4 in snd_pcm_open (/pipewire/build/subprojects/alsa/dist/usr/lib/libasound.so.2+0x58c9d4) (BuildId: 2137baa0902bc081fc7d45192f387a7550800d43)
    #5 0x7b5f91ccdf07 in pa_alsa_open_by_device_string ../spa/plugins/alsa/acp/alsa-util.c:716
[...]
```

</details>

While this is probably generally harmless in practice, if there is a simple change to avoid it, it would be nice to have it fixed.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/505
Repository URL: https://github.com/alsa-project/alsa-lib
