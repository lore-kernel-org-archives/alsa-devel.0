Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E39C3DA4A
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Aug 2024 12:48:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4EA46469E;
	Fri,  2 Aug 2024 14:47:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4EA46469E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1722602884;
	bh=z+Sp/e05K5Vs3Docgs64RMH7lUs8XWU9ixiBYYv/QaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uLiQBeA+Xuc5bLqtNGUjtfP79WSVrD4WGAUL6J3IA5L/QYinzPiJ4nsv/4soS9PiP
	 haC07HejA+uWQ5E6j9jsUJDF2mK6wc+NnFR60X2f4fy0UsqzyUU4g66xEbIJAHBKrZ
	 hH7KpLtYC6e4bWPaUZrT1Rd4IBh5qEvJjw6g78HQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C9F70F80640; Fri,  2 Aug 2024 14:46:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8BED9F80448;
	Fri,  2 Aug 2024 14:46:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8704AF80607; Fri,  2 Aug 2024 14:46:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 21576F805F3
	for <alsa-devel@alsa-project.org>; Fri,  2 Aug 2024 14:46:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21576F805F3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gC+uhE/r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722602794; x=1754138794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z+Sp/e05K5Vs3Docgs64RMH7lUs8XWU9ixiBYYv/QaI=;
  b=gC+uhE/rpSsKT4OaZ6vW3/pWjxDfQqkaq8gRays5u2giW1Fae6kHNyL0
   VhcoIe66RDFoPpxS0Tt5OG1P8K4zURJl2eynte+Ly0hAuo0dNa80zX87A
   ttMqlLfwxZwJn35U+EcKhuQIhwZKR28LtzsL1J96Vdf6QJmsPvuu/OI0e
   PR3qVXN/HZyVjg1M49FxIEqYlXsaflxQQmpStRlJhp+uLgLPOgY8u1AHK
   OnZtQr+SOyLx0C3HTPur8HZL+P3mDFoeUyTp+AcntgmXutrmKwacIYdFw
   1f0kmmvTcS7je7vp0IuiKYZvMQIYrsPR4hCkxhgcJXXumRmL4BeXcsX4o
   A==;
X-CSE-ConnectionGUID: cxdH+QjGRdmEiqBp4KZbRw==
X-CSE-MsgGUID: 7LoT/bT4TnuKMK7umtrVxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="20199394"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800";
   d="scan'208";a="20199394"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2024 05:46:32 -0700
X-CSE-ConnectionGUID: pZCeloacRgK9OLuASgvsNg==
X-CSE-MsgGUID: XTmyxUFeRwGIlTlhgtT5BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800";
   d="scan'208";a="60407902"
Received: from ltuz-desk.ger.corp.intel.com (HELO pbossart-mobl6.intel.com)
 ([10.245.246.89])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2024 05:46:29 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Subject: [PATCH 4/4] ASoC: SOF: sof-audio.h: optimize
 snd_sof_pcm_stream_pipeline_list
Date: Fri,  2 Aug 2024 14:46:09 +0200
Message-ID: <20240802124609.188954-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802124609.188954-1-pierre-louis.bossart@linux.intel.com>
References: <20240802124609.188954-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KFMDH6DRQQTGFZIZWRKSSR4LA46OMW2J
X-Message-ID-Hash: KFMDH6DRQQTGFZIZWRKSSR4LA46OMW2J
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KFMDH6DRQQTGFZIZWRKSSR4LA46OMW2J/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Invert members to remove hole.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/sof-audio.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 49be02234fc3..b9b8b64768b9 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -314,12 +314,12 @@ struct sof_token_info {
 
 /**
  * struct snd_sof_pcm_stream_pipeline_list - List of pipelines associated with a PCM stream
- * @count: number of pipeline widgets in the @pipe_widgets array
  * @pipelines: array of pipelines
+ * @count: number of pipeline widgets in the @pipe_widgets array
  */
 struct snd_sof_pcm_stream_pipeline_list {
-	u32 count;
 	struct snd_sof_pipeline **pipelines;
+	u32 count;
 };
 
 /* PCM stream, mapped to FW component  */
-- 
2.43.0

