Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF04FC5478C
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Mar 2024 19:06:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B678283B;
	Mon,  4 Mar 2024 20:05:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B678283B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1709579161;
	bh=IGtLZonsM9HIqBfRp5gPX4on64P1EIL/CQLv8R7f7l4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hi3zeRqAEw1fOZIRA/Et5qp9ZHb2/18xil95Q27neoKpQrsbgj63+PtFdgwrfiBJJ
	 Up/3iWygfX3v3Rl8Ht9XHO7ex5u0kTLfADykDd3bU6OzF23+KqQhgvB6as0C6KBToy
	 OenwoxjcZ5WCrfqYrYNMtB8bKsvUQU4IfNFfziHk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 634DCF80589; Mon,  4 Mar 2024 20:04:50 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C5BFF80494;
	Mon,  4 Mar 2024 20:04:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7525BF805B0; Mon,  4 Mar 2024 20:04:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B454CF801F5
	for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2024 20:04:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B454CF801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Xpl7rWbi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709579072; x=1741115072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IGtLZonsM9HIqBfRp5gPX4on64P1EIL/CQLv8R7f7l4=;
  b=Xpl7rWbinS3u0RkRXxAbcFAXnO3wKX9Fyiv1tiCse6+sMkvsLF5d6TSS
   Qwdh4FmZ/ScBXVA6fuDlz1fYrKTaqvmAaR86KdIdWKYKhGlxCND5Sdzju
   tT3HZVEj5gfivuAI4g3NgbGmRYcKtmS3VE//2XKEkauLYytqRYlp0NbmG
   ZLAJHfazDRpNkQU7IuzKA43U0XV9Cdl77855xh1eCyH3jNi3Oj7OWKu4W
   Tf/n8D9bil3IaRoTUrYQb9Rmb98Ld5BxvIvygACXV1n251lSGjg8VqnVt
   NjKHEOwNwPgvfyoRCFUH+/pVaZBJQZkNH9eJkAI3808qmgei9d9vYYFhM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4257275"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000";
   d="scan'208";a="4257275"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 11:04:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000";
   d="scan'208";a="13788282"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by orviesa005.jf.intel.com with ESMTP; 04 Mar 2024 11:04:26 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	hdegoede@redhat.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 2/5] ASoC: topology: Do not ignore route checks when parsing
 graphs
Date: Mon,  4 Mar 2024 20:05:33 +0100
Message-Id: <20240304190536.1783332-3-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240304190536.1783332-1-cezary.rojewski@intel.com>
References: <20240304190536.1783332-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: GSC6K7MZNOONQB6SOT5C2KT4HIXUKBCC
X-Message-ID-Hash: GSC6K7MZNOONQB6SOT5C2KT4HIXUKBCC
X-MailFrom: cezary.rojewski@intel.com
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
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

One of the framework responsibilities is to ensure that the enumerated
DPCMs are valid i.e.: a valid BE is connected to a valid FE DAI. While
the are checks in soc-core.c and soc-pcm.c that verify this, a component
driver may attempt to workaround this by loading an invalid graph
through the topology file.

Be strict and fail topology loading when invalid graph is encountered.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/soc-topology.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index d6d368837235..778f539d9ff5 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1083,8 +1083,9 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 			break;
 		}
 
-		/* add route, but keep going if some fail */
-		snd_soc_dapm_add_routes(dapm, route, 1);
+		ret = snd_soc_dapm_add_routes(dapm, route, 1);
+		if (ret && !dapm->card->disable_route_checks)
+			break;
 	}
 
 	return ret;
-- 
2.25.1

