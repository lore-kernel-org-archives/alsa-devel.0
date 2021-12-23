Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F5BC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Dec 2021 11:42:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1B0418D6;
	Thu, 23 Dec 2021 12:41:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1B0418D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640259746;
	bh=Ge62tpfRSlEvvinNhAXRV1hWm2EHQvHlD6bCK/SUGbs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jd1PoDiSKl736HtHsWW6DwEsRzOE5082YOy0lE9ccwsM0R/n02PZr02f1XAgro8jJ
	 FElh3AqCW9sdODXE5Jhxemc7rQvTVYuRhIuKtmGybjS9yuV5sdO7keqfwidGogoskl
	 vjV3abIVxM/FxlnHrLlK9pVYM2xYDyKM2HWPKpmY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E045F80587;
	Thu, 23 Dec 2021 12:37:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2DCC8F80553; Thu, 23 Dec 2021 12:37:03 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD12CF80551
 for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2021 12:36:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD12CF80551
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="BEX8V/5F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640259412; x=1671795412;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ge62tpfRSlEvvinNhAXRV1hWm2EHQvHlD6bCK/SUGbs=;
 b=BEX8V/5FFSgOmYMRhuzf+9ul7wPEnqyaBtDK0iQNXlQuYdTtjazqUWj4
 MW9tHeSgOmk1POqiiGqgwLd5awVrjf9wbWOBLxY4miMEq1F4Ok0ux033B
 1Cf2Ok/NskrO4F+8mXcVFdckjRwBTEB5Vn/4FqJhxI8GoWAdVAkdv22Ku
 gNrJTY1Qszhlv4+nePfWXhrB5SsZG3hkOV55C+4r+DZDHi1+cgO+LPab6
 kiES5wgkE8SmOkgr7ezz3lr8peYADi6uebVjBjX9/aDyrqsQnGUCAWJhQ
 Jd1wHElfy8c7p5b7wCH74tlgqk4n3LLhabGJY+Ly8/8tlB3zchjScFKrI A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="304180845"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; d="scan'208";a="304180845"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Dec 2021 03:36:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; d="scan'208";a="522065204"
Received: from gcatala-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.251.214.126])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Dec 2021 03:36:41 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH 14/20] ASoc: SOF: core: Update the FW boot state transition
 diagram
Date: Thu, 23 Dec 2021 13:36:22 +0200
Message-Id: <20211223113628.18582-15-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211223113628.18582-1-peter.ujfalusi@linux.intel.com>
References: <20211223113628.18582-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com,
 chao.song@intel.com, daniel.baluta@nxp.com
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

Update the state flow diagram to reflect the current implementation.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/core.c | 52 ++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index aa7a721f34e4..bc3d7192bdda 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -114,32 +114,32 @@ EXPORT_SYMBOL(snd_sof_get_status);
 /*
  *			FW Boot State Transition Diagram
  *
- *    +-----------------------------------------------------------------------+
- *    |									      |
- * ------------------	     ------------------				      |
- * |		    |	     |		      |				      |
- * |   BOOT_FAILED  |	     |  READY_FAILED  |-------------------------+     |
- * |		    |	     |	              |				|     |
- * ------------------	     ------------------				|     |
- *	^			    ^					|     |
- *	|			    |					|     |
- * (FW Boot Timeout)		(FW_READY FAIL)				|     |
- *	|			    |					|     |
- *	|			    |					|     |
- * ------------------		    |		   ------------------	|     |
- * |		    |		    |		   |		    |	|     |
- * |   IN_PROGRESS  |---------------+------------->|    COMPLETE    |	|     |
- * |		    | (FW Boot OK)   (FW_READY OK) |		    |	|     |
- * ------------------				   ------------------	|     |
- *	^						|		|     |
- *	|						|		|     |
- * (FW Loading OK)			       (System Suspend/Runtime Suspend)
- *	|						|		|     |
- *	|						|		|     |
- * ------------------		------------------	|		|     |
- * |		    |		|		 |<-----+		|     |
- * |   PREPARE	    |		|   NOT_STARTED  |<---------------------+     |
- * |		    |		|		 |<---------------------------+
+ *    +----------------------------------------------------------------------+
+ *    |									     |
+ * ------------------	     ------------------				     |
+ * |		    |	     |		      |				     |
+ * |   BOOT_FAILED  |<-------|  READY_FAILED  |				     |
+ * |		    |<--+    |	              |	   ------------------	     |
+ * ------------------	|    ------------------	   |		    |	     |
+ *	^		|	    ^		   |	CRASHED	    |---+    |
+ *	|		|	    |		   |		    |	|    |
+ * (FW Boot Timeout)	|	(FW_READY FAIL)	   ------------------	|    |
+ *	|		|	    |		     ^			|    |
+ *	|		|	    |		     |(DSP Panic)	|    |
+ * ------------------	|	    |		   ------------------	|    |
+ * |		    |	|	    |		   |		    |	|    |
+ * |   IN_PROGRESS  |---------------+------------->|    COMPLETE    |	|    |
+ * |		    | (FW Boot OK)   (FW_READY OK) |		    |	|    |
+ * ------------------	|			   ------------------	|    |
+ *	^		|				|		|    |
+ *	|		|				|		|    |
+ * (FW Loading OK)	|			(System Suspend/Runtime Suspend)
+ *	|		|				|		|    |
+ *	|	(FW Loading Fail)			|		|    |
+ * ------------------	|	------------------	|		|    |
+ * |		    |	|	|		 |<-----+		|    |
+ * |   PREPARE	    |---+	|   NOT_STARTED  |<---------------------+    |
+ * |		    |		|		 |<--------------------------+
  * ------------------		------------------
  *    |	    ^			    |	   ^
  *    |	    |			    |	   |
-- 
2.34.1

