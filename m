Return-Path: <SRS0=x+il=FL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5911DC4361B
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 08:48:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC550230F9
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Dec 2020 08:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC550230F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F07F174C;
	Mon,  7 Dec 2020 09:47:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F07F174C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607330897;
	bh=OXcWzKJWIoeGPLYbAZFAkfJ1mRq+HFaUDZndzZ44aK8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RLOtAHStXDkdi7VqzdEp0BuJE0VKWi1woPwBmhj0wMZNQFWy36iJMtHBlipIj+Pei
	 cK5fvABEihLxs3Xyo56ZklTdvY1Cdecps3C5Dh9kz9cIBhaUBkcrsvApzd/L/8nIIO
	 j7Mj8tO1+Ex6K7m00/XjWgL4dqgNVJC0+ocH8IsI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 548DCF80227;
	Mon,  7 Dec 2020 09:46:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 96DC1F8026A; Mon,  7 Dec 2020 09:46:33 +0100 (CET)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0AFFAF80227
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2020 09:46:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0AFFAF80227
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="sch1nJmJ"
Received: by mail-qt1-x843.google.com with SMTP id y15so1313186qtv.5
 for <alsa-devel@alsa-project.org>; Mon, 07 Dec 2020 00:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NpdyYEoACj40I4ZoU6WJldnVBTLBOwlyVOBQr8T4Kew=;
 b=sch1nJmJjyLcCpem9TYTDXeAaeeWlxQkuXNCbmblSiPHOtE4NfUqUpcQnUFZJZ/HpD
 kL/Ga9mPGlkojKYjTEqnEERK9cyf+PEsooGLU7l3bY4GVxeLAkIWpKfxxdfd4IPDVvPI
 ngORmXaOooXuleNyvRfEdNDeaQ2NTWXpAAz993L8+48hCcI5XAZ70IGVk9SFkBzjuJis
 tQf/XfsducGWaylpomokcaJIEsvd/fbw8IePOXDgkJVXJHDTGYLC3JDcy1aB0W/e4ojL
 HIzTq5IxkToB1DS1OeQ+jVWpkmypQM85jA5t5IblJIXckHwpfyleUX1IfL4e/Ordiz7G
 PlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NpdyYEoACj40I4ZoU6WJldnVBTLBOwlyVOBQr8T4Kew=;
 b=JiFx4lUMfi6oAKZDsKjDj6eJ2+qjJMQav7n3WFcL2H7tGotLhb8N5dDbqOD25C9Cyz
 wsUIurDoJbyFW7tQb6xuF5EtvHdYJAp9zoYbj04+phlJitDDL6zPoXN0K4KSBrF819Vr
 +q2pnSdM38WB4ryVGNu/HGD2cYDNvTboftgZq0+dT1GvjxLzHCcC985o294DXTJo4/Px
 Ufif8LyyrXPXdjoQt8DSmRF/N47/jAv6W96k52ON5OGWQOZQSeT326g30QrsHqKBTpcW
 KFKR6vCm5eA0t9bRZC6a2LcyaONleiMXN3spP9OZP1E4yxkvpeAyFxFZFeBKH8RQBXII
 3HdQ==
X-Gm-Message-State: AOAM531j3XjvA+lUcM1iizkOUyeacL9FnjkIMo4l1tlYjfnI6IlEB9Qc
 +A6HzHcmAIZPOLPyGFvn4ojojBdwnXc=
X-Google-Smtp-Source: ABdhPJzAJgTIZ1mMj6CcgI4tmLpV4ibh78NNHIWaZzz07FiegjSWTPIUJtrRnvEA7wX0rH1+LEpqKg==
X-Received: by 2002:ac8:1c92:: with SMTP id f18mr10045859qtl.319.1607330787050; 
 Mon, 07 Dec 2020 00:46:27 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com.
 [71.65.111.223])
 by smtp.googlemail.com with ESMTPSA id a9sm3424681qkk.39.2020.12.07.00.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Dec 2020 00:46:26 -0800 (PST)
From: Connor McAdams <conmanx360@gmail.com>
To: 
Subject: [PATCH 3/3] ALSA: hda/ca0132 - Unmute surround when speaker output is
 selected.
Date: Mon,  7 Dec 2020 03:46:15 -0500
Message-Id: <20201207084616.411531-3-conmanx360@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201207084616.411531-1-conmanx360@gmail.com>
References: <20201207084616.411531-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, conmanx360@gmail.com,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
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

Make sure GPIO pin for surround channel mute is set to 0 when speaker
output is selected.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 793dc5d501a5..6d647d461eab 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1390,7 +1390,7 @@ static const struct ca0132_alt_out_set_quirk_data quirk_out_set_data[] = {
 		  .has_hda_gpio     = false,
 		  .mmio_gpio_count  = 3,
 		  .mmio_gpio_pin    = { 2, 3, 5 },
-		  .mmio_gpio_set    = { 1, 1, 0 },
+		  .mmio_gpio_set    = { 1, 0, 0 },
 		  .scp_cmds_count   = 0,
 		  .has_chipio_write = false,
 		},
-- 
2.25.1

