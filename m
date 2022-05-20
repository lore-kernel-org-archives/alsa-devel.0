Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFE6C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 20 May 2022 21:21:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 41AC81768;
	Fri, 20 May 2022 23:20:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 41AC81768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653081699;
	bh=EHs6eO1CLtdckRmqkO15PRqJD3a5ZaJCzlMXaUVz6bY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qPUnw3ufh1aKas2kYWo+1jZX3jCfAiUDkAWNGmvhyyZ9rDdUnb/0gjL3hLKUnvb5o
	 3JCVBRYAVl2P5hfLBBkGCnYzcnOPDorUeYXOcH5pe4kbf0qYOC1aYNuR/N6yqZP0xX
	 BOnpUTP8//NRZpArVLI6UU9hKtlco4XCGA47bwl0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B7248F80559;
	Fri, 20 May 2022 23:17:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B3561F80549; Fri, 20 May 2022 23:17:54 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6684FF801F5
 for <alsa-devel@alsa-project.org>; Fri, 20 May 2022 23:17:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6684FF801F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="naRRPQK/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653081463; x=1684617463;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EHs6eO1CLtdckRmqkO15PRqJD3a5ZaJCzlMXaUVz6bY=;
 b=naRRPQK/6wLrshAtCaTqUiS1ciDQlIO7IJxo/DcrL3qmfcD1XNMUZkCz
 bmU7Zzmmuu/fMEPhbdQUeIGOZUudY1yUZGvM9VjTRYSBpUxWkj1KlUTBu
 BMri+NJMN/w1mFy+2tQBNy6yfG4/0mpfp/B2BsayhqoY+HjPUWiqWAAS/
 PQtcVj7j3hi7zbJSK5NDgND6es/pbVUSacRK+/qV7HYGfJJ78pYRa8yTE
 mj2R+UAvtdzCtshhlPwab8+D3/cBt5HHCjqApj/BoyEeMuNUJdcup/e74
 oUA+ekqoGaHNWgkb0PaPb8KCsa2zJ+JAfycRB1yIYbi6xv6b9rsDU0OEZ A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="270324244"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; d="scan'208";a="270324244"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2022 14:17:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; d="scan'208";a="674796031"
Received: from achsu-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.181.190])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2022 14:17:36 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 09/16] ASoC: Intel: boards: reset acpi_chan_package
Date: Fri, 20 May 2022 16:17:12 -0500
Message-Id: <20220520211719.607543-10-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220520211719.607543-1-pierre-louis.bossart@linux.intel.com>
References: <20220520211719.607543-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 broonie@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

cppcheck complains about possible tests of uninitialized 'aif_value'
members. This isn't really possible but static analysis cannot know
what ACPICA does, so make sure the acpi_chan_package structure is
reset prior to use to make the warning go away.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c   | 2 +-
 sound/soc/intel/boards/bytcr_rt5651.c   | 2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 7b948a219177d..7cc85fd862b21 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1634,7 +1634,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		 * with the codec driver/pdata are non-existent
 		 */
 
-		struct acpi_chan_package chan_package;
+		struct acpi_chan_package chan_package = { 0 };
 
 		/* format specified: 2 64-bit integers */
 		struct acpi_buffer format = {sizeof("NN"), "NN"};
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index d467fcaa48eaa..03a52b1069a92 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -952,7 +952,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 		 * with the codec driver/pdata are non-existent
 		 */
 
-		struct acpi_chan_package chan_package;
+		struct acpi_chan_package chan_package = { 0 };
 
 		/* format specified: 2 64-bit integers */
 		struct acpi_buffer format = {sizeof("NN"), "NN"};
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 45c301ea5e003..453281326c831 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -603,7 +603,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		 * with the codec driver/pdata are non-existent
 		 */
 
-		struct acpi_chan_package chan_package;
+		struct acpi_chan_package chan_package = { 0 };
 
 		/* format specified: 2 64-bit integers */
 		struct acpi_buffer format = {sizeof("NN"), "NN"};
-- 
2.30.2

