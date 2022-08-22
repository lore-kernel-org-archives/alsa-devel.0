Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C88CC28D13
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Aug 2022 19:03:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 853CF844;
	Mon, 22 Aug 2022 21:02:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 853CF844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661195010;
	bh=smfHeyMJlpzoBpYfEocIH9ieVsIxG9keuV/37GeSQCU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ux/tFO2bO6Wh5c7uqH2BF7XHW3ODeyTgRNXz1k5AsFGDWLzvG5Wv4SOOhK03UqTYo
	 Bn0+O8iYqdNfSYAk6BZTVh3kFphK6vmwkWWxmLtYfFUXFL2Ds+oheq36tctlOOq6Nm
	 aeN/y51+AvDAL0gEy65TkqC4ttYjDC+6j9ALgHWw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E36F1F80154;
	Mon, 22 Aug 2022 21:02:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ADF25F804A9; Mon, 22 Aug 2022 21:02:38 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F149F80154
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2022 21:02:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F149F80154
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="mWQfqMNs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1661194953; x=1692730953;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=smfHeyMJlpzoBpYfEocIH9ieVsIxG9keuV/37GeSQCU=;
 b=mWQfqMNsPCwL0vUQ9aKunnnm/LgRKUB8CnARDDAzZJltiYnlt4KDWLge
 dEElaQj5OBzunmkGvwXwjTwLCvMVsyVJEPjMO2nwcczQCYSyYO2Keop8T
 X0LAnjzSmDsE1xXqgAoVX6b5NjqvKniPkzyDI5sXIuxILs8HgAHccBgeZ
 +BeXWhLuu7BXav3CylvdAq1uEzT0ekptE4t4BqgyOrOROQwSfJqd3wdf/
 YmvcmYthDtfLdtwrh/+IkeDKRC4PLhUaNsd8oAgbqM6T9KPIp5AlIiBvo
 fd9oFgCIbFb3whV+MPJ0e8dgxzRi1Ou4YyRqSvX4EuTQVYSZQa7Ka8Fj2 A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="276525559"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; d="scan'208";a="276525559"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2022 12:02:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; d="scan'208";a="784964898"
Received: from apascali-mobl2.ger.corp.intel.com (HELO pbossart-mobl3.home)
 ([10.252.42.21])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2022 12:02:23 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: SOF: ipc4-topology: fix alh_group_ida max value
Date: Mon, 22 Aug 2022 21:02:11 +0200
Message-Id: <20220822190211.170537-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: kernel test robot <lkp@intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
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

From: Bard Liao <yung-chuan.liao@linux.intel.com>

group_id is from 0 ~ ALH_MULTI_GTW_COUNT - 1, not 0 ~
ALH_MULTI_GTW_COUNT.

Fixes: 0e357b5290532 ("ASoC: SOF: ipc4-topology: add SoundWire/ALH aggregation support"
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index c6abfaf5d5326..64929dc9af397 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -1251,7 +1251,7 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 			if (blob->alh_cfg.count > 1) {
 				int group_id;
 
-				group_id = ida_alloc_max(&alh_group_ida, ALH_MULTI_GTW_COUNT,
+				group_id = ida_alloc_max(&alh_group_ida, ALH_MULTI_GTW_COUNT - 1,
 							 GFP_KERNEL);
 
 				if (group_id < 0)
-- 
2.34.1

