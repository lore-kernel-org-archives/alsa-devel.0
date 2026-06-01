Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EABACD6E55
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2026 13:33:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E7F56021D;
	Mon,  1 Jun 2026 15:33:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E7F56021D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780320829;
	bh=pSsku0BcGMFsvx31lC9RxCjcXONLmZhVXWKV76tk5Uo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=synFTZZF/XQHKLrufGxRw8RsFc4+Mc7F/ambZlt2y+ctXHtFICCKIXV/qIvOCBkv2
	 s8Juhs8kYcvo9hf0En2iObvIsgPJK8bbH5txCR/eG0qEIExfxdwQaR9vdZ3xJFFdZt
	 Xsuwr1FPC1zX8UNomMBhBUMPNVA2ZTkjMmVeUHh4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6DB9AF805FE; Mon,  1 Jun 2026 15:33:13 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 37E5CF805F2;
	Mon,  1 Jun 2026 15:33:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7833EF805E2; Mon,  1 Jun 2026 15:33:07 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id AC683F805A1
	for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2026 15:33:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC683F805A1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b4f85256ff6a00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/771@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/771@alsa-project.org>
Subject: ucm2: USB-Audio: add Creative Sound Blaster G8 support
Date: Mon,  1 Jun 2026 15:33:07 +0200 (CEST)
Message-ID-Hash: VMN7IYRTPWGEMCOVIFEYH44NYBITSQBM
X-Message-ID-Hash: VMN7IYRTPWGEMCOVIFEYH44NYBITSQBM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VMN7IYRTPWGEMCOVIFEYH44NYBITSQBM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #771 was opened from romain-pereira:

Add UCM2 configuration for the Creative Sound Blaster G8 (USB 041e:329b).

Devices (HiFi verb):
- Headphones: playback via Speaker DAC (hw:${CardId},0, -64 to 0 dB)
[alsa-info-g8.txt](https://github.com/user-attachments/files/28466856/alsa-info-g8.txt)

- External Mic, Line In, S/PDIF In, What U Hear: capture via hardware mux (PCM Capture Source), mutually exclusive via ConflictingDevice

BootSequence disables hardware monitoring paths (Line In/S/PDIF In Playback Switch are on by default in firmware) and sets External Mic as the default capture source.

Direct verb provided via common/directm.conf macro.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/771
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/771.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
