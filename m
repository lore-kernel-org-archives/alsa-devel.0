Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C997C4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Nov 2022 12:45:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3ED71672;
	Wed, 23 Nov 2022 13:44:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3ED71672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669207543;
	bh=L9r4kjJsiW5M3NLw6MrsVcUMzqrSzh2vWjRZgkrCBiM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=upU0/p3NAGdMjzoH0N7Pd8HsYjBvZJ4ZNsbSB9lZ/0oQMvgelNONb+GHlod87i5C4
	 SCl+68r1wjCPy00BQ1okGUS5znmgMuyjkE7V7deL8bwZMrvrW5ZUhrs/+Q8Qp7gsjV
	 l0w3PPr2Mvv1EUW7gTnisoulLxxC9/WYiLXRXGXI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E0262F80566;
	Wed, 23 Nov 2022 13:44:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1DC89F80566; Wed, 23 Nov 2022 13:44:01 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CA55CF80566
 for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2022 13:43:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CA55CF80566
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="t0EXdee+"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8668961C64;
 Wed, 23 Nov 2022 12:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D694EC433C1;
 Wed, 23 Nov 2022 12:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669207432;
 bh=L9r4kjJsiW5M3NLw6MrsVcUMzqrSzh2vWjRZgkrCBiM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=t0EXdee+/J7ZQnPZhlTX3MZwpXKy+nqcOLEg7R2qIisCnj9tKWeqsRd5AUclipYmW
 drL3Udwu7J3fzTTzX7GQ0/GjdwuKa86DKQgmxjpFNS4EQN8qBFL0yFHftCOJFgRqpp
 aTdOT4gV7MPz2eiQ95xAiieEwqZE0kWdud6JvOu+WogRXB4NU0rQv9VfMJcLrMd7l7
 C5wRyB+KSY/9OZ4e9KdnvIYmWCwA8hmlnMPd6OBme3ohAQSA6Cfm4PxzLbKoLx/JTU
 NR0CRcbJLiYVZ08wncy+VhWvtHHZpbgg0kbd9D69FcPc/l6pNzO0A9omE3IKTFiMyA
 D1my+IkIi2aUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 04/22] ASoC: hda: intel-dsp-config: add ES83x6
 quirk for IceLake
Date: Wed, 23 Nov 2022 07:43:19 -0500
Message-Id: <20221123124339.265912-4-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221123124339.265912-1-sashal@kernel.org>
References: <20221123124339.265912-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 kai.vehmanen@linux.intel.com, Takashi Iwai <tiwai@suse.de>,
 gongjun.song@intel.com, tiwai@suse.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, muralidhar.reddy@intel.com,
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
index 2a5ba9dca6b0..7fd5c819ec36 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -302,6 +302,11 @@ static const struct config_entry config_table[] = {
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

