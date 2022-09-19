Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5432FC54EE9
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Sep 2022 12:14:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 535F9166F;
	Mon, 19 Sep 2022 14:13:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 535F9166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663589654;
	bh=IoGE4X3IpsdVRsX6LFxpjSusnXt+9Ixxd8JGe8a9p68=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ckt4sw8baY/cE8SK/D2ZdxeByy05AB9uNrGMp10wRABgdOFaYVwsDHyc0BW4PWQOG
	 DlTTqqbL4V+qD46qOGyyRltXRLrOm+0tqandx4xTslpSuFRytY1nFFDZbIpqxLO30Q
	 zbfgxlvLiEp18o09ezkliKb4KB/RJJhL1TbhovZI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F53FF80578;
	Mon, 19 Sep 2022 14:11:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EBAF3F803DD; Mon, 19 Sep 2022 14:11:45 +0200 (CEST)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E969F803DD
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2022 14:11:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E969F803DD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="NmtsMvK8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663589500; x=1695125500;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IoGE4X3IpsdVRsX6LFxpjSusnXt+9Ixxd8JGe8a9p68=;
 b=NmtsMvK8rc3b2dkakuJ+MFSz77wyg0g7QiaMhsDo34WGbru4urfzjfeU
 5vqgKkai4Q597OudaXG2VbZ6HK6Luy9qRh9gFGHOv1+Wgsz8nDPUtlKzj
 DGJxnhMNeitWMnOaBU5beuBYvTBMK0GNjSq/d3QjNUfcJ3TRJ0a0oR4bd
 jmIM50TE1hu4BT8CuyOJ7STbS61huy1lXJQL64UrMAT/Lci0w9tXqfyof
 NjRFKv5VkX5O9jrgx1++9A/0dTeGiBA7WgeOIpCltWBZI8YNXSde/hWV1
 +n6xuXnEIDU00bFmptw/jqG+KguCt8SPO/Ipqj6ZoeDr3lOo/pZoyM4sZ w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="361121136"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; d="scan'208";a="361121136"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2022 05:11:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; d="scan'208";a="680826265"
Received: from amagnus-mobl2.ger.corp.intel.com (HELO pbossart-mobl3.home)
 ([10.249.46.168])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2022 05:11:35 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 8/8] ALSA: hda: ext: remove always-true conditions on host and
 link release
Date: Mon, 19 Sep 2022 14:10:41 +0200
Message-Id: <20220919121041.43463-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919121041.43463-1-pierre-louis.bossart@linux.intel.com>
References: <20220919121041.43463-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org,
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

By construction a host and link DMA are always decoupled. This
decoupling happens in the assign() phase. There's no point in checking
if the two parts are decoupled, this is by-design always-true.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/hda/ext/hdac_ext_stream.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index 9a2bc7e803dd6..70f3ad71aaf0d 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -382,7 +382,8 @@ void snd_hdac_ext_stream_release(struct hdac_ext_stream *hext_stream, int type)
 
 	case HDAC_EXT_STREAM_TYPE_HOST:
 		spin_lock_irq(&bus->reg_lock);
-		if (hext_stream->decoupled && !hext_stream->link_locked)
+		/* couple link only if not in use */
+		if (!hext_stream->link_locked)
 			snd_hdac_ext_stream_decouple_locked(bus, hext_stream, false);
 		snd_hdac_stream_release_locked(&hext_stream->hstream);
 		spin_unlock_irq(&bus->reg_lock);
@@ -390,7 +391,8 @@ void snd_hdac_ext_stream_release(struct hdac_ext_stream *hext_stream, int type)
 
 	case HDAC_EXT_STREAM_TYPE_LINK:
 		spin_lock_irq(&bus->reg_lock);
-		if (hext_stream->decoupled && !hext_stream->hstream.opened)
+		/* couple host only if not in use */
+		if (!hext_stream->hstream.opened)
 			snd_hdac_ext_stream_decouple_locked(bus, hext_stream, false);
 		hext_stream->link_locked = 0;
 		hext_stream->link_substream = NULL;
-- 
2.34.1

