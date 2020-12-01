Return-Path: <SRS0=HhIj=FF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03734C64E7A
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 13:25:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E4E207FF
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Dec 2020 13:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="APCK2jj3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bCh1RcV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E4E207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A50E1787;
	Tue,  1 Dec 2020 14:24:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A50E1787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606829105;
	bh=05IqQkYYtx7yVBkhV1sKnCol6I3wx97VPaj9k9sz9HQ=;
	h=Date:In-Reply-To:References:Subject:From:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=APCK2jj3B3vrkmkZCmGS3d6+nDsMfosUIaXZtNLMCOGffWCJtqunhpqJkx6h1gNI4
	 OB2JRfSaXx/VtIP73QZ/AiOc+6Qp093WRzMuS6ULuQwUrToVh/pb4lTzyxBTPcu4cX
	 Mc9ST/U7FYmy5ns5C9Dh2uDlg0kKx72V/f9KVFm4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 83345F804E6;
	Tue,  1 Dec 2020 14:22:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4D99F804E0; Tue,  1 Dec 2020 14:22:00 +0100 (CET)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7093F804CA
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2020 14:21:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7093F804CA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="bCh1RcV3"
Received: by mail-yb1-xb4a.google.com with SMTP id w8so2375632ybq.4
 for <alsa-devel@alsa-project.org>; Tue, 01 Dec 2020 05:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:in-reply-to:message-id:mime-version:references:subject
 :from:to:cc; bh=JYH8VKIBKyMDH0Ua+cEyxJiCIfU2UCkNUgqzQ0+FSHQ=;
 b=bCh1RcV3lkdSB+ESsNi2IjgeDqgqSwlR5wBpVzHp+VsAVK0SCPKuB8xPvGe8iEfohB
 P/A9kfWqY/4O7UuVuj/1TZ/C4fNdHQL8HFH2WvBLD7NR8/+39m2hegnuDthtmLyFXMuw
 dTJYeyud2vhV1QTgS98OSZwDqAZUMUvpTbCHsaJgEVn3eJznfA5yJRVvj9QoaujSmsbX
 jERSeMIPZt7AivGDIBum0sZ73+LmUyyLye4Kcgjgb1579zAabx+AAm8eJrj82B8TEm9Y
 bL7u7NLg2irgh2v7tzOc26yGy2a+/xv5IMYqYox/bvNOgrsC/J+U6HdouTrK/hXWi1n2
 4gZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=JYH8VKIBKyMDH0Ua+cEyxJiCIfU2UCkNUgqzQ0+FSHQ=;
 b=AWWRsavXvhTlDhORhQvLZ29eNlX93/QCtjEpuSvquDJQDxjOQ89cBLTkaYuzvBSifO
 hppRin5iT5Mh3frUlY1KeNyXn50Ihbi0t105ESgyIEujiUt9azUXq9vAElWeJtU0n3GD
 cIq812B14njIcPw9nzPwGI6jQmg4Fjl/MJUGhgKISPHYUhD9TpBeqEXj1n/45wUmqNrb
 0GWHbiikZX9I72lFCZ6SxFsQtXATAfMUv6ShUWdNT/i+qWzgr6eWf0MGG7Y21UpRejyA
 U8u569pYdAoIHyeYuJtI0IPBiBJOjycnFKHbazy7tEHfT+tRFb6uewD3fwCmWm2XIEhB
 fa+g==
X-Gm-Message-State: AOAM530BNzcaI9pohi7CSbZ5t7SMQEhrQrcSOBj8+C5dputDgI3Y2leU
 xqluLHX07z2jbQuLvckRtbgAiepNKBQE
X-Google-Smtp-Source: ABdhPJzHFhzDxNs1EtHKiNCBDwNBT3/Igi8dCG5KZOj6ziQ/PXkFbKcM79RhH4DrGPZWaQVgKUT/qgmTFdyr
X-Received: from tzungbi-z840.tpe.corp.google.com
 ([2401:fa00:1:b:725a:fff:fe41:c6a5])
 (user=tzungbi job=sendgmr) by 2002:a25:5689:: with SMTP id
 k131mr4997526ybb.257.1606828915829; Tue, 01 Dec 2020 05:21:55 -0800 (PST)
Date: Tue,  1 Dec 2020 21:21:25 +0800
In-Reply-To: <20201201132126.1676005-1-tzungbi@google.com>
Message-Id: <20201201132126.1676005-6-tzungbi@google.com>
Mime-Version: 1.0
References: <20201201132126.1676005-1-tzungbi@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 5/6] ASoC: dt-bindings: mt8192-mt6359: add new compatible for
 using rt1015p
From: Tzung-Bi Shih <tzungbi@google.com>
To: broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: tzungbi@google.com, alsa-devel@alsa-project.org
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

Adds new compatible string "mt8192_mt6359_rt1015p_rt5682" for machines
with rt1015p and rt5682.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 .../bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml           | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
index b336a42bbb16..bf8c8ba25009 100644
--- a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
@@ -15,7 +15,9 @@ description:
 
 properties:
   compatible:
-      const: mediatek,mt8192_mt6359_rt1015_rt5682
+    enum:
+      - mediatek,mt8192_mt6359_rt1015_rt5682
+      - mediatek,mt8192_mt6359_rt1015p_rt5682
 
   mediatek,platform:
     $ref: "/schemas/types.yaml#/definitions/phandle"
-- 
2.29.2.454.gaff20da3a2-goog

