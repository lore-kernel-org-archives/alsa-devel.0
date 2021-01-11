Return-Path: <SRS0=maC8=GO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1F9C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 13:07:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0BC21973
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 13:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0BC21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C533D16B6;
	Mon, 11 Jan 2021 14:06:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C533D16B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610370447;
	bh=jpvlPaZVEezRMz9QjFHNhf6I/H6LSkXPCsNgw2Z23Xw=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BMRcoGesGWmAUm2jpsD1ey0GEG3qZ+DR4k19bVK4evS/H6CakIInQIj2TaKRcnwgE
	 jneT8FItV+WJdGJ36ll6xG/6lDEHLfhuaoRkRe+zby1tVJ+5o9ZvLEQHR68T6pi3Js
	 jaPMdYkveEKLm83N0DEvy0jCPSeyEqGpfJ0fhW9Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E2EBF8016C;
	Mon, 11 Jan 2021 14:06:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6479EF8016D; Mon, 11 Jan 2021 14:06:35 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A70A2F800BE
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2021 14:06:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A70A2F800BE
Received: from [123.114.32.120] (helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1kywtv-0001Ym-Lu; Mon, 11 Jan 2021 13:06:31 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz,
 kai.vehmanen@linux.intel.com
Subject: [RFC][PATCH v4 0/4] design a way to change audio Jack state by
 software
Date: Mon, 11 Jan 2021 21:05:53 +0800
Message-Id: <20210111130557.90208-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

the changes in the v4:
 - change the sound-core to sound and change the sound_core_debugfs_root
   to sound_debugfs_root in the 0001-xxx.patch
 - change kzalloc/kfree to kvzalloc/kvfree in the debugfs fops for
   0001-xxx.patch and 0003-xxx.patch
 - And if needed, I could squash 4 patches into 1 patch before merging.

the changes in the v3 (for easy to review, divide change into 4 patches):
 - address the comment about the snd_jack_report() and _snd_jack_report(),
   the v2 design is hard to understand and is hard to review, in the v3,
   separate the jack_report to snd_jack_report() and snd_jack_inject_report(),
   hw jack events call snd_jack_report() as before, if a jack contains multi
   jack_kctl and the jack_kctl's sw_inject is enabled, the status and the
   related input-dev's events will not be reproted. The injection events call
   snd_jack_inject_report(). This change is squashed to 0001-xxx.patch,  the
   rest part of 0001-xxx.patch is same as v2.

 - address the comment about folders'name in the 0002-xxx.patch, so far, drop
   the '/', ',', '=' and ' ' from the folders' name.

 - address the comment about adding more debugfs nodes in the 0003-xxx.patch,
   it adds kctl_id, mask_bits, status and type.

 - address the comment about save-n-restore jack's hw status in the
   0004-xxx.patch, adding a hw_status_cache and save the last reported jack
   hw event, once the sw_inject is disabled, will restore all jack_kctl's
   state under the same snd_jack with hw_status_cache.
[snip]


the changes in the V2:
 - using debugfs instead of sysfs
 - using jack_ctrl to create a folder instead of snd_jack, since ASoC drivers
   could create multi jack_ctrls within a snd_jack
 - create a folder for each jack_ctrl instead for all jack_ctrls
[ snip ]


Hui Wang (4):
  alsa: jack: implement software jack injection via debugfs
  alsa: jack: adjust jack_kctl debugfs folder's name
  alsa: jack: add more jack_kctl debugfs nodes
  alsa: jack: implement save-and-restore for jack's hw status

 include/sound/core.h |   2 +
 include/sound/jack.h |   1 +
 sound/core/init.c    |   7 +
 sound/core/jack.c    | 352 ++++++++++++++++++++++++++++++++++++++++++-
 sound/core/sound.c   |   8 +
 5 files changed, 366 insertions(+), 4 deletions(-)

-- 
2.25.1

