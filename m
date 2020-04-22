Return-Path: <SRS0=We8V=6G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F73C55185
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:05:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8307206EC
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FR0dPJnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8307206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 06B9116A4;
	Wed, 22 Apr 2020 15:05:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 06B9116A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587560755;
	bh=BtCNhZ0xuhtlCys6/fKMuYQzaIFSs8CNe+8qNl96ZuA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FR0dPJnvJSgYNe/dfOa7yhr83mkOnkj1k0zkMV1Vrk3abqxnJ1iGXgy1ysp3qobUb
	 5pPeSQF8luGqOrDCwyG+ZGfO/OygIAAhGV52KDmdnLlLiNPFXHbaS+GOkYW5Vg/ZIa
	 S/0iEOAolM6TBl9KYdsqNGZWFJ2sAw7qKgO/GDD8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 685D0F80142;
	Wed, 22 Apr 2020 15:05:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA218F801D9; Wed, 22 Apr 2020 15:05:01 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21271F800FF
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 15:04:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21271F800FF
IronPort-SDR: aEWXPFa0qdeOj+qMRCL899exAMVxPvMwgy1Eam+y1jhqrsEfZzqSBYQ67vf9s3wp537O5SrdQ2
 Jd7GdIsgaThQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2020 06:04:47 -0700
IronPort-SDR: xa/PhuUHP3+6q9h+fZvxxxVp/YEDuOTbM8RYXcZEppVtWZakorJvXc0zFHWIM7hh//SRVwLlGq
 wu6RRzIkBFgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; d="scan'208";a="247460230"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga008.fm.intel.com with ESMTP; 22 Apr 2020 06:04:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 098CB58F; Wed, 22 Apr 2020 16:04:43 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
Subject: [PATCH v1] ASoC: Intel: Skylake: Replace guid_copy() with
 import_guid()
Date: Wed, 22 Apr 2020 16:04:43 +0300
Message-Id: <20200422130443.38815-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

There is a specific API to treat raw data as GUID, i.e. import_guid().
Use it instead of guid_copy() with explicit casting.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/skylake/skl-sst-utils.c | 2 +-
 sound/soc/intel/skylake/skl-topology.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index d43cbf4a71ef2..b233f89517c11 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -290,7 +290,7 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
 			goto free_uuid_list;
 		}
 
-		guid_copy(&module->uuid, (guid_t *)&mod_entry->uuid);
+		import_guid(&module->uuid, mod_entry->uuid);
 
 		module->id = (i | (index << 12));
 		module->is_loadable = mod_entry->type.load_type;
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 69cd7a81bf2ac..43a159f23a10d 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1989,7 +1989,7 @@ static int skl_tplg_get_uuid(struct device *dev, guid_t *guid,
 	      struct snd_soc_tplg_vendor_uuid_elem *uuid_tkn)
 {
 	if (uuid_tkn->token == SKL_TKN_UUID) {
-		guid_copy(guid, (guid_t *)&uuid_tkn->uuid);
+		import_guid(guid, uuid_tkn->uuid);
 		return 0;
 	}
 
@@ -3376,8 +3376,8 @@ static int skl_tplg_get_manifest_tkn(struct device *dev,
 				dev_err(dev, "Too many UUID tokens\n");
 				return -EINVAL;
 			}
-			guid_copy(&skl->modules[uuid_index++]->uuid,
-				  (guid_t *)&array->uuid->uuid);
+			import_guid(&skl->modules[uuid_index++]->uuid,
+				    array->uuid->uuid);
 
 			tuple_size += sizeof(*array->uuid);
 			continue;
-- 
2.26.1

