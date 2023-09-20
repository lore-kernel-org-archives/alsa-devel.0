Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9AEC04AA7
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Sep 2023 16:26:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4099C886;
	Wed, 20 Sep 2023 18:26:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4099C886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695227214;
	bh=RqgySJ17ze7rLUI/SS0jzL8LN8CO1W6nlt0s4842QFI=;
	h=Subject:From:To:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=jqyYSU5/eyOwu/uBsO2ajwvTAjGCLLqDialLc9cy8JJadYg2d5iFctbv3l2vE+pc4
	 uN9btopHFlW1c++2iT+9mTMBZ4zMX99xKBdWyzzL2zJpVTlx5WoW/IOWnkk4kVr9j1
	 Ab7eI7QxQ2ugD7GfSebD5bv7+M/ALFdFMsrUyz3U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EE723F800AA; Wed, 20 Sep 2023 18:25:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A9D45F8025A;
	Wed, 20 Sep 2023 18:25:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3249BF8047D; Wed, 20 Sep 2023 18:25:52 +0200 (CEST)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id 274FDF80125
	for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2023 18:25:52 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: S0ix issues and Cirrus Amp on HP Elitebook 845 G10
From: alsamail@lenielsen.de
To: alsa-devel@alsa-project.org
Date: Wed, 20 Sep 2023 16:25:52 -0000
Message-ID: <169522715215.21.8751817512777154985@mailman-web.alsa-project.org>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: 2HMBNGI4NPT45YZASBUUHJTQPFMIW33L
X-Message-ID-Hash: 2HMBNGI4NPT45YZASBUUHJTQPFMIW33L
X-MailFrom: alsamail@lenielsen.de
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2HMBNGI4NPT45YZASBUUHJTQPFMIW33L/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

my HP Elitebook 845 G10 has issues with S0ix deep sleep which seem to be somehow related to the Cirrus AMP.
The following log entry appears right before the issue occurs:

2023-09-12 21:03:27,588 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Failed to read MBOX STS: -121
2023-09-12 21:03:27,588 DEBUG:	cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Failed to read MBOX STS: -121


I have already asked at AMD's gitlab regarding the s0ix issues, but we could not find a solution.
See https://gitlab.freedesktop.org/drm/amd/-/issues/2808#note_2082084 for logs and different tests and kernels

OS / Kernel: Pop!_OS with 6.5 Kernel
CPU: Ryzen 7 7840U
Bios / Firmware: everything is up to date
