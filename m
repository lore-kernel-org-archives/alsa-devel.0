Return-Path: <SRS0=5/d5=AO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C9CC433DF
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:20:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F5020720
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2020 07:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KO0MsWaY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LuBmQALB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F5020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AB2716AA;
	Fri,  3 Jul 2020 09:19:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AB2716AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593760822;
	bh=/91qFkstDyp2juSqrhB3S1a98ogURT/J9OTYgL5vhFE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KO0MsWaY9sQoiSrJkgvCLyqBwFfV69CwVnrXriov1lM1bCmIMBcSNAIDUItVYEMFH
	 QMa1sW81GmY6XSIrzBMBOyhX3GCafxAIQqgioavF56ZRS7VZIEXFMrq7CHRrwPE1P5
	 vDmOOZoXdFYcghVpMFBwQKu48Y0oOLC8aiMjwaT4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DCBF3F8020C;
	Fri,  3 Jul 2020 09:19:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53650F80217; Fri,  3 Jul 2020 09:19:30 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 570AAF800E2
 for <alsa-devel@alsa-project.org>; Fri,  3 Jul 2020 09:19:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 570AAF800E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="LuBmQALB"
Received: by mail-pj1-x1044.google.com with SMTP id mn17so217718pjb.4
 for <alsa-devel@alsa-project.org>; Fri, 03 Jul 2020 00:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JylBBIg6s0EqS8bdMWdfMXLZabsAcyVLV5Ia1GF24jE=;
 b=LuBmQALByFHpbapAUDv6bqBgiD40v2S3cpXHTBd494VfOxmTeAfoOVxc3X7KJq6rYf
 mf3j3YomUb9B9FUv07321mneQR8s1v3xe+VZhtu4Ez8Gx6bEpl7muNosjsBi7YNyqExw
 PvJH23Kq03SPfX55KZjdgzDNJufwLz/TYl3Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JylBBIg6s0EqS8bdMWdfMXLZabsAcyVLV5Ia1GF24jE=;
 b=Dh+JEGSE3MY3IURJyjBMrj2m5FhlRDSrYd/ZfB42gzLnwEQefWJ/gbyv0JHbt1kiZ1
 tPL6V/szcbW5dwM7BCmBPcmBgHPdFIjH2PVUoI6etycdk6KpbNk4ta/h9FCtRFVbXkdL
 yrcE9GA69rlGavNdA7xXQyBTn8L9xHaekxVXU/Yl8N0aa5LA8qHCPz8kROr/wAT3SRPq
 9OKo9H56VneHQqztWQHARUdaWBNvZX0CEg/tjoEj1vfXBrANV3vtQEbtqGx9RTtnkNbR
 y+eIvR5UOz445xyDjq5swCJAUGUJm2cLnFGWWh33K+Fl2hsoy7c4lFnDYIRrXLcAvyps
 5rLA==
X-Gm-Message-State: AOAM530KbTfHCBGsZM8ethXIPD2e99CsKnZtHx5oiI2OfDP+s9fQlfEC
 4ENA/zL1ugE38l0sHV/AF9AYvw==
X-Google-Smtp-Source: ABdhPJwc5DFMU7lUMcC9pIOl141dJmNWbcK3lxZkVUgks8KYeFld2VbYBWEOy49NWxeoXdxhvCf0ig==
X-Received: by 2002:a17:902:c391:: with SMTP id
 g17mr30067388plg.330.1593760760320; 
 Fri, 03 Jul 2020 00:19:20 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:725a:fff:fe46:44eb])
 by smtp.gmail.com with ESMTPSA id f3sm9603746pju.54.2020.07.03.00.19.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 00:19:18 -0700 (PDT)
From: Yu-Hsuan Hsu <yuhsuan@chromium.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: cros_ec_codec: Log results when EC commands fail
Date: Fri,  3 Jul 2020 15:19:13 +0800
Message-Id: <20200703071913.2358882-1-yuhsuan@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Tzung-Bi Shih <tzungbi@google.com>,
 Mark Brown <broonie@kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>,
 Yu-Hsuan Hsu <yuhsuan@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>
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

Log results of failed EC commands to identify a problem more easily.

Replace cros_ec_cmd_xfer_status with cros_ec_cmd_xfer because the result
has already been checked in this function. The wrapper is not needed.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
---
 sound/soc/codecs/cros_ec_codec.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
index 8d45c628e988e..a4ab62f59efa6 100644
--- a/sound/soc/codecs/cros_ec_codec.c
+++ b/sound/soc/codecs/cros_ec_codec.c
@@ -90,10 +90,17 @@ static int send_ec_host_command(struct cros_ec_device *ec_dev, uint32_t cmd,
 	if (outsize)
 		memcpy(msg->data, out, outsize);
 
-	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
+	ret = cros_ec_cmd_xfer(ec_dev, msg);
 	if (ret < 0)
 		goto error;
 
+	if (msg->result != EC_RES_SUCCESS) {
+		dev_err(ec_dev->dev, "Command %d failed: %d\n", cmd,
+			msg->result);
+		ret = -EPROTO;
+		goto error;
+	}
+
 	if (insize)
 		memcpy(in, msg->data, insize);
 
-- 
2.27.0.212.ge8ba1cc988-goog

