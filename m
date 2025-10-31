Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96986CCF9FA
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:05:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 532C460218;
	Fri, 31 Oct 2025 12:05:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 532C460218
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1761908733;
	bh=8762XYVCam+g3F1D1dvrTtuSM4k0ab6vCYIMDZyugbA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=s0x3CzJcaAB/pHuRikhVBLKb5NC5lEvHtRBrdhsNsW3oJxICr3P8rL7IcCCRfgQY9
	 3Cg0lpwFT+eggvnLZCYb+5uK8uh2YGiZmE8yvZ3/ZJd1p4gDe+0arDjwIv8whtNkT6
	 /RpFVghiIEuKZEw0FVv5EcgBrR/f2F/Gc1K5Ehdc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DA83DF80495; Fri, 31 Oct 2025 12:05:00 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AC286F805DF;
	Fri, 31 Oct 2025 12:05:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1C80EF80495; Fri, 31 Oct 2025 12:04:51 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C266F80071
	for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2025 12:04:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C266F80071
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18738e9e3bb5d800-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/633@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/633@alsa-project.org>
Subject: ucm2: sof: hdmi: Add 5.1 and 7.1 variants of HDMI devices when using
 IPC4
Date: Fri, 31 Oct 2025 12:04:51 +0100 (CET)
Message-ID-Hash: GCCIIBXMRENLRRRW7KJTFP43WX62PWTS
X-Message-ID-Hash: GCCIIBXMRENLRRRW7KJTFP43WX62PWTS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GCCIIBXMRENLRRRW7KJTFP43WX62PWTS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #633 was edited from ujfalusi:

Systems using IPC4 can support up to 8 channels of audio (and passthrough) via HDMI.

In UCM the default PlaybackChannels is set to 2, which prevents users from selecting multichannel configurations.

When probing the card, Pipewire will drop configurations that are not supported either by the PCM device or based on ELD information.
This means that if the equipment supports only stereo then the 5.1 and 7.1 variants should not be visible, if the equipment is 5.1 capable, then only the 7.1 variant is removed.

The kernel will refine the PCM parameters based on the ELD information as wall when https://lore.kernel.org/linux-sound/20251029073600.13624-1-peter.ujfalusi@linux.intel.com/ is applied.

@perexg, @wtay, @ford-prefect, is this something which can help PW and user space to handle the HDMI a bit better with SOF?

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/633
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/633.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
