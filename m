Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0008C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Nov 2022 12:43:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CBE4E1654;
	Wed, 23 Nov 2022 13:42:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CBE4E1654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669207394;
	bh=ZBzGAWl3jAjXsuaAxqAReEc8x1UE2t/I3rQ6tqO6rrM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cCemZ4My9X616ps/Eq5Y1bfdXy/oBlHmR/4IJUH7ZQXevYcR23dYVWEjJ866Nu6zT
	 tgYCQA+1YDyTfDp+VO94wv0EMjLSaNUdbHJrtSponPScg4bjEBW+giyuBwGhsBz65j
	 gBHfCKUq7cAPXUDmdyY9Q1hCgIxrcvMC/QVRCupk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74521F8055C;
	Wed, 23 Nov 2022 13:41:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30D82F8055C; Wed, 23 Nov 2022 13:41:25 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8D15F80542
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2022 13:41:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8D15F80542
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="k/DlsTxj"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AA7A561C81;
 Wed, 23 Nov 2022 12:41:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBA5C433C1;
 Wed, 23 Nov 2022 12:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669207276;
 bh=ZBzGAWl3jAjXsuaAxqAReEc8x1UE2t/I3rQ6tqO6rrM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k/DlsTxjvoVBJh8bNJs28kpijyygJr0lhI3xljKKeQVzJV499aze9+E+7dw4xteIB
 /2jQlpALQUiabrbROxzFoeA96EDnl8WIDSdR7kNXUJfNrPMBnBxR7efMiEAqky21rn
 qolU3MDPrW+ECQnB8y83bXa7T5fyjaxSZ9nY9lo/CjLx9AwJB9Xz8j/Dias8prUv7c
 TMWYVHRbc42aFFPj7nW6fNpwgfcz2zgBQIEWS6JmciKB/wLgkqCvsKFrZILZcx6Vmn
 1UnMeAcerxZIz6jbq96QA/6v9unuHsMVUlZXYJTJ55rSmCP4NQrv5qIm+QXTKbaDpa
 IlmYx1zrn1sAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.0 07/44] ASoC: hda: intel-dsp-config: add ES83x6
 quirk for IceLake
Date: Wed, 23 Nov 2022 07:40:16 -0500
Message-Id: <20221123124057.264822-7-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221123124057.264822-1-sashal@kernel.org>
References: <20221123124057.264822-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 kai.vehmanen@linux.intel.com, Takashi Iwai <tiwai@suse.de>,
 gongjun.song@intel.com, tiwai@suse.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, muralidhar.reddy@intel.com,
 amadeuszx.slawinski@linux.intel.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>, brent.lu@intel.com
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 5d73263f9e7c54ccb20814dc50809b9deb9e2bc7 ]

Yet another hardware variant we need to handle.

Link: https://github.com/thesofproject/linux/issues/3873
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20221031195639.250062-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/intel-dsp-config.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index b9eb3208f288..ae31bb127594 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -320,6 +320,11 @@ static const struct config_entry config_table[] = {
 			{}
 		}
 	},
+	{
+		.flags = FLAG_SOF,
+		.device = 0x34c8,
+		.codec_hid =  &essx_83x6,
+	},
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = 0x34c8,
-- 
2.35.1

