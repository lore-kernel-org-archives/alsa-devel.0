Return-Path: <SRS0=3oRA=EQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B44C388F7
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 03:56:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE09121D91
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Nov 2020 03:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ntDzW3gH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPEBMhWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE09121D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A04B916CB;
	Tue, 10 Nov 2020 04:55:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A04B916CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604980561;
	bh=Rl2FmOKz3FhvTMwiGKfppdkVk2uGslV89dplTpWMBbw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ntDzW3gHJEk2rZC/N8O2G1sx351S9LI1YlbiZzZazXMtec+dz2s6sZxzRWalkj5jq
	 XGJjTzu6rFCF4+zUD1VUTA7eBvJZStI1M6FzWs/lFKnqBrfRkfryaP9rh05H6rf6vf
	 i/CmYxaU7VwX4vNZe2JtyVHcEpX86YMrn6HkTMc0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9260F804C2;
	Tue, 10 Nov 2020 04:53:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 915C9F802C4; Tue, 10 Nov 2020 04:53:35 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A315F801EB;
 Tue, 10 Nov 2020 04:53:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A315F801EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QPEBMhWE"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DBD2020870;
 Tue, 10 Nov 2020 03:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604980405;
 bh=Rl2FmOKz3FhvTMwiGKfppdkVk2uGslV89dplTpWMBbw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QPEBMhWEoez8HYeHPrKsTajmEGoYiwtdAnWHA6C9I5q8bGwIVYJl3uW8DL4g7SeEF
 OJgCiNWhSNZcrSNDCWlDctvohqTWsqIy+2ehrbkJdDe1NjG6sshgUAxL+DrfomuTsb
 jLNuVxyUKvIjaf+bTmTDD1SYMzbXXPS5by3L4Kvs=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.9 04/55] ASoC: SOF: loader: handle all SOF_IPC_EXT
 types
Date: Mon,  9 Nov 2020 22:52:27 -0500
Message-Id: <20201110035318.423757-4-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201110035318.423757-1-sashal@kernel.org>
References: <20201110035318.423757-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 sound-open-firmware@alsa-project.org
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

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 6e5329c6e6032cd997400b43b8299f607a61883e ]

Do not emit a warning for extended firmware header fields that are
not used by kernel. This creates unnecessary noise to kernel logs like:

sof-audio-pci 0000:00:1f.3: warning: unknown ext header type 3 size 0x1c
sof-audio-pci 0000:00:1f.3: warning: unknown ext header type 4 size 0x10

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://lore.kernel.org/r/20201021182419.1160391-1-kai.vehmanen@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/loader.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/sof/loader.c b/sound/soc/sof/loader.c
index b94fa5f5d4808..c90c3f3a3b3ee 100644
--- a/sound/soc/sof/loader.c
+++ b/sound/soc/sof/loader.c
@@ -118,6 +118,11 @@ int snd_sof_fw_parse_ext_data(struct snd_sof_dev *sdev, u32 bar, u32 offset)
 		case SOF_IPC_EXT_CC_INFO:
 			ret = get_cc_info(sdev, ext_hdr);
 			break;
+		case SOF_IPC_EXT_UNUSED:
+		case SOF_IPC_EXT_PROBE_INFO:
+		case SOF_IPC_EXT_USER_ABI_INFO:
+			/* They are supported but we don't do anything here */
+			break;
 		default:
 			dev_warn(sdev->dev, "warning: unknown ext header type %d size 0x%x\n",
 				 ext_hdr->type, ext_hdr->hdr.size);
-- 
2.27.0

