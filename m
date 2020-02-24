Return-Path: <SRS0=BBoH=4M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09E8C35671
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 13:52:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C1BF20836
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 13:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tEXV0oNA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LEA3mgsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1BF20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8218782E;
	Mon, 24 Feb 2020 14:51:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8218782E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582552350;
	bh=gCO62gZOXqlB1Ijv5sjID0iHH8ewenDro5vImslll60=;
	h=From:To:Subject:Date:References:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=tEXV0oNA0gHBqu7Tp4x+dRwGBNrg2xMd0z7bnr3CVVdlxqNnXk0EN0nmIyYdlNnnG
	 gvzGt/wiAm97ABAmBYpJ2VByPWfvo1l7sDsuZXs3xHLsM0zYVPl99ZPVoeqUJiiqzl
	 /yTRfQ9U8jxJwwHLCoOzG6Cv6FiplXZqdYmZOASY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E07B4F8014D;
	Mon, 24 Feb 2020 14:51:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B2D7F8014E; Mon, 24 Feb 2020 14:51:38 +0100 (CET)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D53BFF80137
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 14:51:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D53BFF80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com
 header.b="LEA3mgsi"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200224135133euoutp013fde8194cda4baaec7219ef905b6febe~2Wu0Fd1Zp0466804668euoutp01B
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 13:51:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200224135133euoutp013fde8194cda4baaec7219ef905b6febe~2Wu0Fd1Zp0466804668euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1582552293;
 bh=EzeGv53Ui4L1MziFSWesdry8RRpPQMeyYmWPuFhfIA0=;
 h=From:To:Cc:Subject:Date:References:From;
 b=LEA3mgsis/be8V9IuHN5/2l5fTpTkoF6KnpTVldxVhFqBqkvLa+SbIc5ewOWXYMqp
 6xdcjV6rkx9+TyK1p3V/5EfkokYqzZEMsxURrwXeYJzmurMCHgh+DelliZy3/lV0Pc
 +NO9IT55lo3iP9//CzK1OZT0xEbAUf5so3BwMqvs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200224135132eucas1p27fc7695f55c0537660d0142c827ddff8~2Wuz2S5Ol2987629876eucas1p2u;
 Mon, 24 Feb 2020 13:51:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 23.82.60679.4E4D35E5; Mon, 24
 Feb 2020 13:51:32 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200224135132eucas1p22bb497f3d77452c531dc3d6658d26ff3~2WuzfFB__2993529935eucas1p28;
 Mon, 24 Feb 2020 13:51:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200224135132eusmtrp18acc57360217780c55163a2266331ebd~2WuzedBm23154231542eusmtrp1F;
 Mon, 24 Feb 2020 13:51:32 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-80-5e53d4e45c8f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id F7.6F.08375.4E4D35E5; Mon, 24
 Feb 2020 13:51:32 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200224135132eusmtip1c1375166c17b8ebafe9fa03189b1ca7e~2WuzHqWAT0548905489eusmtip1y;
 Mon, 24 Feb 2020 13:51:32 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mfd: wm8994: Fix driver operation if loaded as modules
