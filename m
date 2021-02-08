Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3C6C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 12:03:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C7664E60
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 12:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C7664E60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 02A59167A;
	Mon,  8 Feb 2021 13:02:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 02A59167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612785783;
	bh=/fow4WzTNyRj37UrEYakhzILHVjGuRgb6Kr6YGudMl8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rZaK1VjdMqOWMrieySTGLvNV4OAnKlW41UOqBVTgYtFzlMLnyRdfR8WDEvZjdUmTL
	 W+ErR5yIcZHdX/vAb2MU3jQi3jmhtMUpaiVkedQa3bosT56kdvHnuKcTO16w5P+Gz9
	 ZhHxG81tHfxvnAvn2XMOFHwKgUlNviTuElUNEQcU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C33AF80240;
	Mon,  8 Feb 2021 13:01:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 246EDF80169; Mon,  8 Feb 2021 13:01:20 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A0EEF8013A
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2021 13:01:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A0EEF8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="K16cTG+3"
Received: by mail-lf1-x12c.google.com with SMTP id a12so21855340lfb.1
 for <alsa-devel@alsa-project.org>; Mon, 08 Feb 2021 04:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z8kzQS3YPM948wmJnc1Eek6a7lxZy6M65U4pTGtlXO4=;
 b=K16cTG+3k/StGHXC+r8CudIYqXvQ0vkKMMdiq29IfUfaGg5WhQFHyz4MzmcDyypSn0
 dOnPM3izORupsA2vtRW17fDlQ/+X1nMm+/cdwhThC5IIKYEwZdgitpP/GjqX9corVK4F
 kq4X04HsoKT8ridfCeLaIEJta6gMCjRwChzNmFIUPUnTjzQe5LaobNnT4NWqppHgyPsF
 Jgj2NEIaH9mmWF51zRlCqYoS54L26cpuC1I/wL0quD2Vy+gm0AqQCBo8RQb5oUOOLZXb
 Cw82CsWLa/rCox+AwQ0Sg38mab0nI6CxFImAlWUfOTlKxGS1D+ZLNi0/S0VrBICofb5V
 CQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z8kzQS3YPM948wmJnc1Eek6a7lxZy6M65U4pTGtlXO4=;
 b=OLiYS/QYfMOmIaxBdOysVJOIc5mAeDl8A/WKZQ4U92md0yP3E/hNM7vUktjGAn+X83
 3waEER64g4Cgp+5sCtEcmBo7SS5djMJ5Y6r7sx4HnTKg+EnY+YHP+YF+eQDm2NZfjdlK
 H2UjhgdWHDWh0+yo9W4qMO49VSGG7DXdPFLq2qLZEYpYE66qX+gazY5e/U8YdEXBUuiZ
 je4Aa66x1hlmdS8KneqcIhUO59HgXPsuuN1fqgcx9WbWYy+JgK9LzJRLAw/7HQmnP2jf
 4dLGl14KuHnAZWR1z/OCZv3gINwaGSIBcaG7xQRjvNtbtnEoPF7A07D9RgZPCf1fFVsz
 Oy/g==
X-Gm-Message-State: AOAM532ys9Yntk0JgDvlBRS/sbsBoSzz2R3Mwee/7BKgGvEXEj6U37wD
 UdqyI0sWN43Nn0Ug/kRdZVOacxS/lZLKKQ==
X-Google-Smtp-Source: ABdhPJzgXV3dE/YmpoPEhiHF1uxHkm2TbQ7iUL71H1BPo2N7lyBpNUlX3j1SnYiRc4hPM1t1ngZr3A==
X-Received: by 2002:ac2:4e8a:: with SMTP id o10mr10273956lfr.656.1612785672291; 
 Mon, 08 Feb 2021 04:01:12 -0800 (PST)
Received: from localhost.localdomain (109241203030.gdansk.vectranet.pl.
 [109.241.203.30])
 by smtp.gmail.com with ESMTPSA id t15sm719086lft.239.2021.02.08.04.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Feb 2021 04:01:11 -0800 (PST)
From: =?UTF-8?q?Marcin=20=C5=9Alusarz?= <marcin.slusarz@gmail.com>
To: alsa-devel@alsa-project.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] ACPICA: update documentation of acpi_walk_namespace
Date: Mon,  8 Feb 2021 13:01:04 +0100
Message-Id: <20210208120104.204761-2-marcin.slusarz@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210208120104.204761-1-marcin.slusarz@gmail.com>
References: <a3f01a5d-d7a5-8280-4091-b2486b01a782@linux.intel.com>
 <20210208120104.204761-1-marcin.slusarz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: marcin.slusarz@intel.com, Salvatore Bonaccorso <carnil@debian.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
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

From: Marcin Ślusarz <marcin.slusarz@intel.com>

Signed-off-by: Marcin Ślusarz <marcin.slusarz@intel.com>
---
 drivers/acpi/acpica/nsxfeval.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index f9d059647cc5..7149c8f70a6e 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -532,8 +532,8 @@ static void acpi_ns_resolve_references(struct acpi_evaluate_info *info)
  *              return_value        - Location where return value of
  *                                    user_function is put if terminated early
  *
- * RETURNS      Return value from the user_function if terminated early.
- *              Otherwise, returns NULL.
+ * RETURNS      Returns status from the callback function if terminated early.
+ *              Otherwise, returns a status of the walk, AE_OK if succeeded.
  *
  * DESCRIPTION: Performs a modified depth-first walk of the namespace tree,
  *              starting (and ending) at the object specified by start_handle.
@@ -542,6 +542,11 @@ static void acpi_ns_resolve_references(struct acpi_evaluate_info *info)
  *              a non-zero value, the search is terminated immediately and this
  *              value is returned to the caller.
  *
+ *              Note that both the callback functions and the walk itself
+ *              use overlapping return values (e.g. AE_OK), so user of this
+ *              function can't rely only on the return value to tell if
+ *              the callback function was called.
+ *
  *              The point of this procedure is to provide a generic namespace
  *              walk routine that can be called from multiple places to
  *              provide multiple services; the callback function(s) can be
-- 
2.25.1

