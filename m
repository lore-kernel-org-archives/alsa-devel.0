Return-Path: <SRS0=vkql=A4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E70C433E5
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 21:50:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6021520739
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 21:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="e7qPAFJu";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2FsjmqEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6021520739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99F741673;
	Fri, 17 Jul 2020 23:49:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99F741673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595022634;
	bh=d6pg/moIc4Lfqu+IfBjkbjoSoRMlnQNHmTVvs1VG1nk=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=e7qPAFJuNJT96ZKx1xpGXOD0bRM/GX48f+qYh4OqyF2NYCUpZFp70dlrTi8PycrOt
	 Si16k/Jus+xX3afof793mCO+fz/8XCs47zqwmY7VwmshKblfJ/OMNnGGkVaxRoq5u/
	 6L/09BVLjPW1cIvg2eujyfaAqUsgjqdmTNgdBwGM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C6E3F801D8;
	Fri, 17 Jul 2020 23:49:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BECE0F80217; Fri, 17 Jul 2020 23:49:42 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C3638F8014E
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2020 23:49:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C3638F8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="2FsjmqEN"
Received: from embeddedor (unknown [201.162.167.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C2EA320759;
 Fri, 17 Jul 2020 21:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595022573;
 bh=d6pg/moIc4Lfqu+IfBjkbjoSoRMlnQNHmTVvs1VG1nk=;
 h=Date:From:To:Cc:Subject:From;
 b=2FsjmqENNaKb2fIvhkjaY9xknfwSoNvX+heeZudSyESchWojQCWTVoy5V//d1bDev
 ssv6gOfMQnPh8DaqKaf1XzTwnYClT/4M8zjFMmX0HpN/Tkl+BDyNPM80B0ThNsNZ+M
 K651XniFOE0QEEJcqZ8ylRUhH6Dpr38HeVLNEPC0=
Date: Fri, 17 Jul 2020 16:55:00 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH][next] ASoC: Intel: Skylake: Avoid the use of one-element array
Message-ID: <20200717215500.GA13910@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
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

One-element arrays are being deprecated[1]. Replace the one-element
array with a simple value type 'u8 reserved'[2], once it seems this
is just a placeholder for alignment.

[1] https://github.com/KSPP/linux/issues/79
[2] https://github.com/KSPP/linux/issues/86

Tested-by: kernel test robot <lkp@intel.com>
Link: https://github.com/GustavoARSilva/linux-hardening/blob/master/cii/0-day/skylake-20200717.md
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.h b/sound/soc/intel/skylake/skl-topology.h
index 9889f728752c..5e93ad85e06d 100644
--- a/sound/soc/intel/skylake/skl-topology.h
+++ b/sound/soc/intel/skylake/skl-topology.h
@@ -97,7 +97,7 @@ struct skl_audio_data_format {
 	u8 number_of_channels;
 	u8 valid_bit_depth;
 	u8 sample_type;
-	u8 reserved[1];
+	u8 reserved;
 } __packed;
 
 struct skl_base_cfg {
-- 
2.27.0

