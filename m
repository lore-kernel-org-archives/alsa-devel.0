Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3EEC4321E
	for <alsa-devel@archiver.kernel.org>; Mon, 30 May 2022 13:38:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 856641E73;
	Mon, 30 May 2022 15:37:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 856641E73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653917912;
	bh=OiuAQG3BrJbwqcLIwcvhXNkXPjIkvPVxMQwHSHsuVqM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r7etUBPo6HsqWu6OWymVFADOfgGI+T/uYTkCdXnxN5iMZ+b4ubkZDGHdY89XKLdTA
	 xM/fhlhlJ+luJNXUbEsh+/LZCA22ka5xCShc97Prjh/OQNustJ4S9nZ6edYYRpZvbZ
	 S7s2/S3DPgtVzrl2opK1rXpXGOJpt/rluK37i9wg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 22208F801F5;
	Mon, 30 May 2022 15:37:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A6DD2F80240; Mon, 30 May 2022 15:37:40 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38FA9F800DE
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2022 15:37:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38FA9F800DE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="gvc/Awzr"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 277C660F78;
 Mon, 30 May 2022 13:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EF8C36AEA;
 Mon, 30 May 2022 13:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653917857;
 bh=OiuAQG3BrJbwqcLIwcvhXNkXPjIkvPVxMQwHSHsuVqM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gvc/Awzr3DqUHv9COwceNCkR+LXWA/JA6H8j0STp+XGn9iG0SPxZBBrEuK5HjdLYk
 AsuO2ukuaJPjaPqEJywnvY2++qTqVoQyvXBXj9EBV148/C9XC25qY+CfAnG2KykKAz
 VZO7NRIZ0CZOAf83IMDA7j7U48I/x4jWTZJd9x+ZhlehmrYojIc04eTSkwJ9YK8b3l
 MxpmMuL7oqnCK8AFf5+TPjI1+Za4b188900Ld3pWPoHPqkfuCpf/p/DUBRLzhdKsFG
 uET4NgRD66gVMJyDDQhXqCfx/HIG1SYe7aQd3cXbihMyZMXzNtoR4EqIJ4zFTHSZx2
 uTSZF0OeGNb2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.17 118/135] ASoC: max98357a: remove dependency on
 GPIOLIB
Date: Mon, 30 May 2022 09:31:16 -0400
Message-Id: <20220530133133.1931716-118-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530133133.1931716-1-sashal@kernel.org>
References: <20220530133133.1931716-1-sashal@kernel.org>
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

[ Upstream commit 21ca3274333f5c1cbbf9d91e5b33f4f2463859b2 ]

commit dcc2c012c7691 ("ASoC: Fix gpiolib dependencies") removed a
series of unnecessary dependencies on GPIOLIB when the gpio was
optional.

A similar simplification seems valid for max98357a, so remove the
dependency as well. This will avoid the following warning

   WARNING: unmet direct dependencies detected for SND_SOC_MAX98357A
     Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
     Selected by [y]:
     - SND_SOC_INTEL_SOF_CS42L42_MACH [=y] && SOUND [=y] && !UML &&
       SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y] &&
       (SND_SOC_SOF_HDA_LINK [=y] || SND_SOC_SOF_BAYTRAIL [=n]) && I2C
       [=y] && ACPI [=y] && SND_HDA_CODEC_HDMI [=y] &&
       SND_SOC_SOF_HDA_AUDIO_CODEC [=y] && (MFD_INTEL_LPSS [=y] ||
       COMPILE_TEST [=n])

Reported-by: kernel test robot <yujie.liu@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://lore.kernel.org/r/20220517172647.468244-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 30c00380499c..a8c6c2bfd5a7 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -943,7 +943,6 @@ config SND_SOC_MAX98095
 
 config SND_SOC_MAX98357A
 	tristate "Maxim MAX98357A CODEC"
-	depends on GPIOLIB
 
 config SND_SOC_MAX98371
 	tristate
-- 
2.35.1

