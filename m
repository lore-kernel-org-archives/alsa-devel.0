Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEC2C48BC2
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:10:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C706115B
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C706115B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C9751684;
	Mon, 21 Jun 2021 20:09:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C9751684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624299007;
	bh=MCS2YXDg0xfCnDtSUpUjKIJHepT3/KUj70lruPZhD64=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cqj5B2Bal3HdJdUqUvGjVf8FCdjHWUeNNSE3JMvtIsCavnDsW6umP8gq9GPsreMnY
	 4xI9F75Pwfnl9OULQumTARtyIPUl7x2OMKaLcXVCHU+DQc82N15HkvBVLRv5X60SSW
	 vG8iDFxp2HnZwjPgtOcPSyEPu5p6vCZ0cWOLdBGI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A88D2F8016B;
	Mon, 21 Jun 2021 20:09:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B145FF8016B; Mon, 21 Jun 2021 20:09:14 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72B89F80137
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 20:09:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72B89F80137
Received: by m.b4.vu (Postfix, from userid 1000)
 id 2142361E286F; Tue, 22 Jun 2021 03:39:01 +0930 (ACST)
Date: Tue, 22 Jun 2021 03:39:01 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/31] Refactor Scarlett Gen 2 support and add Scarlett Gen 3
 support
Message-ID: <cover.1624294591.git.g@b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Hin-Tak Leung <htl10@users.sourceforge.net>,
 Vladimir Sadovnikov <sadko4u@gmail.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This patch set broadly:
- Refactors the Scarlett Gen 2 support to make the Gen 3 mixer support
  trivial to add
- Fixes a couple of minor issues with the Gen 2 support (low priority
  for stable; the issues were not reported by any user)
- Adds support for Gen 3 devices with and without a mixer
- Adds support for the major features new with the Gen 3 devices

Geoffrey D. Bennett (31):
  ALSA: usb-audio: scarlett2: Add usb_tx/rx functions
  ALSA: usb-audio: scarlett2: Update initialisation sequence
  ALSA: usb-audio: scarlett2: Fix 6i6 Gen 2 line out descriptions
  ALSA: usb-audio: scarlett2: Always enable interrupt polling
  ALSA: usb-audio: scarlett2: Add "Sync Status" control
  ALSA: usb-audio: scarlett2: Merge common line in capture strings
  ALSA: usb-audio: scarlett2: Reformat scarlett2_config_items[]
  ALSA: usb-audio: scarlett2: Improve device info lookup
  ALSA: usb-audio: scarlett2: Move info lookup out of init function
  ALSA: usb-audio: scarlett2: Remove repeated device info comments
  ALSA: usb-audio: scarlett2: Add scarlett2_vol_ctl_write() helper
  ALSA: usb-audio: scarlett2: Add mute support
  ALSA: usb-audio: scarlett2: Allow arbitrary ordering of mux entries
  ALSA: usb-audio: scarlett2: Split struct scarlett2_ports
  ALSA: usb-audio: scarlett2: Fix Level Meter control
  ALSA: usb-audio: scarlett2: Add Gen 3 mixer support
  ALSA: usb-audio: scarlett2: Add support for "input-other" notify
  ALSA: usb-audio: scarlett2: Add Gen 3 MSD mode switch
  ALSA: usb-audio: scarlett2: Move get config above set config
  ALSA: usb-audio: scarlett2: Allow bit-level access to config
  ALSA: usb-audio: scarlett2: Add support for Solo and 2i2 Gen 3
  ALSA: usb-audio: scarlett2: Add "air" switch support
  ALSA: usb-audio: scarlett2: Add phantom power switch support
  ALSA: usb-audio: scarlett2: Add direct monitor support
  ALSA: usb-audio: scarlett2: Label 18i8 Gen 3 line outputs correctly
  ALSA: usb-audio: scarlett2: Split up sw_hw_enum_ctl_put()
  ALSA: usb-audio: scarlett2: Add sw_hw_ctls and mux_ctls
  ALSA: usb-audio: scarlett2: Update mux controls to allow updates
  ALSA: usb-audio: scarlett2: Add speaker switching support
  ALSA: usb-audio: scarlett2: Update get_config to do endian conversion
  ALSA: usb-audio: scarlett2: Add support for the talkback feature

 sound/usb/mixer.c               |    2 +-
 sound/usb/mixer_quirks.c        |    6 +
 sound/usb/mixer_scarlett_gen2.c | 2725 +++++++++++++++++++++++++------
 3 files changed, 2239 insertions(+), 494 deletions(-)


base-commit: 6c0a2078134aba6a77291554035304df9e16b85c
-- 
2.31.1

