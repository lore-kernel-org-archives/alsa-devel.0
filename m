Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D995C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 30 May 2022 13:44:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C315C1EF1;
	Mon, 30 May 2022 15:43:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C315C1EF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653918280;
	bh=lCKe4ucTRzZZVHOi/79ZSIpq7eiSisbTI1Mxo7eA1Xo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IRyIq+gYKYb2EFnCowe6IxdSF7dbeINLcn0JwaVdRmSnaXd/HSoZA3UcrVKefsoHZ
	 u/1Kz5xbUmP4syGdQhGF+8/hNnyHN7nEKwyyDgiShOfMJ2X934cO+SjtmQC5lQc4RW
	 PMu4fJJC/plO8rEpxDKltJxS3s1N0Dq5i1aGEEho=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 69434F8051E;
	Mon, 30 May 2022 15:43:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C9352F8051D; Mon, 30 May 2022 15:43:33 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 645A0F80240
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2022 15:43:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 645A0F80240
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uv7jecdj"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E3D59B80DA7;
 Mon, 30 May 2022 13:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D81DC385B8;
 Mon, 30 May 2022 13:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653918209;
 bh=lCKe4ucTRzZZVHOi/79ZSIpq7eiSisbTI1Mxo7eA1Xo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uv7jecdjcjvjvAQmYvCM0U5NYss5erIY4aZGPqrs2f2zr7zHGPnHSsuHryTN1Y43O
 W3YKb4du7bqSQdVxSCxkp8Ve5e9FFQI76GzgLHxTjfc/o3MxEk3gb+7RrPxl37v8B0
 Qfv5G0q2TBs8nMQGqgHO4Sy09TRZbfI+zYSmIqxBfZudMZIjKGrOx39hFUdbsSC2mN
 rIQz+HFxz3hGBRKP/ny9eelqKslOQ0qIcL8nMpz+tIweZ2jWezbBlY2gv2z813QbtY
 iLytCjXKMsdavkFD/2B2HSgMgi/4yxbjExhV6o2PtqI/Eo8AYglstg1l1Yg7ZKRhX1
 +HPx2lORmQqiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 094/109] ASoC: rt1015p: remove dependency on
 GPIOLIB
Date: Mon, 30 May 2022 09:38:10 -0400
Message-Id: <20220530133825.1933431-94-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530133825.1933431-1-sashal@kernel.org>
References: <20220530133825.1933431-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 kernel test robot <yujie.liu@intel.com>, tanureal@opensource.cirrus.com,
 hdegoede@redhat.com, tiwai@suse.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 lgirdwood@gmail.com, cy_huang@richtek.com, Mark Brown <broonie@kernel.org>,
 srinivas.kandagatla@linaro.org, pbrobinson@gmail.com,
 ckeepax@opensource.cirrus.com, james.schulman@cirrus.com,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>
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

[ Upstream commit b390c25c6757b9d56cecdfbf6d55f15fc89a6386 ]

commit dcc2c012c7691 ("ASoC: Fix gpiolib dependencies") removed a
series of unnecessary dependencies on GPIOLIB when the gpio was
optional.

A similar simplification seems valid for rt1015p, so remove the
dependency as well. This will avoid the following warning

  WARNING: unmet direct dependencies detected for SND_SOC_RT1015P

     Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] &&
     GPIOLIB [=n]

     Selected by [y]:

     - SND_SOC_INTEL_SOF_RT5682_MACH [=y] && SOUND [=y] && !UML && SND
       [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y] &&
       (SND_SOC_SOF_HDA_LINK [=y] || SND_SOC_SOF_BAYTRAIL [=n]) && I2C
       [=y] && ACPI [=y] && (SND_HDA_CODEC_HDMI [=y] &&
       SND_SOC_SOF_HDA_AUDIO_CODEC [=y] && (MFD_INTEL_LPSS [=y] ||
       COMPILE_TEST [=y]) || SND_SOC_SOF_BAYTRAIL [=n] &&
       (X86_INTEL_LPSS [=n] || COMPILE_TEST [=y]))

Reported-by: kernel test robot <yujie.liu@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://lore.kernel.org/r/20220517172647.468244-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 2cbf4fc0f675..d59a7e99ce42 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1148,7 +1148,6 @@ config SND_SOC_RT1015
 
 config SND_SOC_RT1015P
 	tristate
-	depends on GPIOLIB
 
 config SND_SOC_RT1019
 	tristate
-- 
2.35.1

