Return-Path: <SRS0=6Vr6=3D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19CEC33C9E
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:45:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD9F207FF
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oNJkUvy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD9F207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C5772179C;
	Tue, 14 Jan 2020 16:44:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C5772179C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579016713;
	bh=OD1paoCfLDj9o2XyQYxcL03esyY8sLb+NkARM3IGwxI=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oNJkUvy6IHIaxl40W3YZMbN7fa9mBUIYbmWG9HWPaYcS3psOQ9OrpCtpluqjSeK7L
	 FEaXR77nkrpJ3ET4ltlKWERAnWs7HWJbOP/rLOKEjQtcLbnLian4XoZPRUDtazhpgm
	 Gt4cWfwUPMHfpjtIeUNe9WNPQ2Ge3q2LWzEAKIvk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E143F8014D;
	Tue, 14 Jan 2020 16:44:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CFC96F8014E; Tue, 14 Jan 2020 16:44:20 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D53C9F800B9
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2020 16:44:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D53C9F800B9
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1irOMW-0004SH-W0; Tue, 14 Jan 2020 15:44:13 +0000
From: Colin King <colin.king@canonical.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
 alsa-devel@alsa-project.org
Date: Tue, 14 Jan 2020 15:44:12 +0000
Message-Id: <20200114154412.365395-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH] ALSA: hda - fix out of bounds read on
	spec->smux_paths
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Colin Ian King <colin.king@canonical.com>

It is possible for the call to snd_hda_get_num_conns to fail and return
a negative error code that gets assigned to num_conns. In that specific
case, the check of very large values of val against num_conns will not
fail the -EINVAL check and later on an out of bounds array read on
spec->smux_paths will occur.  Fix this by sanity checking for an error
return from the call to snd_hda_get_num_conns.

Addresses-Coverity: ("Out-of-bounds read")
Fixes: 272f3ea31776 ("ALSA: hda - Add SPDIF mux control to AD codec auto-parser")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/hda/patch_analog.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 88c46b051d14..399561369495 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -756,9 +756,11 @@ static int ad1988_auto_smux_enum_put(struct snd_kcontrol *kcontrol,
 	struct ad198x_spec *spec = codec->spec;
 	unsigned int val = ucontrol->value.enumerated.item[0];
 	struct nid_path *path;
-	int num_conns = snd_hda_get_num_conns(codec, 0x0b) + 1;
+	int num_conns = snd_hda_get_num_conns(codec, 0x0b);
 
-	if (val >= num_conns)
+	if (num_conns < 0)
+		return num_conns;
+	if (val >= num_conns + 1)
 		return -EINVAL;
 	if (spec->cur_smux == val)
 		return 0;
-- 
2.24.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
