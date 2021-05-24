Return-Path: <SRS0=TLt2=KT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FD6C2B9F7
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 14:49:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C3C6144D
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 14:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C3C6144D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0AE55169E;
	Mon, 24 May 2021 16:49:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0AE55169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621867796;
	bh=A2WEoULKf3UGbZpFCnzA4fcaKOiqPYWyi3rwCwUC4BI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sxz486LIr15PNw4z5suykFVqIb9k1W/KWzIXBRk/isI8eUDIQ36ozDlDJRU5Y/oJu
	 rW2c6AnCnZoRMfehoss3isHdCi0FCU2ZGAVztmSYlp9VlI3ZbpN+BdeaUFKS4XGnh+
	 iuxboHd5t0cphnbw6CdfriLCMRj85p+UNBQ5Vrn8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9796DF804B0;
	Mon, 24 May 2021 16:47:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73F93F804AD; Mon, 24 May 2021 16:47:07 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22C8AF804A9
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 16:47:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22C8AF804A9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="suvWceqV"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06093613EA;
 Mon, 24 May 2021 14:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621867622;
 bh=A2WEoULKf3UGbZpFCnzA4fcaKOiqPYWyi3rwCwUC4BI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=suvWceqV2aFhDU3hLHGn4TPHdmNHNqyQ3vwjIBtjIg6BTdJVIMnOneDYX/i+eRgQB
 Lzg+mcR74TbecWuGc9bWFQPwUeqctDG1N/FQKWO87RphT70JqwffbgETkl5Mu0HJk8
 kopzp3xtxuRf9frkyFaBIcuclIMpvGbP0qVuay2LBQeOdXHpTBlQPnQCTwKVpxFrOF
 bQmjSMcUKRrRm9l+USASLnHwGRyU5NwmPndaM/O9UlkUe2sxMa5ovYx4CTNzpoi1Ni
 k5NvlG+Btn2GI8aPDJS+WP/F8q+l9CXtzv8CzKp/XGH3hZBJeD4NTvT6qY4Dw1nxHf
 p27OZonViaMkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 32/63] ASoC: cs43130: handle errors in
 cs43130_probe() properly
Date: Mon, 24 May 2021 10:45:49 -0400
Message-Id: <20210524144620.2497249-32-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210524144620.2497249-1-sashal@kernel.org>
References: <20210524144620.2497249-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit 2da441a6491d93eff8ffff523837fd621dc80389 ]

cs43130_probe() does not do any valid error checking of things it
initializes, OR what it does, it does not unwind properly if there are
errors.

Fix this up by moving the sysfs files to an attribute group so the
driver core will correctly add/remove them all at once and handle errors
with them, and correctly check for creating a new workqueue and
unwinding if that fails.

Cc: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20210503115736.2104747-58-gregkh@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs43130.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index c2b6f0ae6d57..80cd3ea0c157 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -1735,6 +1735,14 @@ static DEVICE_ATTR(hpload_dc_r, 0444, cs43130_show_dc_r, NULL);
 static DEVICE_ATTR(hpload_ac_l, 0444, cs43130_show_ac_l, NULL);
 static DEVICE_ATTR(hpload_ac_r, 0444, cs43130_show_ac_r, NULL);
 
+static struct attribute *hpload_attrs[] = {
+	&dev_attr_hpload_dc_l.attr,
+	&dev_attr_hpload_dc_r.attr,
+	&dev_attr_hpload_ac_l.attr,
+	&dev_attr_hpload_ac_r.attr,
+};
+ATTRIBUTE_GROUPS(hpload);
+
 static struct reg_sequence hp_en_cal_seq[] = {
 	{CS43130_INT_MASK_4, CS43130_INT_MASK_ALL},
 	{CS43130_HP_MEAS_LOAD_1, 0},
@@ -2302,23 +2310,15 @@ static int cs43130_probe(struct snd_soc_component *component)
 
 	cs43130->hpload_done = false;
 	if (cs43130->dc_meas) {
-		ret = device_create_file(component->dev, &dev_attr_hpload_dc_l);
-		if (ret < 0)
-			return ret;
-
-		ret = device_create_file(component->dev, &dev_attr_hpload_dc_r);
-		if (ret < 0)
-			return ret;
-
-		ret = device_create_file(component->dev, &dev_attr_hpload_ac_l);
-		if (ret < 0)
-			return ret;
-
-		ret = device_create_file(component->dev, &dev_attr_hpload_ac_r);
-		if (ret < 0)
+		ret = sysfs_create_groups(&component->dev->kobj, hpload_groups);
+		if (ret)
 			return ret;
 
 		cs43130->wq = create_singlethread_workqueue("cs43130_hp");
+		if (!cs43130->wq) {
+			sysfs_remove_groups(&component->dev->kobj, hpload_groups);
+			return -ENOMEM;
+		}
 		INIT_WORK(&cs43130->work, cs43130_imp_meas);
 	}
 
-- 
2.30.2

