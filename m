Return-Path: <SRS0=hSU8=IQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21685C433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 15:14:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A23564F2B
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Mar 2021 15:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A23564F2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EBEA11694;
	Thu, 18 Mar 2021 16:13:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EBEA11694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616080461;
	bh=pk0JcXdp+cEpM7R1IyzG8c0PMt0MndmHH4wb3rzfZ3s=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Jh8hzs8RHBGNt0XLVrfRiIUyEhmjh8S33zMia2wbGmq7aIhD4pi2THRblQs3C9HPj
	 ZB+gBpeFsMs3Zb/BRLKwfNXp/kNAwlIceM2PN4l16UqQ+oJuXb6Y3REtYmI49/+1OT
	 vTQGr3VpQkf24Khs3gD4llRl5UdVCrT/a6Fi+5y8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 60B4DF80218;
	Thu, 18 Mar 2021 16:13:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 017EEF800E0; Thu, 18 Mar 2021 16:13:28 +0100 (CET)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2ABB7F800E0
 for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2021 16:13:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2ABB7F800E0
IronPort-SDR: v9m0EBwM3aWAHqGimgk9FSjuOlsaTtlkdw6iWD2xl/0triGJC/C4xWkphO7jcJF07TFr2irE27
 TkJuvMI3rdyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="209702401"
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; d="scan'208";a="209702401"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2021 08:13:19 -0700
IronPort-SDR: /nJXgJO2oOjmXK5Hg/NcOwPzS4yukmUVlBZ1WVLTWU5SmeJhHaOcsBgGus9gmn37FZn7EvfYEG
 K0U/hp3qEZig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; d="scan'208";a="606207190"
Received: from pi-desktop.igk.intel.com ([10.237.148.102])
 by fmsmga005.fm.intel.com with ESMTP; 18 Mar 2021 08:13:18 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 0/3] Fix SND_HDA_PREALLOC issue
Date: Thu, 18 Mar 2021 16:11:19 +0100
Message-Id: <20210318151122.2493096-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
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

For context it started with user reporting failures when running arecord
without any error or warning in dmesg (after fixing some configuration
problems thet they had).
https://bugzilla.kernel.org/show_bug.cgi?id=201251#c279

After spending time investigating the issue it was narrowed to quite big
setting of CONFIG_SND_HDA_PREALLOC_SIZE (4096).
When looking at code
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/core/pcm_memory.c?id=6417f03132a6952cd17ddd8eaddbac92b61b17e0#n30
there is a limit of memory per card:
max_alloc_per_card = 32UL * 1024UL * 1024UL

When SND_HDA_PREALLOC_SIZE is set to 4096 it only has memory to alloc
for 8 frontends, while Skylake HDA card has 10 of them (6 playback and 4
capture), so preallocated memory is exhausted while probing. In
consequence 2 of FEs end without allocated memory.

It can be workarounded on user side with setting SND_HDA_PREALLOC_SIZE
to lower value, other is changing memory limit per card.

However in order to not waste user memory, change maximum allocation
size on HDA controller to 4MB and force automatical memory allocation
insted of preallocated one.

First patch adds prints, so similar issues can be easily identified in
the future.
Second changes maximum size of hda buffer to reasonable value of 4MB.
And last one reverts patch which allowed setting prealloc size on X86
platforms.

Amadeusz Sławiński (3):
  ALSA: pcm: Add debug print on memory allocation failure
  ALSA: hda: Change AZX_MAX_BUF_SIZE from 1GB to 4MB
  ALSA: hda: Revert "ALSA: hda: Allow setting preallocation again for
    x86"

 include/sound/hda_register.h | 4 ++--
 sound/core/pcm_memory.c      | 8 ++++++++
 sound/hda/Kconfig            | 7 +++----
 3 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.25.1

