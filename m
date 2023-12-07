Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C813EC4167B
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Dec 2023 17:30:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA020868;
	Thu,  7 Dec 2023 18:30:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA020868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701970213;
	bh=Dhv8KM+9xz4mrV57fruWPSPRB7WEwdVUOFd9ULM5OPU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=RSHjhKKQEAm2dnk96D1i6TLqO8df4rqxtSBEYGq5yuKuk4r9Gen9R2TUpIpn+yoMt
	 jo2ZIESAMaOXUaJbo6s34vtiOs0jfUl28/F/9Kfjvg1s/TK1hKftGqTQitgitKsz41
	 6OT1FveQjmh8u6CRhXM45JxuuxkEVyhXjxPh2Bps=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8E30DF80567; Thu,  7 Dec 2023 18:29:42 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D5E7AF802BE;
	Thu,  7 Dec 2023 18:29:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7DAC1F8024E; Thu,  7 Dec 2023 18:29:35 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id EFA1BF800D2
	for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2023 18:29:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EFA1BF800D2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1701970171980381250-webhooks-bot@alsa-project.org>
References: <1701970171980381250-webhooks-bot@alsa-project.org>
Subject: nhlt: Revert SSP_ANALOG device_type field
Message-Id: <20231207172935.7DAC1F8024E@alsa1.perex.cz>
Date: Thu,  7 Dec 2023 18:29:35 +0100 (CET)
Message-ID-Hash: C47QKTKJJCVWHTIUSUGEKXIKARBUYKEM
X-Message-ID-Hash: C47QKTKJJCVWHTIUSUGEKXIKARBUYKEM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C47QKTKJJCVWHTIUSUGEKXIKARBUYKEM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-utils pull request #248 was opened from andyross:

This partially reverts commit 3a47ef2487ed ("topology: nhlt: intel: support more device types and directions"), which changed the default device_type in the endpoint descriptor from zero to SSP_ANALOG.

This change breaks the Linux kernel NHLT parser (which AFAICT doesn't recognize SSP_ANALOG at all), producing errors like:

  [56458.583812] sof-audio-pci-intel-mtl 0000:00:1f.3: no matching blob for sample rate: 48000 sample width: 32 channels: 2
  [56458.583833] sof-audio-pci-intel-mtl 0000:00:1f.3: failed to prepare widget dai-copier.SSP.SSP0-Codec.playback
  [56458.583840] sof-audio-pci-intel-mtl 0000:00:1f.3: Failed to prepare connected widgets
  [56458.583847] sof-audio-pci-intel-mtl 0000:00:1f.3: error: failed widget list set up for pcm 1 dir 0
  [56458.583853] sof-audio-pci-intel-mtl 0000:00:1f.3: ASoC: error at snd_soc_pcm_component_hw_params on 0000:00:1f.3: -22

Revert for compatibility.

Request URL   : https://github.com/alsa-project/alsa-utils/pull/248
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/248.patch
Repository URL: https://github.com/alsa-project/alsa-utils
