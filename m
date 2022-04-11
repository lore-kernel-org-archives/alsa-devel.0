Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA03C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Apr 2022 20:19:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 874F91727;
	Mon, 11 Apr 2022 22:18:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 874F91727
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649708360;
	bh=SGmGyo3vAuw8xuhGzUT+cykO6GQd8Q2xN+LFWpH3x6U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gcSEC0WcNJ0HHQZWWlwSOupB8n8rwcZeeeOU9vIwaECUj7QaD5P7JUCHu693Wuemf
	 MDnYEJYFSTO1rNZjMsFpDYWpUqNzpYOCU0HnUhGwsIAw/acSivGnCWRIfiaM4nQKz4
	 6yod3a4LWoAOE648/5o0UelpjSrVENtiCcpWpO6k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1838AF8050F;
	Mon, 11 Apr 2022 22:18:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 407B8F80249; Mon, 11 Apr 2022 22:18:03 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 540BEF80249
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2022 22:17:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 540BEF80249
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="QpKHCL1X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649708277; x=1681244277;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SGmGyo3vAuw8xuhGzUT+cykO6GQd8Q2xN+LFWpH3x6U=;
 b=QpKHCL1X/kVYGAPXtIo8+0byUFO7IVErS/exlS/JRS78xYOE+2bE4ojc
 cVsslIEJH7OCl0Wsec/FNlYvs7yPcOgaAwi8P69p7CEMPUPDI/RHmFJ33
 XIHGLRridpWomv+MjOGlghJLBsFgGXFBntozija/Ciu+KPp/EfGigqs33
 iJONmALjX0zxtQXoAaLanYpNzxbBkm+f8iX1O9WAZn5Km6FtoDL8oBD79
 P+1DFEzhnC1rtxmQmNyueshMHr3DqOe9MciPA5gbDn2tm4C+VcziUL5H3
 WqPUTegfgBUSTWeUY7ZbQM6GzZ/3+2h7iP0p8QNYVOUHD4pTyDKfksVya Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="244090821"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; d="scan'208";a="244090821"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2022 13:17:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; d="scan'208";a="526135641"
Received: from prposam-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.162.151])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2022 13:17:49 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 01/16] ASoC: SOF: add definitions for different IPC types
Date: Mon, 11 Apr 2022 15:17:12 -0500
Message-Id: <20220411201727.77971-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411201727.77971-1-pierre-louis.bossart@linux.intel.com>
References: <20220411201727.77971-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, broonie@kernel.org,
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

Add enum type to allow for different types of IPCs. The IPCv4 is
intended for Intel only as a convergence path with firmware used in
Windows. Follow-up patches will introduce different abstractions with
.ops and different search paths for firmware and topology files.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 include/sound/sof.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/sound/sof.h b/include/sound/sof.h
index 7cdfc954df12..2658a38be5bd 100644
--- a/include/sound/sof.h
+++ b/include/sound/sof.h
@@ -47,6 +47,13 @@ enum sof_dsp_power_states {
 	SOF_DSP_PM_D3,
 };
 
+/* Definitions for multiple IPCs */
+enum sof_ipc_type {
+	SOF_IPC,
+	SOF_INTEL_IPC4,
+	SOF_IPC_TYPE_COUNT
+};
+
 /*
  * SOF Platform data.
  */
@@ -83,6 +90,8 @@ struct snd_sof_pdata {
 	const struct snd_soc_acpi_mach *machine;
 
 	void *hw_pdata;
+
+	enum sof_ipc_type ipc_type;
 };
 
 /*
-- 
2.30.2

