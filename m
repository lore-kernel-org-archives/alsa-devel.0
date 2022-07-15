Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7BFC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jul 2022 14:55:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5109C1908;
	Fri, 15 Jul 2022 16:54:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5109C1908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657896900;
	bh=rRLbyaoIc0IiA6uXB65P7kFfvv0yy0KEQSZq15DcTAY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XQuI2C+B/0VZ62q2vA9OjBW+5N2Uj/lAingVMcglM++WGiFzsP1b6edc28DUr9OoZ
	 uvwML45GsDCjaNmI8sBB6C13FlKWLGPYAgtOh9x7E+Zlxf5j6tPM1mj5sIzgicN7MH
	 AAQfeA8L0vtO7W4UOcKZeFDXrrYbWl3YOLGR6SGI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D6DCF80558;
	Fri, 15 Jul 2022 16:53:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 89353F8055B; Fri, 15 Jul 2022 16:53:05 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF548F80507
 for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2022 16:52:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF548F80507
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="apnT+7QD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657896777; x=1689432777;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rRLbyaoIc0IiA6uXB65P7kFfvv0yy0KEQSZq15DcTAY=;
 b=apnT+7QD8M/j0ZwRjCrN+lYSZxtQOyEezE9vv+nDnqtJ9NC4CHcehnvS
 61FNzUbVzlun/hmFHL8qD+NT90/Ys3W4bx98UeBb55Pqy2bX+scfvKhds
 gS9u657jZY+PQvBiKDhFdgiaFp5QAQo/syBnZVSHoGXf/+VQy4VdWT1UO
 MqIFI/7nRSK0VC4PUCTZ35p5+tThV6DTXCR6PdwNYrcmnXBta74uLW91Z
 etTAFfcdws5byx364uZlUv/6qNPN2Lvo2y5Ylvwgzdm0uO+e5YEx/BLMK
 HoRHcXJOOB5uR8tCMHeB7mDqgoXxQ4cTQ3GSM4oyh4dylbjaNPF1DdPVr Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="311476915"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; d="scan'208";a="311476915"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2022 07:52:35 -0700
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; d="scan'208";a="923533127"
Received: from jmurope-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.212.14.184])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2022 07:52:34 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 08/11] ASoC: SOF: Intel: hda: don't set fw_filename
Date: Fri, 15 Jul 2022 09:52:13 -0500
Message-Id: <20220715145216.277003-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220715145216.277003-1-pierre-louis.bossart@linux.intel.com>
References: <20220715145216.277003-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Bard Liao <yung-chuan.liao@linux.intel.com>,
 broonie@kernel.org,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
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

The fw_filename is now set at a higher level and can be overridden by
kernel parameters or DMI quirks.

Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index be3c4f1d8ff5..b702412e2a17 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1401,7 +1401,6 @@ static struct snd_soc_acpi_mach *hda_sdw_machine_select(struct snd_sof_dev *sdev
 			mach->mach_params.links = mach->links;
 			mach->mach_params.link_mask = mach->link_mask;
 			mach->mach_params.platform = dev_name(sdev->dev);
-			pdata->fw_filename = pdata->desc->default_fw_filename[pdata->ipc_type];
 			pdata->tplg_filename = mach->sof_tplg_filename;
 
 			/*
-- 
2.34.1

