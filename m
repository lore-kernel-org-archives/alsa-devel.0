Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB31CC4345F
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Apr 2024 22:32:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 300102BF7;
	Fri, 12 Apr 2024 00:32:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 300102BF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712874774;
	bh=F/gI6jdQzZTY4a2T3I8ooQcwxQGn2NnW7MR76QFt71Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mZwkyvuAHFT4UnJbjbW7nJrWbUXroVbVWZYBvrTLoYuxBvjkiM97iWqphRlc6gry5
	 ba9qz1zkeUK7qkY9PqP1n9qhyOECpL4Q4gdX7b0X1TRKOOeK5EXTpoUkskENHauRxa
	 D0w1HagLFHdJrWd+oa2JR3VbuyulBCWlIDacc5Oc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 47986F805F1; Fri, 12 Apr 2024 00:31:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D965CF80601;
	Fri, 12 Apr 2024 00:31:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 99C61F80130; Fri, 12 Apr 2024 00:16:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E7B37F8056F
	for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2024 00:04:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7B37F8056F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cv/vNQql
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712873067; x=1744409067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F/gI6jdQzZTY4a2T3I8ooQcwxQGn2NnW7MR76QFt71Q=;
  b=cv/vNQql9meVQeBjMvv22RBaFfoyANSioAXXHljvX3LitdEQYJjnUj/U
   5ErLm3bihvJDP0ICwVnM8iHwj7AcqGP7fJuF5LfHTPpzgSc+61idbdjJf
   pjNF9JNlRhVX4NxtTVgA9Rgv/tsJgkvLD54683GshOD/ofOeeoxdBUS/4
   kIsWBkDghXLDUpdUxuPnE4Arabm2oVQMTw2Nr4dklFWCVLYZrym9Xd4LF
   zu4WV5QwH+9xr2wJxu1/FtelYNUruU8WbyRkm30cwlPBVF5fkIR54gjgU
   BQcNueUAAw9tG1D7LD3loz+kCKGJ+ZmHHbSzxjIDrxi5xcxhpb0HzjGZs
   A==;
X-CSE-ConnectionGUID: DQnpiZ9RRji+Z/fiWoomEQ==
X-CSE-MsgGUID: OjDMuJ8FRW65ubX3lfx0qw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="19708365"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000";
   d="scan'208";a="19708365"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2024 15:04:17 -0700
X-CSE-ConnectionGUID: qF4ih7T4RmeRJ90B7sAcQQ==
X-CSE-MsgGUID: h3D/k9HmR4i7wmMHkPQDAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000";
   d="scan'208";a="21628751"
Received: from aramana1-mobl.amr.corp.intel.com (HELO pbossart-mobl6.lan)
 ([10.213.177.233])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2024 15:04:17 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Brent Lu <brent.lu@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 07/12] ASoC: Intel: sof_da7219: mach cleanup for rpl boards
Date: Thu, 11 Apr 2024 17:03:42 -0500
Message-Id: <20240411220347.131267-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240411220347.131267-1-pierre-louis.bossart@linux.intel.com>
References: <20240411220347.131267-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: EDWYK5RYWUHMTQKRRV523WZ6IPWZQLNG
X-Message-ID-Hash: EDWYK5RYWUHMTQKRRV523WZ6IPWZQLNG
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EDWYK5RYWUHMTQKRRV523WZ6IPWZQLNG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Brent Lu <brent.lu@intel.com>

Add a common entry in enumeration table for all da7219 boards
with/without speaker amplifier. All other rpl_da7219_def entries
become redundant so get removed.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Brent Lu <brent.lu@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../intel/common/soc-acpi-intel-rpl-match.c   | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-rpl-match.c b/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
index 34588db6138a..b0a49e28ab09 100644
--- a/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
@@ -361,11 +361,6 @@ static const struct snd_soc_acpi_codecs rpl_max98357a_amp = {
 	.codecs = {"MX98357A"}
 };
 
-static const struct snd_soc_acpi_codecs rpl_max98360a_amp = {
-	.num_codecs = 1,
-	.codecs = {"MX98360A"},
-};
-
 static const struct snd_soc_acpi_codecs rpl_lt6911_hdmi = {
 	.num_codecs = 1,
 	.codecs = {"INTC10B0"}
@@ -411,6 +406,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_rpl_machines[] = {
 		.tplg_quirk_mask = SND_SOC_ACPI_TPLG_INTEL_AMP_NAME |
 					SND_SOC_ACPI_TPLG_INTEL_CODEC_NAME,
 	},
+	{
+		.id = DA7219_ACPI_HID,
+		.drv_name = "rpl_da7219_def",
+		.sof_tplg_filename = "sof-rpl", /* the tplg suffix is added at run time */
+		.tplg_quirk_mask = SND_SOC_ACPI_TPLG_INTEL_AMP_NAME |
+					SND_SOC_ACPI_TPLG_INTEL_CODEC_NAME,
+	},
 	{
 		.id = NAU8825_ACPI_HID,
 		.drv_name = "rpl_nau8825_def",
@@ -438,13 +440,6 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_rpl_machines[] = {
 		.drv_name = "rpl_lt6911_hdmi_ssp",
 		.sof_tplg_filename = "sof-rpl-nocodec-hdmi-ssp02.tplg"
 	},
-	{
-		.id = "DLGS7219",
-		.drv_name = "rpl_da7219_def",
-		.machine_quirk = snd_soc_acpi_codec_list,
-		.quirk_data = &rpl_max98360a_amp,
-		.sof_tplg_filename = "sof-rpl-max98360a-da7219.tplg",
-	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_rpl_machines);
-- 
2.40.1

