Return-Path: <SRS0=lYxt=YV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40734CA9EA0
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:37:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC52C214AF
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Oct 2019 07:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Gp8DeZzM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYmllqNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC52C214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F7241AEA;
	Mon, 28 Oct 2019 08:36:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F7241AEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572248260;
	bh=9gzrKbW0YCcQwB1yukBbIjKl8fpGUGXtpTGpuruxe8U=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Gp8DeZzMQZ8kNtQ9zmYzKvjLCs4KqQG7L1rzT0J2iGWEmBYFz36OmbSeMPwzMdXQE
	 9LJmKnn1HQZHMy6B0cHXUkgwNh6tODJ8jbM8VZGLW3t/FQQPtdvO/i7az8rBoEPm/a
	 1cKVxgvtMYEoMlArziIN8wh+g1emh+yA/gT7mfx4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70FCFF80634;
	Mon, 28 Oct 2019 08:33:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 168C5F80392; Sun, 27 Oct 2019 22:53:45 +0100 (CET)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F7D6F80145
 for <alsa-devel@alsa-project.org>; Sun, 27 Oct 2019 22:53:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F7D6F80145
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="hYmllqNN"
Received: by mail-io1-xd41.google.com with SMTP id q1so8497138ion.1
 for <alsa-devel@alsa-project.org>; Sun, 27 Oct 2019 14:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=CCZl0j1P1FyTjIpTDRJfaJQYXzqQniNrCSsMSJER5FE=;
 b=hYmllqNNLIaHWyfzEhzbgV41fN6DR4+U1k3TUA8UD/BT4nz/7KR0ZyVtq8sUS9T5wk
 bLFsQMrd5ii67uAp22grpEvPHmldksyk9foPhnfAZsSDBRm5CCsZDcSgoCh3E3fU1kg1
 nvpMNxIL7IRDaNHOVsXf03TRrAQ/L3larGXZLsnb/3U8PTR732e1dUia+ImSqrDjKRz0
 yMKXpkv7a0ocLAumQDPFlx2JGwJ0hy966ZusA/a2/LGUzs0kh8ggiG55BLesTCumL2rT
 PHU4X6WjyZsE90RRq4RdP1CHL/Bp5WF1RY3VR3gSN1KeqJvklgOOIyBM4ZfCxJQdlNNq
 lr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=CCZl0j1P1FyTjIpTDRJfaJQYXzqQniNrCSsMSJER5FE=;
 b=MeRxvcSYDMCSViDNkj8AbI0NuAkVRuZuodGuimkeoN23WIdjnqI1lcy5Azwecqsov5
 VY9aNOkkVxtCgI181EkvMU5o0pi56MN2KpBtgJe5xZhjHJHUVUNZh93FFH6M4XXwnnAA
 Q2PxGYQTMKiVDneyCHGTIbDnYd6Inr8uh4Orl+xo3qjqEloJX0Ct33hPU4sq4rwjDhEN
 S1VyMXOEfRAgRgMLYJb1ZXZ5Icea7Tv8qriEA83YYtna6L6Fr0aK2TO2JnO39OgOGAUG
 0e8bE3LwEbfiSp61OkLfseKf6I2Te4QMJDzo9fkRHZW+cs5bDozIwDxDGCIOTW4NdBNs
 XTew==
X-Gm-Message-State: APjAAAVFWcNzQV47veCkX3zl8w3nOrEfpR4RV9uNJOGduLWoyAMtHsmL
 pDmuMZotxy6h+6x0wUcawMI=
X-Google-Smtp-Source: APXvYqx0XI3ng3sOrKsNNVRkOoLbKi3BQ92jxGPmPUezDvyxLx62hpOCJ8W8vjpQY4WRYfopUQUaYA==
X-Received: by 2002:a02:19c1:: with SMTP id b184mr14699631jab.54.1572213219249; 
 Sun, 27 Oct 2019 14:53:39 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
 by smtp.googlemail.com with ESMTPSA id d17sm948686ioe.31.2019.10.27.14.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2019 14:53:38 -0700 (PDT)
From: Navid Emamdoost <navid.emamdoost@gmail.com>
To: 
Date: Sun, 27 Oct 2019 16:53:24 -0500
Message-Id: <20191027215330.12729-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Mon, 28 Oct 2019 08:33:18 +0100
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Pan Xiuli <xiuli.pan@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 kjlu@umn.edu, Liam Girdwood <lgirdwood@gmail.com>,
 Slawomir Blauciak <slawomir.blauciak@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, smccaman@umn.edu,
 Navid Emamdoost <navid.emamdoost@gmail.com>, linux-kernel@vger.kernel.org,
 emamd001@umn.edu
Subject: [alsa-devel] [PATCH] ASoC: SOF: ipc: Fix memory leak in
	sof_set_get_large_ctrl_data
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

In the implementation of sof_set_get_large_ctrl_data() there is a memory
leak in case an error. Release partdata if sof_get_ctrl_copy_params()
fails.

Fixes: 54d198d5019d ("ASoC: SOF: Propagate sof_get_ctrl_copy_params() error properly")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 sound/soc/sof/ipc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
index b2f359d2f7e5..086eeeab8679 100644
--- a/sound/soc/sof/ipc.c
+++ b/sound/soc/sof/ipc.c
@@ -572,8 +572,10 @@ static int sof_set_get_large_ctrl_data(struct snd_sof_dev *sdev,
 	else
 		err = sof_get_ctrl_copy_params(cdata->type, partdata, cdata,
 					       sparams);
-	if (err < 0)
+	if (err < 0) {
+		kfree(partdata);
 		return err;
+	}
 
 	msg_bytes = sparams->msg_bytes;
 	pl_size = sparams->pl_size;
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
