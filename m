Return-Path: <SRS0=QEGn=OO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC6AC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Sep 2021 19:27:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99007610CB
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Sep 2021 19:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 99007610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F3F91676;
	Fri, 24 Sep 2021 21:26:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F3F91676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632511623;
	bh=MeluS5u2WAyXTRYOUYlWx8FDJFvntKM/j2V7SQjiv4k=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EitiwN9zzl3Vj0Ao4LtJGHybVrlIKjJT+3DCLSjw3BaDwAnKrm2sG4bsOcgh/8Qdb
	 12PvRav2ZdWub9wUS2ZU2YMiCXSkulXGE8erx2F6HJ/mwQ2z/YzcE7J45ycMrMczVB
	 EpY8TCQvduotKgog1DkRt4AIzu+XsflLHo8olduU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3FB16F804F1;
	Fri, 24 Sep 2021 21:24:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD654F804E6; Fri, 24 Sep 2021 21:24:57 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32283F804BB
 for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2021 21:24:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32283F804BB
X-IronPort-AV: E=McAfee;i="6200,9189,10117"; a="203643414"
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; d="scan'208";a="203643414"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2021 12:24:39 -0700
X-IronPort-AV: E=Sophos;i="5.85,320,1624345200"; d="scan'208";a="551922507"
Received: from bordone-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.164.235])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2021 12:24:39 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 4/4] ASoC: SOF: Intel: hda-dai: fix potential locking issue
Date: Fri, 24 Sep 2021 14:24:17 -0500
Message-Id: <20210924192417.169243-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924192417.169243-1-pierre-louis.bossart@linux.intel.com>
References: <20210924192417.169243-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, vkoul@kernel.org, broonie@kernel.org,
 Cezary Rojewski <cezary.rojewski@intel.com>,
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

The initial hdac_stream code was adapted a third time with the same
locking issues. Move the spin_lock outside the loops and make sure the
fields are protected on read/write.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-dai.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index d71165fb6fad..e349f06c49fa 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -72,6 +72,7 @@ static struct hdac_ext_stream *
 		return NULL;
 	}
 
+	spin_lock_irq(&bus->reg_lock);
 	list_for_each_entry(stream, &bus->stream_list, list) {
 		struct hdac_ext_stream *hstream =
 			stream_to_hdac_ext_stream(stream);
@@ -111,12 +112,12 @@ static struct hdac_ext_stream *
 		 * is updated in snd_hdac_ext_stream_decouple().
 		 */
 		if (!res->decoupled)
-			snd_hdac_ext_stream_decouple(bus, res, true);
-		spin_lock_irq(&bus->reg_lock);
+			snd_hdac_ext_stream_decouple_locked(bus, res, true);
+
 		res->link_locked = 1;
 		res->link_substream = substream;
-		spin_unlock_irq(&bus->reg_lock);
 	}
+	spin_unlock_irq(&bus->reg_lock);
 
 	return res;
 }
-- 
2.25.1

