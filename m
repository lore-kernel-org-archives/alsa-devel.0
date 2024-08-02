Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95D7C52D6D
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Aug 2024 12:48:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C8B64612;
	Fri,  2 Aug 2024 14:47:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C8B64612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1722602872;
	bh=5foePlp2+cV6Hcaj7mVVBKfwSze+k9WjEGjj4Z0R3rM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EEMkfQksEvGIxhmFYSAYH4Enbd06h5JNudbtMl7+l45+3SrMDFEu5BuLfdb3NBg7g
	 bT5yvX9bBl0rFQ/5NZESgvkAR0EcdXaXNcBccXm9vUR65qc5jZYQ78Zv0kxztGUpLp
	 EYO5Os4CwQq+uaWkf2jwd2Lpse1OfObybz1zJUd0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B51FAF80621; Fri,  2 Aug 2024 14:46:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4CA71F80621;
	Fri,  2 Aug 2024 14:46:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 38A1DF805E9; Fri,  2 Aug 2024 14:46:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 191C3F805AD
	for <alsa-devel@alsa-project.org>; Fri,  2 Aug 2024 14:46:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 191C3F805AD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fJhnCSkW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722602792; x=1754138792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5foePlp2+cV6Hcaj7mVVBKfwSze+k9WjEGjj4Z0R3rM=;
  b=fJhnCSkW4+phsXsE4ABhPCs2rOBQZDDQVKX+4Vb/CS4ggzQ9cOLgikGS
   /ILnBlC4WoEECgjepxndrwkEiGYBcljy+GPXV+ElSY+tyIq5zjN3k1esS
   GG3Rpfpjm3R3QugzDtdl5K/lSQpMi+emlzdhydkv8itRkPQS9UeXbDmKB
   T7d8ehachqfgwE+1dIrxCgoemFoHvzL/LMJoZnfvsOEludVFzLjdkDf8F
   THKv0cDBIQG76QQAeUExLO4bxzAs45H9AFBBDg6J9I9FXtxs6EBjOdwgS
   sRSdcUJ+VUFVRgau9IARi1t7VXlKJzbNC/7lq2EDAfZjvaBGkpRbC7cOP
   A==;
X-CSE-ConnectionGUID: S3A1jQB0T02RBYV3iZPjqQ==
X-CSE-MsgGUID: ZA/eYbznRxW32kldi/Tb/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20199389"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800";
   d="scan'208";a="20199389"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2024 05:46:29 -0700
X-CSE-ConnectionGUID: yAC/kB31QJmlUPxIkGuiRg==
X-CSE-MsgGUID: GpK/gihXTRaGT//6H3+6jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800";
   d="scan'208";a="60407888"
Received: from ltuz-desk.ger.corp.intel.com (HELO pbossart-mobl6.intel.com)
 ([10.245.246.89])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2024 05:46:26 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Subject: [PATCH 3/4] ASoC: SOF: sof-priv.h: optimize snd_sof_ipc_msg
Date: Fri,  2 Aug 2024 14:46:08 +0200
Message-ID: <20240802124609.188954-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802124609.188954-1-pierre-louis.bossart@linux.intel.com>
References: <20240802124609.188954-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 66ZHMTKQA6CXTDMDWEF3WCQH6ROURXLJ
X-Message-ID-Hash: 66ZHMTKQA6CXTDMDWEF3WCQH6ROURXLJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/66ZHMTKQA6CXTDMDWEF3WCQH6ROURXLJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Move waitq to make sure it's entirely in the same cache line, and move
ipc_complete to reduce padding.

struct snd_sof_ipc_msg {
	void *                     msg_data;             /*     0     8 */
	void *                     reply_data;           /*     8     8 */
	size_t                     msg_size;             /*    16     8 */
	size_t                     reply_size;           /*    24     8 */
	int                        reply_error;          /*    32     4 */
	bool                       ipc_complete;         /*    36     1 */

	/* XXX 3 bytes hole, try to pack */

	wait_queue_head_t          waitq;                /*    40    88 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	void *                     rx_data;              /*   128     8 */

	/* size: 136, cachelines: 3, members: 8 */
	/* sum members: 133, holes: 1, sum holes: 3 */
	/* last cacheline: 8 bytes */
};

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/sof-priv.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 6ecc58e11592..843be3b6415d 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -425,11 +425,12 @@ struct snd_sof_ipc_msg {
 	size_t reply_size;
 	int reply_error;
 
+	bool ipc_complete;
+
+	wait_queue_head_t waitq;
+
 	/* notification, firmware initiated messages */
 	void *rx_data;
-
-	wait_queue_head_t waitq;
-	bool ipc_complete;
 };
 
 /**
-- 
2.43.0

