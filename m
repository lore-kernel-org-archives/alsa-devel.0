Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3916610FC456
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2026 01:35:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3D4A60205;
	Thu,  9 Apr 2026 03:35:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3D4A60205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775698512;
	bh=Js4Vj/WsL2YcDLXwDcy1Etlkp9wywTDa6hAMOcB1BDk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=jDntS3PROkkUM/rf2F8UES2e4hIAkB8IbckEx3EvHopnEmlPvECr2eUOPVTMBZTKC
	 aJfs4J/SaL1vzQHGEImfLLpERUGx4YcRWbBryRplFPotmNzLxbpEr02MvaS/663jxv
	 z8PRsu9qAldmT/Bj5QZ2VcY8Bkqn6dRqWMFYibck=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CC04EF805F5; Thu,  9 Apr 2026 03:34:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0AA30F805EF;
	Thu,  9 Apr 2026 03:34:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1724FF8052D; Thu,  9 Apr 2026 03:34:24 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id EC9F1F8012B
	for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2026 03:34:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC9F1F8012B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18a48c576f585e00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/740@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/740@alsa-project.org>
Subject: sof-soundwire: rt711-sdca: fix silent headphones and headset mic
Date: Thu,  9 Apr 2026 03:34:24 +0200 (CEST)
Message-ID-Hash: GS5SAMLXI6T7SZXYPEE4OWFOR2DPBUCD
X-Message-ID-Hash: GS5SAMLXI6T7SZXYPEE4OWFOR2DPBUCD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GS5SAMLXI6T7SZXYPEE4OWFOR2DPBUCD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #740 was opened from dankovacek:

Two related UCM fixes for rt711-sdca on sof-soundwire platforms.

**Fix 1: Headphones produce no audio**

PGA30.0 30 Playback Volume (the SOF pipeline 30 gain stage for PCM device 0)
defaults to 0 at boot, which the dBscale treats as a hardware mute. The DAPM
chain is active and audio flows on the SoundWire bus, but the pipeline passes
silence into the codec. Added to Headphones EnableSequence with value 32,32 (0 dB).

**Fix 2: Headset microphone produces no audio**

Headset Mic Switch is a DAPM gate controlling the codec mic input path. UCM never
enabled it, so the capture path was powered down regardless of the FU0F Capture
Switch state. Added on/off to Headset Enable/DisableSequence, matching the existing
pattern for Headphone Switch.

Both bugs affect any sof-soundwire platform using rt711-sdca.
Tested on Dell Precision 5480 (Intel Raptor Lake-P, sof-audio-pci-intel-tgl,
rt711-sdca on SoundWire master-0-2).

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/740
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/740.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
