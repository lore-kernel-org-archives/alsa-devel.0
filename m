Return-Path: <SRS0=We8V=6G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B80AC55189
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:25:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7AE620781
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ez6xtWYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7AE620781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F5C9168D;
	Wed, 22 Apr 2020 13:24:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F5C9168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587554727;
	bh=Cu5IacCeiglMo6qJFJ3BgUjkOxoh30q8a49JBJJJs2g=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ez6xtWYWM/0Dej/Hb8XT9CxDu4o4v69gTGHBE/70XAydzjvr3acdn9ioa3MYX5FL5
	 9LZQ0s5CxPKuI06v7IBnifztMhP3cK0Bnz8Sx/tnHpxd/W73b17Dn31eGw8NiP9pih
	 5WtfPG+3Aoef4uNK7iekofW9Tp4dMGueCjm1VxbY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D7E5F80142;
	Wed, 22 Apr 2020 13:24:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 228E1F801D9; Wed, 22 Apr 2020 13:24:34 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C5B7F800FF;
 Wed, 22 Apr 2020 13:24:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C5B7F800FF
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1jRDUH-0006HA-IO; Wed, 22 Apr 2020 11:24:17 +0000
From: Colin King <colin.king@canonical.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: SOF: ensure all fields in header are zero'd before
 copying back to userspace
Date: Wed, 22 Apr 2020 12:24:17 +0100
Message-Id: <20200422112417.208843-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

From: Colin Ian King <colin.king@canonical.com>

Field header.tlv is uninitialized and being copied back to userspace
and hence leaking data from the stack to userspace.  Fix this by
ensuring the header structure is zero'd.

Fixes: c3078f539704 ("ASoC: SOF: Add Sound Open Firmware KControl support")
Addresses-Coverity: ("Uninitialized scalar variable")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/sof/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/control.c b/sound/soc/sof/control.c
index dfc412e2d956..97d5c1a4c1ff 100644
--- a/sound/soc/sof/control.c
+++ b/sound/soc/sof/control.c
@@ -362,7 +362,7 @@ int snd_sof_bytes_ext_get(struct snd_kcontrol *kcontrol,
 	struct snd_sof_control *scontrol = be->dobj.private;
 	struct snd_soc_component *scomp = scontrol->scomp;
 	struct sof_ipc_ctrl_data *cdata = scontrol->control_data;
-	struct snd_ctl_tlv header;
+	struct snd_ctl_tlv header = { };
 	struct snd_ctl_tlv __user *tlvd =
 		(struct snd_ctl_tlv __user *)binary_data;
 	int data_size;
-- 
2.25.1

