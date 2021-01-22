Return-Path: <SRS0=81m9=GZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B80C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 14:16:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4923523B53
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 14:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4923523B53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA0611F02;
	Fri, 22 Jan 2021 15:15:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA0611F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611324980;
	bh=HrQpMR/r6ihWmK2nab/1HQWAX4ZVb2FsClqZrxkXOBc=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FlGM23miUG40J9ECAp/QJkQdeqK16rse2JHmZPh3w3kA1CEw8zI2oy3Q5HbH0y+Ns
	 0ppZ9F5N9N6I0aKxHAuz4TmrpX9AgFP7QqQJ7dG6IX1q0Ujhg5+cwp9eaIwDiuyV1i
	 EzlMYxkIAheCjqo5d85GyUp3hRQDbHtmdWp9+A5g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33D21F80166;
	Fri, 22 Jan 2021 15:15:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A9DE6F8016E; Fri, 22 Jan 2021 15:15:28 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00D65F80164
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2021 15:15:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00D65F80164
Received: from [123.112.70.0] (helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1l2xDd-0003uW-Hg; Fri, 22 Jan 2021 14:15:22 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz,
 kai.vehmanen@linux.intel.com
Subject: [RFC][PATCH v6 0/1] audio jack software injection
Date: Fri, 22 Jan 2021 22:14:55 +0800
Message-Id: <20210122141456.12460-1-hui.wang@canonical.com>
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

the changes in the v6:
 - use the sizeof(buf) to replace the digits in the scnprintf
 - squash the document patch into the 0001-xxx.patch.


the changes in the v5:
 - add a Kconfig to enable/disable the jack injection feature
 - replace all kzalloc with local char[] in the debugfs fops
 - replace the chars of !isalnum() to '_' for the jack folder's name
 - squash all .c files patches into one patch
 - add a document to explain jack injection, for easier review, put
   the document in a standalone patch. If needed, will squash this
   patch to the previous one.
 

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

Hui Wang (1):
  alsa: jack: implement software jack injection via debugfs

 Documentation/sound/designs/index.rst         |   1 +
 .../sound/designs/jack-injection.rst          | 124 ++++++++
 include/sound/core.h                          |   2 +
 include/sound/jack.h                          |   1 +
 sound/core/Kconfig                            |   9 +
 sound/core/init.c                             |  10 +
 sound/core/jack.c                             | 298 +++++++++++++++++-
 sound/core/sound.c                            |   8 +
 8 files changed, 449 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/sound/designs/jack-injection.rst

-- 
2.25.1

