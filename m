Return-Path: <SRS0=Q+Fc=4C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F115AC3B1A1
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:12:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8089D246A6
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FxcgucbG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBNWAtsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8089D246A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B6D5116A9;
	Fri, 14 Feb 2020 17:11:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B6D5116A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581696748;
	bh=kdqGTpszHByimBYGzCCGz5jDdUmnh1M0LA/YCJJG0ok=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FxcgucbGZ7pcwhNTMuZWYN5PkeUrUAqYm/8yRr9GHRiLujoCQzL/HsUfChpJoolGh
	 yGrBkDzp3F2Hyp+qwHlNjCYW/MAR/9H4kqwsAhg1vIVUqPBHnXrk/hSPxu1YvLILpa
	 Z/UqOKlPddcTna9pvSTTesXhAYqPH1sTjGn7voU8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B31BF802D2;
	Fri, 14 Feb 2020 17:07:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BB1E1F802D2; Fri, 14 Feb 2020 17:07:17 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 75976F802A7
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2020 17:07:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75976F802A7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="aBNWAtsG"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 48FCF222C2;
 Fri, 14 Feb 2020 16:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581696432;
 bh=AIbo4S4usFiwy+n5RgPSDhWrfMvr5ydKo17MWKxWy40=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aBNWAtsGN6eXarS0jW8LYqFg1EinNcfHonhonbb2RBQLnaQbtPcYzISWSxdjSx036
 7eiPv3QSn2MNlMxT1tZzAyV92YbPtl6lW6WFCtjAfDoq8PToKj5R3kCTO2DHPGqk1O
 0O4mVM+9NVaO4k/XIl2W6TM0QWSz87Hl/spqstrU=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Fri, 14 Feb 2020 10:58:20 -0500
Message-Id: <20200214160149.11681-250-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, Sam McNally <sammc@chromium.org>,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH AUTOSEL 5.4 250/459] ASoC: Intel: sof_rt5682:
	Ignore the speaker amp when there isn't one.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Sam McNally <sammc@chromium.org>

[ Upstream commit d4b74e218a8d0d6cf58e546627ab9d4d4f2645ab ]

Some members of the Google_Hatch family include a rt5682 jack codec, but
no speaker amplifier. This uses the same driver (sof_rt5682) as a
combination of rt5682 jack codec and max98357a speaker amplifier. Within
the sof_rt5682 driver, these cases are not currently distinguishable,
relying on a DMI quirk to decide the configuration. This causes an
incorrect configuration when only the rt5682 is present on a
Google_Hatch device.

For CML, the jack codec is used as the primary key when matching,
with a possible speaker amplifier described in quirk_data. The two cases
of interest are the second and third 10EC5682 entries in
snd_soc_acpi_intel_cml_machines[]. The second entry matches the
combination of rt5682 and max98357a, resulting in the quirk_data field
in the snd_soc_acpi_mach being non-null, pointing at
max98357a_spk_codecs, the snd_soc_acpi_codecs for the matched speaker
amplifier. The third entry matches just the rt5682, resulting in a null
quirk_data.

The sof_rt5682 driver's DMI data matching identifies that a speaker
amplifier is present for all Google_Hatch family devices. Detect cases
where there is no speaker amplifier by checking for a null quirk_data in
the snd_soc_acpi_mach and remove the speaker amplifier bit in that case.

Signed-off-by: Sam McNally <sammc@chromium.org>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200103124921.v3.1.Ib87c4a7fbb3fc818ea12198e291b87dc2d5bc8c2@changeid
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_rt5682.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 9441ddfeea5e6..06b7d6c6c9a04 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -594,6 +594,14 @@ static int sof_audio_probe(struct platform_device *pdev)
 
 	dmi_check_system(sof_rt5682_quirk_table);
 
+	mach = (&pdev->dev)->platform_data;
+
+	/* A speaker amp might not be present when the quirk claims one is.
+	 * Detect this via whether the machine driver match includes quirk_data.
+	 */
+	if ((sof_rt5682_quirk & SOF_SPEAKER_AMP_PRESENT) && !mach->quirk_data)
+		sof_rt5682_quirk &= ~SOF_SPEAKER_AMP_PRESENT;
+
 	if (soc_intel_is_byt() || soc_intel_is_cht()) {
 		is_legacy_cpu = 1;
 		dmic_be_num = 0;
@@ -654,7 +662,6 @@ static int sof_audio_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
 
 	sof_audio_card_rt5682.dev = &pdev->dev;
-	mach = (&pdev->dev)->platform_data;
 
 	/* set platform name for each dailink */
 	ret = snd_soc_fixup_dai_links_platform_name(&sof_audio_card_rt5682,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