Date: Mon, 24 Feb 2020 14:51:22 +0100
Message-Id: <20200224135123.27301-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7djP87pPrgTHGZxq0LW4cvEQk8XGGetZ
 LaY+fMJmcf/rUUaLy7vmsFmsPXKX3eLwm3ZWB3aPDZ+b2Dw2repk87hzbQ+bR9+WVYwenzfJ
 BbBGcdmkpOZklqUW6dslcGXse36QreAiV8WeE/tZGxifcXQxcnJICJhIdEyfy9LFyMUhJLCC
 UWLHvXdsEM4XRomHJx6yQzifGSW2TlvKCtPybucpZojEckaJiw8bGOFaZu5fwQ5SxSZgKNH1
 tosNxBYRsJV4vaMBbAmzwE2gJXf6gBwODmEBb4mLlxRBTBYBVYmv61lAynmByn/92MoIsUxe
 YvWGA2DLJASus0lceXyaBSLhIjF7+wooW1ji1fEt7BC2jMTpyT0sEA3NQD+cW8sO4fQwSlxu
 mgE11lrizrlfbCCbmQU0Jdbv0ocIO0o0z/3PDhKWEOCTuPFWECTMDGRO2jadGSLMK9HRJgRR
 rSYx6/g6uLUHL1xihrA9JDq2PwAHlpBArETHuu9MExjlZiHsWsDIuIpRPLW0ODc9tdgoL7Vc
 rzgxt7g0L10vOT93EyMwGZz+d/zLDsZdf5IOMQpwMCrx8ErsDY4TYk0sK67MPcQowcGsJMLr
 zRgUJ8SbklhZlVqUH19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVANjxe41
 P5+p/eP/XfRxymy7J3M28aw0EfU/dcqj92rR9bSOhIAZzXYXLS2uH2HcszXKeWdnjLjVpB4p
 Xd57LgxHSg6lL6s69Cxpa6hX4osFSVmO5j38+W+/zmh7sqdmWu+j3H+l/feCEw27WW5/XL5Q
 ydczyq0gg/8zz2S12mnbP9RorqzbaCmsxFKckWioxVxUnAgAuhwRtwIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsVy+t/xu7pPrgTHGfTulLS4cvEQk8XGGetZ
 LaY+fMJmcf/rUUaLy7vmsFmsPXKX3eLwm3ZWB3aPDZ+b2Dw2repk87hzbQ+bR9+WVYwenzfJ
 BbBG6dkU5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GXs
 e36QreAiV8WeE/tZGxifcXQxcnJICJhIvNt5irmLkYtDSGApo8T7bwfZIRIyEienNbBC2MIS
 f651sUEUfWKUuHLvBSNIgk3AUKLrLUiCk0NEwF7iwa9/YDazwF2gotd+XYwcHMIC3hIXLymC
 mCwCqhJf17OAVPAK2Er8+rGVEWK8vMTqDQeYJzDyLGBkWMUoklpanJueW2yoV5yYW1yal66X
 nJ+7iREYgNuO/dy8g/HSxuBDjAIcjEo8vBJ7g+OEWBPLiitzDzFKcDArifB6MwbFCfGmJFZW
 pRblxxeV5qQWH2I0Bdo9kVlKNDkfGB15JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNT
 UwtSi2D6mDg4pRoYZXWi8vm938veWCzDWKvGPjdAa032zbmeUut3f/IIKJxQqVtwQ/LDvjmT
 r9a3X36hG/vlmf6sWayPj326V/1Z5mjj2Xfh9qUWq3YHb3qW5HjP8+D5+MYln+MsBHb6ym1p
 MLSpPPtIyMW4bIbSlnqu4iaVgFxf1obE8woeh0xPvyyY7SnPlCqvxFKckWioxVxUnAgA13rj
 AlYCAAA=
X-CMS-MailID: 20200224135132eucas1p22bb497f3d77452c531dc3d6658d26ff3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200224135132eucas1p22bb497f3d77452c531dc3d6658d26ff3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200224135132eucas1p22bb497f3d77452c531dc3d6658d26ff3
References: <CGME20200224135132eucas1p22bb497f3d77452c531dc3d6658d26ff3@eucas1p2.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
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

WM8994 chip has built-in regulators, which might be used for chip
operation. They are controlled by a separate wm8994-regulator driver,
which should be loaded before this driver calls regulator_get(), because
that driver also provides consumer-supply mapping for the them. If that
driver is not yet loaded, regulator core substitute them with dummy
regulator, what breaks chip operation, because the built-in regulators are
never enabled. Fix this by adding a comment and a call to module_request()
helper.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mfd/wm8994-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 1e9fe7d92597..f15f12d8bccc 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -321,6 +321,13 @@ static int wm8994_device_init(struct wm8994 *wm8994, int irq)
 	int ret, i, patch_regs = 0;
 	int pulls = 0;
 
+	/*
+	 * Request a driver for built-in regulators first, because they are
+	 * default supplies for "AVDD1" and "DCVDD". Otherwise, getting them
+	 * fails due to lack of consumer mapping defined by that driver.
+	 */
+	request_module("wm8994_regulator");
+
 	if (dev_get_platdata(wm8994->dev)) {
 		pdata = dev_get_platdata(wm8994->dev);
 		wm8994->pdata = *pdata;
-- 
2.17.1

