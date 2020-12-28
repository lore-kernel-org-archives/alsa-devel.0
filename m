Return-Path: <SRS0=H50z=GA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4525DC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 08:01:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78AC8207B6
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Dec 2020 08:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AC8207B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C61716FD;
	Mon, 28 Dec 2020 09:00:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C61716FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609142476;
	bh=HyPbpD71mWndT3Nxct1NcWDhYYwu9HT9mOcSwRIsEzA=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=F2huXzsmvInJSBSGJH0CHb6XTay6hWwkuiKuf06YYKq79hkg7AQ445bqL43tIHc+b
	 n8zuSg6lfGDGY7wKSNBqtdPP9OY8dTIHBXeLdRFQfKNkbxbNUR1yw2y9pEXHIQh/Sh
	 Gr2uJQwUAA5POJVf0ZgOyIV5dNEAM7vakwtk/gGI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EF28F801F5;
	Mon, 28 Dec 2020 09:00:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD2ACF801ED; Mon, 28 Dec 2020 09:00:19 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55D0EF801ED
 for <alsa-devel@alsa-project.org>; Mon, 28 Dec 2020 09:00:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55D0EF801ED
Received: from [223.72.45.82] (helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1ktnRs-0004UZ-1p; Mon, 28 Dec 2020 08:00:12 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz,
 kai.vehmanen@linux.intel.com
Subject: [RFC][PATCH v3 0/4] design a way to change audio Jack state by
 software
Date: Mon, 28 Dec 2020 15:59:59 +0800
Message-Id: <20201228080003.19127-1-hui.wang@canonical.com>
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

Now the layout of folders looks like below:
/sys/kernel/debug# tree sound-core/
sound-core/
└── card0
    ├── HDMIDPpcm3Jack
    │   ├── jackin_inject
    │   ├── kctl_id
    │   ├── mask_bits
    │   ├── status
    │   ├── sw_inject_enable
    │   └── type
    ├── HDMIDPpcm4Jack
    │   ├── jackin_inject
    │   ├── kctl_id
    │   ├── mask_bits
    │   ├── status
    │   ├── sw_inject_enable
    │   └── type
    ├── HDMIDPpcm5Jack
    │   ├── jackin_inject
    │   ├── kctl_id
    │   ├── mask_bits
    │   ├── status
    │   ├── sw_inject_enable
    │   └── type
    ├── HeadphoneJack
    │   ├── jackin_inject
    │   ├── kctl_id
    │   ├── mask_bits
    │   ├── status
    │   ├── sw_inject_enable
    │   └── type
    └── MicJack
        ├── jackin_inject
        ├── kctl_id
        ├── mask_bits
        ├── status
        ├── sw_inject_enable
        └── type

/sys/kernel/debug# cat sound-core/card0/HeadphoneJack/kctl_id 
Headphone Jack
/sys/kernel/debug# cat sound-core/card0/HeadphoneJack/mask_bits 
0x0001 HEADPHONE(0x0001)
/sys/kernel/debug# cat sound-core/card0/HeadphoneJack/status 
0x0000
/sys/kernel/debug# cat sound-core/card0/HeadphoneJack/sw_inject_enable 
Jack: Headphone Jack		Inject Enabled: 0
/sys/kernel/debug# cat sound-core/card0/HeadphoneJack/type 
0x0001 HEADPHONE(0x0001)








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
 sound/core/jack.c    | 351 ++++++++++++++++++++++++++++++++++++++++++-
 sound/core/sound.c   |   8 +
 5 files changed, 365 insertions(+), 4 deletions(-)

-- 
2.25.1

