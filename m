Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF7DC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 30 May 2022 13:31:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7EC971B45;
	Mon, 30 May 2022 15:30:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7EC971B45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653917507;
	bh=YUT/g2jwaEbyBeENevqDwxAfPQZzcjDa+B0CACpQ21Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=edTKZbIgpGQ8uVFFe+oRAfBzajWMCHohJ0RQGj+38F9WTe/vv7rr3nrl6cF/SSLh0
	 x4W12TjZeJ34smk3o6Iq6XKjHX0Z66fD7qYrBv8YXoeimkb6MhBYwJ5P7EgxNEampC
	 M9SOTNiok83DZvORDt87RV5Hahys97mXYpFonw50=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AAF4F804BD;
	Mon, 30 May 2022 15:30:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 398AEF801F5; Mon, 30 May 2022 15:30:56 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB83FF80124
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2022 15:30:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB83FF80124
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QMJeH91/"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 91330B80DA8;
 Mon, 30 May 2022 13:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77381C385B8;
 Mon, 30 May 2022 13:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653917451;
 bh=YUT/g2jwaEbyBeENevqDwxAfPQZzcjDa+B0CACpQ21Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QMJeH91/jMb1UKyxHCItMlohChQVqr3BzJZez6U3mcyNQeGKh2ooapKhZVW17r1vg
 uJaRqXLzZXMCzCT4ET/7i5UIGAx9toeDLW35GnBeA5AnkRmNRo4xJ3j17hpbpQGgsL
 UuS9r9M3hn09Wb+o5pPFWXSaTPI5wyCN84cV4lY6UufiNFd4jDeeuFkq5b7vD+73sC
 v2I+yXf2cbj2mlEsc9JRjC8lmE847/+gUPjtSWiUcgrkc+zBt39DVIWNp1iGnyhUII
 xlXxzJy3Sg+9uMMnqEVD2B3Q36405r0hlkD9cyRsFGnfGynU09Y+DmwEtpAQrHuqOt
 NVuLHlcA/VuXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.18 141/159] ASoC: rt1015p: remove dependency on
 GPIOLIB
Date: Mon, 30 May 2022 09:24:06 -0400
Message-Id: <20220530132425.1929512-141-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530132425.1929512-1-sashal@kernel.org>
References: <20220530132425.1929512-1-sashal@kernel.org>
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
index 156f2519459d..3dea20b2c405 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1212,7 +1212,6 @@ config SND_SOC_RT1015
 
 config SND_SOC_RT1015P
 	tristate
-	depends on GPIOLIB
 
 config SND_SOC_RT1019
 	tristate
-- 
2.35.1

