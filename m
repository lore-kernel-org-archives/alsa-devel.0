Return-Path: <SRS0=bL7i=LQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74341C2B9F4
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 17:01:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCAB76128C
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 17:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAB76128C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F75E850;
	Tue, 22 Jun 2021 19:00:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F75E850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624381302;
	bh=vkM+Hrttef4o+HJ9JKsaNV8KRKRJYqWj8KncEakkFmo=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=H1gcYyOYzPr9olU6z4dNDydnugN+Plb6yujIyBG3GUEE+Bww0JXD8p15+i8wk0YOM
	 hMbUjtk4IJLTxpxlNylYH6yEYQ4gjfmogA4ujp69X+xhd58AsO6THrcS2VWTUnV58y
	 tzZDzlacwKcOHbEXb30pFRTDppXzjgLx+0mAViQ4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EC898F8025F;
	Tue, 22 Jun 2021 19:00:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F077CF80268; Tue, 22 Jun 2021 19:00:50 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02986F80161
 for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2021 19:00:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 02986F80161
Received: by m.b4.vu (Postfix, from userid 1000)
 id 09D5561E286E; Wed, 23 Jun 2021 02:30:34 +0930 (ACST)
Date: Wed, 23 Jun 2021 02:30:33 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH V3 00/17] Add Scarlett Gen 3 support
Message-ID: <cover.1624379707.git.g@b4.vu>
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

This patch series adds a fixed version of Scarlett Gen 3 support on
top of the previous "Refactor Scarlett Gen 2 support" patches 1-15/31.

Two differences from the previous patches 16-31/31:

- Add patch from Takashi fixing scarlett2_add_new_ctl()

- Don't increase MAX_ID_ELEMS

I tested the above changes on the 18i20 Gen 3 and confirmed no crash
with 439 controls and MAX_ID_ELEMS 256.

Geoffrey D. Bennett (16):
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

Takashi Iwai (1):
  ALSA: usb-audio: scarlett2: Fix wrong resume call

 sound/usb/mixer.c               |    3 +
 sound/usb/mixer.h               |    1 +
 sound/usb/mixer_quirks.c        |    6 +
 sound/usb/mixer_scarlett_gen2.c | 1804 ++++++++++++++++++++++++++++---
 4 files changed, 1637 insertions(+), 177 deletions(-)

-- 
2.31.1

