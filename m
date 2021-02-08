Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CD9C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 07:25:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5687F64E16
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 07:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5687F64E16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD56A167A;
	Mon,  8 Feb 2021 08:24:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD56A167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612769103;
	bh=cOgsOBBCgJvrK3ozt4RGGiwveiLuJ5d4r2aLU/Xw/eI=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZteOyEUVZwnpkChEG2mIGXIh7/jmh3MPb2AJ/BGrnfoj7gdZ6Vn9Dy1lJ+UyTFhe5
	 rY5iuKoAXkZ2hM+gLgUdNAmPyNIcebE+KnQOmU6qWljsOrSi/MJzG3JV27wxeLJAz+
	 YAe9baY9Pxr/4GOE8V/Kj1y/8Y7hYQTO+CCZ6IWs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13721F80169;
	Mon,  8 Feb 2021 08:24:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A3F8F8022B; Mon,  8 Feb 2021 08:24:10 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 608B9F80165
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2021 08:23:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 608B9F80165
Received: from 1.general.hwang4.uk.vpn ([10.172.195.16]
 helo=localhost.localdomain) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1l90to-0003Vx-2E; Mon, 08 Feb 2021 07:23:56 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, broonie@kernel.org
Subject: [PATCH] ASoC: SOF: debug: Fix a potential issue on string buffer
 termination
Date: Mon,  8 Feb 2021 15:22:57 +0800
Message-Id: <20210208072257.73900-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

The function simple_write_to_buffer() doesn't add string termination
at the end of buf, we need to add it on our own if calling that
function to write the size of count chars to buf. This change refers
to the function tokenize_input() in debug.c and the function
sof_dfsentry_trace_filter_write() in trace.c.

We didn't find this potential issue in the past because sometimes we
are very lucky, we kzalloc the size of count buf, the kernel not only
returns a buf with buf[0 ... (count - 1)] = 0 but buf[count] = 0, with
this luck, this issue will not be exposed.

Fixes: 091c12e1f50c ("ASoC: SOF: debug: add new debugfs entries for IPC flood test")
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/soc/sof/debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
index 30213a1beaaa..edd4893119dd 100644
--- a/sound/soc/sof/debug.c
+++ b/sound/soc/sof/debug.c
@@ -352,9 +352,10 @@ static ssize_t sof_dfsentry_write(struct file *file, const char __user *buffer,
 	char *string;
 	int ret;
 
-	string = kzalloc(count, GFP_KERNEL);
+	string = kzalloc(count+1, GFP_KERNEL);
 	if (!string)
 		return -ENOMEM;
+	string[count] = '\0';
 
 	size = simple_write_to_buffer(string, count, ppos, buffer, count);
 	ret = size;
-- 
2.25.1

