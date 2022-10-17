Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30622C4332F
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Oct 2022 23:50:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AFD07A0E8;
	Fri, 21 Oct 2022 01:49:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AFD07A0E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666309844;
	bh=2ggRPEMRf9V51/KbMEH5FwxR//1+0JIBwk3UrMRB14w=;
	h=Resent-From:Resent-Date:Resent-To:From:To:Date:Subject:
	 In-Reply-To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From;
	b=q6sdzh+L7EIJBCot3vKNzlH3lWADnAXevWk3+SQ4fZQTGxRypYX9IANIaS4kc/Rff
	 GIo68bJfJefFMDryDHigLzatnJmQqsGoQzbdEI+PzX3AWQ0YpGopr/UgSaZCF0ZmqD
	 +OFSk3zvdRxIosmqEMID5O2Y1xcBWLDs/mZaaLd0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 591FEF800B5;
	Fri, 21 Oct 2022 01:49:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B41EAF804D8; Fri, 21 Oct 2022 01:49:53 +0200 (CEST)
Received: from tartarus.angband.pl (tartarus.angband.pl [51.83.246.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BDBDBF800B5
 for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2022 01:49:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BDBDBF800B5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=angband.pl header.i=@angband.pl
 header.b="uCG1yeqt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=angband.pl; 
 s=tartarus;
 h=In-Reply-To:Subject:Date:To:From:Resent-To:Resent-Message-ID:
 Resent-Date:Resent-From:Sender:Reply-To:Message-ID:Cc:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Sender:Resent-Cc:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ytGemd8TUUP6iR/VoFGETCFoSPfcw2IqvbDsWpHrIzE=; b=uCG1yeqtS22d7vaexpY6lNaFMk
 K7aTT+M0FCxW44f5pJPqFC6WN7hlevhyre6ru91EHdvEWQJm4p6lW4EDXltrPwj8U53TQ0m3NpMqR
 GQuptLKJu74TAso1AdYYrVuc5f3xLCgFQRQnHKh7HdD29qrEL7Z3yV42e/hxYDLtdI4Q=;
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94.2)
 (envelope-from <kilobyte@angband.pl>)
 id 1oleJS-009Obi-Ix; Fri, 21 Oct 2022 00:46:54 +0200
Resent-From: Adam Borowski <kilobyte@angband.pl>
Resent-Date: Fri, 21 Oct 2022 00:46:54 +0200
Resent-Message-ID: <Y1HP3rf/NMmVh+Bf@angband.pl>
Resent-To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
From: Adam Borowski <kilobyte@angband.pl>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date: Mon, 17 Oct 2022 08:17:12 +0200
Subject: [PATCH 6/6] ASoC: Intel: boards: add missing dependency from
 realtek-common
In-Reply-To: <S229853AbiJTWkg/20221020224036Z+12888@vger.kernel.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
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
Message-ID: <20221017061712.hD1TJvoQuJ8s5a_ppsEApKfyqoiprhKaCseFxOD_l2o@z>

These boards use code from sound/soc/sof/sof-audio.c

Fixes: e1d5e13324020c4b405e63cae34560c7992bec2e
Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 sound/soc/intel/boards/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index aa12d7e3dd2f..3179ba061d87 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -34,6 +34,7 @@ config SND_SOC_INTEL_SOF_MAXIM_COMMON
 
 config SND_SOC_INTEL_SOF_REALTEK_COMMON
 	tristate
+	depends on SND_SOC_SOF
 
 config SND_SOC_INTEL_SOF_CIRRUS_COMMON
 	tristate
-- 
2.37.2.609.g9ff673ca1a
