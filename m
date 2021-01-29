Return-Path: <SRS0=iLk1=HA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ABCC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 15:40:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C892764DE9
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 15:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C892764DE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 63863169A;
	Fri, 29 Jan 2021 16:39:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 63863169A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611934821;
	bh=donZ+VCelZesukOHHig0GP3GsiKZtmd+5K8MQrnxzHY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EtYVuhiD/sg4Gu+jS0xO2O889qO0jwDy8qiaxAKiL+60PC5G5jXlMX7b64Gg9xQ1L
	 iAFKYdfcLMnPPmly1xSzTM8wcDw1pFnha5Mn8QQ4ffk7aeBObaNBboziNZeOumj+Wu
	 PSyLK9CfYJPoJgFhL/78OB2nd1W+KDeWM5eITzrc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E23CCF804EB;
	Fri, 29 Jan 2021 16:38:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2538CF804EB; Fri, 29 Jan 2021 16:38:28 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26B49F804E2
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 16:38:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26B49F804E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KUUTmj5z"
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE34664E33;
 Fri, 29 Jan 2021 15:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611934700;
 bh=donZ+VCelZesukOHHig0GP3GsiKZtmd+5K8MQrnxzHY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KUUTmj5zCMjN9+XXvDI3TZ2mj+vhiv92X8fTghKXsdwgPr2ktL5tNRyPs9sgT9E2u
 cvE3f56g9p8a+Q38C9jN2j2VAwKlYaH7ol1Ln0gh9zyAJlV1GqY3TEvLG1J7NyBkhf
 pn8QZkwBKX0MLrPs8G98lSsT74diQHDfWmbIukS/QVS/h0lVvMiCAb6D+qO4nMOwg2
 ZcILD3KZ+/VzXDpSmfzUPluUYwEyhrym+XYQz3WcQh1NI0YHDxMuad46IaKWaBxYJ6
 vR+acDp5kcCASa8y7FEv4DlOMRrghEZ6FqwE4kLyBCU/1kbn0zW9KjYy/J0mz4/nWa
 wwUY91NwuHWgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 11/19] ALSA: hda: Add Cometlake-R PCI ID
Date: Fri, 29 Jan 2021 10:37:58 -0500
Message-Id: <20210129153806.1592565-11-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210129153806.1592565-1-sashal@kernel.org>
References: <20210129153806.1592565-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
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

From: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>

[ Upstream commit f84d3a1ec375e46a55cc3ba85c04272b24bd3921 ]

Add HD Audio Device PCI ID for the Intel Cometlake-R platform

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
Link: https://lore.kernel.org/r/20210115031515.13100-1-kaichuan.hsieh@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 5f515a29668c8..b3667a5efdc1f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2450,6 +2450,9 @@ static const struct pci_device_id azx_ids[] = {
 	/* CometLake-S */
 	{ PCI_DEVICE(0x8086, 0xa3f0),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
+	/* CometLake-R */
+	{ PCI_DEVICE(0x8086, 0xf0c8),
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
 	/* Icelake */
 	{ PCI_DEVICE(0x8086, 0x34c8),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
-- 
2.27.0

