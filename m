Return-Path: <SRS0=+Hcd=CD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112C2C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 05:27:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FCD620706
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2020 05:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pOyRrOVh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Kc7jwu05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCD620706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 288541689;
	Tue, 25 Aug 2020 07:26:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 288541689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598333235;
	bh=iKo3IAGGJK6KjDfpaY/VYjfFIt9Mk8dJII+i+B8JoNc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pOyRrOVhc7q6GEE+DFirxaQfR0OYonJ+Wm0DjkC+4h8DK6p6JvmNdvPUEMJMAnM7w
	 tU1naY1sAcEk81bUr1dlRgvRkP6AG9JAsbrZsQl4e0aZwHr1aqLXDS/LDIe0cuEAef
	 1ZsbwxfL/a4Wo1YYa4nJZ3QKkk+lBzujddJMFFQk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 81D56F8028A;
	Tue, 25 Aug 2020 07:24:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D11ACF802BC; Tue, 25 Aug 2020 07:24:46 +0200 (CEST)
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 47F9CF80245
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2020 07:24:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47F9CF80245
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="Kc7jwu05"
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5f44a0510000>; Mon, 24 Aug 2020 22:23:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Mon, 24 Aug 2020 22:24:31 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Mon, 24 Aug 2020 22:24:31 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 05:24:30 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 25 Aug 2020 05:24:30 +0000
Received: from mkumard.nvidia.com (Not Verified[10.24.34.162]) by
 hqnvemgw03.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5f44a08c0002>; Mon, 24 Aug 2020 22:24:30 -0700
From: Mohan Kumar <mkumard@nvidia.com>
To: <tiwai@suse.com>, <aplattner@nvidia.com>, <spujar@nvidia.com>
Subject: [PATCH 1/2] ALSA: hda: Fix 2 channel swapping for Tegra
Date: Tue, 25 Aug 2020 10:54:14 +0530
Message-ID: <20200825052415.20626-2-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825052415.20626-1-mkumard@nvidia.com>
References: <20200825052415.20626-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1598333009; bh=a5QUmoqtIdKI1HCFjXoyAjuO2g0uZRGOpFekUri+6Uo=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Type;
 b=Kc7jwu05vAO5eUQTavB+uV/tcJuuROZvTEvr85O0yZCbd+ipdmPBh9Sap3ikj8mvF
 2PXzV9jocAPzg2h+KrGp38++dU2b8KXu2BdLOpqdGKUmApx1aRqeeJlgofJoEaKd0W
 69Vwb+lbjw115eFCyOWFHRNY/L3OAJ9h4uVbIT6IWlkdDbyIU1FfE/kpccxGgzQxKP
 q5G6pkK8RqHCnBE7BZK9qYtVkb4kbMoTHwJs5tWJu1RSI8BPvBet1x6hp2Y1u1Boa0
 ZaPa1YoVUQygaA2c+dmrquL4/xI50vL0vRjpie0LNL03VNS494+HhJUpy4VdrAqPNv
 XMRDmW1qWy9pw==
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 treding@nvidia.com, Mohan Kumar <mkumard@nvidia.com>, jonathanh@nvidia.com
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

The Tegra HDA codec HW implementation has an issue related to not
swapping the 2 channel Audio Sample Packet(ASP) channel mapping.
Whatever the FL and FR mapping specified the left channel always
comes out of left speaker and right channel on right speaker. So
add condition to disallow the swapping of FL,FR during the playback.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 sound/pci/hda/patch_hdmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index b8c8490e568b..3259d713ace9 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -3734,6 +3734,7 @@ static int tegra_hdmi_build_pcms(struct hda_codec *codec)
 
 static int patch_tegra_hdmi(struct hda_codec *codec)
 {
+	struct hdmi_spec *spec;
 	int err;
 
 	err = patch_generic_hdmi(codec);
@@ -3741,6 +3742,10 @@ static int patch_tegra_hdmi(struct hda_codec *codec)
 		return err;
 
 	codec->patch_ops.build_pcms = tegra_hdmi_build_pcms;
+	spec = codec->spec;
+	spec->chmap.ops.chmap_cea_alloc_validate_get_type =
+		nvhdmi_chmap_cea_alloc_validate_get_type;
+	spec->chmap.ops.chmap_validate = nvhdmi_chmap_validate;
 
 	return 0;
 }
-- 
2.17.1

