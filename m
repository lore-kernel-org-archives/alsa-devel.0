Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCDCC77B76
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Apr 2023 11:06:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 97FFAEDD;
	Thu, 20 Apr 2023 13:05:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 97FFAEDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681988783;
	bh=FxSpL+k7mWLJ/yG1GbUE51+sbJSmAkqDaYqGJUi2tiY=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qDCwDQ4eWoxHxZnYmWVhGsyjk4fvdGHIr1LXXIEyrHX5n9GWvJ1bBPCg7NZxFX81f
	 lw+5xrmGunEw6kXXA30v7ut5xTWbps4vd6PHg7zyaDnNLE/uQ5MWcGAl1+egvybfHR
	 7K3ZF7rcA4JqKxdUIFHAVt1SprndO4JTct+/E6cI=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D9E0F805AA;
	Thu, 20 Apr 2023 13:03:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8BFE7F805A9; Thu, 20 Apr 2023 13:02:58 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 19C42F8057D
	for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2023 13:02:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19C42F8057D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Pn7MpPoM
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EE090647B4;
	Thu, 20 Apr 2023 11:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD7FC4339B;
	Thu, 20 Apr 2023 11:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681988574;
	bh=FxSpL+k7mWLJ/yG1GbUE51+sbJSmAkqDaYqGJUi2tiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pn7MpPoMNANqjG+LlzCNnDHE36SoPBzNM0qQbj9axollLrIZoWzZIdCV4vAVh/yb8
	 wSjr5Oi0wXdcNtBYxkdDXWdISpSMuK1IZLiTp0c3dOWyCdo7hSKFGwsR1+PnsN4gjx
	 y+Didaz8eFgPSJ1FbniBf9V/wolDckHCRidusxk3cGwPqW0A5RN1Iaowq5Hs1v4q+l
	 J+dyVG8dicdUKlZwL/HRjCghBjt2VBIF2OcRFkU6c7TfXd8q5akIWB9xpLnUHKxCZz
	 yssqkR94tKEHTYbKH5da/VxcEZ7NEdSu1ZtqT/27KVcM4AtEOuYN4EvnwTW8urO93r
	 twRPdr+6eWxEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 08/15] ASoC: da7213.c: add missing
 pm_runtime_disable()
Date: Thu, 20 Apr 2023 07:02:22 -0400
Message-Id: <20230420110231.505992-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420110231.505992-1-sashal@kernel.org>
References: <20230420110231.505992-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Message-ID-Hash: GHOZSTZMUI5WVVG3SCBVPFB2UE2E5N7M
X-Message-ID-Hash: GHOZSTZMUI5WVVG3SCBVPFB2UE2E5N7M
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Duy Nguyen <duy.nguyen.rh@renesas.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Khanh Le <khanh.le.xr@renesas.com>, Mark Brown <broonie@kernel.org>,
 Sasha Levin <sashal@kernel.org>, support.opensource@diasemi.com,
 lgirdwood@gmail.com, tiwai@suse.com, alsa-devel@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GHOZSTZMUI5WVVG3SCBVPFB2UE2E5N7M/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Duy Nguyen <duy.nguyen.rh@renesas.com>

[ Upstream commit 44378cd113e5f15bb0a89f5ac5a0e687b52feb90 ]

da7213.c is missing pm_runtime_disable(), thus we will get
below error when rmmod -> insmod.

	$ rmmod  snd-soc-da7213.ko
	$ insmod snd-soc-da7213.ko
	da7213 0-001a: Unbalanced pm_runtime_enable!"

[Kuninori adjusted to latest upstream]

Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Khanh Le <khanh.le.xr@renesas.com>
Link: https://lore.kernel.org/r/87mt3xg2tk.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/da7213.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 544ccbcfc8844..5678683c71bee 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1996,6 +1996,11 @@ static int da7213_i2c_probe(struct i2c_client *i2c)
 	return ret;
 }
 
+static void da7213_i2c_remove(struct i2c_client *i2c)
+{
+	pm_runtime_disable(&i2c->dev);
+}
+
 static int __maybe_unused da7213_runtime_suspend(struct device *dev)
 {
 	struct da7213_priv *da7213 = dev_get_drvdata(dev);
@@ -2039,6 +2044,7 @@ static struct i2c_driver da7213_i2c_driver = {
 		.pm = &da7213_pm,
 	},
 	.probe_new	= da7213_i2c_probe,
+	.remove		= da7213_i2c_remove,
 	.id_table	= da7213_i2c_id,
 };
 
-- 
2.39.2

