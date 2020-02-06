Return-Path: <SRS0=rQAG=33=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD199C352A2
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:29:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 313C320715
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HV+p9UP1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSVM7mzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313C320715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5FD4A166D;
	Fri,  7 Feb 2020 14:28:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5FD4A166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581082148;
	bh=LGjUf4aNjKQvY2fA1X6U/12COvhXhUvC9kd/7dOhhhY=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HV+p9UP1x/QX3HkhZq52hgGEisHzYlFK4W99rStJf9eAWMckZS0NNi9rb5EM3fhAt
	 sg7pg4owDfQVtGHDLjUp44LeoYzr8hGCSjqGRB1UOtcE9mnXExvVH/PZoVA+qldtJL
	 N7GYxNwnu7KcCOk7FkRAoXuLPBHbmv3e7qFR8Xyo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 41B2FF8014C;
	Fri,  7 Feb 2020 14:27:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CD98AF80277; Thu,  6 Feb 2020 21:03:57 +0100 (CET)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C6F3BF800C6
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2020 21:03:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6F3BF800C6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="cSVM7mzr"
Received: by mail-pj1-x1043.google.com with SMTP id d5so442586pjz.5
 for <alsa-devel@alsa-project.org>; Thu, 06 Feb 2020 12:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xYVWyJLdHXKTWIk8j2ax5kw5RYDuD9TSmcROhOEWoJY=;
 b=cSVM7mzrYFyCNF+Kj+lgqxPFSKNWXl/V/LgyeDPLBBYoUM7OExyLAOvUWCSMOuuRvo
 t8zJPHvOqgb38zvrGh7yLifD+VYwDdG354v/O7sB20y5JFNaVsbRfUytZJAIZ9fzvwI9
 ePizfuuQSkWj8nvqxP8p+Fz1Xkna+crztfOEIUPJg18NuJhiTtT4mJBmlpNp2hOfuFDA
 m3l3ds2kEE41h0UGptjSXZLjZt+SdhHfF6ZDcn4l6/ZUtEF8SUsLSqdnm4TJi2cTNnI5
 zgd6VmJy0AWCnh3E6AaNxlPl4E5iooSyPGOutDu0NebTuIinzGEqJkqaFSoHVU1wtyER
 VpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xYVWyJLdHXKTWIk8j2ax5kw5RYDuD9TSmcROhOEWoJY=;
 b=DbCw4yMFqUban7SGScyl2Sa80LJVufaFJ9Zu7tP1BS3FIrFV6rtT0HhnUIrAJTFhZZ
 vPVItCvaJ6M/ay8cCN5OxT+uCBPDTdxw4QI1Fb3i7e8XCIeqqNzbxdiQEWSQRdx7Cr99
 bzMsJET2GVlynJzWCxzHZx7P+WtFx7mAxYdn06ToMgpOS4UukAxRowOCGyyGveKRm/GJ
 gE0f33bE9curvTFt9K0utIt0atnT1/VXcgO4/iKrt97WwId96fVA5dUcy+1Ea12MKPN9
 gAzni6aGrT0bu5yjnfybKAgebft5Tj4IXyCgISR3AlYqzfBnEULEnJT8YT+Gfy1ugusO
 DtGA==
X-Gm-Message-State: APjAAAVvcnAqbIQfdXJpdW/vZo3Dhz1QP4gEpcTSjL8UJWUz6XZRBFN7
 9ar8D3Esro4I+K1l7SqFpJ4=
X-Google-Smtp-Source: APXvYqxbcoRpfgNMOZBFNsQv9nU1i+hjpBwVkZceeq8p0EIxs08l9j5FCvV9DFkQCfLaUFcHestELw==
X-Received: by 2002:a17:90a:fe02:: with SMTP id
 ck2mr6475995pjb.10.1581019431482; 
 Thu, 06 Feb 2020 12:03:51 -0800 (PST)
Received: from jiancai.svl.corp.google.com
 ([2620:15c:2ce:0:90af:5dee:afd9:7294])
 by smtp.googlemail.com with ESMTPSA id k29sm233056pfh.77.2020.02.06.12.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 12:03:50 -0800 (PST)
From: Jian Cai <caij2003@gmail.com>
To: 
Date: Thu,  6 Feb 2020 12:03:45 -0800
Message-Id: <20200206200345.175344-1-caij2003@gmail.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 07 Feb 2020 14:27:21 +0100
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>, caij2003@gmail.com
Subject: [alsa-devel] [PATCH] ASoC: soc-core: fix an uninitialized use
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

Fixed the uninitialized use of a signed integer variable ret in
soc_probe_component when all its definitions are not executed. This
caused  -ftrivial-auto-var-init=pattern to initialize the variable to
repeated 0xAA (i.e. a negative value) and triggered the following code
unintentionally.

err_probe:
	if (ret < 0)
		soc_cleanup_component(component);

Signed-off-by: Jian Cai <caij2003@gmail.com>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 068d809c349a..bfb813ba34f3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1180,7 +1180,7 @@ static int soc_probe_component(struct snd_soc_card *card,
 		snd_soc_component_get_dapm(component);
 	struct snd_soc_dai *dai;
 	int probed = 0;
-	int ret;
+	int ret = 0;
 
 	if (!strcmp(component->name, "snd-soc-dummy"))
 		return 0;
-- 
2.25.0.341.g760bfbb309-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
