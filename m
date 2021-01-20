Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9575CC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 01:27:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EBA2233FB
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 01:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBA2233FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 29B9818B9;
	Wed, 20 Jan 2021 02:26:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 29B9818B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611106028;
	bh=Zgo+Eu0ONQsyiqmfFfZYOd5kp7Y4SaoXFo9SIbMhikc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r3SZ/HNJmW0btIsDlRf/9MZenKc7Q8CSNOKjX6FbrfSKxT5+vLl40+igqcUUfcZAC
	 72RdsYVm7U4FCfK8NeYX3F3DbRZuH9JG99xnw+ejy18hdEsEOqz8Uc8G0exExkB2mA
	 UjFxsWIkitq1kPi8k2Qw9FUY2Nx6gvV+muRBcBdE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4148F80255;
	Wed, 20 Jan 2021 02:26:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6692AF80273; Wed, 20 Jan 2021 02:26:16 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A29C9F800FE
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 02:26:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A29C9F800FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="iQTgPSkD"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B291B2311C;
 Wed, 20 Jan 2021 01:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611105965;
 bh=Zgo+Eu0ONQsyiqmfFfZYOd5kp7Y4SaoXFo9SIbMhikc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iQTgPSkDXD2XGBV51bqnnGia53i4mqGktyvR39ch7S47YP1Xf8C8d7NeI7Mh2xtPJ
 60ruQHF4tf3Mvh/55lNWFPfw/ri2YfafA6iO6OQPrrmEnRDJtFy6Pjq9yfc+Wo/Hqp
 HcQfokKbtM2nJHJj4O/Qv2v5uflchYgLwRnjYS9O+u84o+c9itVIWq9fdowwQof8jF
 Ig6S6Q2IXaDoyPHbpzepgjxnZOTXazIzJBZZncHCrTtECadYFR2jcShHQinldk5f8x
 M6+KFKapuGJyoasCH3rHqRVPZPoPS/iS5FC8P5F+QctS4sTxTB96NvDxKh7cNCB2iP
 7n7/M9UCXR3Og==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 02/45] ASoC: rt711: mutex between calibration and
 power state changes
Date: Tue, 19 Jan 2021 20:25:19 -0500
Message-Id: <20210120012602.769683-2-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210120012602.769683-1-sashal@kernel.org>
References: <20210120012602.769683-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Shuming Fan <shumingf@realtek.com>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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

From: Shuming Fan <shumingf@realtek.com>

[ Upstream commit 6108f990c0887d3e8f1db2d13c7012e40a061f28 ]

To avoid calibration time-out, this patch adds the mutex between calibration and power state changes

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Link: https://lore.kernel.org/r/20201217085651.24580-1-shumingf@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt711.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/rt711.c b/sound/soc/codecs/rt711.c
index 65b59dbfb43c8..a9b1b4180c471 100644
--- a/sound/soc/codecs/rt711.c
+++ b/sound/soc/codecs/rt711.c
@@ -462,6 +462,8 @@ static int rt711_set_amp_gain_put(struct snd_kcontrol *kcontrol,
 	unsigned int read_ll, read_rl;
 	int i;
 
+	mutex_lock(&rt711->calibrate_mutex);
+
 	/* Can't use update bit function, so read the original value first */
 	addr_h = mc->reg;
 	addr_l = mc->rreg;
@@ -547,6 +549,8 @@ static int rt711_set_amp_gain_put(struct snd_kcontrol *kcontrol,
 	if (dapm->bias_level <= SND_SOC_BIAS_STANDBY)
 		regmap_write(rt711->regmap,
 				RT711_SET_AUDIO_POWER_STATE, AC_PWRST_D3);
+
+	mutex_unlock(&rt711->calibrate_mutex);
 	return 0;
 }
 
@@ -859,9 +863,11 @@ static int rt711_set_bias_level(struct snd_soc_component *component,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
+		mutex_lock(&rt711->calibrate_mutex);
 		regmap_write(rt711->regmap,
 			RT711_SET_AUDIO_POWER_STATE,
 			AC_PWRST_D3);
+		mutex_unlock(&rt711->calibrate_mutex);
 		break;
 
 	default:
-- 
2.27.0

