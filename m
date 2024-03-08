Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFBAC54E4A
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Mar 2024 09:04:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 09F11B70;
	Fri,  8 Mar 2024 10:04:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 09F11B70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1709888692;
	bh=987J4jSN2YeS8t+dPex97AJlbaCIYqZsrW1RFXkxa5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jkMNTzrFSs+ir934JoOh5lHeVsWKi3T3kckxuLKC+8cdNs4olfziAGDa2uBOMGzWC
	 7VHgnvC3apV3QxmoOmt9VpK12oLjDzgbfKkGs7bHlgpquhIDYo8hQfPBj+ROipyspY
	 OVN9Uj8HijL5p2gjVQHL0UaTK2kRF5856Gy8EkNY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C7F89F805FE; Fri,  8 Mar 2024 10:03:55 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 135C5F805EB;
	Fri,  8 Mar 2024 10:03:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3E99AF80087; Fri,  8 Mar 2024 10:03:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8ED77F801F5
	for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2024 10:03:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8ED77F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=j60w2bXY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709888612; x=1741424612;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=987J4jSN2YeS8t+dPex97AJlbaCIYqZsrW1RFXkxa5c=;
  b=j60w2bXYxAnYCPwdYaJVuTGVGIF8kZxafpmeHNKDvDX/tUN+wGfNV3Kp
   gHxarCGpQXOBvhNl2LQE5xKealgCFwB2HPQ8mRyGQFHXK5ULJpLKqroOz
   VY2yExqXf8ImH05vcqaZavUmHgRmyGnexlknmZakmy2Y7sRtG7VwxzhQY
   8zsrTPvmEk8WXbVYSyOMIeW7E9TpV6EXfg3p9tjmJU/rJW5DxJYMy9Av0
   atSzWzPPgFzSuUvUnCsKx7Bz4qbGy4wbSCDkLIzXcLU2IsGIzvf8A0QnP
   uNKFHK3XXN22+E/uZ0bajCy8bXzRnv7Ck+uR8BabAV9rolMiAbBNHNKAK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15247001"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000";
   d="scan'208";a="15247001"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2024 01:03:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000";
   d="scan'208";a="10419269"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by orviesa010.jf.intel.com with ESMTP; 08 Mar 2024 01:03:26 -0800
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
Subject: [PATCH v2 2/5] ASoC: topology: Do not ignore route checks when
 parsing graphs
Date: Fri,  8 Mar 2024 10:04:59 +0100
Message-Id: <20240308090502.2136760-3-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240308090502.2136760-1-cezary.rojewski@intel.com>
References: <20240308090502.2136760-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: QNHJ2DBDKGORMQVOSFOLUA3JSNUW23ZJ
X-Message-ID-Hash: QNHJ2DBDKGORMQVOSFOLUA3JSNUW23ZJ
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
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QNHJ2DBDKGORMQVOSFOLUA3JSNUW23ZJ/>
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
 sound/soc/soc-topology.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index d6d368837235..90ca37e008b3 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1083,8 +1083,15 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 			break;
 		}
 
-		/* add route, but keep going if some fail */
-		snd_soc_dapm_add_routes(dapm, route, 1);
+		ret = snd_soc_dapm_add_routes(dapm, route, 1);
+		if (ret) {
+			if (!dapm->card->disable_route_checks) {
+				dev_err(tplg->dev, "ASoC: dapm_add_routes failed: %d\n", ret);
+				break;
+			}
+			dev_info(tplg->dev,
+				 "ASoC: disable_route_checks set, ignoring dapm_add_routes errors\n");
+		}
 	}
 
 	return ret;
-- 
2.25.1

