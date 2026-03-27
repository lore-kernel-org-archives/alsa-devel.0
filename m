Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258D210A62E8
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2026 02:30:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 519BD601F5;
	Fri, 27 Mar 2026 03:30:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 519BD601F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774578651;
	bh=ZI3lyzMwQlV4CrUvsrm6scTLUH/r88gSsaSfSwPHWOY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=cAccYUAOC0FSlW0XE23ObJTiylp9yQ4Zv7woKtMfkBPZsK7qeNoRfOoYaeT/17o4+
	 TWf8lIoTz6DwdZ6FNmGPKMMUCDn52zwk4aMBEkouoJTH3pjxEuk6ZBUogCWirCMa7t
	 /wJnc7V2SM/NliZTd7Clc+SW5ougDhE+soUMmcoY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B66EAF805EA; Fri, 27 Mar 2026 03:30:19 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B997F805F1;
	Fri, 27 Mar 2026 03:30:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 46FE9F804F3; Fri, 27 Mar 2026 03:30:10 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id A735BF80212
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2026 03:30:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A735BF80212
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a091d6fe3ed400-webhooks-bot@alsa-project.org>
In-Reply-To: <18a091d6fe1f2700-webhooks-bot@alsa-project.org>
References: <18a091d6fe1f2700-webhooks-bot@alsa-project.org>
Subject: Missing UCM for Acer Nitro ANV15-51
 (RPL-NitroANV15_51-V1.26-Sportage_RTH)
Date: Fri, 27 Mar 2026 03:30:10 +0100 (CET)
Message-ID-Hash: HVJI65WUWBV35GI7VJ6KR6XFQN6P4F2R
X-Message-ID-Hash: HVJI65WUWBV35GI7VJ6KR6XFQN6P4F2R
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HVJI65WUWBV35GI7VJ6KR6XFQN6P4F2R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #734 was opened from Amane47:

Hardware: Acer Nitro ANV15-51
Codec: Realtek ALC245
PCI SSID: 1025:171e
Card name: RPL-NitroANV15_51-V1.26-Sportage_RTH
Kernel: 6.19.9-arch1-1
Driver: sof-audio-pci-intel-tgl

Issue: No specific UCM exists for this laptop. Falls back to generic 
sof-hda-dsp UCM which causes distorted audio on headphone jack at boot.
Audio is fixed by physically reconnecting the jack, which triggers 
PipeWire to recreate the audio node.

dmesg: snd_hda_codec_alc269: ALC245: picked fixup for PCI SSID 1025:171e

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/734
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
