Return-Path: <SRS0=TNia=LA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69949C47096
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Jun 2021 17:45:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8336E613CB
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Jun 2021 17:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8336E613CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42BA516BF;
	Sun,  6 Jun 2021 19:44:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42BA516BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623001518;
	bh=iUv8ybzjGeBOPpp16tkFbtedftd4brTJfWrF0jK5xws=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BFapDtcXBaAix8vKIYMt+kEp/yRBf0vEJ5E7306igCcDMBCW9mzUqw3Mt50wdPSGF
	 ATHB888gDfKjuog6gnph5X1kK3yJ6fpcsiLAwwhZHKQ4JFHQFbuzn3IR/YLB/XWZSc
	 +YGc+Icz2p6y5IDxyJC4S4GGqxsg+DONqywdzA7M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C46CEF8019B;
	Sun,  6 Jun 2021 19:44:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06083F80218; Sun,  6 Jun 2021 19:44:26 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A964F800C8
 for <alsa-devel@alsa-project.org>; Sun,  6 Jun 2021 19:44:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A964F800C8
Received: by m.b4.vu (Postfix, from userid 1000)
 id B3DD3612FB14; Mon,  7 Jun 2021 03:14:14 +0930 (ACST)
Date: Mon, 7 Jun 2021 03:14:14 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/8] ALSA: usb-audio: scarlett2: cleanup
Message-ID: <cover.1622999147.git.g@b4.vu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Vladimir Sadovnikov <sadko4u@gmail.com>
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

Hi Takashi,

Over the next few weeks I will have ready about 40 patches to clean up
the Scarlett Gen 2 mixer driver a bit, add a few missing features, and
add support for all Scarlett Gen 3 models.

I was planning on submitting them in batches of 5-10 at a time; is
that okay?

Here are the first 8 patches which are ready to go; only small
cleanups/renames/fixes. They are intended to be applied after these
two patches that I submitted earlier:

- ALSA: usb-audio: scarlett2: Read mixer volumes at init time
- ALSA: usb-audio: scarlett2: Read mux at init time

Thanks,
Geoffrey.

Geoffrey D. Bennett (8):
  ALSA: usb-audio: scarlett2: Remove incorrect S/PDIF comment
  ALSA: usb-audio: scarlett2: Coding style improvements
  ALSA: usb-audio: scarlett2: Remove unused/useless code
  ALSA: usb-audio: scarlett2: Remove interrupt debug message
  ALSA: usb-audio: scarlett2: Rename buttons/interrupts
  ALSA: usb-audio: scarlett2: Rename struct scarlett2_mixer_data
  ALSA: usb-audio: scarlett2: Add temp variable for consistency
  ALSA: usb-audio: scarlett2: Fix data_mutex lock

 sound/usb/mixer_scarlett_gen2.c | 229 ++++++++++++++------------------
 1 file changed, 102 insertions(+), 127 deletions(-)

-- 
2.31.1

