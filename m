Return-Path: <SRS0=30sX=ZH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2DDC432C3
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:54:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C7F2072D
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mW+xRcie";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq23hm2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C7F2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D0C7165F;
	Fri, 15 Nov 2019 17:53:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D0C7165F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573836860;
	bh=Z8XnqJrNVJv56cbiDpjidXyypBfAv0b62NKRe2jX3es=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mW+xRciednm3eXS7g8saLw1YSJsQHPzjCDb9ji+buJOSzVLE4ULfOFwTt2yeQp4ow
	 KhzvhcDDGSXf52mfv65IbEkvlvg8NopmRjdj+iwAS0j8uGEO931S+9dbVYY04x/Bq8
	 hjsZdWd3EPjU6HqDUvUvZhwR6iRar+RnCr44HKEE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E646F80132;
	Fri, 15 Nov 2019 17:51:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE1F2F80107; Fri, 15 Nov 2019 17:50:55 +0100 (CET)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66B85F80106
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2019 17:50:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66B85F80106
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="bq23hm2q"
Received: by mail-qv1-xf43.google.com with SMTP id q19so4014631qvs.5
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2019 08:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oO2VfC8qhxADPkDyDVx31uSOTMR49nkzK5iaws33oXY=;
 b=bq23hm2qPCoADVjFQxSIbYklRU8bnvJR6vE8sqzIyk0vWIQRX8WmKk1IluI+LV9KNi
 kaoO8ZwoAR2Lt2J2U7+pWJJoHMilaZ0CT/qe1RTZ+wc9d9ZbtLnf7WsAG/GFPX1ScRsF
 5F2vp3JNa5qIL6k0RYwbjCY9iHATdf8wt8a/Fh+a982yqjYJJfs8Hh0U6o2ymIrufKac
 Wu85aQFRe8mUY22VfzTjGni2wrXX/M4AM+ffyi8UxwqdpD1g8Ziyzvt+zcLG9auk7kYA
 MJqNFTsEeRELIZjGtu5vvtZHeSjrs8uKCFqwlLcGkEnPrekvc/UIPyN/p9Uuq1Uc9Gr6
 rdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oO2VfC8qhxADPkDyDVx31uSOTMR49nkzK5iaws33oXY=;
 b=eYV8yjxTDbxlw7GnmKja3t1+4zhc7n677axC9Y/ebtBGS8vpkbcfBgweBB6YYMeWEd
 qHrUufs6DZwO+zJFs8EmQehqnfVI5u5fkZyCoegtPUtuszteg1JIDIsMVj/T2FPFve8O
 z+OC5OL20fMj4d0qT2yjUTZWhjmz0IOTQ/4ykCLYRTkF0MF8zYjhKBhqpZ0oxIfP7A0l
 QyEYcGAKwAYaPDMSWbNIvAm7Bsmt+WOgGGvOvPn4EHFW0uzH7g6CbFeVfZumIukBJ9eI
 2WNAg7yWdNWJNTl2783QkZHEVB/yiu5mTaXMOHdEzn3g+DoLagR9+V25SOISDRnD5uPP
 VaHg==
X-Gm-Message-State: APjAAAUuiPmM2i06TPFedp8mZQUmDlqBbhGFAFr3lnXswZvrrWT/VZjI
 ZZnN8EquQSDrztz39bbawpM=
X-Google-Smtp-Source: APXvYqwym8WcQSfdzXEn9QA+9uo60hF+W0BRETn6JImdbqpPfgbUVJzW+sFkUw2mrm8ZoW5g9UQ9Iw==
X-Received: by 2002:a0c:cd8b:: with SMTP id v11mr14436226qvm.66.1573836650183; 
 Fri, 15 Nov 2019 08:50:50 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id r29sm5610331qtb.63.2019.11.15.08.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:50:49 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Date: Fri, 15 Nov 2019 11:50:21 -0500
Message-Id: <20191115165038.56646-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115165038.56646-1-alexander.deucher@amd.com>
References: <20191115165038.56646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Subject: [alsa-devel] [PATCH 03/20] drm/amdgpu: add supports_baco callback
	for SI asics.
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

BACO - Bus Active, Chip Off

Not supported.

Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 29024e64c886..cb682d44737a 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1197,6 +1197,11 @@ static int si_asic_reset(struct amdgpu_device *adev)
 	return 0;
 }
 
+static bool si_asic_supports_baco(struct amdgpu_device *adev)
+{
+	return false;
+}
+
 static enum amd_reset_method
 si_asic_reset_method(struct amdgpu_device *adev)
 {
@@ -1425,6 +1430,7 @@ static const struct amdgpu_asic_funcs si_asic_funcs =
 	.get_pcie_usage = &si_get_pcie_usage,
 	.need_reset_on_init = &si_need_reset_on_init,
 	.get_pcie_replay_count = &si_get_pcie_replay_count,
+	.supports_baco = &si_asic_supports_baco,
 };
 
 static uint32_t si_get_rev_id(struct amdgpu_device *adev)
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
